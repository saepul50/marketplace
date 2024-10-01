<?php 
use SilverStripe\ORM\DataObject;

use SilverStripe\Assets\Image;

class BannerPromo extends DataObject{
    private static $db = [
        'Title' => 'Varchar'
    ];

    private static $has_one = [
        'Banner' => Image::class
    ];

    private static $has_many = [
        'Products' => ProductObject::class
    ];

    private static $owns = [
        'Banner'
    ];

    public function canCreate($member = null, $context = [])
        {
            return false; 
        }
        public function canView($member = null)
        {
            return true;
        }
        public function canEdit($member = null)
        {
            return true;
        }
        public function canDelete($member = null)
        {
            return false;
        }
}