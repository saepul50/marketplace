<?php

use SilverStripe\Dev\Debug;
use SilverStripe\ORM\ArrayList;
use SilverStripe\Security\Security;

class HomePageController extends PageController{
    protected function init() {
        parent::init();
        
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
    public function getMember(){
        return Security::getCurrentUser();
    }
}