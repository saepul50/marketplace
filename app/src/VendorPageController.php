<?php 

use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\CMS\Model\SiteTree;
use SilverStripe\Control\Controller;
use SilverStripe\ORM\ArrayList;
use SilverStripe\ORM\PaginatedList;
use SilverStripe\View\ArrayData;

class VendorPageController extends PageController {
    private static $allowed_actions = [
        'index',
        'filter'
    ];

    public function index(HTTPRequest $request) {
        $pathname = $this->getRequest()->param('ID');
        if($pathname){
            $vendor = Vendor::get()->filter(['Pathname' => $pathname])->first();
            $categories = ShopCategoryObject::get();
            $subCategoryList = ShopSubCategoryObject::get();
            $brandList = ProductBrandObject::get();
            $productQuery = ProductObject::get()->filter('VendorID', $vendor->ID);
            $ProductObject = ProductObject::get()->filter('VendorID', $vendor->ID);
            $count = $productQuery->count();
            
            $pagelength = $request->getSession()->get('PageLength');
            $sortOption = $request->getVar('sort');
            $brandFilter = $request->getVar('filter');
            $subCategoryFilter = $request->getVar('subcategory');
    
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
            if (!$vendor) {
                return $this->httpError(404, 'Toko tidak ditemukan');
            }

            $brandsWithCount = new ArrayList();
            foreach ($brandList as $brand) {
                $productCount = ProductObject::get()->filter([
                    'ProductBrandsID' => $brand->ID, 
                    'VendorID' => $vendor->ID
                ])->count();
                $brandsWithCount->push(new ArrayData([
                    'ID' => $brand->ID,
                    'Title' => $brand->Title,
                    'ProductCount' => $productCount
                ]));
            }

            return $this->customise([
                'SubCategory' => $subCategoryList,
                'Brand' => $brandsWithCount,
                'Category' => $categories,
                'PaginatedProduct' => $paginatedProduct,
                'CurrentFilter' => $brandFilter,
                'CurrentLength' => $pagelength,
                'CurrentSort' => $sortOption,
                'CurrentSubCategory' => $subCategoryFilter,
                'Vendor' => $vendor,
                'Count' => $count,
                'ProductObjects' => $ProductObject  
                ])->renderWith(['VendorPage', 'Page']);
        } else{
            return null;
        }
    }
    public function filter(HTTPRequest $request){
        $data = $request->postVars();
        $page = $data['select'];

        $request->getSession()->set('PageLength', $page);
        return json_encode([
            'success' => true,
            'message' => 'success'
        ]);
    }
}
