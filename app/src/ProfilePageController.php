<?php

use SilverStripe\Assets\Image;
use SilverStripe\Assets\Upload;
use SilverStripe\Control\Email\Email;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\Security\Member;
use SilverStripe\Security\PasswordValidator;
use SilverStripe\Security\Security;
use SilverStripe\SiteConfig\SiteConfig;

class ProfilePageController extends PageController{
    private static $allowed_actions = [
        'ChangeData',
        'SentOTP',
        'CheckOTP',
        'ChangePass',
    ];
    public function index() {
        $data = $this->nepo(); // Call the nepo() method from PageController
        $member = Security::getCurrentUser();
        // Debug::show($member);
        return [
            'Account' =>$member,
            'Notif' => $data['Notif'] ?? null,
            'Product' => $data['Product'] ?? null,
            'Count' => $data['Count'] ?? null,
        ];
    }
    public function Vendor() {
        $member = Security::getCurrentUser();
        if($member){
            $vendor = Vendor::get()->filter('OwnerID', $member->ID)->first();
            if ($vendor) {
                return $vendor;
            }
            return null;
        }
    }
    public function ChangeData(HTTPRequest $request){
        $ChangeData = json_decode($request->postVar('dataChange'));
        $UserID = $ChangeData->UserID;
        $FirstName = $ChangeData->FirstName;
        $LastName = $ChangeData->LastName;
        $Account = Member::get()->byID($UserID);
        $changes = [];
        // Debug::show($Account);
        // die();
        if ($Account) {
            if ($Account->FirstName != $FirstName) {
                $Account->FirstName = $FirstName;
                $changes[] = 'FirstName';
            }
    
            if ($Account->Surname != $LastName) {
                $Account->Surname = $LastName;
                $changes[] = 'LastName';
            }
    
            if (isset($_FILES['profileChange']) && $_FILES['profileChange']['size'] > 0) {
                $upload = new Upload();
                $img = new Image();
                $upload->loadIntoFile($_FILES['profileChange'], $img);
                
                if (!$upload->isError()) {
                    if ($Account->ProfileImageID != $img->ID) {
                        $Account->ProfileImageID = $img->ID;
                        $changes[] = 'ProfileImage';
                    }
                }
            }
    
            $Account->write();
    
            return json_encode([
                'success' => true,
                'message' => 'Success Updated Data',
                'changedFields' => $changes
            ]);
        }
    
        return json_encode([
            'success' => false,
            'message' => 'User not found'
        ]);
    }
    public function SentOTP(HTTPRequest $request){
        $member = Security::getCurrentUser();
        $data = json_decode($request->postVar('ChangePass'),true);
        // Debug::show($data);
        // die();
        $otp = $data['CodeOTP'];
        $expiryTime = date('Y-m-d H:i:s', strtotime('+180 seconds'));
        $siteconfig = SiteConfig::current_site_config();
        $send = $siteconfig->Email;
        // Debug::show($send);
        // die();
        $email = new Email();
        $email->setTo($data['EmailChange']);
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
    public function CheckOTP(HTTPRequest $request){
        $Account = Security::getCurrentUser();
        $otpcode = $request->postVar('OTPCode');
        $getotps = DataSend::get()->filter('UserID', $Account->ID);
        $matchFound = false;

        foreach ($getotps as $getotp) {
            if ($otpcode == $getotp->Codeotp) {
                if (strtotime($getotp->ExpiryTime) >= time()) {
                    $matchFound = true;
                    return json_encode(['success' => true, 'message' => 'Ok']);
                } else {
                    return json_encode(['success' => false, 'message' => 'Kode OTP telah kedaluwarsa']);
                }
            }
        }
        if (!$matchFound) {
            return json_encode(['success' => false, 'message' => 'Kode OTP Salah']);
        }
    }
    public function ChangePass(HTTPRequest $request)
    {
        $Account = Security::getCurrentUser();
        if ($Account) {
            $NewPassword = $request->postVar('NewPassword');
            if ($NewPassword) {
                $validator = new PasswordValidator();
                $validationResult = $validator->validate($NewPassword, $Account);

                if ($validationResult->isValid()) {
                    $Account->changePassword($NewPassword);
                    $Account->write();

                    return [
                        'Success' => true,
                        'Message' => 'Password berhasil diubah.'
                    ];
                } else {
                    return [
                        'Success' => false,
                        'Message' => $validationResult->getMessages()
                    ];
                }
            }
        }

        return [
            'Success' => false,
            'Message' => 'Akun Tidak Ada'
        ];
    }
}
