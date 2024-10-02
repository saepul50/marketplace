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

class StatusAdmin extends LeftAndMain implements PermissionProvider{
    private static $menu_title = 'Status';
    private static $url_segment = 'status'; 
    private static $menu_icon_class = '';
    private static $allowed_actions = [
        'dashboard',
    ];
    private static $required_permission_codes = ['CMS_ACCESS_StatusAdmin'];
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
        $startOfWeek = date('Y-m-d H:i:s', strtotime('-7 days'));
        if($member->ID == 1){
            $vendor = Vendor::get();
            $list = ProductObject::get();
            $order = ProductCheckoutObject::get();
            $data = ProductCheckoutHeaderObject::get();
            $datatime = ProductCheckoutHeaderObject::get()->filter('TimeCheckout:GreaterThanOrEqual', $startOfWeek);
            
            $count = $data->count();
            $pending = $data->filter('Status', 'Dikemas')->count();  
            $Completed = $data->filter('Status', 'Selesai')->count();  
            $Proccesing = $data->filter('Status', 'Dikirim')->count();  
            $Cancelled = $data->filter('Status', 'Dibatalkan')->count();  
        } else {
            $vendor = Vendor::get()->filter('OwnerID', $member->ID)->first();
            $list = ProductObject::get()->filter('VendorID', $vendor->ID);
            $order = ProductCheckoutObject::get()->filter(['ProductID'=> $list->column('ID')]);
            $headerid = $order->column('HeaderCheckoutID');
            $data = ProductCheckoutHeaderObject::get()->filter(['ID' => $headerid]);
            $datatime = ProductCheckoutHeaderObject::get()->filter(['ID' => $headerid, 'TimeCheckout:GreaterThanOrEqual' => $startOfWeek]);

            $count = $data->count();
            $pending = $data->filter('Status', 'Dikemas')->count();  
            $Completed = $data->filter('Status', 'Selesai')->count();  
            $Proccesing = $data->filter('Status', 'Dikirim')->count();  
            $Cancelled = $data->filter('Status', 'Dibatalkan')->count();
        }
        $transactionsPerDate = [];
        $transactionsPerDateCan = [];
        $labelTransactions = [];
        $labelCategory = [];
        for ($i = 0; $i < 7; $i++) {
            $date = date('d/m/Y', strtotime("-$i days"));
            $transactionsPerDate[$date] = 0;
            $transactionsPerDateCan[$date] = 0;
            $labelTransactions[] = $date;
        }
        foreach($list as $product){
            $category = ShopCategoryObject::get()->Filter('ID', $product->ProductCategoryID);
            $categoryTitle = $category[0]->Title;
            // Debug::show($categoryTitle);
            if ($categoryTitle){
                if (!isset($labelCategory[$categoryTitle])) {
                    $labelCategory[$categoryTitle] = 0;
                }
                $labelCategory[$categoryTitle]++;
            }
        }
        foreach ($data as $checkout) {
            if($checkout->Status != 'Dibatalkan'){
                $checkoutDate = DateTime::createFromFormat('d/m/Y H:i:s', $checkout->TimeCheckout);
                if ($checkoutDate) {
                    $dateString = $checkoutDate->format('d/m/Y');
                    if (isset($transactionsPerDate[$dateString])) {
                        $transactionsPerDate[$dateString]++;
                    }
                }
            } else if($checkout->Status === 'Dibatalkan'){
                $checkoutDate = DateTime::createFromFormat('d/m/Y H:i:s', $checkout->TimeCheckout);
                if ($checkoutDate) {
                    $dateString = $checkoutDate->format('d/m/Y');
                    if (isset($transactionsPerDateCan[$dateString])) {
                        $transactionsPerDateCan[$dateString]++;
                    }
                }
            }
        }
        return $this->customise([
            'Dikemas' => $pending,
            'Selesai' => $Completed,
            'Dikirim' => $Proccesing,
            'Dibatalkan' => $Cancelled,
            'Data' => $count,
            'Vendor' => $vendor,
            'Transactions' => json_encode(array_reverse($transactionsPerDate)),
            'TransactionsCancel' => json_encode(array_reverse($transactionsPerDateCan)),
            'Labels' => json_encode(array_reverse($labelTransactions)),
            'LabelsCategory' => json_encode($labelCategory) 
        ])
        ->renderWith('Status');
    }
    public function canView($member = null)
    {
        return Permission::check('CMS_ACCESS_StatusAdmin');
    }
}