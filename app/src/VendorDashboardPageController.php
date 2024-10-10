<?php

use SilverStripe\Control\HTTPRequest;
use SilverStripe\Security\Security;

    class VendorDashboardPageController extends PageController{
        private static $allowed_actions = [
            'addProduct' => true
        ];
        public function index(){
            $member = Security::getCurrentUser();
            $vendor = Vendor::get()->filter(['OwnerID' => $member->ID])->first();
            if (!$vendor) {
                return 'Anda belum membuat toko.';
            }

            $products = $vendor->Products();
            return $this->customise([
                'Vendor' => $vendor, 
                'Products' => $products
            ])->renderWith(['VendorDashboard', 'Page']);
        }

        public function addProduct(HTTPRequest $request){
            $member = Security::getCurrentUser();
            $vendor = Vendor::get()->filter(['OwnerID' => $member->ID])->first();

            if (!$vendor) {
                return $this->httpError(403, 'Anda tidak memiliki toko.');
            }
            if($request){
            }
            $product = ProductObject::create();
            // $form->saveInto($product);
            $product->VendorID = $vendor->ID;
            $product->write();

            // return $this->redirectBack();
        }
    }