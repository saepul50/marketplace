<?php 

class TrackingPageController extends PageController{
    public function index() {
        $data = $this->nepo(); // Call the nepo() method from PageController

        return [
            'Notif' => $data['Notif'] ?? null,
            'Product' => $data['Product'] ?? null,
            'Count' => $data['Count'] ?? null,
        ];
    }
}