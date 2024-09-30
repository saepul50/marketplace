<?php

use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;

    class ProductCheckoutObject extends DataObject{
        private static $db = [
            'OrderID'=>'Varchar(255)',
            'ProductCartID' => 'Int',
            'ProductID' => 'Int',
            'ProductTitle' => 'Text',
            'ProductImage' => 'Varchar(255)',
            'ProductVariant'=> 'Text',
            'ProductVariantID' => 'Int',
            'ProductVariantWeight' => 'Float',
            'ProductPrice' => 'Text',
            'ProductQuantity' => 'Int',
            'ProductTotalPrice' => 'Text',
            'ProductSubTotalPrice' => 'Text',
            'ProductCostShipping' => 'Text',
            'ProductFinalPrice' => 'Text',
        ];
        private static $has_one = [
            'Member' => Member::class,
            'HeaderCheckout' => ProductCheckoutHeaderObject::class
        ];
        private static $summary_fields = [
            'ProductTitle' => 'Product Name'
        ];
        private static $default_sort = 'Created DESC';
        public function getCMSFields() {
            $fields = parent::getCMSFields();
            
            foreach ($fields->dataFields() as $field) {
                $field->setReadonly(true);
            }
            return $fields;
        }
        public function getOrderStatus(){
            if ($this->HeaderCheckout()->exists()) {
                return $this->HeaderCheckout()->Status;
            }
            return null;
        }
        public function updateStock() {
            $variant = ProductVariantObject::get()->byID($this->VariantID);
            if ($variant) {
                // Debug::show($variant->Stock);
                // die();
                if ($variant->Stock >= $this->Quantity) {
                    $variant->Stock -= $this->Quantity;
                } else {
                }
            
                $variant->write();
            }
        }
        public function updateSold() {
            $product = ProductObject::get()->byID($this->ProductID);
            if ($product) {
                // Debug::show($variant->Stock);
                // die();
                $product->QuantitySold += $this->Quantity;
            
                $product->write();
            }
        }
        public function canView($member = null)
        {
            return true;
        }
        public function canEdit($member = null)
        {
            return true;
        }
    }