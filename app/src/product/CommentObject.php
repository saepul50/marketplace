<?php
use SilverStripe\ORM\DataObject;

    class CommentObject extends DataObject{
        private static $db = [
            'Name' => 'Text',
            'Date' => 'Varchar',
            'Email' => 'Text',
            'Title' => 'Text',
        ];
        private static $has_many = [
            'Reply' => CommentReplyObject::class
        ];
    }