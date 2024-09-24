<?php

use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\ORM\PaginatedList;


    class ShopCategoryController extends PageController{
        private static $allowed_actions = [
            'filter'
        ];
        public function index(HTTPRequest $request){
            $data = $request->postVar('filter');
            $pagelength = $request->getSession()->get('PageLength');

            // Debug::show($pagelength);
            $categorys = ShopCategoryObject::get();
            $subcategorylist = ShopSubCategoryObject::get();
            $subcategory = $subcategorylist;
            // Debug::show($subcategory);
            $paginatedProduct = PaginatedList::create(ProductObject::get(), $this->getRequest())
            ->setPageLength($pagelength)
            ->setPaginationGetVar('s');

            return  [
                'SubCategory' => $subcategory,
                'Category' => $categorys,
                'PaginatedProduct' =>  $paginatedProduct,
                'CurrentFilter' => $data,
            ];
        }


        public function ProductObjects() {
            return ProductObject::get();
        }

        public function filter(HTTPRequest $request){
            $data = $request->postVars();
            $page = $data['select'];
            // Debug::show(val: $page);

            $request->getSession()->set('PageLength', $page);
            return json_encode([
                'success' => true,
                'message' => 'success'
            ]);
        }

        
    }