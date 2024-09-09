<?php

use SilverStripe\Dev\Debug;
use SilverStripe\ORM\ArrayList;

class HomePageController extends PageController{
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
}