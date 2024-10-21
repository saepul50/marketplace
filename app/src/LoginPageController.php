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
            $forgetpassword->Unique = substr(str_shuffle(str_repeat("0123456789ABCDEFGHIJKLMNOPGRSTUFWXYZ", 10)), 0, 10);
            $forgetpassword->ExpDate = date('Y-m-d H:i:s', strtotime('+24 hours'));
            $forgetpassword->write();
            $siteconfig = SiteConfig::current_site_config();
            $email = new Email();
            $email->setTo($emails);
            $email->setFrom($siteconfig->Email);
            $email->setSubject('Password Change Request');
            $email->setBody('
            <div style="color:black;">
                <div>
                    <h1>' . $siteconfig->Title . '</h1>
                </div>
                <h3> Change your password</h3>
                <p>We Have Received a password change from you Karma account '.$emails. '.</p>
                <p>if you not request change password,you can ignore this email and your password not change.This link active for 24 Hours.</p>
                <p>This below is your link reset password</p>
                <a  href="http://localhost/marketplace/forgetpassword/for/'. $forgetpassword->Unique .'">
                    <button style="display: block;
                        border-radius: 0px;
                        line-height: 38px;
                        width: 25%;
                        text-transform: uppercase;
                        border: none;
                        osition: relative;
                        overflow: hidden;
                        color: #fff;
                        padding: 0 30px;
                        line-height: 35px;
                        border-radius: 6px;
                        display: inline-block;
                        text-transform: uppercase;
                        font-weight: 500;
                        cursor: pointer;
                        -webkit-transition: all 0.3s ease 0s;
                        -moz-transition: all 0.3s ease 0s;
                        -o-transition: all 0.3s ease 0s;
                        transition: all 0.3s ease 0s;
                            background: -webkit-linear-gradient(90deg, #ffba00 0%, #ff6c00 100%);
                        background: -moz-linear-gradient(90deg, #ffba00 0%, #ff6c00 100%);
                        background: -o-linear-gradient(90deg, #ffba00 0%, #ff6c00 100%);
                        background: linear-gradient(90deg, #ffba00 0%, #ff6c00 100%);"
                    >Click Here</button>
                </a>
            </div>
            ' );
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