<?php 
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;


class ForgetPassword extends DataObject{
    private static $db = [
        'Unique' => 'Varchar'
    ];

    private static $has_one = [
        'Member' => Member::class
    ];
}