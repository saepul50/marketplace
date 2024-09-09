<?php

use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Forms\TextField;
use SilverStripe\ORM\DataObject;

    class ShopCategoryObject extends DataObject{
        private static $db = [
            'Title' => 'Varchar',
        ];
    
        private static $has_many = [
            'ProductSubCategory' => ShopSubCategoryObject::class,
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
    }