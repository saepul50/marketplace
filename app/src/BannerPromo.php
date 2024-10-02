<?php 
use SilverStripe\ORM\DataObject;

use SilverStripe\Assets\Image;
use SilverStripe\Security\Security;

class BannerPromo extends DataObject{
    private static $db = [
        'Title' => 'Varchar'
    ];

    private static $has_one = [
        'Banner' => Image::class
    ];

    private static $many_many = [
        'Products' => ProductObject::class
    ];

    private static $owns = [
        'Banner'
    ];

    public function canCreate($member = null, $context = [])
        {
            // $member = Security::getCurrentUser();
            // if($member && $member->inGroup('Seller')){
            //     return true;
            // }
            return true;
        }
        public function canView($member = null)
        {
            // $member = Security::getCurrentUser();
            // if($member && $member->inGroup('Seller')){
            //     return true;
            // }
            return true;
        }
        public function canEdit($member = null)
        {
            // $member = Security::getCurrentUser();
            // if($member && $member->inGroup('Seller')){
            //     return true;
            // }
            return true;
        }
        public function canDelete($member = null)
        {
            // $member = Security::getCurrentUser();
            // if($member && $member->inGroup('Seller')){
            //     return true;
            // }
            return true;
        }
}