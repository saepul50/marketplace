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
            $SessionChat = $request->getSession()->get('ownerVendor');
            // Debug::show($SessionChat);
            // die();
            if ($currentMember) {
                $url = $request->getVar('m');
                $chatList = ChatObject::get()->filterAny([
                    'ReceiverID' => [$currentMember->ID],
                    'SenderID' => [$currentMember->ID]
                ]);
                if (!$chatList->exists()) {
                    $user = explode('l', $url)[0];
                    $receiver = explode('l', $url)[1];
                    $unichat1 = '?m=' . $user . 'l' . $receiver;
                    $unichat2 = '?m=' . $receiver . 'l' . $user;
                    $chatList = new ArrayList();
                    $vendor = Vendor::get()->filter('OwnerID', $receiver);
                    return [
                        'Receiver' => $receiver,
                        'ChatVendor' => $vendor[0],
                        'ChatList' => $chatList,
                        'Messages' => new ArrayList(),
                        'Vendor' => Vendor::get(),
                        'CurrentUser' => $currentMember->ID,
                    ];
                }
                $groupedChats = [];
                foreach ($chatList as $chat) {
                    $key = min($chat->SenderID, $chat->ReceiverID) . '-' . max($chat->SenderID, $chat->ReceiverID);
                    
                    if (!isset($groupedChats[$key])) {
                        $groupedChats[$key] = $chat;
                    }
                    $lastMessage = ChatObject::get()
                    ->filter([
                        'SenderID' => [$chat->SenderID, $chat->ReceiverID],
                        'ReceiverID' => [$chat->ReceiverID, $chat->SenderID]
                    ])
                    ->sort('LastEdited', 'DESC')
                    ->first();
                    
                    if($currentMember->ID == $chat->ReceiverID){
                        $vendor = Vendor::get()->filterAny([
                            'OwnerID' => $chat->SenderID
                        ])->first();
                    } else{
                        $vendor = Vendor::get()->filterAny([
                            'OwnerID' => $chat->ReceiverID
                        ])->first();
                    }
                    $chat->LastMessage = $lastMessage;
                    $chat->Vendor = $vendor;
                }
                $chatList = new ArrayList($groupedChats);
                if (!$url) {
                    return [
                        'ChatList' => $chatList,
                        'Messages' => new ArrayList(),
                        'Vendor' => Vendor::get(),
                        'CurrentUser' => $currentMember->ID,
                        'Receiver' => $SessionChat,
                    ];
                }
                // Debug::show($currentMember->ID);
                // die();
                $user = explode('l', $url)[0];
                $receiver = explode('l', $url)[1];
                $unichat1 = '?m=' . $user . 'l' . $receiver;
                $unichat2 = '?m=' . $receiver . 'l' . $user;
                // if (!$chatList->exists()) {
                //     $chatList = new ArrayList();
                //     $vendor = Vendor::get()->filter('OwnerID', $receiver);
                //     return [
                //         'ChatVendor' => $vendor[0],
                //         'ChatList' => $chatList,
                //         'Messages' => new ArrayList(),
                //         'Vendor' => Vendor::get(),
                //         'CurrentUser' => $currentMember->ID,
                //     ];
                // }
                // Debug::show($receiver);
                // die();
                $messages = ChatObject::get()->filter([
                    'unichat' => [$unichat1, $unichat2]
                ])->sort('LastEdited', 'DESC');
                
                if($receiver == $currentMember->ID){
                    $senderVendor = Vendor::get()->filter('OwnerID', $user)->exists();
                    $chatMain = Member::get()->byID($user);
                } else{
                    $senderVendor = Vendor::get()->filter('OwnerID', $receiver)->exists();
                    $chatMain = Member::get()->byID($receiver);
                }
                // Debug::show($chatMain);
                // die();
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
        $ownerVendor = $request->postVar('ownerVendor');
        // Debug::show($ownerVendor);
        // die();
        if ($ownerVendor) {
            $request->getSession()->set('ownerVendor', $ownerVendor);
            return json_encode(['success' => true, 'message' => 'Success']);
        }
        return json_encode(['success' => false, 'message' => 'Error']);
    }
    public function clearSession(HTTPRequest $request) {
        $request->getSession()->clear('ownerVendor');
        
        return json_encode(['success' => true, 'message' => 'Session cleared']);
    }
    
    public function sendMessage(HTTPRequest $request) {
        $currentMember = Security::getCurrentUser();
        if ($currentMember && $request->isPOST()) {
            $messageContent = $request->postVar('Message');
            $receiverID = $request->postVar('ReceiverID');
            $receiverVendor = Vendor::get()->filter('OwnerID', $receiverID)[0];
            $unichat = '?m=' . $currentMember->ID . 'l' . $receiverID;
            // Debug::show($receiverVendor);
            // die();
            $chat = ChatObject::create();
            $chat->SenderID = $currentMember->ID;
            $chat->ReceiverID = $receiverID;
            $chat->ReceiverID = $receiverID;
            $chat->Message = $messageContent;
            $chat->Unichat = $unichat;
            if($receiverVendor){
                $chat->VendorID = $receiverVendor->ID;
            }
            $chat->write();
            
            return json_encode(['success' => true, 'message' => 'Sukses']);
        }
        return json_encode(['success' => false, 'message' => 'Error']);
    }
}
