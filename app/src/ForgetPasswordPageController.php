<?php
use SilverStripe\Control\Director;
use SilverStripe\Dev\Debug;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Security\Member;

class ForgetPasswordPageController extends PageController{
    private static $allowed_actions = [
        'for',
        'changepass'
    ];

    public function changepass(HTTPRequest $request){
        $ID = $request->postVar('ID');
        $Pass = $request->postVar('Pw');
        $forgetpassword = ForgetPassword::get()->filter('Unique', $ID)->first();
        if($forgetpassword){
        $member = Member::get()->byID($forgetpassword->MemberID);
        $member->changePassword($Pass);
        $member->write();
        
        return json_encode([
            'success' => true,
            'messsage' => 'Password Anda Berhasil Diganti Silahkan Kembali ke Menu Login'
        ]);    
        } else {
            return json_encode([
                'success' => false,
                'messsage' => 'Terjadi Kesalahan'
            ]);  
        }
    }

    public function for (HTTPRequest $request) {
        $unique = $request->param('ID'); 
        $request->getSession()->set('Unique', $unique);
        $forgetpassword = ForgetPassword::get()->filter('Unique', $unique)->first();
    
        if ($forgetpassword && $forgetpassword->exists()) {

            return $this->customise([
                'ForgetPassword' => $forgetpassword->Unique
            ])->renderWith(["ForgetPasswordPage", "Page"]);
        } else {
            return $this->httpError(404, 'Invalid or expired reset link.');
        }
    }
    
}