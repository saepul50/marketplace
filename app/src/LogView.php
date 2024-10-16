<?php 
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;

class LogView extends DataObject{
    private static $db = [
        // 'Member' => 'Varchar'
    ];

    private static $has_many = [
    ];
    
    private static $has_one = [
        'Vendor' => Vendor::class,
        'Member' => Member::class
    ];
}