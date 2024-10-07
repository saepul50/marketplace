<?php

use SilverStripe\Dev\Debug;
use SilverStripe\ORM\ArrayList;
use SilverStripe\Security\Member;
use SilverStripe\Security\Security;

class HomePageController extends PageController{
    protected function init() {
        parent::init();
        // $member = Security::getCurrentUser();
        // // Debug::show($member);
        // // die();
        // if (!$member) {
        //     return $this->redirect('login');
        // }
    }
    public function ProductObjects() {
        return ProductObject::get();
    }
    public function PromotionObjects() {
        return PromotionObject::get();
    }
    public function RandomProducts() {
        $products = ProductObject::get()->toArray();
        // Debug::show($products);
        // die();
        shuffle($products);
        return new ArrayList($products);
    }
    public function Member() {
        return Member::get();
    }
    public function getMember(){
        return Security::getCurrentUser();
    }
    public function index() {
        $data = $this->nepo(); // Call the nepo() method from PageController
        if($data != null){

        return [
            'Notif' => $data['Notif'],
            'Product' => $data['Product'],
            'Count' => $data['Count'],
        ];
        }
    }
}