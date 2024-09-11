<?php 

use SilverStripe\Control\HTTPRequest;
use SilverStripe\Control\Session;
use SilverStripe\Dev\Debug;
use SilverStripe\Security\Member;
use SilverStripe\Security\MemberAuthenticator\LoginHandler;
use SilverStripe\Security\MemberAuthenticator\MemberAuthenticator;
use SilverStripe\Security\Security;

class  LoginPageController extends PageController{
    private static $allowed_actions = [
        'proseslogin',
        'prosesregistrasi',
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
            $session = $request->getSession();
            $session->set('MemberID', $member->ID);
            // Debug::show(''. $member->FirstName);
            return json_encode([
                'success' => true
            ]);
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
}