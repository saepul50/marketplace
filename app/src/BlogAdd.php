<?php 
use SilverStripe\Assets\Image;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Control\Controller;
use SilverStripe\Forms\CheckboxField;
use SilverStripe\Forms\CheckboxSetField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\HTMLEditor\HTMLEditorField;
use SilverStripe\Forms\TextareaField;
use SilverStripe\Forms\TextField;
use SilverStripe\ORM\DataObject;

class BlogAdd extends DataObject{
    private static $db = [
        'Title' => 'Varchar(60)',
        'Summary' => 'Varchar(500)',
        'Content' => 'HTMLText',
        'Quotes' => 'Varchar(400)',
    ];


    private static $has_one = [
        'Member' => Member::class,
        'ImageThumbnail' => Image::class,
        'HeaderImage' => Image::class,
    ];
    private static $has_many = [
        'BlogComment' => BlogComment::class
    ];


    private static $many_many = [
        'BlogCategories' => BlogCategory::class
    ];
    private static $owns = [
        'ImageThumbnail',
        'HeaderImage',
    ];
    public function Link() {
        return Controller::join_links('blogdetail', $this->ID);
    }
    public function getCMSFields()
    {
        return new FieldList(
            TextField::create('Title'),
            TextareaField::create('Summary'),
            UploadField::create('ImageThumbnail'),
            UploadField::create('HeaderImage', 'Header Image Min Width(700)'),
            HTMLEditorField::create('Content'),
            TextareaField::create('Quotes'),
            CheckboxSetField::create('BlogCategories','Categories', BlogCategory::get()),
        );
    }
}



