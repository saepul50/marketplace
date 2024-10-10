<?php
use SilverStripe\Admin\ModelAdmin;
use SilverStripe\Security\Permission;
use SilverStripe\Security\Security;


class BannerPromoAdmin extends ModelAdmin{
    private static $menu_title = 'Banner Promo';
    private static $url_segment = 'banner-promo';
    private static $menu_icon_class = 'font-icon-block-layout';
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
    public function getList() {
        $list = parent::getList();
        $member = Security::getCurrentUser();
        $vendor = Vendor::get()->filter('OwnerID', $member->ID)->first();
        $modelClass = $this->modelClass;

        if ($member->ID !== 1) {
            if ($modelClass === PromoToko::class) {
                $list = PromoToko::get()->filter('VendorID', $vendor->ID);
            } elseif ($modelClass === BannerPromo::class) {
                $list = BannerPromo::get()->filter('VendorID', $vendor->ID);;
            }
        } else if ($member->ID == 1) {
            if ($modelClass === PromoToko::class) {
                $list = PromoToko::get();
            } elseif ($modelClass === BannerPromo::class) {
                $list = BannerPromo::get();
            }
        }

        return $list;
    }
}