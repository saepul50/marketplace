<?php

use SilverStripe\Assets\Image;
use SilverStripe\Assets\Upload;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\ORM\ArrayList;
use SilverStripe\ORM\ValidationException;
use SilverStripe\Security\Security;
use SilverStripe\View\ArrayData;

class ProductCheckoutPageController extends PageController{
    private static $allowed_actions = [
        'index',
        'static',
        'rajoProvince',
        'rajoRegency',
        'rajoCost',
        'address',
        'paymentmethod',
        'transaction',
        'checktransaction',
        'manualpayment',
        'manualTF',
        'cash',
        'coupon',
        'couponuser',
    ];
    public function index(HTTPRequest $request) {
        $member = Security::getCurrentUser();
    
        if ($member) {
            $checkoutData = $request->getSession()->get('CheckoutProductData');
            // Debug::show($checkoutData);
            // die();  
            $AddressData = $request->getSession()->get('AddressData');
            $coupons = $member->PromoTokos()->filter('ExpDate:GreaterThan', date('Y-m-d H:i:s'));
            // Debug::show($coupons);
            $groupedData = [];
            $validasi = false;
           
        if ($checkoutData && is_array($checkoutData)) {
            foreach ($checkoutData as $data) {
                $vendorID = $data['VendorID'];
                $vendor = Vendor::get()->byID($vendorID);

                if (!isset($groupedData[$vendorID])) {
                    $groupedData[$vendorID] = [
                        'Vendor' => $vendor,
                        'Products' => new ArrayList(),
                        'Discounts' => new ArrayList()
                    ];
                }
            }

            foreach ($checkoutData as $data) {
                $vendorID = $data['VendorID'];

                if (isset($groupedData[$vendorID])) {
                    $groupedData[$vendorID]['Products']->push($data);
                }
            }

            foreach ($coupons as $coupon) {
                $vendorID = $coupon->VendorID;

                if (isset($groupedData[$vendorID])) {
                    $groupedData[$vendorID]['Discounts'][] = [
                        'Code' => $coupon->Code,
                        'Diskon' => $coupon->Diskon,
                        'ExpDate' => $coupon->ExpDate,
                        'VendorID'=> $coupon->VendorID,
                        'ID' => $coupon->ID,
                    ];
                }
            }
        }
            
        
            $listDataCheckoutGrouped = new ArrayList();
            foreach ($groupedData as $vendorID => $group) {
                $listDataCheckoutGrouped->push(new ArrayData([
                    'Vendor' => $group['Vendor'],
                    'Products' => $group['Products'],
                    'Discounts' => $group['Discounts'], 
                ]));
            }
            // Debug::show($listDataCheckoutGrouped);
            // die();
            return [
                'CheckoutProductData' => $listDataCheckoutGrouped,
                'AddressData' => $AddressData,
                'Member' => $member,
                'Coupons' => $coupons
            ])->renderWith(['ProductCheckoutPage', 'Page']);
        }
    
        return $this->redirect('login');
    }


    public function coupon(HTTPRequest $request){
        $data = $request->postVar('Coupon'); 
        $promo = PromoToko::get()->filter('Code', $data)->first();
        date_default_timezone_set('Asia/Jakarta');  

        if ($promo) {
            $diskon = $promo->Diskon;
            $max = $promo->MaximumUse;
            $time = strtotime($promo->ExpDate);
            // Debug::show($promo->ExpDate);
            // Debug::show($time >= time());

            if ($time >= time() && $max !== 0 ) { 
                if ($promo->MaximumUse > 0) {
                    $promo->MaximumUse -= 1;
                    $promo->write();
                }
                
                $request->getSession()->set('Coupon', $data);
                // Debug::show($data);
                return json_encode([
                    'success' => true,
                    'message' => "Success! You get a discount of {$diskon}%."
                ]);
            } else {
                return json_encode([
                    'success' => false,
                    'message' => 'Coupon has expired or reaches the usage limit.'
                ]);
            }
        } else {
            return json_encode([
                'success' => false,
                'message' => 'Coupon not found.'
            ]);
        }
        

        
    }


    public function couponuser(HTTPRequest $request) {
            $Code = $request->postVar('Code');
            $VendorID = $request->postVar('VendorID');
            // Debug::show($Code);
            // Debug::show($VendorID);
            $member = Security::getCurrentUser();
            $Coupon = PromoToko::get()->filter('Code', $Code)->filter('VendorID', $VendorID)->first();
            if($Coupon){
                $max = $Coupon->MaximumUse;
                $time = strtotime($Coupon->ExpDate);
                if ($Coupon && $member && $time >= time() && $max !== 0  ) {
                    if ($Coupon->MaximumUse > 0  && !$Coupon->Members()->byID($member->ID) && ! $member->PromoTokos()->add($Coupon->ID)) {
                        $member->PromoTokos()->add($Coupon->ID);
                        $Coupon->Members()->add($member->ID);
                        $Coupon->MaximumUse -= 1;
                        $Coupon->write();
                        return json_encode([
                            'success' => true,
                            'message' => "Success! Promo added to your account."
                        ]);
                    } else {
                        return json_encode([
                            'success' => false,
                            'message' => "Coupon Already Exists In your Account"
                        ]);
                    }
                    
                } else {
                    return json_encode([
                        'success' => false,
                        'message' => "Your coupon has reached limit usage or has expired "
                    ]);
                }
            } else {
                return json_encode([
                    'success' => false,
                    'message' => "No coupon found for the code and vendor you entered."
                ]);  
            }
       
    }
    
    public function address(HTTPRequest $request){
        if ($request) {
            $Number = $request->postVar('Number');
            $FName = $request->postVar('FName');
            $LName = $request->postVar('LName');
            $Address = $request->postVar('Address');
            $AddressDetail = $request->postVar('AddressDetail');
            $Regency = $request->postVar('Regency');
            $Province = $request->postVar('Province');
            $Postal = $request->postVar('Postal');
            $Email = $request->postVar('Email');

            if (!empty($Number) && !empty($FName) && !empty($Address) && !empty($AddressDetail) && !empty($Regency)) {
                $data = [
                    'Number' => $Number,
                    'FName' => $FName,
                    'LName' => $LName,
                    'Address' => $Address,
                    'AddressDetail' => $AddressDetail,
                    'Regency' => $Regency,
                    'Province' => $Province,
                    'Postal' => $Postal,
                    'Email' => $Email,
                ];
                    // Debug::show($data);
                    // die();      
                $request->getSession()->set('AddressData', $data);

                return json_encode(['success' => true]);
            } else {
                return json_encode(['success' => false, 'message' => 'Incomplete data received']);
            }
        }

        return json_encode(['success' => false, 'message' => 'No data received']);
    }
    public function static(HTTPRequest $request){
        if($request->isPOST()){
            $productCheckoutData = json_decode($request->postVar('ProductCheckoutDatas'), true);
            // Debug::show($productCheckoutData);
            // Debug::show($productCheckoutData);
            // die();
            if (is_array($productCheckoutData)) {
                $products = $productCheckoutData;
                
                if (!empty($products)) {
                    $checkoutData = [];

                    foreach ($products as $product) {
                        $productData = [
                            'ProductID' => $product['ProductID'],
                            'VendorID' => $product['productCheckoutVendorID'],
                            'productCheckoutVendorID' => $product['ProductID'],
                            'ProductTitle' => $product['ProductTitle'],
                            'ProductImage' => $product['ProductImage'],
                            'ProductVariant' => $product['ProductVariant'],
                            'ProductVariantID' => $product['ProductVariantID'],
                            'ProductVariantWeight' => $product['ProductVariantWeight'],
                            'ProductPrice' => $product['ProductPrice'],
                            'ProductTotalPrice' => $product['ProductTotalPrice'],
                            'ProductQuantity' => $product['ProductQuantity'],
                            'ProductSubTotalPrice' => $product['ProductSubTotalPrice'],
                            'ProductSubTotalNFPrice' => $product['ProductSubTotalPriceNF'],
                            'MemberFirstname' => $product['MemberFirstName'],
                            'MemberLastname' => $product['MemberLastName'],
                            'MemberEmail' => $product['MemberEmail'],
                        ];
                        // Debug::show($productData);
                        // die();
                        if (isset($product['ProductCartID'])) {
                            $productData['ProductCartID'] = $product['ProductCartID'];
                        }
                        
                        $checkoutData[] = $productData;
                    }
                    // Debug::show($checkoutData);
                    // die();
                    $request->getSession()->set('CheckoutProductData', $checkoutData);

                    return json_encode(['success' => true]);
                } else {
                    return json_encode(['success' => false, 'message' => 'Empty data received']);
                }
            } else {
                return json_encode(['success' => false, 'message' => 'Nothing Item Checkout']);
            }
        }
    }
    public function rajoProvince(HTTPRequest $request){
        $curl = curl_init();
        curl_setopt_array($curl, array(
            CURLOPT_URL => "https://api.rajaongkir.com/starter/province",
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => "GET",
            CURLOPT_HTTPHEADER => array(
                "key: c9ba6f9ee619e3eae6b2b65d64fac437"
            ),
        ));

        $response = curl_exec($curl);
        $err = curl_error($curl);
        // Debug::show($response);
        // die();
        curl_close($curl);

        if ($err) {
            echo "cURL Error #:" . $err;
        } else {
            header('Content-Type: application/json');
            echo $response;
        }
    }
    public function rajoRegency(HTTPRequest $request){
        $province = $request->postVar('ProvinceID');
        // Debug::show($Province);
        // die();            
        $curl = curl_init();
        curl_setopt_array($curl, array(
        CURLOPT_URL => "https://api.rajaongkir.com/starter/city?province=$province",
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => "",
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => "GET",
        CURLOPT_HTTPHEADER => array(
            "key: c9ba6f9ee619e3eae6b2b65d64fac437"
        ),
        ));

        $response = curl_exec($curl);
        $err = curl_error($curl);

        curl_close($curl);

        if ($err) {
        echo "cURL Error #:" . $err;
        } else {
        echo $response;
        }
    }
    public function rajoCost(HTTPRequest $request) {
        $curl = curl_init();
        $regency = $request->postVar('RegencyID');
        $weight = $request->postVar('Weight');
        $courir = $request->postVar('Courir');
        $origin = $request->postVar('Origin');
        $surabaya = 444;
        // Debug::show($regency);
        // Debug::show($weight);
        // Debug::show($courir);
        // Debug::show($origin);
        // die();
        curl_setopt_array($curl, array(
        CURLOPT_URL => "https://api.rajaongkir.com/starter/cost",
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => "",
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => "POST",
        CURLOPT_POSTFIELDS => "origin=$origin&destination=$regency&weight=$weight&courier=$courir",
        CURLOPT_HTTPHEADER => array(
            "content-type: application/x-www-form-urlencoded",
            "key: c9ba6f9ee619e3eae6b2b65d64fac437"
        ),
        ));

        $response = curl_exec($curl);
        $err = curl_error($curl);

        curl_close($curl);

        if ($err) {
        echo "cURL Error #:" . $err;
        } else {
        echo $response;
        }
    }

    public function paymentmethod(HTTPRequest $request){
        // Set kode merchant anda 
        $merchantCode = "DS20031"; 
        // Set merchant key anda 
        $apiKey = "8c98ceb5b29429b26bfcd384d5f76d02";
        // catatan: environtment untuk sandbox dan passport berbeda 

        $datetime = date('Y-m-d H:i:s');  
        $paymentAmount = 10000;
        $signature = hash('sha256',$merchantCode . $paymentAmount . $datetime . $apiKey);

        $params = array(
            'merchantcode' => $merchantCode,
            'amount' => $paymentAmount,
            'datetime' => $datetime,
            'signature' => $signature
        );

        $params_string = json_encode($params);

        $url = 'https://sandbox.duitku.com/webapi/api/merchant/paymentmethod/getpaymentmethod'; 

        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, $url); 
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");                                                                     
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params_string);                                                                  
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);                                                                      
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(                                                                          
            'Content-Type: application/json',                                                                                
            'Content-Length: ' . strlen($params_string))                                                                       
        );   
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);

        //execute post
        $request = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);

        if($httpCode == 200)
        {
            $results = json_decode($request, true);
            $array = [
                'Data'=>$results['paymentFee']
            ];
            return json_encode($array);
        }
        else{
            $request = json_decode($request);
            $error_message = "Server Error " . $httpCode ." ". $request->Message;
            echo $error_message;
        }
    }
    public function transaction(HTTPRequest $request) {
        $member = Security::getCurrentUser();
        if ($request->isPOST()) {
            $postData = json_decode($request->postVar('paymentDatas'), true);
    
            $results = [];
            foreach ($postData as $checkoutData) {
                $headerCheckout = ProductCheckoutHeaderObject::create();
                $s = substr(str_shuffle(str_repeat("0123456789abcdefghijklmnopqrstuvwxyz", 16)), 0, 16);
                $OrderID = "SHOESTORE{$s}";
                $headerCheckout->OrderID = $OrderID;
                $headerCheckout->MemberID = $member->ID;
                $headerCheckout->VendorID = $checkoutData['VendorID'];
                $headerCheckout->CustomerName = $checkoutData['CustomerName'];
                $headerCheckout->CustomerFullName = $checkoutData['CustomerFullName'];
                $headerCheckout->CustomerEmail = $checkoutData['CustomerEmail'];
                $headerCheckout->CustomerHandphone = $checkoutData['CustomerHandphone'];
                $headerCheckout->CustomerAddress = $checkoutData['CustomerAddress'];
                $headerCheckout->CustomerNotes = $checkoutData['CustomerNotes'];
                $headerCheckout->ProductCostShipping = $checkoutData['ProductShippingPrice'];
                $headerCheckout->FinalPrice = $checkoutData['ProductTotalPrice'];
                $headerCheckout->Bank = $checkoutData['Bank'];
                $headerCheckout->Diskon = $checkoutData['Diskon'];
                $headerCheckout->PaymentMethod = $checkoutData['PaymentMethod'];
                $headerCheckout->TimeCheckout = $checkoutData['TimeCheckout'];
                $headerCheckout->write();
    
                $paymentData = $this->preparePaymentData($checkoutData);
                $merchantOrderId = $paymentData['merchantOrderId'];
                $headerCheckout->DuitkuOrderID = $merchantOrderId;

                $headerCheckout->write();
                $paymentResponse = $this->sendPaymentRequest($paymentData);
                // Debug::show($paymentResponse);
                // die();
                if ($paymentResponse && isset($paymentResponse['paymentUrl'])) {
                    $headerCheckout->PaymentUrl = $paymentResponse['paymentUrl'];
                    $headerCheckout->write();
                }
    
                foreach ($checkoutData['Products'] as $productData) {
                    $productCheckout = ProductCheckoutObject::create();
                    $productCheckout->ProductID = $productData['ProductID'];
                    $productCheckout->ProductTitle = $productData['ProductTitle'];
                    $productCheckout->ProductImage = $productData['ProductImage'];
                    $productCheckout->ProductVariant = $productData['ProductVariant'];
                    $productCheckout->ProductVariantID = $productData['ProductVariantID'];
                    $productCheckout->ProductVariantWeight = $productData['ProductVariantWeight'];
                    $productCheckout->ProductPrice = $productData['ProductPrice'];
                    $productCheckout->ProductQuantity = $productData['ProductQuantity'];
                    $productCheckout->VendorID = $productData['VendorID'];
                    $productCheckout->HeaderCheckoutID = $headerCheckout->ID;
                    $productCheckout->write();

                    $cartItem = CartObject::get()->byID($productData['ProductCartID']);
                    if ($cartItem) {
                        $cartItem->delete();
                    }
                }
    
                $results[] = [
                    'VendorID' => $checkoutData['VendorID'],
                    'OrderID' => $headerCheckout->OrderID,
                    'ProductsSaved' => count($checkoutData['Products']),
                    'PaymentUrl' => $headerCheckout->PaymentUrl
                ];
            }
            return json_encode(['success' => true, 'results' => $results]);
        }
    }
    
    private function preparePaymentData($checkoutData) {
        $merchantCode = 'DS20031';
        $apiKey = '8c98ceb5b29429b26bfcd384d5f76d02';
        $merchantOrderId = time() . '';
        $paymentAmount = $checkoutData['ProductTotalPriceNF'];
        $paymentMethod = $checkoutData['Bank'];
        $productDetails = 'Tes pembayaran menggunakan Duitku';
        $email = $checkoutData['CustomerEmail'];
        $phoneNumber = $checkoutData['CustomerHandphone'];
        $additionalParam = ''; // opsional
        $merchantUserInfo = ''; // opsional
        $customerVaName = $checkoutData['CustomerName'];
        $CustomerAddress = $checkoutData['CustomerAddress'];
        $callbackUrl = '{$BaseHref}/duitkupayment/callback';
        $returnUrl = '/marketplace';
        $expiryPeriod = 120;
        $signature = md5($merchantCode . $merchantOrderId . $paymentAmount . $apiKey);
        $alamat = $CustomerAddress;
        // $city = $addressDetCus;
        $postalCode = "";
        $countryCode = "ID";

        $address = array(
            'firstName' => $customerVaName,
            'lastName' => $customerVaName,
            'address' => $alamat,
            // 'city' => $city,
            'postalCode' => $postalCode,
            'phone' => $phoneNumber,
            'countryCode' => $countryCode
        );
        $customerDetail = array(
            'firstName' => $customerVaName,
            'lastName' => $customerVaName,
            'email' => $email,
            'phoneNumber' => $phoneNumber,
            'billingAddress' => $address,
            'shippingAddress' => $address
        );
        return [
            'merchantCode' => $merchantCode,
            'paymentAmount' => $paymentAmount,
            'paymentMethod' => $paymentMethod,
            'merchantOrderId' => $merchantOrderId,
            'productDetails' => $productDetails,
            'additionalParam' => $additionalParam,
            'merchantUserInfo' => $merchantUserInfo,
            'customerVaName' => $customerVaName,
            'email' => $email,
            'phoneNumber' => $phoneNumber,
            'customerDetail' => $customerDetail,
            'callbackUrl' => $callbackUrl,
            'returnUrl' => $returnUrl,
            'signature' => $signature,
            'expiryPeriod' => $expiryPeriod,
        ];
    }
    
    private function sendPaymentRequest($paymentData) {
        $params_string = json_encode($paymentData);
        $url = 'https://sandbox.duitku.com/webapi/api/merchant/v2/inquiry'; // Sandbox
        $ch = curl_init();
        
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params_string);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json',
            'Content-Length: ' . strlen($params_string)
        ]);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);
        
        $request = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        // Debug::show($request);
        // Debug::show($httpCode);
        // die();
        
        if ($httpCode == 200) {
            return json_decode($request, true);
        } else {
            return null;
        }
    }
    public function checktransaction(){
        $merchantCode = 'DS20031'; // dari duitku
        $apiKey = '8c98ceb5b29429b26bfcd384d5f76d02'; // dari duitku
        if (isset($_GET['orderid'])) {
            $merchantOrderId = $_GET['orderid'];
            // Debug::show(val: $merchantOrderId);
            // die();
        } else {
            Debug::show("Order ID tidak ditemukan.");
            return;
        }

        $signature = md5($merchantCode . $merchantOrderId . $apiKey);

        $params = array(
            'merchantCode' => $merchantCode,
            'merchantOrderId' => $merchantOrderId,
            'signature' => $signature
        );

        $params_string = json_encode($params);
        $url = 'https://sandbox.duitku.com/webapi/api/merchant/transactionStatus';
        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, $url); 
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");                                                                     
        curl_setopt($ch, CURLOPT_POSTFIELDS, $params_string);                                                                  
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);                                                                      
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(                                                                          
            'Content-Type: application/json',                                                                                
            'Content-Length: ' . strlen($params_string))                                                                       
        );   
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, FALSE);

        //execute post
        $request = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);

        if($httpCode == 200)
        {
            $results = json_decode($request, true);
            // print_r($results, false);
            $amount_rupiah = "Rp. " . number_format($results['amount'], 0, ',', '.');

            echo "<div style='display: flex; justify-content: center; align-items: end; height: 60vh;'>";
            echo "<table border='1' cellpadding='10' style='border-collapse: collapse;'>";
            echo "<tr><th>Parameter</th><th>Nilai</th></tr>";
            echo "<tr><td>Merchant Order ID</td><td>" . $results['merchantOrderId'] . "</td></tr>";
            echo "<tr><td>Reference</td><td>" . $results['reference'] . "</td></tr>";
            echo "<tr><td>Amount</td><td>" . $amount_rupiah . "</td></tr>";
            // echo "<tr><td>Fee</td><td>" . $results['fee'] . "</td></tr>";
            // echo "<tr><td>Status Code</td><td>" . $results['statusCode'] . "</td></tr>";
            echo "<tr><td>Status Message</td><td>" . $results['statusMessage'] . "</td></tr>";
            echo "</table>";
            echo "</div>";
        }
        else
        {
            $request = json_decode($request);
            $error_message = "Server Error " . $httpCode ." ". $request->Message;
            echo $error_message;
        }
    }
    public function manualpayment(HTTPRequest $request) {
        $id = $request->param('ID');
        $member = Security::getCurrentUser();
        
        if ($member) {
            if ($request->isPOST() && isset($_FILES['ProofImageManual'])) {
                $id = $request->postVar('ID');
                $checkoutHeader = ProductCheckoutHeaderObject::get()->filter('OrderID', $id)->first();
                
                $upload = new Upload();
                $img = new Image();
                $upload->loadIntoFile($_FILES['ProofImageManual'], $img);

                if (!$upload->isError()) {
                    $checkoutHeader->ProofImage = $img->ID;
                    $checkoutHeader->write();
                    return json_encode(['success' => true, 'message' => 'Sukses']);
                } else {
                    return json_encode(['success' => false, 'message' => 'Gagal menulis file']);
                }
            }
            
            $checkoutHeader = ProductCheckoutHeaderObject::get()->filter('OrderID', $id)->first();
            // Debug::show($checkoutHeader);
            if ($checkoutHeader) {
                $isDetail = $request->getVar('invoice');
                // Debug::show($isDetail);
                // die();
                return [
                    'CheckoutHeader' => $checkoutHeader,
                    'Invoice' => $isDetail,
                ];
            }
        }        
        return $this->httpError(404, 'Page not found');
    }
    
    public function manualTF(HTTPRequest $request) {
        $member = Security::getCurrentUser();
        if ($request->isPOST()) {
            $postData = json_decode($request->postVar('paymentDatas'), true);
            Debug::show($postData);
            if ($postData) {
                $results = [];
                foreach ($postData as $checkoutData) {
                    $headerCheckout = ProductCheckoutHeaderObject::create();
                    $s = substr(str_shuffle(str_repeat("0123456789abcdefghijklmnopqrstuvwxyz", 16)), 0, 16);
                    $OrderID = "SHOESTORE{$s}";
                    $headerCheckout->OrderID = $OrderID;
                    $headerCheckout->MemberID = $member->ID;
                    $headerCheckout->VendorID = $checkoutData['VendorID'];
                    $headerCheckout->CustomerName = $checkoutData['CustomerName'];
                    $headerCheckout->CustomerFullName = $checkoutData['CustomerFullName'];
                    $headerCheckout->CustomerEmail = $checkoutData['CustomerEmail'];
                    $headerCheckout->CustomerHandphone = $checkoutData['CustomerHandphone'];
                    $headerCheckout->CustomerAddress = $checkoutData['CustomerAddress'];
                    $headerCheckout->CustomerNotes = $checkoutData['CustomerNotes'];
                    $headerCheckout->ProductCostShipping = $checkoutData['ProductShippingPrice'];
                    $headerCheckout->FinalPrice = $checkoutData['ProductTotalPrice'];
                    $headerCheckout->Bank = $checkoutData['Bank'];
                    $headerCheckout->Diskon = $checkoutData['Diskon'];
                    $headerCheckout->PaymentMethod = $checkoutData['PaymentMethod'];
                    $headerCheckout->TimeCheckout = $checkoutData['TimeCheckout'];
                    
                    $headerCheckout->write();
                    
                    foreach ($checkoutData['Products'] as $productData) {
                        $productCheckout = ProductCheckoutObject::create();
                        $productCheckout->ProductID = $productData['ProductID'];
                        $productCheckout->ProductTitle = $productData['ProductTitle'];
                        $productCheckout->ProductImage = $productData['ProductImage'];
                        $productCheckout->ProductVariant = $productData['ProductVariant'];
                        $productCheckout->ProductVariantID = $productData['ProductVariantID'];
                        $productCheckout->ProductVariantWeight = $productData['ProductVariantWeight'];
                        $productCheckout->ProductPrice = $productData['ProductPrice'];
                        $productCheckout->ProductQuantity = $productData['ProductQuantity'];
                        $productCheckout->VendorID = $productData['VendorID'];

                        
                        $productCheckout->HeaderCheckoutID = $headerCheckout->ID;
                        
                        $productCheckout->write();

                        $cartItem = CartObject::get()->byID($productData['ProductCartID']);
                        if ($cartItem) {
                            $cartItem->delete();
                        }
                    }
                    // Debug::show($checkoutData['Products']);
                    
                    $results[] = [
                        'VendorID' => $checkoutData['VendorID'],
                        'OrderID' => $headerCheckout->OrderID,
                        'ProductsSaved' => count($checkoutData['Products'])
                    ];
                }
                return json_encode(['success' => true, 'results' => $results]);
            } else {
                return json_encode(['success' => false, 'message' => 'Invalid data format']);
            }
        }
    
        return json_encode(['success' => false, 'message' => 'No data received']);
    }
    public function cash(HTTPRequest $request){
        $member = Security::getCurrentUser();
        if ($request->isPOST()) {
            $postData = json_decode($request->postVar('paymentDatas'), true);
            if ($postData) {
                $results = [];
                foreach ($postData as $checkoutData) {
                    $headerCheckout = ProductCheckoutHeaderObject::create();
                    $s = substr(str_shuffle(str_repeat("0123456789abcdefghijklmnopqrstuvwxyz", 16)), 0, 16);
                    $OrderID = "SHOESTORE{$s}";
                    $headerCheckout->OrderID = $OrderID;
                    $headerCheckout->MemberID = $member->ID;
                    $headerCheckout->VendorID = $checkoutData['VendorID'];
                    $headerCheckout->CustomerName = $checkoutData['CustomerName'];
                    $headerCheckout->CustomerFullName = $checkoutData['CustomerFullName'];
                    $headerCheckout->CustomerEmail = $checkoutData['CustomerEmail'];
                    $headerCheckout->CustomerHandphone = $checkoutData['CustomerHandphone'];
                    $headerCheckout->CustomerAddress = $checkoutData['CustomerAddress'];
                    $headerCheckout->CustomerNotes = $checkoutData['CustomerNotes'];
                    $headerCheckout->ProductCostShipping = $checkoutData['ProductShippingPrice'];
                    $headerCheckout->FinalPrice = $checkoutData['ProductTotalPrice'];
                    $headerCheckout->Bank = $checkoutData['Bank'];
                    $headerCheckout->Diskon = $checkoutData['Diskon'];
                    $headerCheckout->PaymentMethod = $checkoutData['PaymentMethod'];
                    $headerCheckout->TimeCheckout = $checkoutData['TimeCheckout'];
                    
                    $headerCheckout->write();
                    
                    foreach ($checkoutData['Products'] as $productData) {
                        $productCheckout = ProductCheckoutObject::create();
                        $productCheckout->ProductID = $productData['ProductID'];
                        $productCheckout->ProductTitle = $productData['ProductTitle'];
                        $productCheckout->ProductImage = $productData['ProductImage'];
                        $productCheckout->ProductVariant = $productData['ProductVariant'];
                        $productCheckout->ProductVariantID = $productData['ProductVariantID'];
                        $productCheckout->ProductVariantWeight = $productData['ProductVariantWeight'];
                        $productCheckout->ProductPrice = $productData['ProductPrice'];
                        $productCheckout->ProductQuantity = $productData['ProductQuantity'];
                        $productCheckout->VendorID = $productData['VendorID'];
                        
                        $productCheckout->HeaderCheckoutID = $headerCheckout->ID;
                        
                        $productCheckout->write();

                        $cartItem = CartObject::get()->byID($productData['ProductCartID']);
                        if ($cartItem) {
                            $cartItem->delete();
                        }
                    }
                    
                    $results[] = [
                        'VendorID' => $checkoutData['VendorID'],
                        'OrderID' => $headerCheckout->OrderID,
                        'ProductsSaved' => count($checkoutData['Products'])
                    ];
                }
                return json_encode(['success' => true, 'results' => $results]);
            } else {
                return json_encode(['success' => false, 'message' => 'Invalid data format']);
            }
        }
        return json_encode(['success' => false, 'message' => 'No data received']);
    }
}