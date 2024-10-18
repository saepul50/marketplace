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
    private static $menu_icon_class = 'font-icon-chart-pie';
    private static $allowed_actions = [
        'dashboard',
        'getrange'
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
            $this->dashboard($this->getRequest()) 
        );
        $fields->push($iframeField);
        $form = new Form($this, 'EditForm', $fields, new FieldList());

        return $form;
    }

    public function dashboard(HTTPRequest $request)
    {
        $data = $request->postVars();
        // Debug::show($data);
        if (isset($data['length'])) {
            $request->getSession()->set('Length', $data['length']);
        }
        if (isset($data['lengthview'])) {
            $request->getSession()->set('Lengthview', $data['lengthview']);
        }
        $length = $request->getSession()->get('Length') ?? 31;
        $lengthview = $request->getSession()->get('Lengthview') ?? 31;
        $member = Security::getCurrentUser();
        $startOfWeek = date('Y-m-d H:i:s', strtotime('-7 days'));
        if($member->ID == 1){
            $vendor = Vendor::get();
            $list = ProductObject::get();
            $order = ProductCheckoutObject::get();
            $data = ProductCheckoutHeaderObject::get();
            $datatime = ProductCheckoutHeaderObject::get()->filter('TimeCheckout:GreaterThanOrEqual', $startOfWeek);
            $view = LogView::get();

        
        } else {
            $vendor = Vendor::get()->filter('OwnerID', $member->ID)->first();
            $list = ProductObject::get()->filter('VendorID', $vendor->ID);
            $view = LogView::get()->filter('VendorID', $vendor->ID);
            // Debug::show($list);
            // die();
            if($list && $list->exists()){
                $order = ProductCheckoutObject::get()->filter(['ProductID'=> $list->column('ID')]);
                if($order && $order->exists()){

                $headerid = $order->column('HeaderCheckoutID');
                $data = ProductCheckoutHeaderObject::get()->filter(['ID' => $headerid]);
                $datatime = ProductCheckoutHeaderObject::get()->filter(['ID' => $headerid, 'TimeCheckout:GreaterThanOrEqual' => $startOfWeek]); 
                } else {
                    $data = null;
                }

            } else {    
                $data = null;
            } 
        }
        // Debug::show($view);
        $transactionsPerDate = [];
        $transactionsPerDateCan = [];
        $labelTransactions = [];
        $labelCategory = [];
        
        // Debug::show($data);
        if($data && $data->exists()){
            $count = $data->count();
            $pending = $data->filter('Status', 'Dikemas')->count();  
            $Completed = $data->filter('Status', 'Selesai')->count();  
            $Proccesing = $data->filter('Status', 'Dikirim')->count();  
            $Cancelled = $data->filter('Status', 'Dibatalkan')->count();
            for ($i = 0; $i <  $length ; $i++) {
                $date = date('d/m/Y', strtotime("-$i days"));
                $transactionsPerDate[$date] = 0;
                $transactionsPerDateCan[$date] = 0;
                $labelTransactions[] = $date;
            }
            // Debug::show($date);
            // Debug::show($transactionsPerDate);
            // Debug::show($transactionsPerDateCan);
            // Debug::show($labelTransactions);
            foreach ($list as $product) {
                $category = ShopCategoryObject::get()->Filter('ID', $product->ProductCategoryID);
                if ($category && $category->exists()) {
                    $categoryTitle = $category[0]->Title;
                    if ($categoryTitle) {
                        if (!isset($labelCategory[$categoryTitle])) {
                            $labelCategory[$categoryTitle] = 0;
                        }
                        $labelCategory[$categoryTitle]++;
                    }
                } else {
                    // Debug::show("No category found for Product ID: " . $product->ID);
                }
            }
            foreach ($data as $checkout) {
                if($checkout->Status != 'Dibatalkan'){
                    $checkoutDate = DateTime::createFromFormat('d/m/Y H:i:s', $checkout->TimeCheckout);
                    // Debug::show($checkoutDate);
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
        } 
        $labelview = [];
        $viewperdate = [];
        if($view && $view->exists()){
            for($i = 0 ; $i < $lengthview; $i++){
                $date = date('d/m/Y', strtotime("-$i days"));
                $labelview[] = $date;
                $viewperdate[$date] = 0;
            }
            foreach($view as $views){
                $viewDate = DateTime::createFromFormat('Y-m-d H:i:s', $views->Created); 
                if($viewDate){
                    $dateString = $viewDate->format('d/m/Y');
                    if(isset($viewperdate[$dateString])){
                        $viewperdate[$dateString]++;
                    }
                }
            }
        }
        // Debug::show($labelview);
        // Debug::show($viewperdate);
        // Debug::show($transactionsPerDate);
        //     Debug::show($transactionsPerDateCan);
        //     Debug::show($labelTransactions);
        //     Debug::show($labelCategory);
        return $this->customise([
            'Dikemas' => $pending ?? 0,
            'Selesai' => $Completed ?? 0,
            'Dikirim' => $Proccesing ?? 0,
            'Dibatalkan' => $Cancelled ?? 0,
            'Data' => $count ?? 0,
            'Vendor' => $vendor ?? null,
            'DataView' => json_encode(array_reverse($viewperdate)) ?? null,
            'LabelView' => json_encode(array_reverse($labelview)) ?? null,
            'Transactions' => json_encode(array_reverse($transactionsPerDate)) ?? null,
            'TransactionsCancel' => json_encode(array_reverse($transactionsPerDateCan)) ?? null,
            'Labels' => json_encode(array_reverse($labelTransactions)) ?? null,
            'LabelsCategory' => json_encode($labelCategory) ?? null
        ])
        ->renderWith('Status');
    }
    public function canView($member = null)
    {
        return Permission::check('CMS_ACCESS_StatusAdmin');
    }


    public function getrange(HTTPRequest $request){
        $data = $request->postVars();
        if (isset($data['length'])) {
            $request->getSession()->set('Length', $data['length']);
        }

        return json_encode([
            'success' => true,
            'message' => 'Data Got it'
        ]);
    }
}