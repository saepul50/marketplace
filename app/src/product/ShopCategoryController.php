<?php

use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\ORM\ArrayList;
use SilverStripe\ORM\PaginatedList;


    class ShopCategoryController extends PageController{
        private static $allowed_actions = [
            'filter'
        ];
        public function index(HTTPRequest $request) {
            $sortOption = $request->getVar('sort');
            $brandFilter = $request->getVar('filter');
            $subCategoryFilter = $request->getVar('subcategory');
            $pagelength = $request->getSession()->get('PageLength');
            
            $categories = ShopCategoryObject::get();
            $subCategoryList = ShopSubCategoryObject::get();
            $brandList = ProductBrandObject::get();
            
            $productQuery = ProductObject::get();
            
            if ($brandFilter && $brandFilter !== 'all') {
                $productQuery = $productQuery->filter('ProductBrandsID', $brandFilter);
            }
            if ($subCategoryFilter && $subCategoryFilter !== 'all') {
                $productQuery = $productQuery->filter('ProductSubCategory.ID', $subCategoryFilter);
            }
            $products = $productQuery->toArray();
            if ($sortOption == 2) {
                usort($products, function($a, $b) {
                    return $a->minPriceDiscountedSort() <=> $b->minPriceDiscountedSort();
                });
            } elseif ($sortOption == 3) {
                usort($products, function($a, $b) {
                    return $b->minPriceDiscountedSort() <=> $a->minPriceDiscountedSort();
                });
            }
        
            $paginatedProduct = PaginatedList::create(new ArrayList($products), $this->getRequest())
                ->setPageLength($pagelength)
                ->setPaginationGetVar('s');
        
            return [
                'SubCategory' => $subCategoryList,
                'Brand' => $brandList,
                'Category' => $categories,
                'PaginatedProduct' => $paginatedProduct,
                'CurrentFilter' => $brandFilter,
                'CurrentLength' => $pagelength,
                'CurrentSort' => $sortOption,
                'CurrentSubCategory' => $subCategoryFilter
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