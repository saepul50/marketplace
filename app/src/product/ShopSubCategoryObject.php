<?php

use SilverStripe\Dev\Debug;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Forms\TextField;
use SilverStripe\ORM\DataObject;

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
        
        public function getCMSFields() {
            $categories = ShopCategoryObject::get()->map('ID', 'Title')->toArray();
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
            return $fields;
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