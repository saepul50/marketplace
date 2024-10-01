<?php

use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Forms\TextField;
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Security;

    class ShopCategoryObject extends DataObject{
        private static $db = [
            'Title' => 'Varchar',
        ];
    
        private static $has_many = [
            'ProductSubCategory' => ShopSubCategoryObject::class,
        ];
        private static $has_one = [
            'Vendor' => Vendor::class,
        ];
        public function getCMSFields() {
            $fields = new FieldList(
                TextField::create('Title'),
                GridField::create(
                    'ProductSubCategory',
                    'Sub Category',
                    $this->ProductSubCategory(),
                    GridFieldConfig_RecordEditor::create()
                )
            );
            return $fields;
        }    

        public function onBeforeWrite()
        {
            parent::onBeforeWrite();
            $member = Security::getCurrentUser();
            $vendor = Vendor::get()->filter('OwnerID', $member->ID)->first();
            if (!$this->ID) {
                if ($member = Security::getCurrentUser()) {
                    $this->VendorID = $vendor->ID;
    
                }else{
                    user_error('No vendor found for this member', E_USER_WARNING); 
                }
                
            }
        }
        public function canCreate($member = null, $context = [])
        {
            return true; 
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
            return true;
        }
    }