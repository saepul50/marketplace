<?php 
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;

class CommentReply extends DataObject{
    private static $db = [
        'Name' => 'Text',
        'Comment' => 'Varchar'
    ];

    private static $has_one = [
        "Member" => Member::class,
        "BlogComment" => BlogComment::class,
    ];


}