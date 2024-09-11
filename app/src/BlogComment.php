<?php 
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;

class BlogComment extends DataObject{
    private static $db = [
        'Name' => 'Text',
        'Comment' => 'Varchar'
    ];

    private static $has_one = [
        "BlogAdd" => BlogAdd::class,
        "Member" => Member::class,
    ];

    private static $has_many = [
        "CommentReply" => CommentReply::class,
    ];

}