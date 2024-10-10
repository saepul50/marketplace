<?php 

use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\CMS\Model\SiteTree;
use SilverStripe\Control\Controller;
use SilverStripe\ORM\ArrayList;
use SilverStripe\ORM\PaginatedList;
use SilverStripe\Security\Member;
use SilverStripe\View\ArrayData;

class VendorPageController extends PageController {
    private static $allowed_actions = [
        'index',
        'filter'
    ];
    private function getBannerPromos($bannerPlaces) {
        $promos = new ArrayList();
        
        // Loop through each BannerPlace and get related BannerPromo
        foreach ($bannerPlaces as $bannerPlace) {
            $relatedPromo = $bannerPlace->BannerPromo();
            if ($relatedPromo->exists()) {
                $promos->merge($relatedPromo); // Merge all promos into one list
            }
        }
    
        return $promos;
    }

    public function index(HTTPRequest $request) {
        $pathname = $this->getRequest()->param('ID');
        date_default_timezone_set('Asia/Jakarta'); 
        if($pathname){
            $vendor = Vendor::get()->filter(['Pathname' => $pathname])->first();
            $categories = ShopCategoryObject::get();
            $subCategoryList = ShopSubCategoryObject::get();
            $brandList = ProductBrandObject::get();
            $productQuery = ProductObject::get()->filter('VendorID', $vendor->ID);
            if($productQuery && $productQuery->exists()){
            $ProductObject = ProductObject::get()->filter('VendorID', $vendor->ID);
            $count = $productQuery->count();
            $bestseller = $productQuery->sort('QuantitySold', 'DESC')->filter('QuantitySold:GreaterThan', 0);
            $bestrating = $productQuery->sort('Rating', 'DESC')->filter('Rating:GreaterThan', 0);
            $ratingsData = ProductRating::get()->filter('ProductObjectID', $productQuery->column('ID'));
            } else {
                $ratingsData = null;
                $count = null;
                $bestseller = null;
                $bestrating = 0;

            }
            $pagelength = $request->getSession()->get('PageLength');
            $sortOption = $request->getVar('sort');
            $brandFilter = $request->getVar('filter');
            $subCategoryFilter = $request->getVar('subcategory');
            
            if($ratingsData && $ratingsData->exists()){
            $productRatings = [];
            foreach ($ratingsData as $rating) {
                $productId = $rating->ProductObjectID;
                if (!isset($productRatings[$productId])) {
                    $productRatings[$productId] = [
                        'Ratings' => [],
                        'Count' => 0,
                        'Average' => 0, 
                    ];
                }
                $productRatings[$productId]['Ratings'][] = $rating->Rating;
                $productRatings[$productId]['Count']++;
            }
                $totalAverageSum = [];
                $totalCount = 0;
                foreach ($productRatings as $productId => &$data) {
                    if ($data['Count'] > 0) {
                        $data['Average'] = array_sum($data['Ratings']) / $data['Count'];
                        $totalAverageSum = $data['Average']; 
                        $totalCount++;
                    } else {
                        $data['Average'] = 0;
                    }
                }
                $overallAverage =  $totalAverageSum / $totalCount;
                $formatave = number_format($overallAverage, 2);
                // Debug::show($productRatings);
            }
            $promo = PromoToko::get()->filter(['VendorID'=> $vendor->ID,'ExpDate:GreaterThanOrEqual' => time()]);
            $banner = BannerPromo::get()->filter('VendorID', $vendor->ID)->column('BannerPlacesID'); 
            // Debug::show($banner);
            if ($banner != null) {
                $MainBanner = BannerPlace::get()->filter(['ID'=> $banner,'MainBanner'=> true ,]); 
                $SubBanner = BannerPlace::get()->filter(['ID'=> $banner,'SubBanner'=> true]); 
                $SubBanner2 = BannerPlace::get()->filter(['ID'=> $banner,'SubBanner2'=> true]); 
                $SubBanner3 = BannerPlace::get()->filter(['ID'=> $banner,'SubBanner3'=> true]); 
                // Debug::show($MainBanner);
                // Debug::show($SubBanner);
                // Debug::show($SubBanner2);
                // Debug::show($SubBanner3);
                $mainBannerPromos = $this->getBannerPromos($MainBanner);
                $subBannerPromos = $this->getBannerPromos($SubBanner);
                $subBanner2Promos = $this->getBannerPromos($SubBanner2);
                $subBanner3Promos = $this->getBannerPromos($SubBanner3);

            } else {
                $MainBanner =  null;
                $SubBanner =  null;
                $SubBanner2 = null;
                $SubBanner3 =  null;
                $mainBannerPromos = null;
                $subBannerPromos = null;
                $subBanner2Promos = null;
                $subBanner3Promos =  null ;
            }


        
    
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
            $data = $this->nepo(); 
        
            return $this->customise([
                'Notif' => $data['Notif'],
                'Product' => $data['Product'],
                'Counts' => $data['Count'],
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
                'Promo' => $promo,
                'OverralAverage' => $formatave ?? null,
                'BestSeller' => $bestseller,
                'BestRating' => $bestrating,
                'ProductRating' => $productRatings ?? null,
                'MainBannerPromos' => $mainBannerPromos,
                'SubBannerPromos' => $subBannerPromos,
                'SubBanner2Promos' => $subBanner2Promos,
                'SubBanner3Promos' => $subBanner3Promos,
                'ProductObjects' => $ProductObject ?? null  
                ])->renderWith(['VendorPage', 'Page']);
            
        } else{
            return null;
        }
    }
    public function filter(HTTPRequest $request){
        $data = $request->postVars();
        $page = $data['select'];

        $request->getSession()->set('PageLength', $page);
        // return json_encode([
        //     'success' => true,
        //     'message' => 'success'
        // ]);
    }
}
