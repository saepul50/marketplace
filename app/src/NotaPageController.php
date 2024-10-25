<?php 
use SilverStripe\Dev\Debug;
use SilverStripe\Control\HTTPRequest;

class NotaPageController extends PageController{
    private static $allowed_actions = [
        'for'
    ];
    public function for(HTTPRequest $request){
        $data = $request->param('ID');
        $header = ProductCheckoutHeaderObject::get()->filter('OrderId', $data)->first();
        // Debug::show($header);
        return $this->customise([
            'Header' =>  $header,
        ])->renderWith(["NotaPage", "Page"]);
        // 
    }
}