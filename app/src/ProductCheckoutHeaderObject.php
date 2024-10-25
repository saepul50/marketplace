<?php

use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Assets\Image;
use SilverStripe\Dev\Debug;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\LiteralField;
use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\FieldType\DBHTMLText;
use SilverStripe\Security\Member;
use SilverStripe\Security\Permission;
use SilverStripe\Security\Security;

    class ProductCheckoutHeaderObject extends DataObject{
        private static $db = [
            'OrderID'=>'Varchar(255)',
            'CustomerName'=> 'Text',
            'CustomerFullName'=> 'Text',
            'CustomerEmail'=> 'Varchar',
            'CustomerHandphone'=> 'Varchar',
            'CustomerAddress'=> 'Text',
            'CustomerNotes'=> 'Text',
            'ProductCostShipping' => 'Text',
            'FinalPrice'=> 'Text',
            'Bank' => 'Text',
            'Status' => 'Enum("Dikemas,Dikirim,Selesai,Dibatalkan", "Dikemas")',
            'StatusChangeBy' => 'Text',
            'TimeCheckout'=> 'Text',
            'PaymentMethod' => 'Text',
            'PaymentUrl'=>'Varchar(255)',
            'DuitkuOrderID'=>'Varchar(255)',
            'Diskon' => 'Int',
        ];
        private static $has_many = [
            'Items'=> ProductCheckoutObject::class,
        ];
        private static $has_one = [
            'Member' => Member::class,
            'Vendor' => Vendor::class,
            'ProofImage' => Image::class
        ];
        private static $summary_fields = [
            'OrderID'=>'No. Resi',
            'CustomerName'=> 'Nama Customer',
            'TimeCheckout' => 'Waktu Pemesanan',
            'StatusBadge' => 'Status',
            'PaymentMethod' => 'Pembayaran'
        ];
        private static $default_sort = 'Created DESC';
        public function onAfterWrite() {
            parent::onAfterWrite();
            
            if ($this->isChanged('Status')) {
                $currentUser = Security::getCurrentUser();
                if ($currentUser && Permission::check('CMS_ACCESS_OrderAdmin')) {
                    $this->StatusChangeBy = 'Seller';
                } else {
                    $this->StatusChangeBy = 'User';
                }
                $this->write();
                $this->handleStatusChange();
            }
        }
        
        public function handleStatusChange() {
            if ($this->Status == 'Selesai') {
                foreach ($this->Items() as $item) {
                    if ($item) {
                    // Debug::show($item);
                    // die();
                        $item->updateStock();
                        $item->updateSold();
                    }
                }
            }
            $this->createNotification();
        }
        public function createNotification() {
            $notification = NotificationObject::create();
            $notification->Type = 'Order';
            $notification->Status = $this->Status;
            $notification->Title = 'Pesanan ' . $this->Status;
            if ($this->Status == 'Selesai') {
                $notification->Message = 'Pesanan ' . $this->OrderID . ' telah diterima';
            } else {
                $notification->Message = 'Pesanan ' . $this->OrderID . ' telah ' . $this->Status;
            }
            $notification->HeaderCheckoutID = $this->ID;
    
            $notification->write();
        }
        public function getCMSFields() {
            $fields = parent::getCMSFields();
            
            foreach ($fields->dataFields() as $field) {
                if (!$field instanceof DropdownField && !$field instanceof UploadField) {
                    $field->setReadonly(true);
                }
            }
            if ($statusField = $fields->fieldByName('Root.Main.Status')) {
                $statusField->setReadonly(false);
            }
    
            if ($proofImageField = $fields->fieldByName('Root.Main.ProofImage')) {
                $proofImageField->setReadonly(false);
            }

            if ($memberField = $fields->fieldByName('Root.Main.MemberID')) {
                $memberField->setReadonly(true);
            }
        
            if ($vendorField = $fields->fieldByName('Root.Main.VendorID')) {
                $vendorField->setReadonly(true);
            }
            
            if ($this->PaymentMethod === 'Duitku') {
                $link = '<a href="/marketplace/productcheckout/checkTransaction?orderid=' . $this->DuitkuOrderID . '" target="_blank">Cek Status Duitku</a>';
                $fields->replaceField('OrderID', LiteralField::create('OrderID', $link));
            }
            return $fields;
        }
        public function getStatusBadge() {
            $color = '';
            switch ($this->Status) {
                case 'Dikemas':
                    $color = 'darkorange';
                    break;
                case 'Dikirim':
                    $color = 'darkblue';
                    break;
                case 'Dibatalkan':
                    $color = 'red';
                    break;
                case 'Selesai':
                    $color = 'green';
                    break;
            }
    
            return DBHTMLText::create()->setValue(sprintf(
                '<span style="display: flex; align-items: center; justify-content: center; width: 100px; background-color: %s; color: white; padding: .5rem 1rem; border-radius: 4px;">%s</span>',
                $color,
                $this->Status
            ));
        }
        public function canCreate($member = null, $context = [])
        {
            return false; 
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
            return false;
        }

    }