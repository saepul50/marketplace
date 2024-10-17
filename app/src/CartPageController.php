<?php

use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\ORM\ArrayList;
use SilverStripe\ORM\ValidationException;
use SilverStripe\Security\Security;

class CartPageController extends PageController{
    // protected function init() {
    //     parent::init();
    //     $member = Security::getCurrentUser();
    //     // Debug::show($member);
    //     // die();
    //     if (!$member) {
    //         return $this->redirect('login');
    //     }
    // }
    private static $allowed_actions = [
        'addcart',
        'remove',
        'variantShow',
    ];
    
    public function getCart(){
        // die();
        $member = Security::getCurrentUser();
        if ($member) {
            $cart = CartObject::get()->filter('MemberID', $member->ID);
            $cartProducts = [];
            foreach($cart as $cartProduct){
                $product = ProductObject::get()->byID($cartProduct->ProductID);
                $variant = ProductVariantObject::get()->byID($cartProduct->ProductVariantID);
                if ($product) {
                    $cartProduct->Product = $product;
                    $cartProduct->Variant = $variant;
                    $cartProducts[] = $cartProduct;
                }
            }
            // Debug::show($cart);
            // die();
            $cartProducts = new ArrayList($cartProducts);
            return $cartProducts;
        }
        return null;
    }
    public function getMember() {
        $member = Security::getCurrentUser();
        if ($member) {
            return $member;
        }
        return null;
    }
    public function addcart(HTTPRequest $request){
        $member = Security::getCurrentUser();
        if($member){
            if($request){
                // Debug::show($request);
                $ProductID = $request->postVar('ProductID');
                $ProductTitle = $request->postVar('ProductTitle');
                $ProductImage = $request->postVar('ProductImage');
                $ProductCategoryId = $request->postVar('ProductCategoryID');
                $ProductVariant = $request->postVar('ProductVariant');
                $ProductVariantID= $request->postVar('ProductVariantID');
                $ProductVariantWeight= $request->postVar('ProductVariantWeight');
                $ProductPrice = $request->postVar('ProductPrice');
                $ProductQuantity = $request->postVar('ProductQuantity');
                $data = [
                    'ProductID' => $ProductID,
                    'ProductTitle' => $ProductTitle,
                    'ProductCategryID' => $ProductCategoryId,
                    'ProductImage' => $ProductImage,
                    'ProductVariant' => $ProductVariant,
                    'ProductVariantWeight' => $ProductVariantWeight,
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
                    $existingCartItem2 = CartObject::get()
                        ->filter('ProductCategoryId', 2)
                        ->filter('ProductID', $ProductID)
                        ->filter('MemberID', Security::getCurrentUser()->ID)
                        ->first();
                    
                    if ($existingCartItem) {
                        $existingCartItem->ProductQuantity += $ProductQuantity;
                        $existingCartItem->ProductVariantWeight += $ProductVariantWeight;
                        $existingCartItem->write();
                    } else if ($existingCartItem2) {
                        $existingCartItem2->ProductQuantity += $ProductQuantity;
                        $existingCartItem2->ProductVariantWeight += $ProductVariantWeight;
                        $existingCartItem2->write();
                    } else {
                        $cartItem = CartObject::create();
                        $cartItem->ProductID = $ProductID;
                        $cartItem->ProductTitle = $ProductTitle;
                        $cartItem->ProductImage = $ProductImage;
                        $cartItem->ProductCategoryId = $ProductCategoryId;
                        $cartItem->ProductVariant = $ProductVariant;
                        $cartItem->ProductVariantID = $ProductVariantID;
                        $cartItem->ProductVariantWeight = $ProductVariantWeight;
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
        return json_encode(['success' => false, 'message' => 'Login terlebih dahulu']);
    }
    public function remove(HTTPRequest $request) {
        if ($request) {
            $IDs = $request->postVar('ID') ? [$request->postVar('ID')] : $request->postVar('IDs');
    
            if (is_array($IDs)) {
                $success = true;
                foreach ($IDs as $ID) {
                    $cartItem = CartObject::get()->byID($ID);
                    if ($cartItem && $cartItem->MemberID == Security::getCurrentUser()->ID) {
                        $cartItem->delete();
                    } else {
                        $success = false;
                    }
                }
                return json_encode(['success' => $success]);
            } else {
                $cartItem = CartObject::get()->byID($IDs);
                if ($cartItem && $cartItem->MemberID == Security::getCurrentUser()->ID) {
                    $cartItem->delete();
                    return json_encode(['success' => true]);
                }
                return json_encode(['success' => false, 'message' => 'Item not found or permission denied']);
            }
        }
        return $this->httpError(405, 'Method Not Allowed');
    }  
    public function variantShow(HTTPRequest $request) {
        $productID = $request->postVar('ProductID');
        if ($productID) {
            $product = ProductObject::get()->byID($productID);
            
            if ($product && $product->ProductVariants()->exists()) {
                return json_encode([
                    'success' => true,
                    'product' => $product->toMap(),
                    'productImage' => $product->getFirstProductImageModal()->getURL(),
                    'variants' => $product->ProductVariants()->toNestedArray()
                ]);
            }
        }
        return json_encode(['success' => false]);
    }    
}
