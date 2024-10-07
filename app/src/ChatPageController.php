<?php

use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\Security\Member;
use SilverStripe\Security\Security;

    class ChatPageController extends PageController{
        public function index(HTTPRequest $request){
            $id = $request->param('ID');
            $vendor = Vendor::get()->byID($id);
            $vendors = Vendor::get();
            $member = Security::getCurrentUser();
            $chat = ChatObject::get();
            $memberID = $member->ID;
            // Debug::show($vendors);
            // die();   
            $data = $this->nepo(); // Call the nepo() method from PageController

            return $this->customise([
                'Notif' => $data['Notif'],
                'Product' => $data['Product'],
                'Count' => $data['Count'],
                'ChatID' => $id,
                'Vendor' => $vendor,
                'UserID' => $memberID,
                'Chat' => $chat,
            ])->renderWith(['ChatPage', 'Page']);
        }
    }