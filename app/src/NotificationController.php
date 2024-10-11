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
        if($member){
            $Notification = NotificationObject::get();
            if($Notification){
                
                $UnreadNotifs = NotificationObject::get()->filter([
                    'Read' => 'Unread',
                ])->sort('Created', 'DESC');
                
                $ownsUnreadNotif = [];
                foreach ($UnreadNotifs as $Unnotif) {
                    $headerCheckout = $Unnotif->HeaderCheckout();
                    if ($headerCheckout) {
                        $firstItem = $headerCheckout->Items()->first();
                        if ($firstItem && $firstItem->MemberID == $member->ID) {
                            $ownsUnreadNotif[] = $Unnotif;
                        }
                    }
                }
                
                $AllNotifs = NotificationObject::get()->sort('Created', 'DESC');
                $ownsNotif = [];
                foreach ($AllNotifs as $notif) {
                    $headerCheckout = $notif->HeaderCheckout();
                    if ($headerCheckout) {
                        $firstItem = $headerCheckout->Items()->first();
                        // Debug::show($member->ID);
                        // die();
                        if ($firstItem && $firstItem->MemberID == $member->ID) {
                            $ownsNotif[] = $notif;
                        }
                    }
                }
                $ownsNotif = ArrayList::create($ownsNotif);
                // Debug::show($ownsNotif);
                return [
                    'AllNotifs' => $ownsNotif,
                ];
            }
        }
        return $this->redirect('login');
    }
    public function NotificationRead(HTTPRequest $request){
        $OrderID = $request->postVar('OrderID');
        if($OrderID){
            // Debug::show($OrderID);
            // die();
            $HeaderCheckout = ProductCheckoutHeaderObject::get()->filter('OrderID', $OrderID)->first();
            $Notification = NotificationObject::get()->filter('HeaderCheckoutID', $HeaderCheckout->ID)->first();
            if ($Notification && $Notification->Read == 'Unread') {
                $Notification->Read = 'Read';
                $Notification->write();
                return json_encode(['success' => true]);
            }
        }
        return json_encode(['success' => false]);
    }    
}