<?php

use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\HiddenField;
use SilverStripe\ORM\DataExtension;
use SilverStripe\Assets\Image;

class MyMemberExtension extends DataExtension 
{
    private static $db = [
	
    ];
    
    private static $has_one = [
        'ProfileImage' => Image::class,
        'Vendor' => Vendor::class,
        
    ];
    
    private static $has_many =[
        'SentMessages' => ChatObject::class . '.Sender',
        'ReceivedMessages' => ChatObject::class . '.Receiver',
        'LogView' => LogView::class,
        'ForgetPassword' => ForgetPassword::class

    ];
    private static $owns = [
        'ProfileImage'
    ];

    public function updateCMSFields(FieldList $fields)
        { 
            $fields->addFieldToTab('Root.Main', HiddenField::create('VendorID'));
            $fields->removeByName(array('SentMessages','ReceivedMessages','LogView','ForgetPassword','Permissions'));

            
            return $fields;
        }

}