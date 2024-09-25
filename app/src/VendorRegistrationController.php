<?php
use SilverStripe\Control\Director;
use SilverStripe\Dev\Debug;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Security\Security;


class VendorRegistrationController extends PageController{
    private static $allowed_actions=[
        'handelprofile',
        'handeleditprofile',
    ];
    public function index(){
        $member = Security::getCurrentUser();
        $toko = DataToko::get()->filter('MemberID', $member->ID);
        // Debug::show($toko);

        return  [
            'Toko' => $toko,
        ];
    }

    public function handelprofile(HTTPRequest $request){
        $member = Security::getCurrentUser();
        $data = $request->postVars();
        Debug::show($data);
        $toko = DataToko::create();
        $toko->NamaToko = $data['NamaToko'];
        $toko->MemberID = $member->ID;
        $toko->Email = $data['Email'];
        $toko->NomerHandPhone = $data['NomerHandPhone'];
        $toko->DeskripsiToko = $data['Message'];
        $toko->ImageBase64 = $data['Image'];
        $toko->write();
    }

    public function handeleditprofile(HTTPRequest $request){
        $member = Security::getCurrentUser();
        $data = $request->postVars();
        Debug::show($data);
        $toko = DataToko::get()->filter('MemberID', $member->ID)->first();
        $toko->NamaToko = $data['NamaToko'];
        $toko->Email = $data['Email'];
        $toko->NomerHandPhone = $data['NomerHandPhone'];
        $toko->DeskripsiToko = $data['Message'];
        $toko->ImageBase64 = $data['Image'];
        $toko->ProvinsiID = $data['Provinsi'];
        $toko->RegencyID = $data['Regency'];
        $toko->write();

    }
} 