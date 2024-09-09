<?php
namespace App\Extension;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Assets\Image;
use SilverStripe\Core\Extension;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\HTMLEditor\HTMLEditorField;
use SilverStripe\Forms\TextField;

class CustomSiteConfig extends Extension
{
    private static $db = [
        // 'Title' => 'Text',
    ];
    private static $has_one = [
        'Image' => Image::class,
        'HomeImage' => Image::class,
        'Background' => Image::class,
        'SuperSaleImage' => Image::class,
        'LoginImage' => Image::class,
        'Favicon' => Image::class,
        'HotDealImage' => Image::class,
        
    ];
    private static $owns = [
        'Image',
        'HomeImage',
        'Background',
        'SuperSaleImage',
        'LoginImage',
        'Favicon',
        'InstagramImage',
        'HotDealImage',

    ];
    private static $many_many = [
        'InstagramImage' => Image::class,
    ];


    public function updateCMSFields(FieldList $fields)
    {
        $fields->addFieldToTab('Root.Main', UploadField::create('Image', 'Image Navbar'));
        $fields->addFieldToTab('Root.Main', UploadField::create('HomeImage', 'Home Image'));
        $fields->addFieldToTab('Root.Main', UploadField::create('Background', 'Background Banner'));
        $fields->addFieldToTab('Root.Main', UploadField::create('SuperSaleImage', 'Deals Of the Week Image'));
        $fields->addFieldToTab('Root.Main', UploadField::create('LoginImage', 'Login Image'));
        $fields->addFieldToTab('Root.Main', UploadField::create('Favicon', 'Favicon Image'));
        $fields->addFieldToTab('Root.Main', UploadField::create('HotDealImage', 'Background Hot Deals Image'));
        $fields->addFieldToTab('Root.Main', UploadField::create('InstagramImage', 'Instagram Image')->setIsMultiUpload(true));
    }
}