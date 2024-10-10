<?php 
use PharIo\Manifest\Requirement;
use SilverStripe\Forms\GridField\GridFieldAddNewButton;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Dev\Debug;
use SilverStripe\Admin\LeftAndMain;
use SilverStripe\Admin\ModelAdmin;
use SilverStripe\Control\Director;
use SilverStripe\Forms\GridField\GridFieldConfig;
use SilverStripe\Forms\GridField\GridFieldFilterHeader;
use SilverStripe\ORM\ArrayList;
use SilverStripe\Security\Security;
use SilverStripe\View\Requirements;


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
        $gridfieldconfig = GridFieldConfig_RecordEditor::create();

        $gridfieldconfig->removeComponentsByType('SilverStripe\Forms\GridField\GridFieldPaginator');
        $gridfieldconfig->removeComponentsByType('SilverStripe\Forms\GridField\GridField_ActionMenu');
        $gridfieldconfig->removeComponentsByType('SilverStripe\Forms\GridField\GridField_ActionMenu');
        
        // Remove the "Add new record" button
        $gridfieldconfig->removeComponentsByType('SilverStripe\Forms\GridField\GridFieldAddNewButton');

        if($vendor){
                $list = new ArrayList([$vendor]);
        } else{
            $list = Vendor::get()->filter('ID', -1);
        }
        $fields = $this->getVendorFields($list, $gridfieldconfig);

        return parent::getEditForm($id, $fields);

    }

    private function getVendorFields($list, $gridFieldConfig) {
        $fields = parent::getEditForm()->Fields();
        $gridField = $fields->fieldByName('Vendor');
        if ($gridField) {
            $gridField->setList($list);
            $gridField->setConfig($gridFieldConfig);
        }
        return $fields;
    }

}