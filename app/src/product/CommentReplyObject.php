<?php
use SilverStripe\ORM\DataObject;

    class CommentReplyObject extends DataObject{
        private static $db = [
            'Name' => 'Text',
            'Date' => 'Varchar',
            'Email' => 'Text',
            'Title' => 'Text',
        ];
        private static $has_one = [
            'Comment' => CommentObject::class
        ];
    }