<?php

use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\ORM\ValidationException;
use SilverStripe\Security\Security;

class CartPageController extends PageController{
    protected function init() {
        parent::init();
        $member = Security::getCurrentUser();
        // Debug::show($member);
        // die();
        if (!$member) {
            return $this->redirect('login');
        }
    }
    private static $allowed_actions = [
        'addcart' => true
    ];
    public function getCart(){
        $member = Security::getCurrentUser();
        if ($member) {
            return CartObject::get()->filter('MemberID', $member->ID);
        }
        return null;
    }
    public function addcart(HTTPRequest $request){
        if($request){
            $ProductID = $request->postVar('ProductID');
            $ProductTitle = $request->postVar('ProductTitle');
            $ProductImage = $request->postVar('ProductImage');
            $ProductCategoryId = $request->postVar('ProductCategoryID');
            $ProductVariant = $request->postVar('ProductVariant');
            $ProductVariantID= $request->postVar('ProductVariantID');
            $ProductPrice = $request->postVar('ProductPrice');
            $ProductQuantity = $request->postVar('ProductQuantity');
            $data = [
                'ProductID' => $ProductID,
                'ProductTitle' => $ProductTitle,
                'ProductCategryID' => $ProductCategoryId,
                'ProductImage' => $ProductImage,
                'ProductVariant' => $ProductVariant,
                'ProductVariantID' => $ProductVariantID,
                'Price' => $ProductPrice,
                'Quantity' => $ProductQuantity
            ];
            // Debug::show($data);
            // die();
            try{
                $existingCartItem = CartObject::get()
                    ->filter('ProductVariantID', $ProductVariantID)
                    ->filter('MemberID', Security::getCurrentUser()->ID)
                    ->first();
                $existingCartId2 = CartObject::get()
                    ->filter('ProductCategoryId', $ProductCategoryId)
                    ->filter('MemberID', Security::getCurrentUser()->ID)
                    ->first();
                
                if ($existingCartItem) {
                    $existingCartItem->ProductQuantity += $ProductQuantity;
                    $existingCartItem->write();
                } else if ($existingCartId2->$ProductCategoryId = 2) {
                    $existingCartId2->ProductQuantity += $ProductQuantity;
                    $existingCartId2->write();
                } else {
                    $cartItem = CartObject::create();
                    $cartItem->ProductID = $ProductID;
                    $cartItem->ProductTitle = $ProductTitle;
                    $cartItem->ProductImage = $ProductImage;
                    $cartItem->ProductCategoryId = $ProductCategoryId;
                    $cartItem->ProductVariant = $ProductVariant;
                    $cartItem->ProductVariantID = $ProductVariantID;
                    $cartItem->ProductPrice = $ProductPrice;
                    $cartItem->ProductQuantity = $ProductQuantity;
                    $member = Security::getCurrentUser();
                    if ($member) {
                        $cartItem->MemberID = $member->ID;
                    }
                    $cartItem->write();
                }
                
                return json_encode(['success' => true]);
            } catch (ValidationException $e) {
                return json_encode(['success' => false, 'message' => $e->getMessage()]);
            }
        }
        return $this->httpError(405, 'Method Not Allowed');
    }
}
