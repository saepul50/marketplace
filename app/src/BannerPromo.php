<?php 
use SilverStripe\Dev\Debug;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Forms\CheckboxField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldButtonRow;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Forms\GridField\GridFieldSortableHeader;
use SilverStripe\Forms\HiddenField;
use SilverStripe\ORM\ArrayList;
use SilverStripe\ORM\DataObject;
use SilverStripe\Assets\Image;
use SilverStripe\Security\Security;
use SilverShop\HasOneField\HasOneButtonField;
use SilverStripe\Forms\FormRequestHandler;


class BannerPromo extends DataObject {
    private static $db = [
        'Title' => 'Varchar',
    ];

    private static $has_one = [
        'Banner' => Image::class,
        'Vendor' => Vendor::class,
        'BannerPlaces' => BannerPlace::class, 
    ];
    private static $has_many = [
    ];
    private static $many_many = [
        'Products' => ProductObject::class
    ];

    private static $owns = [
        'Banner'
    ];
    
    public function getCMSFields() {
        $fields = parent::getCMSFields();
        $fields->addFieldToTab('Root.Main', HiddenField::create('BannerPlacesID'));
        $fields->addFieldToTab('Root.Main', HiddenField::create('VendorID'));
        $fields->addFieldToTab("Root.Main", HasOneButtonField::create(
            $this,
            "BannerPlaces"
        ));
        return $fields;
    }
    
    public function getEditForm($id = null, $fields = null) {
        $form = parent::getEditForm($id, $fields);
        
        // Ensure the form submits via POST
        $form->setFormMethod('POST');
    
        return $form;
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

    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
        $member = Security::getCurrentUser();
        $vendor = Vendor::get()->filter('OwnerID', $member->ID)->first();
        // Debug::show($vendor);
        if (!$this->ID) {
            if ($member = Security::getCurrentUser()) {
                $this->VendorID = $vendor->ID;

            }else{
                user_error('No vendor found for this member', E_USER_WARNING); 
            }
            
        }
    }
}
