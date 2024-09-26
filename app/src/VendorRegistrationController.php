<?php

use SilverStripe\Assets\Image;
use SilverStripe\Assets\Upload;
use SilverStripe\Control\Director;
use SilverStripe\Dev\Debug;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Security\Security;


class VendorRegistrationController extends PageController{
    private static $allowed_actions=[
        'newVendor',
        'editVendor',
        'dataInformasi'
    ];
    public function index(HTTPRequest $request){
        $member = Security::getCurrentUser();
        $vendor = Vendor::get()->filter('MemberID', $member->ID);
        $VendorData = $request->getSession()->get('VendorData');
        return  [
            'Vendor' => $vendor,
            'VendorData' => $VendorData
        ];
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
        // Debug::show($member->ID);
        // die();
        $data = json_decode($request->postVar('DataVendor'),true);
        $vendor = Vendor::create();
        $vendor->Name = $data['VendorName'];
        $vendor->OwnerID = $member->ID;
        $vendor->EmailOwner = $data['VendorEmail'];
        $vendor->HandphoneOwner = $data['VendorPhone'];
        $vendor->Description = $data['VendorDescription'];
        $vendor->Address = $data['VendorDescription'];
        $vendor->AddressDetail = $data['VendorDescription'];
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