<?php

namespace {

use SilverStripe\Dev\Debug;
    use SilverStripe\CMS\Controllers\ContentController;
    use SilverStripe\Control\HTTPRequest;
    use SilverStripe\ORM\ArrayList;
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
        ];

        
        protected function init()
        {
            parent::init();
            // You can include any CSS or JS required by your project here.
            // See: https://docs.silverstripe.org/en/developer_guides/templates/requirements/
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
        public function ChatNotif() {
            $member = Security::getCurrentUser();
            if ($member) {
                $CountNotif = ChatObject::get()
                    ->filter([
                        'ReceiverID' => $member->ID,
                        'NotificationStatus' => 'Unread'
                    ])->count();
                return $CountNotif;
            }
            return null;
        }           
        public function Notification() {
            $member = Security::getCurrentUser();
            // Debug::show($member);
            // die();
            if ($member) {
                $Notification = NotificationObject::get();
                if($Notification){
                    $UnreadNotifs = NotificationObject::get()->filter([
                        'Read' => 'Unread',
                    ])->sort('Created', 'DESC');
                    
                    $ownsUnreadNotif = [];
                    foreach ($UnreadNotifs as $Unnotif) {
                        $headerCheckout = $Unnotif->HeaderCheckout();
                        if ($headerCheckout) {
                            $firstItem = $headerCheckout->Items()->first();
                            if ($firstItem && $firstItem->MemberID == $member->ID) {
                                $ownsUnreadNotif[] = $Unnotif;
                            }
                        }
                    }
                    $ownsUnreadNotif = ArrayList::create($ownsUnreadNotif);
                    return $ownsUnreadNotif;
                }
                return null;
            }
            return null;
        }

        public function ProductListSearch(HTTPRequest $request) {
            $product = ProductObject::get();
            $productTitle = $product->column('Title');

            $categories = ShopCategoryObject::get();
            $categoryTitle = $categories->column('Title');

            $subCategories = ShopSubCategoryObject::get();
            $subCategoryTitle = $subCategories->column('Title');

            $brands = ProductBrandObject::get();
            $brandsTitle = $brands->column('Title');

            $allTitle = array_merge($productTitle, $subCategoryTitle, $categoryTitle, $brandsTitle);
            return json_encode($allTitle);
        }

        public function PromotionObjects() {
            return PromotionObject::get();
        }
        public function Object(){
            $data = PromotionObject::get();
            return ProductObject::get()->filter('ID' , $data);
        }
    }
}
