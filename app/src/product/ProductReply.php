<?php 
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;
 class ProductReply extends DataObject{
    
    private static $db = [
        'Comment' => 'Varchar',
        'SendTo' => 'Varchar'
    ];

    private static $has_one = [
        "Member" => Member::class,
        "ProductComment" => ProductComment::class,
        "ProductObject" => ProductObject::class,
    ];
 }