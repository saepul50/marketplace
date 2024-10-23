<?php

use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\ORM\ArrayList;
use SilverStripe\Security\Security;
use SilverStripe\Versioned\ChangeSetItem;
use SilverStripe\View\ArrayData;

class ConfirmPageController extends PageController{
    private static $allowed_actions = [
        'order',
        'service'
    ];

    public function HistoryData() {
        $member = Security::getCurrentUser();
        if ($member) {
            $checkoutHeader = ProductCheckoutHeaderObject::get()->filter('MemberID', $member->ID);
            if ($checkoutHeader) {
                return $checkoutHeader;
            }
        }
        return null;
    }
    public function order(HTTPRequest $request) {
        $id = $request->param('ID');
        $member = Security::getCurrentUser();
        
        if ($member) {
            $checkoutHeader = ProductCheckoutHeaderObject::get()
            ->filter('OrderID', $id)
            ->filter('MemberID', $member->ID)
            ->first();
            // Debug::show($id);
            // die();
            if ($checkoutHeader && $checkoutHeader->exists()) {
                $itemsByVendor = [];
                
                foreach ($checkoutHeader->Items() as $item) {
                    $vendorID = $item->VendorID;
                    
                    if (!isset($itemsByVendor[$vendorID])) {
                        $vendor = Vendor::get()->byID($vendorID);
                        if ($vendor) {
                             $itemsByVendor[$vendorID] = [
                                'Vendor' => $vendor,
                                'Items' => new ArrayList()
                            ];
                        }
                    }
                    if (isset($itemsByVendor[$vendorID])) {
                        $itemsByVendor[$vendorID]['Items']->push($item);
                    }
                }
                
                $arrayVendors = new ArrayList();
                foreach ($itemsByVendor as $vendorData) {
                    $arrayVendors->push(new ArrayData($vendorData));
                }
                
                $isDetail = $request->getVar('detailOrder');
                // Debug::show($arrayVendors);
                // die();
                return [
                    'CheckoutHeader' => $checkoutHeader,
                    'ItemsByVendor' => $arrayVendors,
                    'ShowDetailOrder' => $isDetail,
                ];
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
        if ($Request === 'diterima'){
            $checkoutHeader->Status = 'Selesai';
            $checkoutHeader->write();
            return json_encode(['success' => true, 'message' => 'Success']);
        }
        return json_encode(['success' => false, 'message' => 'Failed']);
    }
}