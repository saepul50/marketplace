<?php 
use SilverStripe\ORM\DataObject;


class BlogCategory extends DataObject {
    private static $db = [
        'Title' => 'Text'
    ];

    private static $belongs_many_many = [
        'BlogAdd' => BlogAdd::class,
    ];
}
