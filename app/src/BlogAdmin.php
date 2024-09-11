<?php 
use SilverStripe\Admin\ModelAdmin;

class BlogAdmin extends ModelAdmin{
    private static $menu_title = 'Blog';

    private static $url_segment = 'blog';
    private static $menu_icon_class = '';

    private static $managed_models = [
        BlogCategory::class,
        BlogAdd::class
    ];
}