<?php 

use SilverStripe\Dev\Debug;
use SilverStripe\Control\Director;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Core\Injector\Injector;
use SilverStripe\ORM\ValidationResult;
use SilverStripe\Security\MemberAuthenticator\LoginHandler;
use SilverStripe\Security\MemberAuthenticator\MemberAuthenticator;
class  LoginPageController extends PageController{
    private static $allowed_actions = [
        'proseslogin'
    ];
    public function proseslogin(HTTPRequest $request)
    {
        $name = $request->postVar('Email');
        $pw = $request->postVar('Password');
        
        $data = [
            'Email' => $name,
            'Password' => $pw
        ];

        $MemberAuthenticator = new MemberAuthenticator;
        $loginHandler = new LoginHandler('auth', $MemberAuthenticator);
        
        
        // Attempt to authenticate the user
        $member = $loginHandler->checkLogin($data, $request);

        if ($member) {
            // Successful login
            $loginHandler->performLogin($member, $data, $request);
            
            return json_encode([
                'success' => true,
                'message' => 'Success'
                
            ]);

        } else {
        
            // Authentication failed
            return json_encode([
                'success' => false,
                'message' => 'The provided details dont seem to be correct. Please try again.'
            ]);
        }
        
    }

}