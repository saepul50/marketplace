<?php

use SilverStripe\Dev\Debug;
use SilverStripe\Security\Security;

class ProfilePageController extends PageController{
    public function index() {
        $data = $this->nepo(); // Call the nepo() method from PageController

        return [
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
}
