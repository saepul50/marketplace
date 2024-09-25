<?php

use SilverStripe\Assets\File;
use SilverStripe\Assets\Image;
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;

    class Vendor extends DataObject{
        private static $db = [
            'Name' => 'Varchar',
            'Pathname' => 'Varchar',
            'Description' => 'Text'
        ];
        private static $has_one = [
            'ProfilImage' => Image::class,
            'Owner' => Member::class
        ];
        private static $has_many = [
            'AboutFile' => File::class,
            'Products' => ProductObject::class
        ];
        public function onBeforeWrite() {
            parent::onBeforeWrite();
    
            if (!$this->Pathname) {
                $this->Pathname = strtolower(str_replace(' ', '', $this->Name));
            }
        }
    }