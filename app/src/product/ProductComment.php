<?php 
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;

class ProductComment extends DataObject{
    private static $db = [
        'Comment' => 'Varchar',
    ];

    private static $has_one = [
        "ProductObject" => ProductObject::class,
        "Member" => Member::class,
    ];

    private static $has_many = [
        "CommentReply" => ProductReply::class,
    ];

}