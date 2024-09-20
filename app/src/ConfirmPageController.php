<?php

use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\Security\Security;

class ConfirmPageController extends PageController{
    private static $allowed_actions = [
        'order' => true
    ];
    public function HistoryData() {
        $member = Security::getCurrentUser();
        if ($member) {
            $checkoutObjects = ProductCheckoutObject::get()->filter('MemberID', $member->ID);
            $headerCheckoutIDs = $checkoutObjects->column('HeaderCheckoutID');
            if (!empty($headerCheckoutIDs)) {
                return ProductCheckoutHeaderObject::get()->filter('ID', $headerCheckoutIDs);
            }
        }
        return null;
    }
    public function order(HTTPRequest $request) {
        // die("da");
        // Debug::show($request);
        // die();      
        $id = $request->param('ID');
        $member = Security::getCurrentUser();
        if ($member) {
            $checkoutObjects = ProductCheckoutObject::get()->filter('MemberID', $member->ID);
            $headerCheckoutIDs = $checkoutObjects->column('HeaderCheckoutID');
    
            $checkoutHeader = ProductCheckoutHeaderObject::get()->filter(['OrderID' => $id])->filter('ID', $headerCheckoutIDs);
            // Debug::show($checkoutHeader);
            // die();
            if ($checkoutHeader->exists()) {
                $isDetail = $request->getVar('detailOrder');
                return $this->customise([
                    'CheckoutHeader' => $checkoutHeader,
                    'ShowDetailOrder' => $isDetail
                ])->renderWith(['ConfirmPage', 'Page']);
            }
        }
    }
}