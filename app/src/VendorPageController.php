<?php

use SilverStripe\Control\HTTPRequest;
use SilverStripe\ORM\ArrayList;
use SilverStripe\ORM\PaginatedList;
use SilverStripe\Security\Security;

    class VendorPageController extends PageController{
        public function index(HTTPRequest $request) {
            // die('dsd');
            $pathname = $request->param('ID');
            $vendor = Vendor::get()->filter(['Pathname' => $pathname])->first();
    
            if (!$vendor) {
                return $this->httpError(404, 'Toko tidak ditemukan');
            }
    
            return $this->customise(['Vendor' => $vendor])->renderWith(['VendorPage', 'Page']);
        }



    }