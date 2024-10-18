<?php
use SilverStripe\Dev\Debug;
use SilverStripe\Admin\LeftAndMain;
use SilverStripe\Forms\FieldList;
use SilverStripe\Forms\Form;
use SilverStripe\Forms\LiteralField;
use SilverStripe\ORM\ArrayList;
use SilverStripe\ORM\PaginatedList;
use SilverStripe\Security\Member;
use SilverStripe\Security\Permission;
use SilverStripe\Security\PermissionProvider;
use SilverStripe\Security\Security;


class LogViewAdmin extends LeftAndMain implements PermissionProvider{
    private static $menu_title = 'Log View';
    private static $url_segment = 'Logview'; 
    private static $menu_icon_class = 'fas fa-eye';
    private static $required_permission_codes = ['CMS_ACCESS_LogViewAdmin'];
    public function providePermissions()
    {
        return [
                'CMS_ACCESS_LogViewAdmin' => [
                    'name' => 'Access to LogView Admin',
                    'category' => 'CMS Access',
                    'help' => 'Allow access to the custom LogView Admin panel'
                ]
        ];
    }

    public function canView($member = null)
    {
        return Permission::check('CMS_ACCESS_LogViewAdmin');
    }


   
    public function getEditForm($id = null, $fields = null)
    {
        $fields = new FieldList();
        $iframeField = LiteralField::create(
            'IframeField',
            $this->logview()
        );
        $fields->push($iframeField);
        $form = new Form($this, 'EditForm', $fields, new FieldList());
        return $form;
    }

    public function logview(){
        $member = Security::getCurrentUser();
        if($member->ID !== 1){
        $vendor = Vendor::get()->filter('OwnerID', $member->ID)->first();
        $logview = LogView::get()->filter('VendorID' , $vendor->ID)->sort('Created', 'DESC');
        // Debug::show($logview);
        } elseif ($member->ID == 1) {
             $logview = LogView::get()->sort('Created', 'DESC');
        }
        $paginatedlog = PaginatedList::create($logview, $this->getRequest())
        ->setPageLength(10)
        ->setPaginationGetVar('s');
        
        
        return $this->customise([
            'LogView' => $paginatedlog,
            'Member' => $member
        ])->renderWith('LogView');
    }
}