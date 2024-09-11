<?php 
use SilverStripe\Dev\Debug;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Security\Member;


class RegisPageController extends PageController{

    private static $allowed_actions = [
        'prosesregister',
    ];
    public function prosesregister(HTTPRequest $request)
    {
        // Debug::show($request->postVars());
        $first_name = $request->postVar('FirstName');
        $email = $request->postVar('Email');
        $username = $request->postVar('Username');
        $password_1 = $request->postVar('Password');
        $password_2 = $request->postVar('ConfirmPassword');

        if ($password_1 !== $password_2) {
            return json_encode([
                'message' => 'Passwords do not match'
            ]);
        }
        
        // Create the member
        $member = Member::create();
        $member->FirstName = $first_name;
        $member->Surname = $username;
        $member->Email = $email;
        $member->write();
        
        return json_encode([
            'success' => true,
            'message'=> 'Success'
        ]);
    }

}