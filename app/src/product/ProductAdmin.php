<?php
use SilverStripe\Admin\ModelAdmin;
use SilverStripe\Security\Permission;
use SilverStripe\Security\Security;

    class ProductAdmin extends ModelAdmin{
        private static $menu_title = 'Product';
        private static $url_segment = 'product';
        private static $menu_icon_class = 'font-icon-p-shop';
        private static $managed_models = [
            ProductObject::class,
            ProductBrandObject::class,
            ShopCategoryObject::class,
        ];

        public function canView($member = null)
        {
            return Permission::check('CMS_ACCESS_ProductAdmin');
        }
    
        public function canCreate($member = null)
        {
            return Permission::check('CMS_ACCESS_ProductAdmin');
        }


        public function getEditForm($id = null, $fields = null) {
            $form = parent::getEditForm($id, $fields);
            $form->setFormMethod('POST');
            return $form;
        }


        public function getList() {
            $list = parent::getList();
            $member = Security::getCurrentUser();
    
            $modelClass = $this->modelClass;
    
            if ($member->ID !== 1) {
                if ($modelClass === ProductObject::class) {
                    $vendor = Vendor::get()->filter('OwnerID', $member->ID)->first();
                    $list = ProductObject::class::get()->filter('VendorID', $vendor->ID);
                } elseif ($modelClass === ProductBrandObject::class) {
                    $list = ProductBrandObject::get();
                } elseif($modelClass === ShopCategoryObject::class ){
                    $list = ShopCategoryObject::get();
                }
            } else if ($member->ID == 1) {
                if ($modelClass === ProductObject::class) {
                    $list = ProductObject::class::get();
                } elseif ($modelClass === ProductBrandObject::class) {
                    $list = ProductBrandObject::get();
                } elseif($modelClass === ShopCategoryObject::class ){
                    $list = ShopCategoryObject::get();
                }
            }
    
            return $list;
        }













    }