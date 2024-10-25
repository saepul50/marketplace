<?php

use SilverStripe\Control\Controller;
use SilverStripe\Control\HTTPResponse;

class BaseController extends Controller {
    public function serveJSON($body, int $statusCode = 200, $statusDescription = null) {
        $jsonBody = json_encode($body);

        $response = new HTTPResponse($jsonBody, $statusCode, $statusDescription);
        $response->addHeader("Content-Type", "application/json; charset=utf-8");
        return $response;
    }
}
