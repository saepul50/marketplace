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
            
            if ($currentMember) {
                $url = $request->getVar('m');
                $chatList = ChatObject::get()->filterAny([
                    'ReceiverID' => [$currentMember->ID],
                    'SenderID' => [$currentMember->ID]
                ]);
                if (!$chatList->exists()) {
                    $chatList = new ArrayList();
                    $vendor = Vendor::get()->filter('OwnerID', $currentMember->ID);
                    return [
                        'ChatVendor' => $vendor[0],
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
                        
                    $chat->LastMessage = $lastMessage;
                }
                $chatList = new ArrayList($groupedChats);
                if (!$url) {
                    return [
                        'ChatList' => $chatList,
                        'Messages' => new ArrayList(),
                        'Vendor' => Vendor::get()
                    ];
                }
                $user = explode('l', $url)[0];
                $receiver = explode('l', $url)[1];
                $unichat1 = '?m=' . $user . 'l' . $receiver;
                $unichat2 = '?m=' . $receiver . 'l' . $user;
                // Debug::show(Vendor::get()->filter('OwnerID', $receiver));
                // die();
                $messages = ChatObject::get()->filter([
                    'unichat' => [$unichat1, $unichat2]
                ])->sort('LastEdited', 'DESC');
                
                $senderVendor = Vendor::get()->filter('OwnerID', $receiver)->exists();

                return [
                    'ChatList' => $chatList,
                    'Messages' => $messages,
                    'Vendor' => Vendor::get()->filter('OwnerID', $receiver)[0],
                    'SenderVendor' => $senderVendor,
                    'chatMain' => Member::get()->byID($receiver)
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
            $unichat = '?m=' . $currentMember->ID . 'l' . $receiverID;
            // Debug::show($unichat);
            // die();
            $chat = ChatObject::create();
            $chat->SenderID = $currentMember->ID;
            $chat->ReceiverID = $receiverID;
            $chat->ReceiverID = $receiverID;
            $chat->Message = $messageContent;
            $chat->Unichat = $unichat;
            $chat->write();
            
            return json_encode(['success' => true, 'message' => 'Sukses']);
        }
        return json_encode(['success' => false, 'message' => 'Error']);
    }
}
