<?php

use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Forms\TextField;
use SilverStripe\ORM\DataObject;

    class ProductBrandObject extends DataObject{
       
    private static $db = [
        'Title' => 'Text'
    ];
    private static $has_many = [
        'Product' => ProductObject::class
    ];
    public function getCMSFields() {
        $fields = new FieldList(
            TextField::create('Title'),
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
        return false;
    }
    public function canDelete($member = null)
    {
        return true;
    }
}