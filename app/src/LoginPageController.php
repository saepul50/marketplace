<?php 

use SilverStripe\Control\Email\Email;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Control\Session;
use SilverStripe\Dev\Debug;
use SilverStripe\Security\Member;
use SilverStripe\Security\MemberAuthenticator\LoginHandler;
use SilverStripe\Security\MemberAuthenticator\MemberAuthenticator;
use SilverStripe\Security\Security;
use SilverStripe\SiteConfig\SiteConfig;

class  LoginPageController extends PageController{
    private static $allowed_actions = [
        'proseslogin',
        'prosesregistrasi',
        'sendlink'
    ];
    public function getMember() {
        $member = Security::getCurrentUser();
        if ($member) {
            return $member;
        }
        return null;
    }
    public function proseslogin(HTTPRequest $request)
    {
        $email = $request->postVar('Email');
        $password = $request->postVar('Password');
        
        $data = [
            'Email' => $email,
            'Password' => $password
        ];

        $MemberAuthenticator = new MemberAuthenticator();
        $loginHandler = new LoginHandler('auth', $MemberAuthenticator);
        $member = $loginHandler->checkLogin($data, $request);
        
        if($member){
            $loginHandler->performLogin($member, $data, $request);
            return json_encode(['success' => true]);
        } else {
            return json_encode([
                'success' => false,
                'message' => 'gaiso'
            ]);
        }
    }
    public function prosesregistrasi(HTTPRequest $request){
        $firstname = $request->postVar('FirstName');
        $lastname  = $request->postVar('SurName');
        $email      = $request->postVar('Email');
        $password = $request->postVar('Password');
        $confirmPassword = $request->postVar('ConfirmPassword');
        
        if ($password !== $confirmPassword) {
            return json_encode([
                'message' => 'Passwords do not match'
            ]);
        }

        # Create the member
        $member            = Member::create();
        $member->FirstName = $firstname;
        $member->Surname   = $lastname;
        $member->Email     = $email;
        $member->changePassword($password);
        $member->write();

        return json_encode([
            'success' => true,
            'message' => 'Account Registered'
        ]);
    }
    public function sendlink(HTTPRequest $request){
        $emails = $request->postVar('Email');
        $member = Member::get()->filter('Email', $emails)->first();
        // Debug::show($member);
        if($member){
        $emails = $request->postVar('Email');
            $forgetpassword = ForgetPassword::create();
            $forgetpassword->MemberID = $member->ID;
            $forgetpassword->Unique =  $s = substr(str_shuffle(str_repeat("0123456789ABCDEFGHIJKLMNOPGRSTUFWXYZ", 10)), 0, 10);
            $forgetpassword->write();
            $siteconfig = SiteConfig::current_site_config();
            // Debug::show($forgetpassword);
            $email = new Email();
            $email->setTo($emails);
            $email->setFrom($siteconfig->Email);
            $email->setSubject('Your Link Forget Password');
            $email->setBody('http://localhost/marketplace/forgetpassword/for/'. $forgetpassword->Unique  );
            $email->send();
            return json_encode([
                'success' => true,
                'message' => 'Link sudah diberikan Ke alamat email anda'
            ]);
        } 
        return json_encode([
            'success' => false,
            'message' => 'Email Tidak Ditemukan'
        ]);
    }
}