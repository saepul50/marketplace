<?php 
use SilverStripe\Dev\Debug;
use SilverStripe\Forms\DateField;
use SilverStripe\Forms\HiddenField;
use SilverStripe\Forms\ReadonlyField;
use SilverStripe\Forms\TextField;
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Security;


class PromoToko extends DataObject{
    private static $db = [
        'Diskon' => 'Int',
        'Code' => 'Varchar',
        'ExpDate' => 'Datetime',
        'MaximumUse' => 'Int',
    ];

    private static $has_one = [
        'Vendor' => Vendor::class
    ];

    public function summaryFields(){
        return  [
            'Diskon' => 'Diskon',
            'Code' => 'Code',
            'ExpDate' => 'Exp.Date',
            'MaximumUse' => 'Maximum Use'
        ];

    }

    public function onBeforeWrite()
    {
        parent::onBeforeWrite();

        $s = substr(str_shuffle(str_repeat("0123456789ABCDEFGHIJKLMNOPGRSTUFWXYZ", 5)), 0, 5);
        $this->Code = $s;
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
    public function getCMSFields()
    { 
        $fields = parent::getCMSFields();
    
        $fields->addFieldToTab('Root.Main', HiddenField::create('Code', 'Code'));
        $fields->addFieldToTab('Root.Main', TextField::create('Diskon', 'Diskon %'));
        $fields->addFieldToTab('Root.Main', TextField::create('MaximumUse', 'Maximum Use'));
        $fields->addFieldToTab('Root.Main', HiddenField::create('VendorID', 'VendorID'));
        return $fields;
    }
}