<?php
use Sheadawson\DependentDropdown\Forms\DependentDropdownField;
use SilverStripe\ORM\DataObject;
use SilverStripe\Assets\Image;
use SilverStripe\Assets\File;
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Dev\Debug;
use SilverStripe\Forms\CheckboxField;
use SilverStripe\Forms\CheckboxSetField;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\TextField;
use SilverStripe\Forms\TextAreaField;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\GridField\GridField;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Forms\GridField\GridFieldDataColumns;

    class ProductObject extends DataObject{
       
    private static $db = [
        'Title' => 'Text',
        'Description'=> 'Text',
        'Spesifikasi'=> 'Text',
        'Rating' => 'Decimal',
        'QuantitySold' => 'Int'
    ];
    private static $summary_fields = [
        'Title' => 'Product Name',
        'FirstProductImage' => 'Product Image'
    ];
    private static $has_one = [
        'ProductVideo' => File::class,
        'ProductCategory' => ShopCategoryObject::class,
        'ProductBrands' => ProductBrandObject::class
    ];
    
    private static $many_many = [
        'ProductImages' => Image::class,
        'ProductSubCategory' => ShopSubCategoryObject::class
    ];

    private static $owns = [
        'ProductImages',
        'ProductVideo'
    ];
    
    private static $has_many = [
        'ProductVariants' => ProductVariantObject::class,
        'Promotion' => PromotionObject::class,
    ];
    private static $default_sort = 'Created DESC';
    public function getFirstProductImage() {
        if ($this->ProductImages()->exists()) {
            $image = $this->ProductImages()->first();
            return $image->Thumbnail(100, 100);
        }
        return null;
    }
    public function getVariant(){
        return $this->ProductVariants();
    }
    
    public function getLink() {
        $page = ProductDetails::get()->first();
        if ($page) {
            $link = $page->Link('view/' . $this->ID);
            return $link;
        }
        return null;
    }
    public function rangePrice() {
        $variants = $this->ProductVariants();
        if ($variants->exists()) {
            $prices = $variants->column('Price');
            $minPrice = min($prices);
            $maxPrice = max($prices);
            if($minPrice == $maxPrice) {
                return 'Rp. ' . number_format($maxPrice, 0, '', '.');
            }
            return 'Rp. ' . number_format($minPrice, 0, '', '.') . ' - Rp. ' . number_format($maxPrice, 0, '', '.');
        }
        return 'No price available';
    }
    public function rangePriceDiscounted() {
        $variants = $this->ProductVariants();
        $promotion = $this->Promotion()->first()->PromoPrice;
        if ($variants->exists()) {
            $prices = $variants->column('Price');
            $minPrice = min($prices);
            $maxPrice = max($prices);
            if($minPrice == $maxPrice) {
                return 'Rp. ' . number_format($maxPrice, 0, '', '.');
            }
            return 'Rp. ' . number_format($minPrice * (1 - $promotion / 100), 0, '', '.') . ' - Rp. ' . number_format($maxPrice * (1 - $promotion / 100), 0, '', '.');
        }
        return 'No price available';
    }
    public function minPrice() {
        $variants = $this->ProductVariants();
        if ($variants->exists()) {
            $prices = $variants->column('Price');
            $minPrice = min($prices);
            return 'Rp. ' . number_format($minPrice, 0, '', '.');
        }
        return 'No price available';
    }
    public function minPriceDiscounted() {
        $variants = $this->ProductVariants();
        $promotion = $this->Promotion()->first()->PromoPrice;
        if ($variants->exists() && $promotion) {
            $prices = $variants->column('Price');
            $minPrice = min($prices);
            return 'Rp. ' . number_format($minPrice * (1 - $promotion / 100), 0, '', '.');
        }
        return 'No price available';
    }
    public function totalStock() {
        $variants = $this->ProductVariants();
        if ($variants->exists()) {
            $totalStock = $variants->sum('Stock');
            return $totalStock;
        }
        return 'Out of Stock';
    }
    public function validate() {
        $result = parent::validate();

        if ($this->ProductVariants()->count() === 0) {
            $result->addMessage('You must add at least one variant before saving this product.');
        }

        return $result;
    }
    public function getCMSFields() {
        $categories = ShopCategoryObject::get()->map('ID', 'Title')->toArray();
        $subCategories = ShopSubCategoryObject::get()->map('ID', 'Title')->toArray();
        $brands = ProductBrandObject::get()->map('ID', 'Title')->toArray();
        $sortVariants = $this->ProductVariants()->sort('VariantName');
        $fields = new FieldList(
            TextField::create('Title', 'Product Name'),
            TextField::create('Rating'),
            TextAreaField::create('Description'),
            UploadField::create('ProductImages', 'Product Images')
                ->setAllowedFileCategories('image/supported')
                ->setIsMultiUpload(true),
            UploadField::create('ProductVideo'),
            DropdownField::create('ProductBrandsID', 'Brand', $brands)
                ->setEmptyString('Select a Brand'),
            $categoryField = DropdownField::create('ProductCategoryID', 'Category', $categories)
                ->setEmptyString('Select a Category'),
            CheckboxSetField::create('ProductSubCategory', 'Sub Category', $subCategories),
            GridField::create(
                'ProductVariants',
                'Variants',
                $sortVariants,
                GridFieldConfig_RecordEditor::create(),
            ),
            GridField::create(
                'Promotion',
                'Promotion',
                $this->Promotion(),
                GridFieldConfig_RecordEditor::create(),
            )
        );
        return $fields;
    }
}