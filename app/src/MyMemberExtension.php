<?php

use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Forms\FieldList;
use SilverStripe\ORM\DataExtension;
use SilverStripe\Assets\Image;

class MyMemberExtension extends DataExtension 
{
    // define additional properties
    private static $db = [
	
    ];
    
    private static $has_one = [
        'ProfileImage' => Image::class,
        'Vendor' => Vendor::class
    ];

    private static $owns = [
        'ProfileImage'
    ];

}