<?php
use SilverStripe\ORM\DataObject;

class Notification extends DataObject{
    private static $db = [
        'CostumerName' => 'Varchar',
        'Status' => 'Text',
        'CheckoutObjectID' => 'Int',
        'Order' => 'Varchar',
        'Notif' => 'Text',
    ];

    private static $has_one = [
        'ProductCheckoutHeader' => ProductCheckoutHeaderObject::class,
    ];

    public function canDelete($member = null){
        return true;
    }
}