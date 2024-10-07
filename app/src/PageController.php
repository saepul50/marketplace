<?php

namespace {

use SilverStripe\Dev\Debug;
    use SilverStripe\CMS\Controllers\ContentController;
    use SilverStripe\Control\HTTPRequest;
    use SilverStripe\Security\Security;

    /**
     * @template T of Page
     * @extends ContentController<T>
     */
    class PageController extends ContentController
    {
        /**
         * An array of actions that can be accessed via a request. Each array element should be an action name, and the
         * permissions or conditions required to allow the user to access it.
         *
         * <code>
         * [
         *     'action', // anyone can access this action
         *     'action' => true, // same as above
         *     'action' => 'ADMIN', // you must have ADMIN permissions to access this action
         *     'action' => '->checkAction' // you can only access this action if $this->checkAction() returns true
         * ];
         * </code>
         *
         * @var array
         */
        private static $allowed_actions = [
            'ProductListSearch',
            'nepo'
        ];

        
        protected function init()
        {
            parent::init();
            // $this->customise($this->nepo());
            // You can include any CSS or JS required by your project here.
            // See: https://docs.silverstripe.org/en/developer_guides/templates/requirements/
        }
        public function nepo(){
            $member = Security::getCurrentUser();
            // Debug::show($member);
            if(!$member){
                // Debug::show('ksdkadka');
                $notif = null ;
                return  [
                    'Notif' => $notif
                ];
            }else{
            $notifs = Notification::get()->sort('Created', 'DESC')->filter(['Notif' => 'Unread','CostumerName'=> $member->FirstName  ]);
            $product = ProductCheckoutObject::get()->filter('HeaderCheckoutID', $notifs->ProductCheckoutHeaderID );
            // $products = [];
            // foreach($notifs as $notif){
            //     $product = $notif;
            //     $products = $product->Status;
            //     }
            }   
            // Debug::show($product);
            // Debug::show($notifs);
            $status = $notifs->column('Status');
            // Debug::show($status);
            
            return[
                'Notif' => $notifs,
                'Status' => $status,
                'Product' => $product,
                'Count' => $notifs->count(),
            ];
        }
        public function CartData() {
            $member = Security::getCurrentUser();
            // Debug::show($member);
            // die();
            if ($member) {
                $totalCart = CartObject::get()->filter('MemberID', $member->ID)->count();
                return $totalCart;
            }
            return null;
        }    
        public function CountNotif() {
            $member = Security::getCurrentUser();
            // Debug::show($member);
            // die();
            if ($member) {
                $countnotif = Notification::get()->sort('Created', 'DESC')->filter(['Notif' => 'Unread','CostumerName'=> $member->FirstName  ])->count() ;
                return $countnotif;
            }
            return null;
        }

        public function ProductListSearch(HTTPRequest $request) {
            $member = Security::getCurrentUser();
            if ($member) {
                $product = ProductObject::get();
                $productNames = $product->column('Title');
                return json_encode($productNames);
            }
            return json_encode([]);
        }

    
    }
}
