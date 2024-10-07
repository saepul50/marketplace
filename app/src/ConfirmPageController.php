<?php

use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\Security\Security;
use SilverStripe\Versioned\ChangeSetItem;

class ConfirmPageController extends PageController{
    private static $allowed_actions = [
        'order' => true,
        'service'
    ];

    public function index() {
        $data = $this->nepo(); // Call the nepo() method from PageController

        return [
            'Notif' => $data['Notif'] ?? null,
            'Product' => $data['Product'] ?? null,
            'Count' => $data['Count'] ?? null,
        ];
    }
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
        // die();      
        $id = $request->param('ID');
        $Status = $request->param('OtherID');
        // Debug::show($Status);
        // Debug::show($id);
        $member = Security::getCurrentUser();
        $data = $this->nepo();

        if ($member) {
            $checkoutObjects = ProductCheckoutObject::get()->filter('MemberID', $member->ID);
            $headerCheckoutIDs = $checkoutObjects->column('HeaderCheckoutID');
            if($Status != null){
                $gg = Notification::get()->byID($Status);
                $gg->Notif = "Read";
                $gg->write();
            }

            
            $checkoutHeader = ProductCheckoutHeaderObject::get()->filter(['OrderID' => $id])->filter('ID', $headerCheckoutIDs);
            // die();
            // Debug::show($checkoutHeader);
            if ($checkoutHeader->exists()) {
                $isDetail = $request->getVar('detailOrder');
                return $this->customise([
                    'CheckoutHeader' => $checkoutHeader,
                    'ShowDetailOrder' => $isDetail,
                    'Notif' => $data['Notif'],
                    'Product' => $data['Product'],
                    'Count' => $data['Count'],
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