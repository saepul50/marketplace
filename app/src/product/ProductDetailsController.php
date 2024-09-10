<?php

use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\Security\Security;

    class ProductDetailsController extends PageController{
        private static $allowed_actions = [
            'getSubCategories',
            'view',
            'comment'
        ];
        public function getSubCategories($request) {
            if ($request->isAjax()) {
                $categoryID = $request->param('ID');
                if ($categoryID) {
                    $subCategories = ShopSubCategoryObject::get()->filter('ProductCategoryID', $categoryID)->map('ID', 'Title')->toArray();
                    return json_encode($subCategories);
                }
            }
            return $this->httpError(400, 'Invalid request');
        }
        public function view(HTTPRequest $request) {
            $id = $request->param('ID');
            $product = ProductObject::get()->byID($id);
            
            return $this->customise(['Product' => $product])->renderWith(['ProductDetails', 'Page']);
        }
        public function comment(HTTPRequest $request){
            if ($request->isPOST()) {
                $postComment = $request->postVar('Comments');
                $member = Security::getCurrentUser();
                $memberName = $member ? $member->FirstName : 'Guest';
                Debug::show($memberName);
                die();
            }
        }
    }