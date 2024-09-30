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

class Stcopy extends LeftAndMain {
    private static $menu_title = 'Status';
    private static $url_segment = 'status'; 
    // private static $menu_icon_class = '';
    // private static $managed_models = [
    //     $this->customise([])->renderWith(['Status'])
    // ];

    private static $allowed_actions = [
        'dashboard',
    ];

    
    public function getCMSFields()
    {
        $fields = parent::getCMSFields();

        // Render the Status.ss template and get its output
        $dashboardContent = $this->dashboard();

        // Add the rendered content directly to the CMS interface
        $fields->addFieldToTab('Root.Main', new LiteralField('DashboardContent', $dashboardContent));

        return $fields;
    }

    public function dashboard()
    {
        // Render the Status.ss template
        return $this->customise([])->renderWith('Admin/Status');
    }
}
