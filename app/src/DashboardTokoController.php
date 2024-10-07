<?php

class DashboardTokoController extends PageController{
    public function index() {
        $data = $this->nepo(); // Call the nepo() method from PageController

        return [
            'Notif' => $data['Notif'],
            'Product' => $data['Product'],
            'Count' => $data['Count'],
        ];
    }
}