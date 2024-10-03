<?php
use SilverStripe\Dev\Debug;
use SilverStripe\Forms\CheckboxField;
use SilverStripe\Forms\HiddenField;
use SilverStripe\ORM\ArrayList;
use SilverStripe\ORM\DataObject;

class BannerPlace extends DataObject{
    private static $db = [
        'MainBanner' => 'Boolean',
        'SubBanner' => 'Boolean',
        'SubBanner2' => 'Boolean',
        'SubBanner3' => 'Boolean',
    ];

    private static $has_many = [
        'BannerPromo' => BannerPromo::class,
    ];
    public function getEditForm($id = null, $fields = null) {
        $form = parent::getEditForm($id, $fields);
        $form->setFormMethod('POST');
        return $form;
    }


    // public function onAfterWrite() {
    //     parent::onAfterWrite();
    //     if ($this->isChanged('ID')) {
    //         $bannerPromos = BannerPromo::get();
    //         // Debug::show($bannerPromos);
    //         foreach ($bannerPromos as $bannerPromo) {
    //             $bannerPromo->BannerPlaceID = $this->ID;
    //             $bannerPromo->write(); 
    //         }
    //     }
    // }
    public function getCMSFields()
    { 
        $fields = parent::getCMSFields();
        
        // Adding multiple checkbox fields to Root.Main one by one
        $fields->addFieldToTab('Root.Main', CheckboxField::create('MainBanner', 'Main Banner'));
        $fields->addFieldToTab('Root.Main', CheckboxField::create('SubBanner', 'Sub Banner'));
        $fields->addFieldToTab('Root.Main', CheckboxField::create('SubBanner2', 'Sub Banner 2'));
        $fields->addFieldToTab('Root.Main', CheckboxField::create('SubBanner3', 'Sub Banner 3'));
        $fields->addFieldToTab('Root.Main', HiddenField::create('BannerPromoID', 'BannerPromoID'));

        
        return $fields;
    }

    public function getBannerPromos() {
        if ($this->MainBanner) {
            return $this->BannerPromo(); // Fetch associated BannerPromo items only if MainBanner is checked
        }
        return new ArrayList(); // Return an empty list if MainBanner is not checked
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
    public function isMainBanner() {
        return $this->MainBanner; // Returns true if this is a main banner
    }
    public function isSubBanner() {
        return $this->SubBanner; // Returns true if this is a main banner
    }
    public function isSubBanner2() {
        return $this->SubBanner2; // Returns true if this is a main banner
    }
    public function isSubBanner3() {
        return $this->SubBanner3; // Returns true if this is a main banner
    }
}