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
use SilverStripe\Security\Security;
use Symbiote\GridFieldExtensions\GridFieldEditableColumns;

class OrderAdmin extends ModelAdmin {
    private static $menu_title = 'Orders';
    private static $url_segment = 'orders';
    private static $menu_icon_class = 'font-icon-cart';
    private static $managed_models = [
        ProductCheckoutHeaderObject::class,
    ];










    

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
            if ($modelClass ===  ProductCheckoutHeaderObject::class) {
                $vendor = Vendor::get()->filter('OwnerID', $member->ID)->first();
                $list = ProductObject::get()->filter('VendorID', $vendor->ID);
                $order = ProductCheckoutObject::get()->filter(['ProductID'=> $list->column('ID')]);
                if($order->exists()){
                $headerid = $order->column('HeaderCheckoutID');
                // Debug::show($headerid);
                $data = ProductCheckoutHeaderObject::get()->filter(['ID' => $headerid]);
                } else{
                    $order = ProductCheckoutObject::get()->filter(['ProductID' => 0]);
                    $data = ProductCheckoutHeaderObject::get()->filter(['ID' => 0]);
                }

                // Debug::show($data);
            }
        } else if ($member->ID == 1) {
            if ($modelClass === ProductCheckoutHeaderObject::class) {
                $data = ProductCheckoutHeaderObject::get();
            } 
        }

        return $data;
    }
}
