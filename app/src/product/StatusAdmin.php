<?php 
use SilverStripe\Control\Director;
use SilverStripe\Forms\FieldList;
use SilverStripe\Dev\Debug;
use SilverStripe\Admin\LeftAndMain;
use SilverStripe\Admin\ModelAdmin;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Forms\Form;
use SilverStripe\Forms\FormAction;
use SilverStripe\Forms\GridField\GridFieldFilterHeader;
use SilverStripe\Forms\HTMLEditor\HTMLEditorField;
use SilverStripe\Forms\LiteralField;
use SilverStripe\Control\PjaxResponseNegotiator;
use SilverStripe\Forms\TabSet;
use SilverStripe\Security\Permission;
use SilverStripe\Security\PermissionProvider;
use SilverStripe\Security\Security;

class StatusAdmin extends LeftAndMain implements PermissionProvider {
    
        private static $menu_title = 'Status';
        private static $url_segment = 'status';
        private static $menu_icon_class = '';
    
        private static $allowed_actions = [
            'dashboard',
        ];
    
        
        private static $required_permission_codes = ['CMS_ACCESS_StatusAdmin'];
        
        public function canView($member = null)
        {
            return Permission::check('CMS_ACCESS_StatusAdmin');
        }

        public function providePermissions()
        {
            return [
                'CMS_ACCESS_StatusAdmin' => [
                    'name' => 'Access to Status Admin',
                    'category' => 'CMS Access',
                    'help' => 'Allow access to the custom Status admin panel'
                ]
            ];
        }
    
        public function getEditForm($id = null, $fields = null)
        {
            $fields = new FieldList();
            $BaseHref = Director::absoluteBaseURL();
            $iframeField = LiteralField::create(
                'IframeField',
                $this->dashboard()
            );
            $fields->push($iframeField);
            $form = new Form($this, 'EditForm', $fields, new FieldList());
    
            return $form;
        }
    
        public function dashboard()
        {
            $member = Security::getCurrentUser();
            if ($member->ID == 1) {
                $vendor = Vendor::get();
                $list = ProductObject::get();
                $order = ProductCheckoutObject::get();
                $data = ProductCheckoutHeaderObject::get();
    
                $pending = $data->filter('Status', 'Pending')->count();  
                $Completed = $data->filter('Status', 'Completed')->count();  
                $Proccesing = $data->filter('Status', 'Processing')->count();  
                $Cancelled = $data->filter('Status', 'Cancelled')->count();  
            } else {
                $vendor = Vendor::get()->filter('OwnerID', $member->ID)->first();
                $list = ProductObject::get()->filter('VendorID', $vendor->ID);
                $order = ProductCheckoutObject::get()->filter(['ProductID'=> $list->column('ID')]);
                $headerid = $order->column('HeaderCheckoutID');
                $data = ProductCheckoutHeaderObject::get()->filter(['ID' => $headerid]);
    
                $pending = $data->filter('Status', 'Pending')->count();  
                $Completed = $data->filter('Status', 'Completed')->count();  
                $Proccesing = $data->filter('Status', 'Processing')->count();  
                $Cancelled = $data->filter('Status', 'Cancelled')->count();  
            }
            
            return $this->customise([
                'Pending' => $pending,
                'Completed' => $Completed,
                'Proccesing' => $Proccesing,
                'Cancelled' => $Cancelled
            ])->renderWith('Status');
        }
    }
