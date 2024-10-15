<?php

use SilverStripe\Dev\Debug;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Forms\TextField;
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Security;

    class ShopSubCategoryObject extends DataObject{
        private static $db = [
            'Title' => 'Varchar'
        ];
    
        private static $has_one = [
            'ProductCategory' => ShopCategoryObject::class
        ];
        private static $belongs_many_many = [
            'ProductObject' => ProductObject::class
        ];
        private static $summary_fields =[
            'Title' => 'Title'
        ];
        public function getProducts() {
            return ProductObject::get()->byId(1);
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
    public function getproduct($VendorID){
        return $this->ProductObject()->filter('VendorID', $VendorID);
    } 
    public function getproductss($VendorID){
        return $this->ProductObject()->filter('VendorID', $VendorID);
    }
        public function getCMSFields() {
            $member = Security::getCurrentUser();
            $vendor = Vendor::get()->filter('OwnerID', $member->ID)->first();
            $product = $this->getproduct($vendor->ID);
            // $this->Test = $product;
            // Debug::show($this->Test);
            $categories = ShopCategoryObject::get()->map('ID', 'Title')->toArray();
            if($member->ID !== 1){
            $fields = new FieldList(
                TextField::create('Title'),
                DropdownField::create('ProductCategoryID', 'Category', $categories)
                    ->setEmptyString('Select a Category'),
                GridField::create(
                    'ProductObject',
                    'Product',
                    $product,
                    GridFieldConfig_RecordEditor::create()
                )
            );
            } else {
                $fields = new FieldList(
                    TextField::create('Title'),
                    DropdownField::create('ProductCategoryID', 'Category', $categories)
                        ->setEmptyString('Select a Category'),
                    GridField::create(
                        'ProductObject',
                        'Product',
                        $this->ProductObject(),
                        GridFieldConfig_RecordEditor::create()
                    )
                );
            }
            return $fields;
        }

       
    }