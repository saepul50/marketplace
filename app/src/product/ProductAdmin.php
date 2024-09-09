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
    }