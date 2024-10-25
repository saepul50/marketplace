<?php

use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\ORM\ArrayList;
use SilverStripe\Security\Security;

class NotificationController extends PageController{
    private static $allowed_actions = [
        'NotificationRead'
    ];
    public function index(){
        $member = Security::getCurrentUser();
        if ($member) {
            $Notification = NotificationObject::get();
            if ($Notification) {
                $AllNotifs = NotificationObject::get()->sort('Created', 'DESC');
                $groupedNotifs = [];
        
                foreach ($AllNotifs as $notif) {
                    $headerCheckout = $notif->HeaderCheckout();
                    if ($headerCheckout && $headerCheckout->MemberID == $member->ID) {
                        $orderID = $headerCheckout->OrderID;
        
                        if (!isset($groupedNotifs[$orderID])) {
                            $groupedNotifs[$orderID] = [
                                'HeaderCheckout' => $headerCheckout,
                                'Notifications' => new ArrayList()
                            ];
                        }
        
                        $groupedNotifs[$orderID]['Notifications']->push($notif);
                    }
                }
                
                $groupedNotifs = ArrayList::create($groupedNotifs);
                // Debug::show($groupedNotifs);
                // die();
                return [
                    'GroupedNotifs' => $groupedNotifs
                ];
            }
        }        
        return $this->redirect('login');
    }
    public function NotificationRead(HTTPRequest $request){
        $OrderID = $request->postVar('OrderID');
        // Debug::show($OrderID);
        if($OrderID){
            // Debug::show($OrderID);
            // die();
            $HeaderCheckout = ProductCheckoutHeaderObject::get()->filter('OrderID', $OrderID)->first();
            $Notification = NotificationObject::get()->filter(['HeaderCheckoutID'=> $HeaderCheckout->ID , 'Read' => 'Unread'])->first();
            // Debug::show($Notification);
            if ($Notification && $Notification->Read == 'Unread') {
                $Notification->Read = 'Read';
                $Notification->write();
                return json_encode(['success' => true]);
            }
        }
        return json_encode(['success' => false]);
    }    
}