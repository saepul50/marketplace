<?php

use SilverStripe\Assets\File;
use SilverStripe\Assets\Image;
use SilverStripe\Forms\HiddenField;
use SilverStripe\Forms\ReadonlyField;
use SilverStripe\Forms\TextField;
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;

    class Vendor extends DataObject{
        private static $db = [
            'Name' => 'Varchar',
            'Pathname' => 'Varchar',
            'Description' => 'Text',
            'EmailOwner' => 'Varchar',
            'HandphoneOwner' => 'BigInt',
            'ProvinsiID' => 'Int',
            'RegencyID' => 'Int',
            'Address' => 'Text',
            'AddressDetail' => 'Text',
            'Postal' => 'Int',
        ];
        private static $has_one = [
            'ProfilImage' => File::class,
            'Owner' => Member::class,
        ];
        private static $has_many = [
            'Products' => ProductObject::class,
            'PromoToko' => PromoToko::class,
            'Chat' => ChatObject::class,
            'BannerPlaces' => BannerPlace::class, 
        ];


        private static $owns = [
             'ProfilImage',
        ];
        public function onBeforeWrite() {
            parent::onBeforeWrite();
            
            if (!$this->Pathname) {
                $this->Pathname = strtolower(str_replace(' ', '', $this->Name));
            }
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

        public function getCMSFields()
        { 
            $fields = parent::getCMSFields();
            
            // Adding multiple checkbox fields to Root.Main one by one
            $fields->addFieldToTab('Root.Main', TextField::create('Name'));
            $fields->addFieldToTab('Root.Main', ReadonlyField::create('Pathname'));
            $fields->addFieldToTab('Root.Main', TextField::create('Description'));
            $fields->addFieldToTab('Root.Main', TextField::create('EmailOwner'));
            $fields->addFieldToTab('Root.Main', TextField::create('HandphoneOwner'));
            $fields->addFieldToTab('Root.Main', HiddenField::create('OwnerID'));
            $fields->addFieldToTab('Root.Main', ReadonlyField::create('ProvinsiID'));
            $fields->addFieldToTab('Root.Main', ReadonlyField::create('RegencyID'));
            $fields->addFieldToTab('Root.Main', ReadonlyField::create('Address'));
            $fields->addFieldToTab('Root.Main', TextField::create('AddressDetail'));
            $fields->addFieldToTab('Root.Main', ReadOnlyField::create('Postal'));
            $fields->removeByName(array('Products','PromoToko','Chat'));
            
            return $fields;
        }
    
    }