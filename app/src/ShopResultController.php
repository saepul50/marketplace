<?php 
use SilverStripe\Dev\Debug;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\ORM\ArrayList;
use SilverStripe\ORM\PaginatedList;
use SilverStripe\View\ArrayData;
class ShopResultController extends PageController{
    private static $allowed_actions = [
        'filter'
    ];
    public function index(HTTPRequest $request) {
        $sortOption = $request->getVar('sort');
        $brandFilter = $request->getVar('filter');
        $subCategoryFilter = $request->getVar('subcategory');
        $search = $request->getVar('keywords');
        $pagelength = $request->getSession()->get('PageLength') ?? 10;
    
        $categories = ShopCategoryObject::get();
        $subCategoryList = ShopSubCategoryObject::get();
        $brandList = ProductBrandObject::get();
    
        $productQuery = ProductObject::get();
        $activeFilters = ArrayList::create();
    
        if ($brandFilter && $brandFilter !== 'all') {
            $productQuery = $productQuery->filter('ProductBrandsID', $brandFilter);
            $activeFilters->push(ArrayData::create([
                'Label' => ProductBrandObject::get()->byID($brandFilter)->Title
            ]));
        }
    
        if ($subCategoryFilter && $subCategoryFilter !== 'all') {
            $productQuery = $productQuery->filter('ProductSubCategory.ID', $subCategoryFilter);
            $activeFilters->push(ArrayData::create([
                'Label' => ShopSubCategoryObject::get()->byID($subCategoryFilter)->Title
            ]));
        }
    
        if ($search) {
            $productQuery = $productQuery->filterAny([
                'Title:PartialMatch' => $search,
                'ProductCategory.Title:PartialMatch' => $search,
                'ProductSubCategory.Title:PartialMatch' => $search,
                'ProductBrands.Title:PartialMatch' => $search
            ]);
            $activeFilters->push(ArrayData::create([
                'Label' => "$search"
            ]));
        }
        $productList = $productQuery->toArray(); 
        // Debug::show($productList);
        if ($sortOption == 2) {
            usort($productList, function ($a, $b) {
                return $a->minPriceDiscountedSort() <=> $b->minPriceDiscountedSort();
            });
        } elseif ($sortOption == 3) {
            usort($productList, function ($a, $b) {
                return $b->minPriceDiscountedSort() <=> $a->minPriceDiscountedSort();
            });
        }

        $productList = ArrayList::create($productList);
    
        $paginatedProduct = PaginatedList::create($productList, $request)
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
            'CurrentSubCategory' => $subCategoryFilter,
            'ActiveFilters' => $activeFilters
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