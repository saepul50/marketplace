<?php

use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Assets\Image;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\LiteralField;
use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\FieldType\DBHTMLText;

    class ProductCheckoutHeaderObject extends DataObject{
        private static $db = [
            'OrderID'=>'Varchar(255)',
            'CustomerName'=> 'Text',
            'CustomerFullName'=> 'Text',
            'CustomerEmail'=> 'Varchar',
            'CustomerHandphone'=> 'Varchar',
            'CustomerAddress'=> 'Text',
            'CustomerNotes'=> 'Text',
            'FinalPrice'=> 'Text',
            'Bank' => 'Text',
            'Status' => 'Enum("Pending,Processing,Completed,Cancelled", "Pending")',
            'TimeCheckout'=> 'Text',
            'PaymentMethod' => 'Text'
        ];
        private static $has_many = [
            'Items'=> ProductCheckoutObject::class,
        ];
        private static $has_one = [
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
        protected function onAfterWrite() {
            parent::onAfterWrite();
            
            if ($this->isChanged('Status')) {
                $this->handleStatusChange();
            }
        }
        
        protected function handleStatusChange() {
            if ($this->Status == 'Completed') {
                foreach ($this->Items() as $item) {
                    if ($item) {
                        // Debug::show($item);
                        // die();
                        $item->updateStock();
                        $item->updateSold();
                    }
                }
            }
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
            if ($this->PaymentMethod === 'Duitku Transfer') {
                $link = '<a href="duitkupayment/checkTransaction?orderid=' . $this->OrderID . '" target="_blank">Cek Status Duitku</a>';
                $fields->replaceField('OrderID', LiteralField::create('OrderID', $link));
            }
            return $fields;
        }
        public function getStatusBadge() {
            $color = '';
            switch ($this->Status) {
                case 'Pending':
                    $color = 'darkorange';
                    break;
                case 'Processing':
                    $color = 'darkblue';
                    break;
                case 'Cancelled':
                    $color = 'red';
                    break;
                case 'Completed':
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