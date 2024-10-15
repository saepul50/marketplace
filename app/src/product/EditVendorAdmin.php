<?php 
use PharIo\Manifest\Requirement;
use SilverStripe\Forms\GridField\GridFieldAddNewButton;
use SilverStripe\Forms\GridField\GridFieldConfig_RecordEditor;
use SilverStripe\Dev\Debug;
use SilverStripe\Admin\LeftAndMain;
use SilverStripe\Admin\ModelAdmin;
use SilverStripe\Control\Director;
use SilverStripe\Forms\GridField\GridFieldConfig;
use SilverStripe\Forms\GridField\GridFieldDetailForm;
use SilverStripe\Forms\GridField\GridFieldDetailForm_ItemRequest;
use SilverStripe\Forms\GridField\GridFieldFilterHeader;
use SilverStripe\ORM\ArrayList;
use SilverStripe\Security\Security;
use SilverStripe\View\Requirements;
use SilverStripe\Forms\GridField\GridField;


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
        if($member->ID !== 1){
        $vendor = Vendor::get()->filter('OwnerID', $member->ID)->first();
        $currentURL = Director::absoluteURL($_SERVER['REQUEST_URI']);
        
        if (strpos($currentURL, '/item/') === false) {
            if ($vendor) {
                return $this->redirect($this->Link("Vendor/EditForm/field/Vendor/item/{$vendor->ID}/edit"));
            } else {
                return $this->redirect(Director::absoluteBaseURL() . '/vendorregistration');
            }
        }
         } else {
            return Vendor::get();
         }
    }
    public function getEditForm($id = null, $fields = null) {
        
        $form = parent::getEditForm($id, $fields);
        $gridField = $form->Fields()->dataFieldByName($this->sanitiseClassName($this->modelClass));

        if ($gridField instanceof GridField) {
            $detailForm = $gridField->getConfig()->getComponentByType(GridFieldDetailForm::class);
            
            if ($detailForm) {
                $detailForm->setItemRequestClass(DetailForm_ItemRequest::class);
            }
        }

        return $form;
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
class DetailForm_ItemRequest extends GridFieldDetailForm_ItemRequest
{
    public function getNextRecordID()
    {
        return false;
    }

    public function getPreviousRecordID()
    {
        return false;
    }
}