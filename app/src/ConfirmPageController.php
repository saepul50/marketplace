<?php

use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\Security\Security;

class ConfirmPageController extends PageController{
    private static $allowed_actions = [
        'order' => true,
        'service'
    ];
    public function HistoryData() {
        $member = Security::getCurrentUser();
        if ($member) {
            $checkoutObjects = ProductCheckoutObject::get()->filter('MemberID', $member->ID);
            $headerCheckoutIDs = $checkoutObjects->column('HeaderCheckoutID');
            $status = ProductCheckoutHeaderObject::get()->filter(['Status'=> 'Completed']);
            $HeaderID = $status->column('ID');
            // Debug::show($filter);

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
            // die();
            // Debug::show($checkoutHeader);
            if ($checkoutHeader->exists()) {
                $isDetail = $request->getVar('detailOrder');
                return $this->customise([
                    'CheckoutHeader' => $checkoutHeader,
                    'ShowDetailOrder' => $isDetail
                ])->renderWith(['ConfirmPage', 'Page']);
            }
        }
    }
    public function service(HTTPRequest $request){
        $OrderID = $request->postVar('OrderID');
        $Request = $request->postVar('Request');
        $checkoutHeader = ProductCheckoutHeaderObject::get()->filter('OrderID', $OrderID)->first();
        // Debug::show($checkoutHeader);
        // die();
        if ($Request === 'batal'){
            $checkoutHeader->Status = 'Dibatalkan';
            $checkoutHeader->write();
            return json_encode(['success' => true, 'message' => 'Success']);
        }
        return json_encode(['success' => false, 'message' => 'Failed']);
    }
}