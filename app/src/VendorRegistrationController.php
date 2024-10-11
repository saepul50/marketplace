<?php

use SilverStripe\Assets\Image;
use SilverStripe\Assets\Upload;
use SilverStripe\Control\Director;
use SilverStripe\Control\Email\Email;
use SilverStripe\Dev\Debug;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Security\Group;
use SilverStripe\Security\Security;
use SilverStripe\SiteConfig\SiteConfig;

class VendorRegistrationController extends PageController{
    private static $allowed_actions=[
        'newVendor',
        'editVendor',
        'dataInformasi',
        'codeotp',
    ];
    public function index(HTTPRequest $request){
        $member = Security::getCurrentUser();
        if($member){
            $vendor = Vendor::get()->filter('MemberID', $member->ID);
            $VendorData = $request->getSession()->get('VendorData');
            $data = $this->nepo();

            return  [
                'Notif' => $data['Notif'],
                'Product' => $data['Product'],
                'Count' => $data['Count'],

                'Vendor' => $vendor,
                'VendorData' => $VendorData
            ];
        }
        return $this->redirect('login');
    }
    public function dataInformasi(HTTPRequest $request){
        if ($request) {
            $VendorEmail = $request->postVar('VendorEmail');
            $VendorPhone = $request->postVar('VendorPhone');
            $VendorAddress = $request->postVar('VendorAddress');
            $VendorAddressDet = $request->postVar('VendorAddressDetail');
            $VendorProv = $request->postVar('VendorProv');
            $VendorReg = $request->postVar('VendorReg');
            $VendorPost = $request->postVar('VendorPost');
            $requiredFields = [
                $VendorEmail, 
                $VendorPhone, 
                $VendorAddress, 
                $VendorAddressDet, 
                $VendorProv, 
                $VendorReg, 
                $VendorPost
            ];
            if (!in_array('', $requiredFields, true)) {
                $data = [
                    'VendorEmail' => $VendorEmail,
                    'VendorPhone' => $VendorPhone,
                    'VendorAddress' => $VendorAddress,
                    'VendorAddressDetail' => $VendorAddressDet,
                    'VendorProv' => $VendorProv,
                    'VendorReg' => $VendorReg,
                    'VendorPost' => $VendorPost,
                ];
                    // Debug::show($data);
                    // die();      
                $request->getSession()->set('VendorData', $data);

                return json_encode(['success' => true]);
            } else {
                return json_encode(['success' => false, 'message' => 'Incomplete data received']);
            }
        }

        return json_encode(['success' => false, 'message' => 'No data received']);
    }
    public function newVendor(HTTPRequest $request){
        $member = Security::getCurrentUser();
        $data = json_decode($request->postVar('DataVendor'),true);
        $getotps = DataSend::get()->filter('UserID', $member->ID);
        $otpcode = $data['CodeOTP'];
        $matchFound = false;

        foreach ($getotps as $getotp) {
            if ($otpcode == $getotp->Codeotp) {
                if (strtotime($getotp->ExpiryTime) >= time()) {
                    $matchFound = true;
                    $vendor = Vendor::create();
                    $vendor->Name = $data['VendorName'];
                    $vendor->OwnerID = $member->ID;
                    $vendor->EmailOwner = $data['VendorEmail'];
                    $vendor->HandphoneOwner = $data['VendorPhone'];
                    $vendor->Description = $data['VendorDescription'];
                    $vendor->Address = $data['VendorAddress'];
                    $vendor->AddressDetail = $data['VendorAddressDetail'];
                    if(isset($_FILES['VendorImage'])){
                        $upload = new Upload();
                        $img = new Image();
                        $upload->loadIntoFile($_FILES['VendorImage'], $img);
                        
                        if (!$upload->isError()) {
                            $vendor->ProfilImageID = $img->ID;
                        }
                    }
                    $vendor->ProvinsiID = $data['VendorProv'];
                    $vendor->RegencyID = $data['VendorReg'];
                    $vendor->Postal = $data['VendorPost']; 
                    
                    $vendor->write();
                    $group = Group::get()->filter('Title', 'Seller')->first();
                                if ($group) {
                                    // Add the current user to the 'Seller' group
                                    $member->Groups()->add($group);
                                    $member->VendorID = $vendor->ID;
                                    $member->write();
                                }  
                    return json_encode(['success' => true, 'message' => 'Registrasi vendor berhasil!']);
                } else {
                    return json_encode(['success' => false, 'message' => 'Kode OTP telah kedaluwarsa']);
                }
            }
        }
        if (!$matchFound) {
            return json_encode(['success' => false, 'message' => 'Kode OTP Salah']);
        }
    }
    public function codeotp(HTTPRequest $request){
        $member = Security::getCurrentUser();
         
        // Debug::show($member->ID);
        // die();
        $data = json_decode($request->postVar('DataVendor'),true);
        // Debug::show($data);
        // die();
        $otp = $data['CodeOTP'];
        $expiryTime = date('Y-m-d H:i:s', strtotime('+30 seconds'));
        $siteconfig = SiteConfig::current_site_config();
        $send = $siteconfig->Email;
        // Debug::show($send);
        // die();
        $email = new Email();
        $email->setTo($data['VendorEmail']);
        $email->setFrom($send);
        $email->setSubject('Your OTP Code');
        $email->setBody("Your OTP code is: $otp");
        try {
            $email->send();
            $dataSend = DataSend::create();
            $dataSend->Codeotp = $otp;
            $dataSend->UserID = $member->ID;
            $dataSend->ExpiryTime = $expiryTime;
            $dataSend->write();
            return json_encode(['success' => true, 'message' => 'Email sent successfully']);
        } catch (Exception $e) {
            return json_encode(['success' => false, 'message' => 'Error sending email: ' . $e->getMessage()]);
        }
    }
    public function editVendor(HTTPRequest $request){
        $member = Security::getCurrentUser();
        $data = $request->postVars();
        $vendor = DataToko::get()->filter('MemberID', $member->ID)->first();
        $vendor->Name = $data['VendorName'];
        $vendor->EmailOwner = $data['Email'];
        $vendor->HandphoneOwner = $data['NomerHandPhone'];
        $vendor->Description = $data['Description'];
        if(isset($_FILES['ProfileImage'])){
            $upload = new Upload();
            $img = new Image();
            $upload->loadIntoFile($_FILES['ProfileImage'], $img);
            
            if (!$upload->isError()) {
                $vendor->ProfilImage = $img->ID;
            }
        }
        $vendor->ProvinsiID = $data['Provinsi'];
        $vendor->RegencyID = $data['Regency'];
        $vendor->write();

    }
} 