<?php
namespace App\Extension;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Assets\Image;
use SilverStripe\Core\Extension;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\HTMLEditor\HTMLEditorField;

class CustomSiteConfig extends Extension
{
    private static $db = [
        // 'Image' => '',
    ];
    private static $has_one = [
        'Image' => Image::class,
        'Background' => Image::class,
    ];
    private static $owns = [
        'Image',
        'Background',
    ];


    public function updateCMSFields(FieldList $fields)
    {
        $fields->addFieldToTab('Root.Main', UploadField::create('Image', 'Image Navbar'));
        $fields->addFieldToTab('Root.Main', UploadField::create('Background', 'Background Banner'));
    }
}