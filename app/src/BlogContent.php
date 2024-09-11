<?php 
use SilverStripe\ORM\DataObject;

class BlogContent extends DataObject {
    private static $db = [
        'Title' => 'Varchar',

    ];
}
