<?php

use SilverStripe\Security\Security;
use SilverStripe\ORM\PaginatedList;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\ORM\ArrayList;
use SilverStripe\Security\Member;

class ChatPageController extends PageController {

    private static $allowed_actions = [
        'sendMessage',
        'index',
        'session',
        'clearSession'
    ];

    public function index(HTTPRequest $request) {
        $currentMember = Security::getCurrentUser();
        $Data = $request->getSession()->get('vendorProduct');
            // Debug::show($Data);
            // die();
        if ($currentMember) {
            $url = $request->getVar('m');
            $chatList = ChatObject::get()->filterAny([
                'ReceiverID' => [$currentMember->ID],
                'SenderID' => [$currentMember->ID]
            ]);
            if (!$chatList->exists()) {
                if($url){
                    $user = explode('l', $url)[0];
                    if($user != $currentMember->ID){
                        return null;
                    }
                    $receiver = explode('l', $url)[1];
                    $unichat1 = '?m=' . $user . 'l' . $receiver;
                    $unichat2 = '?m=' . $receiver . 'l' . $user;

                    if($receiver == $currentMember->ID){
                        $senderVendor = Vendor::get()->filter('OwnerID', $user)->exists();
                        $chatMain = Member::get()->byID($user);
                    } else{
                        $senderVendor = Vendor::get()->filter('OwnerID', $receiver)->exists();
                        $chatMain = Member::get()->byID($receiver);
                    }
                    if($Data){
                        $ProductID = $Data['productID'];
                        if(ProductObject::get()->byID($ProductID)->VendorID == $chatMain->VendorID){
                            $Product = ProductObject::get()->byID($ProductID);
                            
                            // Debug::show($Product);
                            // die();
                            return [
                                'CurrentUser' => $currentMember->ID,
                                'Receiver' => $receiver,
                                'ChatList' => $chatList,
                                'Vendor' => Vendor::get()->filter('OwnerID', $receiver)[0],
                                'SenderVendor' => $senderVendor,
                                'chatMain' => $chatMain,
                                'Product' => $Product,
                            ];
                        }
                    }
                    return [
                        'CurrentUser' => $currentMember->ID,
                        'Receiver' => $receiver,
                        'ChatList' => new ArrayList(),
                        'Vendor' => Vendor::get()->filter('OwnerID', $receiver)[0],
                        'SenderVendor' => $senderVendor,
                        'chatMain' => $chatMain,
                    ];
                }
                    return [
                    'ChatVendor' => null,
                    'ChatList' => new ArrayList(),
                    'Messages' => new ArrayList(),
                    'CurrentUser' => $currentMember->ID,
                ];
            }
            $groupedChats = [];
            foreach ($chatList as $chat) {
                $key = min($chat->SenderID, $chat->ReceiverID) . '-' . max($chat->SenderID, $chat->ReceiverID);
                
                if (!isset($groupedChats[$key])) {
                    $groupedChats[$key] = $chat;
                }

                $lastMessage = $chat->LastMessage();
                if ($lastMessage) {
                    $chat->LastMessage = $lastMessage;
                }

                $chat->UnreadCount = $chat->countUnreadMessages();
                
                if($currentMember->ID == $chat->ReceiverID){
                    $vendor = Vendor::get()->filterAny([
                        'OwnerID' => $chat->SenderID
                    ])->first();
                } else{
                    $vendor = Vendor::get()->filterAny([
                        'OwnerID' => $chat->ReceiverID
                    ])->first();
                }
                $chat->Vendor = $vendor;
            }
            $groupedChats = array_values($groupedChats);
            usort($groupedChats, function($a, $b) {
                return strtotime($b->LastMessage->LastEdited) - strtotime($a->LastMessage->LastEdited);
            });
            $chatList = new ArrayList($groupedChats);
            if (!$url) {
                return [
                    'ChatList' => $chatList,
                    'Messages' => new ArrayList(),
                    'Vendor' => Vendor::get(),
                    'CurrentUser' => $currentMember->ID,
                ];
            }
            // Debug::show($currentMember->ID);
            // die();
            $user = explode('l', $url)[0];
            if($user != $currentMember->ID){
                return null;
            }
            $receiver = explode('l', $url)[1];
            $unichat1 = '?m=' . $user . 'l' . $receiver;
            $unichat2 = '?m=' . $receiver . 'l' . $user;

            $messages = ChatObject::get()->filter([
                'unichat' => [$unichat1, $unichat2]
            ])->sort('LastEdited', 'DESC');
            foreach ($messages as $message) {
                if ($message->NotificationStatus == 'Unread' && $message->ReceiverID == $currentMember->ID) {
                    // die();
                    $message->NotificationStatus = 'Read';
                    $message->write();
                }
            }

            if($receiver == $currentMember->ID){
                $senderVendor = Vendor::get()->filter('OwnerID', $user)->exists();
                $chatMain = Member::get()->byID($user);
            } else{
                $senderVendor = Vendor::get()->filter('OwnerID', $receiver)->exists();
                $chatMain = Member::get()->byID($receiver);
            }
            if($Data){
                $ProductID = $Data['productID'];
                if(ProductObject::get()->byID($ProductID)->VendorID == $chatMain->VendorID){
                    $Product = ProductObject::get()->byID($ProductID);
                    
                    // Debug::show($chatMain);
                    // die();
                    return [
                        'CurrentUser' => $currentMember->ID,
                        'Receiver' => $receiver,
                        'ChatList' => $chatList,
                        'Messages' => $messages,
                        'Vendor' => Vendor::get()->filter('OwnerID', $receiver)[0],
                        'SenderVendor' => $senderVendor,
                        'chatMain' => $chatMain,
                        'Product' => $Product,
                    ];
                }
            }
            return [
                'CurrentUser' => $currentMember->ID,
                'Receiver' => $receiver,
                'ChatList' => $chatList,
                'Messages' => $messages,
                'Vendor' => Vendor::get()->filter('OwnerID', $receiver)[0],
                'SenderVendor' => $senderVendor,
                'chatMain' => $chatMain
            ];
        }
        return $this->redirect('login');
    }
    
    public function session(HTTPRequest $request){
        $productID = $request->postVar('ProductID');
        if ($productID) {
            $data = [
                'productID' => $productID
            ];
            $request->getSession()->set('vendorProduct', $data);
    
            return json_encode(['success' => true, 'message' => 'Success']);
        }
        return json_encode(['success' => false, 'message' => 'Error']);
    }
    public function clearSession(HTTPRequest $request) {
        $request->getSession()->clear('vendorProduct');
        
        return json_encode(['success' => true, 'message' => 'Session cleared']);
    }
    
    public function sendMessage(HTTPRequest $request) {
        $currentMember = Security::getCurrentUser();
        if ($currentMember && $request->isPOST()) {
            $messageContent = $request->postVar('Message');
            $receiverID = $request->postVar('ReceiverID');
            $productID = $request->postVar('ProductID');
            $receiverVendor = Vendor::get()->filter('OwnerID', $receiverID)[0];
            $unichat = '?m=' . $currentMember->ID . 'l' . $receiverID;
            // Debug::show($productID);
            // die();
            $chat = ChatObject::create();
            $chat->SenderID = $currentMember->ID;
            $chat->ReceiverID = $receiverID;
            $chat->ReceiverID = $receiverID;
            $chat->Message = $messageContent;
            $chat->Unichat = $unichat;
            $chat->Status = 'Unread';
            if($receiverVendor){
                $chat->VendorID = $receiverVendor->ID;
            }
            if($productID){
                $chat->ProductID = $productID;
            }
            $chat->write();
            
            return json_encode(['success' => true, 'message' => 'Sukses']);
        }
        return json_encode(['success' => false, 'message' => 'Error']);
    }
}