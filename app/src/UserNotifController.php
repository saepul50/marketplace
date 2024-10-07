<?php
use SilverStripe\Dev\Debug;
use SilverStripe\Security\Security;

class UserNotifController extends PageController{
    public function index(){
        $member = Security::getCurrentUser();
        $notifs = Notification::get()->sort('Created', 'DESC')->filter(['Notif' => 'Unread','CostumerName'=> $member->FirstName]);
        $allnotif = Notification::get()->sort('Created', 'DESC')->filter('CostumerName', $member->FirstName);
        $products = [];
        foreach($notifs as $notif){
            $product = ProductCheckoutObject::get()->filter('HeaderCheckoutID', $notif->ProductCheckoutHeaderID );
            $products = $product;
        }
        // Debug::show($products);
        // Debug::show($products);
        return [
            'Notif' => $notifs,
            'AllNotif' => $allnotif,
            'Product' => $products
        ];
    }
}