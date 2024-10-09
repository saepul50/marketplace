<?php

use SilverStripe\Assets\Image;
use SilverStripe\Assets\Upload;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\ORM\ArrayList;
use SilverStripe\ORM\ValidationException;
use SilverStripe\Security\Security;

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
        'manualTF',
        'cash',
        'coupon',
    ];
    public function index(HTTPRequest $request)
    {
      
        
        $checkoutData = $request->getSession()->get('CheckoutProductData');
        // Debug::show($checkoutData);
        $AddressData = $request->getSession()->get('AddressData');
        $Coupon = $request->getSession()->get('Coupon');
        $diskon = PromoToko::get()->filter('Code', $Coupon);

        $listDataCheckout = new ArrayList();
        
        if ($checkoutData && is_array($checkoutData)) {
            foreach ($checkoutData as $data) {
                $listDataCheckout->push($data);
            }
        }
        // Debug::show($listDataCheckout);
        // die();
        $data = $this->nepo(); // Call the nepo() method from PageController

        return $this->customise([
            'Notif' => $data['Notif'] ?? null,
            'Product' => $data['Product'] ?? null,
            'Count' => $data['Count'] ?? null,
            'CheckoutProductData' => $listDataCheckout,
            'AddressData' => $AddressData,
            'Diskon' => $diskon,
            'Code' => $Coupon
        ])->renderWith(['ProductCheckoutPage', 'Page']);
    }

    public function coupon(HTTPRequest $request){
        $coupon = PromoToko::get()->column('Code');
        $data = $request->postVar('Coupon'); 
        $promo = PromoToko::get()->filter('Code', $data)->first();
        date_default_timezone_set('Asia/Jakarta');  

        if ($promo) {
            $diskon = $promo->Diskon;
            $time = strtotime($promo->ExpDate);
            // Debug::show($promo->ExpDate);
            // Debug::show($time >= time());

            if ($time >= time()) { 
                $request->getSession()->set('Coupon', $data);
                return json_encode([
                    'success' => true,
                    'message' => "Success! You get a discount of {$diskon}%."
                ]);
            } else {
                return json_encode([
                    'success' => false,
                    'message' => 'Coupon has expired.'
                ]);
            }
        } else {
            return json_encode([
                'success' => false,
                'message' => 'Coupon not found.'
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
            // die();
            if (is_array($productCheckoutData)) {
                $products = $productCheckoutData;
                
                if (!empty($products)) {
                    $checkoutData = [];

                    foreach ($products as $product) {
                        $productData = [
                            'ProductID' => $product['ProductID'],
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
    public function rajoCost(HTTPRequest $request){
        $curl = curl_init();
        $regency = $request->postVar('RegencyID');
        $weight = $request->postVar('Weight');
        $courir = $request->postVar('Courir');
        $surabaya = 444;
        // Debug::show($weight);
        // die();
        curl_setopt_array($curl, array(
        CURLOPT_URL => "https://api.rajaongkir.com/starter/cost",
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => "",
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => "POST",
        CURLOPT_POSTFIELDS => "origin=$surabaya&destination=$regency&weight=$weight&courier=$courir",
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
    // public function cash(HTTPRequest $request){
    //     if ($request->isPOST()) {
    //         $postData = json_decode($request->postVar('paymentDatas'), true);
    //         if ($postData) {
    //             $products = $postData;
    //             // Debug::show($products);
    //             // die();
    //             if (!empty($products)) {
    //                 $firstItemProcessed = false;
                    
    //                 foreach ($products as $product) {
    //                     // Debug::show($_FILES['ProofImage']);
    //                     // die();
    //                     $productID = $product['ProductID'];
    //                     $productCartID = $product['ProductCartID'];
    //                     $productTitle = $product['ProductTitle'];
    //                     $productImage = $product['ProductImage'];
    //                     $productVariant = $product['ProductVariantName'];
    //                     $productVariantID = $product['ProductVariantID'];
    //                     $productPrice = $product['ProductPrice'];
    //                     $productSubTotalPrice = $product['ProductSubTotalPrice'];
    //                     $productWeight = $product['ProductWeight'];
    //                     $productQuantity = $product['ProductQuantity'];
    //                     $productDeliveryCost = $product['ProductDeliveryCost'];
    //                     $productFinalPrice = $product['ProductFinalPrice'];
    //                     $name = $product['Name'];
    //                     $number = $product['Number'];
    //                     $address = $product['Address'];
    //                     $addressDetail = $product['AddressDetail'];
    //                     $orderID = $product['OrderID'];
    //                     $bank = $product['Bank'];
    //                     $comments = $product['Comments'];
    //                     $timeCheckout = $product['TimeCheckout'];
    //                     $paymentMethod = $product['PaymentMethod'];

    //                     $debugData = [
    //                         'ProductID' => $product['ProductID'],
    //                         'CartID' => $product['CartID'],
    //                         'ProductTitle' => $product['ProductTitle'],
    //                         'ProductImage' => $product['ProductImage'],
    //                         'VariantName' => $product['VariantName'],
    //                         'VariantID' => $product['VariantID'],
    //                         'Price' => $product['Price'],
    //                         'SubTotalPrice' => $product['SubTotalPrice'],
    //                         'Quantity' => $product['Quantity'],
    //                         'FinalPrice' => $product['FinalPrice'],
    //                         'Name' => $product['Name'],
    //                         'Number' => $product['Number'],
    //                         'Address' => $product['Address'],
    //                         'AddressDetail' => $product['AddressDetail'],
    //                         'OrderID' => $orderID,
    //                         'Bank' => $product['Bank'],
    //                         'Comments' => $product['Comments'],
    //                         'TimeCheckout' => $product['TimeCheckout'],
    //                         'PaymentMethod' => $product['PaymentMethod'],
    //                     ];                
    //                     // Debug::show($debugData);
    //                     // die();           
                        
    //                     try {
    //                         $checkoutItem = ProductCheckoutObject::create();
    //                         $checkoutItem->ProductID = $productID;
    //                         $checkoutItem->ProductCartID = $productCartID;
    //                         $checkoutItem->ProductTitle = $productTitle;
    //                         $checkoutItem->ProductImage = $productImage;
    //                         $checkoutItem->ProductVariant = $productVariant;
    //                         $checkoutItem->ProductVariantID = $productVariantID;
    //                         $checkoutItem->ProductPrice = $productPrice;
    //                         $checkoutItem->ProductQuantity = $productQuantity;
    //                         $checkoutItem->ProductWeight = $productWeight;
    //                         $checkoutItem->ProductTotalPrice = $productSubTotalPrice;
    //                         $checkoutItem->ProductDeliveryCost = $productDeliveryCost;
    //                         $checkoutItem->ProductFinalPrice = $productFinalPrice;
    //                         $checkoutItem->merchantOrderId = $orderID;
    //                         $member = Security::getCurrentUser();
    //                         if ($member) {
    //                             $checkoutItem->MemberID = $member->ID;
    //                         }
    //                         if (!$firstItemProcessed) {
    //                             $checkoutHeader = ProductCheckoutHeaderObject::create();
    //                             $checkoutHeader->OrderID = $orderID;
    //                             $checkoutHeader->Name = $name;
    //                             $checkoutHeader->Number = $number;
    //                             $checkoutHeader->Address = $address;
    //                             $checkoutHeader->AddressDetail = $addressDetail;
    //                             $checkoutHeader->FinalPrice = $finalPrice;
    //                             $checkoutHeader->Bank = $bank;
    //                             $checkoutHeader->Message = $comments;
    //                             $checkoutHeader->TimeCheckout = $timeCheckout;
    //                             $checkoutHeader->PaymentMethod = $paymentMethod;
    //                             $checkoutHeader->write();
    //                             $firstItemProcessed = true;
    //                         }
    //                         $checkoutItem->HeaderCheckoutID = $checkoutHeader->ID;
    //                         $checkoutItem->write();
                            
    //                         $cartItem = CartObject::get()->byID($cartID);
    //                         if ($cartItem) {
    //                             $cartItem->delete();
    //                         }
    //                     } catch (ValidationException $e) {
    //                         Debug::show("iso");
    //                     }
    //                 }
    //             }
    //         } else {
    //             Debug::show("gaiso");
    //         }
    //     }
    // }
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
    public function transaction(HTTPRequest $request){

        if ($request->isPOST()) {
            $postData = json_decode($request->postVar('paymentDatas'), true);
            // Debug::show($postData);
            // die();
            $finalPrice = $postData[0]['ProductFinalPriceNF'];
            $PaymentSelected = $postData[0]['Bank'];
            $PaymentMethode = $postData[0]['PaymentMethod'];
            $TimeCheckout = $postData[0]['TimeCheckout'];
            $CustomerName = $postData[0]['CustomerName'];
            $CustomerEmail = $postData[0]['CustomerEmail'];
            $CustomerHandphone = $postData[0]['CustomerHandphone'];
            $CustomerAddress = $postData[0]['CustomerAddress'];
            $CustomerNotes = $postData[0]['CustomerNotes'];
            // $addressDetCus = $postData[0]['AddressDetail'];
            // Debug::show($finalPrice);
            // die();
            $merchantCode = 'DS20031'; // dari duitku
            $apiKey = '8c98ceb5b29429b26bfcd384d5f76d02'; // dari duitku
            $paymentAmount = $finalPrice;
            $paymentMethod = $PaymentSelected; // VC = Credit Card
            $merchantOrderId = time() . ''; // dari merchant, unik
            $productDetails = 'Tes pembayaran menggunakan Duitku';
            $email = $CustomerEmail; // email pelanggan anda
            $phoneNumber = $CustomerHandphone; // nomor telepon pelanggan anda (opsional)
            $additionalParam = ''; // opsional
            $merchantUserInfo = ''; // opsional
            $customerVaName = $CustomerName; // tampilan nama pada tampilan konfirmasi bank
            $callbackUrl = '{$BaseHref}/duitkupayment/callback'; // url untuk callback
            $returnUrl = '/marketplace'; // url untuk redirect
            $expiryPeriod = 10; // atur waktu kadaluarsa dalam hitungan menit
            $signature = md5($merchantCode . $merchantOrderId . $paymentAmount . $apiKey);
            $paymentData = [
                'MerchantCode' => $merchantCode,
                'ApiKey' => $apiKey,
                'PaymentAmount' => $paymentAmount,
                'PaymentMethod' => $paymentMethod,
                'MerchantOrderId' => $merchantOrderId,
                'ProductDetails' => $productDetails,
                'Email' => $email,
                'PhoneNumber' => $phoneNumber,
                'AdditionalParam' => $additionalParam,
                'MerchantUserInfo' => $merchantUserInfo,
                'CustomerVaName' => $customerVaName,
                'CallbackUrl' => $callbackUrl,
                'ReturnUrl' => $returnUrl,
                'ExpiryPeriod' => $expiryPeriod,
                'Signature' => $signature,
            ];
            // Customer Detail
            $firstName = $CustomerName;
            $lastName = "";

            // Address
            $alamat = $CustomerAddress;
            // $city = $addressDetCus;
            $postalCode = "";
            $countryCode = "ID";

            $address = array(
                'firstName' => $firstName,
                'lastName' => $lastName,
                'address' => $alamat,
                // 'city' => $city,
                'postalCode' => $postalCode,
                'phone' => $phoneNumber,
                'countryCode' => $countryCode
            );

            $customerDetail = array(
                'firstName' => $firstName,
                'lastName' => $lastName,
                'email' => $email,
                'phoneNumber' => $phoneNumber,
                'billingAddress' => $address,
                'shippingAddress' => $address
            );
            $params = array(
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
                'expiryPeriod' => $expiryPeriod
            );

            $params_string = json_encode($params);
            $url = 'https://sandbox.duitku.com/webapi/api/merchant/v2/inquiry'; // Sandbox
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
            
            if ($postData) {
                $products = $postData;
                // Debug::show($products);
                // die();
                if (!empty($products)) {
                    $firstItemProcessed = false;
                    
                    foreach ($products as $product) {
                        // Debug::show($_FILES['ProofImage']);
                        // die();
                        $ProductID = $product['ProductID'];
                        $ProductCartID = $product['ProductCartID'];
                        $ProductTitle = $product['ProductTitle'];
                        $ProductImage = $product['ProductImage'];
                        $ProductVariant = $product['ProductVariant'];
                        $ProductVariantID = $product['ProductVariantID'];
                        $ProductVariantWeight = $product['ProductVariantWeight'];
                        $ProductPrice = $product['ProductPrice'];
                        $ProductQuantity = $product['ProductQuantity'];
                        $ProductTotalPrice = $product['ProductTotalPrice'];
                        $ProductSubTotalPrice = $product['ProductSubTotalPrice'];
                        $ProductCostShipping = $product['ProductCostShipping'];
                        $ProductFinalPrice = $product['ProductFinalPrice'];
                        $CustomerName = $product['CustomerName'];
                        $CustomerFullName = $product['CustomerFullName'];
                        $CustomerEmail = $product['CustomerEmail'];
                        $CustomerHandphone = $product['CustomerHandphone'];
                        $CustomerAddress = $product['CustomerAddress'];
                        $CustomerNotes = $product['CustomerNotes'];
                        // $OrderID = $merchantOrderId;
                        $Bank = $product['Bank'];
                        $TimeCheckout = $product['TimeCheckout'];
                        $PaymentMethod = $product['PaymentMethod'];
                        $debugData = [
                            'ProductID' => $product['ProductID'],
                            'CartID' => $product['ProductCartID'],
                            'ProductTitle' => $product['ProductTitle'],
                            'ProductImage' => $product['ProductImage'],
                            'VariantName' => $product['ProductVariant'],
                            'VariantID' => $product['ProductVariantID'],
                            'Price' => $product['ProductPrice'],
                            'SubTotalPrice' => $product['ProductSubTotalPrice'],
                            'Quantity' => $product['ProductQuantity'],
                            'F' => $product['ProductCostShipping'],
                            'FinalPrice' => $product['ProductFinalPrice'],
                            'Name' => $product['CustomerName'],
                            'Number' => $product['CustomerHandphone'],
                            'Address' => $product['CustomerAddress'],
                            'AddressDetail' => $product['CustomerNotes'],
                            'OrderID' => $merchantOrderId,
                            'Bank' => $product['Bank'],
                            'Comments' => $product['CustomerNotes'],
                            'TimeCheckout' => $product['TimeCheckout']
                        ];                                      
                        // Debug::show($debugData);
                        // die();           
                        
                        try {
                            $checkoutItem = ProductCheckoutObject::create();
                            $checkoutItem->ProductID = $ProductID;
                            $checkoutItem->ProductCartID = $ProductCartID;
                            $checkoutItem->ProductTitle = $ProductTitle;
                            $checkoutItem->ProductImage = $ProductImage;
                            $checkoutItem->ProductVariant = $ProductVariant;
                            $checkoutItem->ProductVariantID = $ProductVariantID;
                            $checkoutItem->ProductVariantWeight = $ProductVariantWeight;
                            $checkoutItem->ProductPrice = $ProductPrice;
                            $checkoutItem->ProductQuantity = $ProductQuantity;
                            $checkoutItem->ProductTotalPrice = $ProductTotalPrice;
                            $checkoutItem->ProductSubTotalPrice = $ProductSubTotalPrice;
                            $checkoutItem->ProductCostShipping = $ProductCostShipping;
                            $checkoutItem->ProductFinalPrice = $ProductFinalPrice;
                            $checkoutItem->OrderId = $merchantOrderId;
                            $member = Security::getCurrentUser();
                            if ($member) {
                                $checkoutItem->MemberID = $member->ID;
                            }
                            if (!$firstItemProcessed) {
                                $checkoutHeader = ProductCheckoutHeaderObject::create();
                                $checkoutHeader->OrderID = $merchantOrderId;
                                $checkoutHeader->CustomerName = $CustomerName;
                                $checkoutHeader->CustomerFullName = $CustomerFullName;
                                $checkoutHeader->CustomerEmail = $CustomerEmail;
                                $checkoutHeader->CustomerHandphone = $CustomerHandphone;
                                $checkoutHeader->CustomerAddress = $CustomerAddress;
                                $checkoutHeader->CustomerNotes = $CustomerNotes;
                                $checkoutHeader->FinalPrice = $ProductFinalPrice;
                                $checkoutHeader->Bank = $PaymentSelected;
                                $checkoutHeader->TimeCheckout = $TimeCheckout;
                                $checkoutHeader->PaymentMethod = $PaymentMethode;
                                $checkoutHeader->write();
                                $firstItemProcessed = true;
                            }
                            $checkoutItem->HeaderCheckoutID = $checkoutHeader->ID;
                            $checkoutItem->write();
                            
                            $cartItem = CartObject::get()->byID($ProductCartID);
                            if ($cartItem) {
                                $cartItem->delete();
                            }
                        } catch (ValidationException $e) {
                            Debug::show("iso2");
                        }
                    }
                }
            } else {
                Debug::show("gaiso");
            }
            if($httpCode == 200)
            {
                $result = json_decode($request, true);
                echo json_encode($result);
            }
            else
            {
                $request = json_decode($request);
                $error_message = "Server Error " . $httpCode ." ". $request->Message;
                echo $error_message;
            }
        }
    }
    public function manualTF(HTTPRequest $request){
        if ($request->isPOST()) {
            // Debug::show($request);
            // die();
            $postData = json_decode($request->postVar('paymentDatas'), true);
            $finalPrice = $postData[0]['ProductFinalPriceNF'];
            $PaymentSelected = $postData[0]['Bank'];
            $PaymentMethode = $postData[0]['PaymentMethod'];
            $TimeCheckout = $postData[0]['TimeCheckout'];
            $CustomerName = $postData[0]['CustomerName'];
            $CustomerEmail = $postData[0]['CustomerEmail'];
            $CustomerHandphone = $postData[0]['CustomerHandphone'];
            $CustomerAddress = $postData[0]['CustomerAddress'];
            $CustomerNotes = $postData[0]['CustomerNotes'];
            $merchantOrderId = $postData[0]['OrderID'];
            // Debug::show($postData[0]);
            // die();
            if ($postData) {
                $products = $postData;
                if (!empty($products)) {
                    $results = [];
                    $firstItemProcessed = false;
                    
                    foreach ($products as $product) {
                        $OrderID = $product['OrderID'];
                        $ProductID = $product['ProductID'];
                        $ProductCartID = $product['ProductCartID'];
                        $ProductTitle = $product['ProductTitle'];
                        $ProductImage = $product['ProductImage'];
                        $ProductVariant = $product['ProductVariant'];
                        $ProductVariantID = $product['ProductVariantID'];
                        $ProductVariantWeight = $product['ProductVariantWeight'];
                        $ProductPrice = $product['ProductPrice'];
                        $ProductQuantity = $product['ProductQuantity'];
                        $ProductTotalPrice = $product['ProductTotalPrice'];
                        $ProductSubTotalPrice = $product['ProductSubTotalPrice'];
                        $ProductCostShipping = $product['ProductCostShipping'];
                        $ProductFinalPrice = $product['ProductFinalPrice'];
                        $CustomerName = $product['CustomerName'];
                        $CustomerFullName = $product['CustomerFullName'];
                        $CustomerEmail = $product['CustomerEmail'];
                        $CustomerHandphone = $product['CustomerHandphone'];
                        $CustomerAddress = $product['CustomerAddress'];
                        $CustomerNotes = $product['CustomerNotes'];
                        // $OrderID = $merchantOrderId;
                        $Bank = $product['Bank'];
                        $TimeCheckout = $product['TimeCheckout'];
                        $PaymentMethod = $product['PaymentMethod'];
                        $debugData = [
                            'ProductID' => $product['ProductID'],
                            'CartID' => $product['ProductCartID'],
                            'ProductTitle' => $product['ProductTitle'],
                            'ProductImage' => $product['ProductImage'],
                            'VariantName' => $product['ProductVariant'],
                            'VariantID' => $product['ProductVariantID'],
                            'Price' => $product['ProductPrice'],
                            'SubTotalPrice' => $product['ProductSubTotalPrice'],
                            'Quantity' => $product['ProductQuantity'],
                            'F' => $product['ProductCostShipping'],
                            'FinalPrice' => $product['ProductFinalPrice'],
                            'Name' => $product['CustomerName'],
                            'Number' => $product['CustomerHandphone'],
                            'Address' => $product['CustomerAddress'],
                            'AddressDetail' => $product['CustomerNotes'],
                            'OrderID' => $merchantOrderId,
                            'Bank' => $product['Bank'],
                            'Comments' => $product['CustomerNotes'],
                            'TimeCheckout' => $product['TimeCheckout']
                        ];  
                        // Debug::show($debugData);
                        // die();
                        
                        try {
                            $checkoutItem = ProductCheckoutObject::create();
                            $checkoutItem->ProductID = $ProductID;
                            $checkoutItem->ProductCartID = $ProductCartID;
                            $checkoutItem->ProductTitle = $ProductTitle;
                            $checkoutItem->ProductImage = $ProductImage;
                            $checkoutItem->ProductVariant = $ProductVariant;
                            $checkoutItem->ProductVariantID = $ProductVariantID;
                            $checkoutItem->ProductVariantWeight = $ProductVariantWeight;
                            $checkoutItem->ProductPrice = $ProductPrice;
                            $checkoutItem->ProductQuantity = $ProductQuantity;
                            $checkoutItem->ProductTotalPrice = $ProductTotalPrice;
                            $checkoutItem->ProductSubTotalPrice = $ProductSubTotalPrice;
                            $checkoutItem->ProductCostShipping = $ProductCostShipping;
                            $checkoutItem->ProductFinalPrice = $ProductFinalPrice;
                            $checkoutItem->OrderId = $merchantOrderId;
                            $member = Security::getCurrentUser();
                            if ($member) {
                                $checkoutItem->MemberID = $member->ID;
                            }
                            if (!$firstItemProcessed) {
                                $checkoutHeader = ProductCheckoutHeaderObject::create();
                                $checkoutHeader->OrderID = $merchantOrderId;
                                $checkoutHeader->CustomerName = $CustomerName;
                                $checkoutHeader->CustomerFullName = $CustomerFullName;
                                $checkoutHeader->CustomerEmail = $CustomerEmail;
                                $checkoutHeader->CustomerHandphone = $CustomerHandphone;
                                $checkoutHeader->CustomerAddress = $CustomerAddress;
                                $checkoutHeader->CustomerNotes = $CustomerNotes;
                                $checkoutHeader->FinalPrice = $ProductFinalPrice;
                                $checkoutHeader->Bank = $PaymentSelected;
                                $checkoutHeader->TimeCheckout = $TimeCheckout;
                                $checkoutHeader->PaymentMethod = $PaymentMethode;
                                $checkoutHeader->write();
                                $firstItemProcessed = true;
                                if(isset($_FILES['ProofImage'])){
                                    $upload = new Upload();
                                    $img = new Image();
                                    $upload->loadIntoFile($_FILES['ProofImage'], $img);
                                    
                                    if (!$upload->isError()) {
                                        $checkoutHeader->ProofImage = $img->ID;
                                    }
                                }
                                $checkoutHeader->write();
                                $firstItemProcessed = true;
                            }
                            $checkoutItem->HeaderCheckoutID = $checkoutHeader->ID;
                            $checkoutItem->write();
                            
                            $cartItem = CartObject::get()->byID($ProductCartID);
                            if ($cartItem) {
                                $cartItem->delete();
                            }
                            $results[] = ['success' => true, 'productID' => $ProductID];
                        } catch (ValidationException $e) {
                            $results[] = ['success' => false, 'productID' => $ProductID, 'message' => $e->getMessage()];
                        }
                    }
    
                    if (count($results) === count($products)) {
                        return json_encode(['success' => true, 'results' => $results]);
                    } else {
                        return json_encode(['success' => false, 'results' => $results]);
                    }
                } else {
                    return json_encode(['success' => false, 'message' => 'Empty data received']);
                }
            } else {
                return json_encode(['success' => false, 'message' => 'Invalid data format']);
            }
        }
    
        return json_encode(['success' => false, 'message' => 'No data received']);
    }
    public function cash(HTTPRequest $request){
        if ($request->isPOST()) {
            // Debug::show($request);
            // die();
            $postData = json_decode($request->postVar('paymentDatas'), true);
            // Debug::show($postData);
            // die();
            $finalPrice = $postData[0]['ProductFinalPriceNF'];
            $PaymentSelected = $postData[0]['Bank'];
            $PaymentMethode = $postData[0]['PaymentMethod'];
            $TimeCheckout = $postData[0]['TimeCheckout'];
            $CustomerName = $postData[0]['CustomerName'];
            $CustomerEmail = $postData[0]['CustomerEmail'];
            $CustomerHandphone = $postData[0]['CustomerHandphone'];
            $CustomerAddress = $postData[0]['CustomerAddress'];
            $CustomerNotes = $postData[0]['CustomerNotes'];
            $merchantOrderId = $postData[0]['OrderID'];
            if ($postData) {
                $products = $postData;
                if (!empty($products)) {
                    $results = [];
                    $firstItemProcessed = false;
                    
                    foreach ($products as $product) {
                        $OrderID = $product['OrderID'];
                        $ProductID = $product['ProductID'];
                        $ProductCartID = $product['ProductCartID'];
                        $ProductTitle = $product['ProductTitle'];
                        $ProductImage = $product['ProductImage'];
                        $ProductVariant = $product['ProductVariant'];
                        $ProductVariantID = $product['ProductVariantID'];
                        $ProductVariantWeight = $product['ProductVariantWeight'];
                        $ProductPrice = $product['ProductPrice'];
                        $ProductQuantity = $product['ProductQuantity'];
                        $ProductTotalPrice = $product['ProductTotalPrice'];
                        $ProductSubTotalPrice = $product['ProductSubTotalPrice'];
                        $ProductCostShipping = $product['ProductCostShipping'];
                        $ProductFinalPrice = $product['ProductFinalPrice'];
                        $CustomerName = $product['CustomerName'];
                        $CustomerFullName = $product['CustomerFullName'];
                        $CustomerEmail = $product['CustomerEmail'];
                        $CustomerHandphone = $product['CustomerHandphone'];
                        $CustomerAddress = $product['CustomerAddress'];
                        $CustomerNotes = $product['CustomerNotes'];
                        // $OrderID = $merchantOrderId;
                        $Bank = $product['Bank'];
                        $TimeCheckout = $product['TimeCheckout'];
                        $PaymentMethod = $product['PaymentMethod'];
                        $debugData = [
                            'ProductID' => $product['ProductID'],
                            'CartID' => $product['ProductCartID'],
                            'ProductTitle' => $product['ProductTitle'],
                            'ProductImage' => $product['ProductImage'],
                            'VariantName' => $product['ProductVariant'],
                            'VariantID' => $product['ProductVariantID'],
                            'Price' => $product['ProductPrice'],
                            'SubTotalPrice' => $product['ProductSubTotalPrice'],
                            'Quantity' => $product['ProductQuantity'],
                            'F' => $product['ProductCostShipping'],
                            'FinalPrice' => $product['ProductFinalPrice'],
                            'Name' => $product['CustomerName'],
                            'Number' => $product['CustomerHandphone'],
                            'Address' => $product['CustomerAddress'],
                            'AddressDetail' => $product['CustomerNotes'],
                            'OrderID' => $merchantOrderId,
                            'Bank' => $product['Bank'],
                            'Comments' => $product['CustomerNotes'],
                            'TimeCheckout' => $product['TimeCheckout']
                        ];  
                        
                        try {
                            $checkoutItem = ProductCheckoutObject::create();
                            $checkoutItem->ProductID = $ProductID;
                            $checkoutItem->ProductCartID = $ProductCartID;
                            $checkoutItem->ProductTitle = $ProductTitle;
                            $checkoutItem->ProductImage = $ProductImage;
                            $checkoutItem->ProductVariant = $ProductVariant;
                            $checkoutItem->ProductVariantID = $ProductVariantID;
                            $checkoutItem->ProductVariantWeight = $ProductVariantWeight;
                            $checkoutItem->ProductPrice = $ProductPrice;
                            $checkoutItem->ProductQuantity = $ProductQuantity;
                            $checkoutItem->ProductTotalPrice = $ProductTotalPrice;
                            $checkoutItem->ProductSubTotalPrice = $ProductSubTotalPrice;
                            $checkoutItem->ProductCostShipping = $ProductCostShipping;
                            $checkoutItem->ProductFinalPrice = $ProductFinalPrice;
                            $checkoutItem->OrderId = $merchantOrderId;
                            $member = Security::getCurrentUser();
                            if ($member) {
                                $checkoutItem->MemberID = $member->ID;
                            }
                            if (!$firstItemProcessed) {
                                $checkoutHeader = ProductCheckoutHeaderObject::create();
                                $checkoutHeader->OrderID = $merchantOrderId;
                                $checkoutHeader->CustomerName = $CustomerName;
                                $checkoutHeader->CustomerFullName = $CustomerFullName;
                                $checkoutHeader->CustomerEmail = $CustomerEmail;
                                $checkoutHeader->CustomerHandphone = $CustomerHandphone;
                                $checkoutHeader->CustomerAddress = $CustomerAddress;
                                $checkoutHeader->CustomerNotes = $CustomerNotes;
                                $checkoutHeader->FinalPrice = $ProductFinalPrice;
                                $checkoutHeader->Bank = $PaymentSelected;
                                $checkoutHeader->TimeCheckout = $TimeCheckout;
                                $checkoutHeader->PaymentMethod = $PaymentMethode;
                                $checkoutHeader->write();
                                $firstItemProcessed = true;
                            }
                            $checkoutItem->HeaderCheckoutID = $checkoutHeader->ID;
                            $checkoutItem->write();
                            
                            $cartItem = CartObject::get()->byID($ProductCartID);
                            if ($cartItem) {
                                $cartItem->delete();
                            }
                            $results[] = ['success' => true, 'productID' => $ProductID];
                        } catch (ValidationException $e) {
                            $results[] = ['success' => false, 'productID' => $ProductID, 'message' => $e->getMessage()];
                        }
                    }
    
                    if (count($results) === count($products)) {
                        return json_encode(['success' => true, 'results' => $results]);
                    } else {
                        return json_encode(['success' => false, 'results' => $results]);
                    }
                } else {
                    return json_encode(['success' => false, 'message' => 'Empty data received']);
                }
            } else {
                return json_encode(['success' => false, 'message' => 'Invalid data format']);
            }
        }
    
        return json_encode(['success' => false, 'message' => 'No data received']);
    }
}