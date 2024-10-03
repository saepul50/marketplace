<?php
use Sheadawson\DependentDropdown\Forms\DependentDropdownField;
use SilverStripe\Forms\RequiredFields;
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
use SilverStripe\Security\Security;
use SilverStripe\View\Requirements;

    class ProductObject extends DataObject{
       
    private static $db = [
        'Title' => 'Text',
        'Features'=> 'Text',
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
        'Vendor' => Vendor::class,
        'ProductVideo' => File::class,
        'ProductCategory' => ShopCategoryObject::class,
        'ProductBrands' => ProductBrandObject::class,
    ];
    
    private static $many_many = [
        'ProductImages' => Image::class,
        'ProductSubCategory' => ShopSubCategoryObject::class
    ];
    
    private static $belongs_many_many = [
        'Banner' => BannerPromo::class,
    ];

    private static $owns = [
        'ProductImages',
        'ProductVideo'
    ];
    
    private static $has_many = [
        'ProductVariants' => ProductVariantObject::class,
        'Promotion' => PromotionObject::class,
        'BlogComment' => ProductComment::class,
        'CommentReply' =>ProductReply::class,
    ];
    private static $default_sort = 'Created DESC';


    
    public function onBeforeWrite()
    {
        parent::onBeforeWrite();
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


    
    public function getFirstProductImage() {
        if ($this->ProductImages()->exists()) {
            $image = $this->ProductImages()->first();
            return $image->Thumbnail(100, 100);
        }
        return null;
    }
    public function getVariants(){
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
        // Debug::show($this->ProductSubCategory());
        // die();
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
        if ($variants->exists() && $promotion) {
            $prices = $variants->column('Price');
            $minPrice = min($prices);
            $maxPrice = max($prices);
            if($minPrice == $maxPrice) {
                return 'Rp. ' . number_format($maxPrice * (1 - $promotion / 100), 0, '', '.');
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
    public function minPriceDiscountedSort() {
        $variants = $this->ProductVariants();
        $promotion = $this->Promotion()->first();
        
        if ($variants->exists()) {
            $prices = $variants->column('Price');
            $minPrice = min($prices);
            
            if ($promotion) {
                return $minPrice * (1 - $promotion->PromoPrice / 100);
            }
            return $minPrice;
        }
        return 0;
    }
    public function totalStock() {
        $variants = $this->ProductVariants();
        if ($variants->exists()) {
            $totalStock = $variants->sum('Stock');
            return $totalStock;
        }
        return 'Out of Stock';
    }
    // public function validate() {
    //     $result = parent::validate();

    //     if ($this->ProductVariants()->count() === 0) {
    //         $result->addMessage('You must add at least one variant before saving this product.');
    //     }

    //     return $result;
    // }
    public function getCMSFields() {
        $member = Security::getCurrentUser();
        $vendor = Vendor::get()->filter('OwnerID', $member->ID)->first();


        if($member->ID == 1){
        $categories = ShopCategoryObject::get()->map('ID', 'Title')->toArray();
        $brands = ProductBrandObject::get()->map('ID', 'Title')->toArray();
        $sortVariants = $this->ProductVariants()->sort('VariantName');
        
        $categoryField = DropdownField::create('ProductCategoryID', 'Category', $categories)
            ->setEmptyString('Select a Category');
    
        $subCategoryField = CheckboxSetField::create('ProductSubCategory', 'Sub Category', []);
        if ($this->ProductCategoryID) {
            $validSubCategories = ShopSubCategoryObject::get()->filter('ProductCategoryID', $this->ProductCategoryID)->map('ID', 'Title')->toArray();
            $subCategoryField->setSource($validSubCategories);
        }
        
        // Debug::show($subCategoryField);
        // die();
        Requirements::customScript(<<<JS
            (function($) {
                $('#Form_ItemEditForm_ProductCategoryID').change(function() {
                    var categoryID = $(this).val();
                    $.ajax({
                        url: '/marketplace/productdetails/getSubCategories/' + categoryID,
                        success: function(data) {
                            var subCategories = JSON.parse(data);
                            var checkboxSetField = $('#Form_ItemEditForm_ProductSubCategory');
                            checkboxSetField.empty();
                            $.each(subCategories, function(id, title) {
                                checkboxSetField.append('<label><input type="checkbox" name="ProductSubCategory[]" value="' + id + '"> ' + title + '</label>');
                            });
                        }
                    });
                });
            })(jQuery);
        JS
        );
    
        $fields = new FieldList(
            TextField::create('Title', 'Product Name'),
            TextField::create('Rating'),
            TextAreaField::create('Features'),
            TextAreaField::create('Description'),
            UploadField::create('ProductImages', 'Product Images')
                ->setAllowedFileCategories('image/supported')
                ->setIsMultiUpload(true),
            UploadField::create('ProductVideo'),
            DropdownField::create('ProductBrandsID', 'Brand', $brands)
                ->setEmptyString('Select a Brand'),
            $categoryField,
            $subCategoryField,
            GridField::create(
                'ProductVariants',
                'Variants',
                $sortVariants,
                GridFieldConfig_RecordEditor::create()
            ),
            GridField::create(
                'Promotion',
                'Promotion',
                $this->Promotion(),
                GridFieldConfig_RecordEditor::create()
            )
        );
    
        return $fields;
        } else if ($member->ID !== 1) {
        $categories = ShopCategoryObject::get();
        $brands = ProductBrandObject::get();
        $sortVariants = $this->ProductVariants()->sort('VariantName');
        
        $categoryField = DropdownField::create('ProductCategoryID', 'Category', $categories)
            ->setEmptyString('Select a Category');
    
        $subCategoryField = CheckboxSetField::create('ProductSubCategory', 'Sub Category', []);
        if ($this->ProductCategoryID) {
            $validSubCategories = ShopSubCategoryObject::get()->filter('ProductCategoryID', $this->ProductCategoryID)->map('ID', 'Title')->toArray();
            $subCategoryField->setSource($validSubCategories);
        }
        
        // Debug::show($subCategoryField);
        // die();
        Requirements::customScript(<<<JS
            (function($) {
                $('#Form_ItemEditForm_ProductCategoryID').change(function() {
                    var categoryID = $(this).val();
                    $.ajax({
                        url: '/marketplace/productdetails/getSubCategories/' + categoryID,
                        success: function(data) {
                            var subCategories = JSON.parse(data);
                            var checkboxSetField = $('#Form_ItemEditForm_ProductSubCategory');
                            checkboxSetField.empty();
                            $.each(subCategories, function(id, title) {
                                checkboxSetField.append('<label><input type="checkbox" name="ProductSubCategory[]" value="' + id + '"> ' + title + '</label>');
                            });
                        }
                    });
                });
            })(jQuery);
        JS
        );
    
        $fields = new FieldList(
            TextField::create('Title', 'Product Name'),
            TextField::create('Rating'),
            TextAreaField::create('Features'),
            TextAreaField::create('Description'),
            UploadField::create('ProductImages', 'Product Images')
                ->setAllowedFileCategories('image/supported')
                ->setIsMultiUpload(true),
            UploadField::create('ProductVideo'),
            DropdownField::create('ProductBrandsID', 'Brand', $brands)
                ->setEmptyString('Select a Brand'),
            $categoryField,
            $subCategoryField,
            GridField::create(
                'ProductVariants',
                'Variants',
                $sortVariants,
                GridFieldConfig_RecordEditor::create()
            ),
            GridField::create(
                'Promotion',
                'Promotion',
                $this->Promotion(),
                GridFieldConfig_RecordEditor::create()
            )
        );
    
        return $fields;
        }
    }

    function getCMSValidator() {
        return new ProductObject_Validator();
    }

}

class ProductObject_Validator extends RequiredFields {

    function php($data) {
        $bRet = parent::php($data);

        //do checking here
        if (empty($data['Title']))
            $this->validationError('Title','Title cannot be empty','required');

        if (empty($data['Features']))
            $this->validationError('Features','Features cannot be empty','required');

        if (empty($data['Description']))
            $this->validationError('Description','Description cannot be empty','required');
        if (empty($data['Rating']))
            $this->validationError('Rating','Rating cannot be empty','required');        
        if (empty($data['ProductImages']))
            $this->validationError('ProductImages','ProductImages cannot be empty','required');

        if (empty($data['ProductBrandsID']))
                    $this->validationError('ProductBrandsID','ProductBrandsID cannot be empty','required');
        if (empty($data['ProductCategoryID']))
                    $this->validationError('ProductCategoryID','ProductCategoryID cannot be empty','required');
        if (empty($data['ProductVariants']))
                    $this->validationError('ProductVariants','ProductVariants cannot be empty','required');
        if (empty($data['ProductImages']))
                    $this->validationError('ProductImages','ProductImages cannot be empty','required');

        return count($this->getErrors());
    }
}

