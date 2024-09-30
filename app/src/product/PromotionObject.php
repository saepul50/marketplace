<?php

use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\ORM\DataObject;
use SilverStripe\Assets\Image;
use SilverStripe\Forms\CheckboxField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\LiteralField;
use SilverStripe\Forms\NumericField;
use SilverStripe\Forms\TextareaField;
use SilverStripe\Forms\TextField;

    class PromotionObject extends DataObject{
        private static $db = [
            'PromoText1' => 'Text',
            'PromoText2' => 'Text',
            'PromoText3' => 'Text',
            'PromoPrice' => 'Decimal',
            'ProductImagesID' => 'Int',
            'ProductImagesInputID' => 'Int',
            'ShowPromotion1' => 'Boolean',
            'ShowPromotion2' => 'Boolean',
            'ShowPromotion3' => 'Boolean',
            'ShowPromotion4' => 'Boolean',
            'ShowPromotion5' => 'Boolean',
            'ShowPromotion6' => 'Boolean',
            'ShowPromotion7' => 'Boolean'
        ];
        private static $has_one = [
            'Product' => ProductObject::class,
            'ProductImages' => Image::class,
            'ProductImagesInput' => Image::class
        ];
        private static $owns = [
            'ProductImagesInput'
        ];
        private static $summary_fields = [
            'Product.Title' => 'Product Name',
            'PromoPrice' => 'Promo Price',
            'FirstProductImage' => 'Product Image'
        ];
        public function getFirstProductImage() {
            if ($this->Product->ProductImages()->exists()) {
                $image = $this->Product->ProductImages()->first();
                return $image->Thumbnail(100, 100);
            }
            return null;
        }
        public function getCMSFields() {
            $fields = FieldList::create(
                DropdownField::create('ProductID', 'Select Product', ProductObject::get()->map('ID', 'Title'))
                    ->setEmptyString('--Select a product--')
                    ->setDescription('Choose the product for this promotion')
                    ->setValue($this->Product->ProductID),
                TextField::create('PromoText1', 'Text 1'),
                TextField::create('PromoText2', 'Text 2'),
                TextareaField::create('PromoText3', 'Text 3'),
                NumericField::create('PromoPrice', 'Promo Price (%)')
                    ->setDescription('Enter a percentage value (0-100)   e.g., 10 for 10%'),
                UploadField::create('ProductImagesInput', 'Upload Promo Image (Optional)')
                    ->setAllowedFileCategories('image/supported')
                    ->setDescription('Size Recommendation For Main Promotion (1920x720 px)')
                    ->setIsMultiUpload(false),
                CheckboxField::create('ShowPromotion1', 'Main Promotion'),
                CheckboxField::create('ShowPromotion2', 'Limited Weekly Deals'),
                CheckboxField::create('ShowPromotion3', 'Featured Item Bottom 1'),
                CheckboxField::create('ShowPromotion4', 'Featured Item Bottom 2')
            );
        
            if ($this->ProductImagesInputID) {
                $image = $this->ProductImagesInput();
                if ($image && $image->exists()) {
                    $imageUrl = $image->Link();
                    $fields->add(LiteralField::create(
                        'ProductImages',
                        sprintf(
                            '<div class="product-image-container"><img src="%s" style="width: 40%%; height: auto;" /></div>',
                            $imageUrl
                        )
                    ));
                }
            } else if ($this->ProductID) {
                $product = ProductObject::get_by_id($this->ProductID);
                if ($product && $product->ProductImages()->exists()) {
                    $image = $product->ProductImages()->first();
                    if ($image) {
                        $imageUrl = $image->Link();
                        $fields->add(LiteralField::create(
                            'ProductImages',
                            sprintf(
                                '<div class="product-image-container"><img src="%s" style="width: 40%%; height: auto;" /></div>',
                                $imageUrl
                            )
                        ));
                    }
                }
            }
        
            return $fields;
        }
        public function validate() {
            $result = parent::validate();
        
            if ($this->PromoPrice < 0 || $this->PromoPrice > 100) {
                $result->addError('Promo Price must be between 0 and 100.');
            }
        
            return $result;
        }
        
        public function onBeforeWrite() {
            parent::onBeforeWrite();
            
            if ($this->ProductID) {
                $product = ProductObject::get_by_id($this->ProductID);
                if ($product && $product->ProductImages()->exists()) {
                    $this->ProductImagesID = $product->ProductImages()->first()->ID;
                }
            }
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
    }