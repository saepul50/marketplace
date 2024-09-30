<?php
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;

    class DataSend extends DataObject{
        private static $db = [
            'Codeotp' => 'Varchar',
            'ExpiryTime' => 'Datetime'
        ];
        private static $has_one = [
            'User' => Member::class
        ];
    }