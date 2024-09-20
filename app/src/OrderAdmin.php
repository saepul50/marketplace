<?php

use SilverStripe\Admin\ModelAdmin;
use SilverStripe\Dev\Debug;
use SilverStripe\Forms\DropdownField;
use SilverStripe\Forms\Form;
use SilverStripe\Forms\FormAction;
use SilverStripe\Forms\GridField\GridFieldConfig;
use SilverStripe\Forms\GridField\GridFieldDataColumns;
use SilverStripe\Forms\GridField\GridFieldDetailForm;
use SilverStripe\Forms\GridField\GridFieldSortableHeader;
use SilverStripe\ORM\ValidationException;
use Symbiote\GridFieldExtensions\GridFieldEditableColumns;

class OrderAdmin extends ModelAdmin {
    private static $menu_title = 'Orders';
    private static $url_segment = 'orders';
    private static $menu_icon_class = 'font-icon-cart';
    private static $managed_models = [
        ProductCheckoutHeaderObject::class,
    ];
}
