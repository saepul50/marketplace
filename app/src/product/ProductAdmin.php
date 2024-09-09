<?php
use SilverStripe\Admin\ModelAdmin;

    class ProductAdmin extends ModelAdmin{
        private static $menu_title = 'Product';
        private static $url_segment = 'product';
        private static $menu_icon_class = 'font-icon-p-shop';
        private static $managed_models = [
            ProductObject::class,
            ProductBrandObject::class,
            ShopCategoryObject::class,
        ];
        private static $url_handlers = [
            'get-subcategories' => 'getSubCategories',
        ];
    
        public function getSubCategories($request) {
            $categoryID = $request->getVar('categoryID');
            $subCategories = ShopSubCategoryObject::get()
                ->filter('ProductCategoryID', $categoryID)
                ->map('ID', 'Title')
                ->toArray();
            return json_encode($subCategories);
        }
    }