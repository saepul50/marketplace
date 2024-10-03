<?php
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;

    class ChatObject extends DataObject{
        private static $db = [
            'Message' => 'Text',
            'Date' => 'Date',
            'Time' => 'Time',
            'FromID' => 'Int',
            'ToID' => 'Int',
        ];
        private static $has_one = [
            'User' => Member::class,
            'Vendor' => Vendor::class
        ];
        public function onBeforeWrite() {
            parent::onBeforeWrite();
    
            if (!$this->Date) {
                $this->Date = date('d-m-Y');
            }
            if (!$this->Time) {
                $this->Time = date('H:i:s');
            }
        }
    }