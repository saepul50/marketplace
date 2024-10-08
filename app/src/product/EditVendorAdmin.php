<?php 
use SilverStripe\Dev\Debug;
use SilverStripe\Admin\LeftAndMain;
use SilverStripe\Admin\ModelAdmin;
use SilverStripe\Control\Director;
use SilverStripe\Forms\GridField\GridFieldConfig;
use SilverStripe\Forms\GridField\GridFieldFilterHeader;
use SilverStripe\Security\Security;


class EditVendorAdmin extends ModelAdmin{
    private static $menu_title = 'Vendor Profile';
    
    private static $url_segment = 'VendorProfile';
    private static $menu_icon_class = 'font-icon-lock';
    
    private static $managed_models = [
        // $member = Security::getCurrentUser(),
        // Vendor::get()->filter('OwnerID', $member->ID),
        Vendor::class
    ];

    protected function init() {
        parent::init();
        $member = Security::getCurrentUser();
        if (!$member) {
            return $this->redirect(Director::absoluteBaseURL() . '/Security/login');
        }

        $vendor = Vendor::get()->filter('OwnerID', $member->ID)->first();
        $currentURL = Director::absoluteURL($_SERVER['REQUEST_URI']);
        
        if (strpos($currentURL, '/item/') === false) {
            if ($vendor) {
                return $this->redirect($this->Link("Vendor/EditForm/field/Vendor/item/{$vendor->ID}/edit"));
            } else {
                return $this->redirect(Director::absoluteBaseURL() . '/vendorregistration');
            }
        }
    }
    public function getEditForm($id = null, $fields = null) {
        $member = Security::getCurrentUser();
        if (!$member) {
            return $this->redirect(Director::absoluteBaseURL() . '/Security/login');
        }

        $vendor = Vendor::get()->filter('OwnerID', $member->ID)->first();
        $currentURL = Director::absoluteURL($_SERVER['REQUEST_URI']);
        
        if (strpos($currentURL, '/item/') === false) {
            if ($vendor) {
                return $this->redirect($this->Link("Vendor/EditForm/field/Vendor/item/{$vendor->ID}/edit"));
            } else {
                return $this->redirect(Director::absoluteBaseURL() . '/vendorregistration');
            }
        }
        return parent::getEditForm($id, $fields);
    }
}