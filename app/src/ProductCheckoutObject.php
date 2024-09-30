<?php

use SilverStripe\Dev\Debug;
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
            $variant = ProductVariantObject::get()->byID($this->ProductVariantID);
            // Debug::show($this);
            // die();
            if ($variant) {
                if ($variant->Stock >= $this->ProductQuantity) {
                    $variant->Stock -= $this->ProductQuantity;
                } else {
                    Debug::show('gagal');
                }
            
                $variant->write();
            }
        }
        public function updateSold() {
            $product = ProductObject::get()->byID($this->ProductID);
            // Debug::show($product);
            // die();
            if ($product) {
                $product->QuantitySold += $this->ProductQuantity;
                $product->write();
            }
        }
    }