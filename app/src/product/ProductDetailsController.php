<?php

use SilverStripe\Dev\Debug;

    class ProductDetailsController extends PageController{
        private static $allowed_actions = [
            'getSubCategories'
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
    }