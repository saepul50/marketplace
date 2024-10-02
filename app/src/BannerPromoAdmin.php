<?php
use SilverStripe\Admin\ModelAdmin;
use SilverStripe\Security\Permission;
use SilverStripe\Security\Security;


class BannerPromoAdmin extends ModelAdmin{
    private static $menu_title = 'Banner Promo';
    private static $url_segment = 'banner-promo';
    private static $menu_icon_class = '';
    private static $managed_models = [
        BannerPromo::class,
        PromoToko::class
    ];

    // public function canView($member = null)
    // {
    //     return Permission::check('CMS_ACCESS_BannerPromoAdmin');
    // }

    // public function canCreate($member = null)
    // {
    //     return Permission::check('CMS_ACCESS_BannerPromoAdmin');
    // }

    public function getEditForm($id = null, $fields = null) {
        $form = parent::getEditForm($id, $fields);
        $form->setFormMethod('POST');
        return $form;
    }

    // public function getList() {    //     $list = parent::getList();
    //     $member = Security::getCurrentUser();

    //     $modelClass = $this->modelClass;

    // }
}