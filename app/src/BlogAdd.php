<?php
use SilverStripe\Assets\Image;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Control\Controller;
use SilverStripe\Dev\Debug;
use SilverStripe\Forms\CheckboxField;
use SilverStripe\Forms\CheckboxSetField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\HTMLEditor\HTMLEditorField;
use SilverStripe\Forms\ReadonlyField;
use SilverStripe\Forms\RequiredFields;
use SilverStripe\Forms\TextareaField;
use SilverStripe\Forms\TextField;
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;
use SilverStripe\Security\Permission;
use SilverStripe\Security\Security;

class BlogAdd extends DataObject
{
    private static $db = [
        'Title' => 'Varchar(60)',
        'Summary' => 'Varchar(500)',
        'Content' => 'HTMLText',
        'Quotes' => 'Varchar(400)',
        'CountComment' => 'Int',
        'CreatedBy' => 'Varchar',
        'ViewCount' => 'Int',
    ];


    private static $has_one = [
        'Member' => Member::class,
        'ImageThumbnail' => Image::class,
        'HeaderImage' => Image::class,
    ];
    private static $has_many = [
        'BlogComment' => BlogComment::class,
        'CommentReply' => CommentReply::class
    ];


    private static $many_many = [
        'BlogCategories' => BlogCategory::class
    ];
    private static $owns = [
        'ImageThumbnail',
        'HeaderImage',
    ];
    public function Link()
    {
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
            // ReadonlyField::create('CountComment'),
            // ReadonlyField::create('ViewCount'),
            CheckboxSetField::create('BlogCategories', 'Categories', BlogCategory::get()),
        );
    }

    public function canCreate($member = null, $context = [])
    {
        return true; // Cek apakah izin disini tidak membatasi akses
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


    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
        $member = Security::getCurrentUser();
        if (!$this->ID) {
            if ($member = Security::getCurrentUser()) {
                $this->CreatedBy = $member->Surname;

            }
        }
    }
    function getCMSValidator() {
        return new BlogAdd_Validator();
    }
}

class BlogAdd_Validator extends RequiredFields {

    function php($data) {
        $bRet = parent::php($data);

        //do checking here
        if (empty($data['Title']))
            $this->validationError('Title','Title cannot be empty','required');

        if (empty($data['Summary']))
            $this->validationError('Summary','Summary cannot be empty','required');

        if (empty($data['Content']))
            $this->validationError('Content','Content cannot be empty','required');

        if (empty($data['ImageThumbnail']))
            $this->validationError('ImageThumbnail','ImageThumbnail cannot be empty','required');

        if (empty($data['HeaderImage']))
            $this->validationError('HeaderImage','HeaderImage cannot be empty','required');        
        if (empty($data['BlogCategories']))
            $this->validationError('BlogCategories','Categories cannot be empty','required');

        return count($this->getErrors());
    }
}


