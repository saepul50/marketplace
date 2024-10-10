<?php
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;

    class ChatObject extends DataObject{
        private static $db = [
            'Message' => 'Text',
            'Date' => 'Date',
            'Time' => 'Time',
            'Unichat' => 'Varchar',
            'NotificationStatus' => "Enum('Unread, Read', 'Unread')",
        ];
        private static $has_one = [
            'Sender' => Member::class,
            'Receiver' => Member::class,
            'Vendor' => Vendor::class,
            'Product' => ProductObject::class
        ];
        public function onBeforeWrite() {
            parent::onBeforeWrite();
    
            if (!$this->Date) {
                date_default_timezone_set('Asia/Jakarta');
                $this->Date = date('d-m-Y');
            }
            if (!$this->Time) {
                date_default_timezone_set('Asia/Jakarta');
                $this->Time = date('H:i:s');
            }
            if (!$this->NotificationStatus) {
                $this->NotificationStatus = 'Unread';
            }
        }
        public function countUnreadMessages() {
            return ChatObject::get()
                ->filter([
                    'ReceiverID' => $this->ReceiverID,
                    'SenderID' => $this->SenderID,
                    'NotificationStatus' => 'Unread'
                ])
                ->count();
        }        
        public function LastMessage() {
            return ChatObject::get()
                ->filter([
                    'SenderID' => [$this->SenderID, $this->ReceiverID],
                    'ReceiverID' => [$this->SenderID, $this->ReceiverID]
                ])
                ->sort('LastEdited', 'DESC')
                ->first();
        }   
    }