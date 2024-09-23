<?php

use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TextField;
use SilverStripe\ORM\DataObject;
use SilverStripe\Assets\Image;

    class ProductVariantObject extends DataObject{
        private static $db = [
            'VariantName' => 'Text',
            'Price'=> 'Decimal(19, 2)',
            'Stock' => 'Int',
            'Weight' => 'Decimal',
        ];
    
        private static $has_one = [
            'Product' => ProductObject::class
        ];
    
        private static $summary_fields = [
            'VariantName' => 'Variant',
            'Price' => 'Price',
            'Stock' => 'Stock',
            'Weight' => 'Weight',
        ];
        
        public function onBeforeWrite() {
            parent::onBeforeWrite();
            if ($this->Price) {
                $this->Price = number_format($this->Price, 2, '.', '');
            }
        }
    
        public function onAfterWrite() {
            parent::onAfterWrite();
            if ($this->VariantImageID && $this->VariantImage()->exists()) {
                $this->VariantImage()->publishSingle();
            }
        }
        public function getNormalPrice() {
            return 'Rp. ' . number_format($this->Price, 0, '', '.');
        }
        public function getDiscountedPrice() {
            $promotion = $this->Product->Promotion()->first();
            // Debug::show($promotion);
            // die();
            if ($promotion && $promotion->PromoPrice) {
                $originalPrice = $this->Price;
                $promoPrice = $promotion->PromoPrice;
                $discountedPrice = $originalPrice * (1 - $promoPrice / 100);
                return 'Rp. ' . number_format($discountedPrice, 0, '', '.');
            }
            return 'Rp. ' . number_format($this->Price, 0, '', '.');
        }
        public function getCMSFields() {
            return new FieldList(
                TextField::create('VariantName', 'Variant'),
                TextField::create('Price')
                ->setDescription('Input Only Number'),
                TextField::create('Stock', 'Stock'),
                TextField::create('Weight')
                ->setDescription('/grams'),
            );
        }
    }