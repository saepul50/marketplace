<?php 

use SilverStripe\Dev\Debug;
use SilverStripe\CMS\Model\SiteTree;
use SilverStripe\Control\Controller;
use SilverStripe\View\ArrayData;

class VendorPageController extends PageController {
    private static $allowed_actions = [
        'index'
    ];

    public function index() {
        $pathname = $this->getRequest()->param('ID');
        $vendor = Vendor::get()->filter(['Pathname' => $pathname])->first();
        // $product = ProductObject::get()->filter('VendorID', $vendor->ID)->count();
        // Debug::show($vendor);
        
        if (!$vendor) {
            return $this->httpError(404, 'Toko tidak ditemukan');
        }

        return $this->customise([
            'Vendor' => $vendor,
            // 'Product' => $product
            ])->renderWith(['VendorPage', 'Page']);
    }
}
