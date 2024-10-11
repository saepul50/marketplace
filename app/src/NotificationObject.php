<?php
use SilverStripe\ORM\DataObject;

class NotificationObject extends DataObject{
    private static $db = [
        'Type' => 'Enum("Order, Promotion", "Order")',
        'Status' => 'Text',
        'Title' => 'Text',
        'Message' => 'Text',
        'Read' => 'Enum("Unread, Read", "Unread")',
        'Date' => 'Date',
        'Time' => 'Time',
    ];

    private static $has_one = [
        'HeaderCheckout' => ProductCheckoutHeaderObject::class,
    ];
    public function onBeforeWrite() {
        parent::onBeforeWrite();

        if (!$this->Date) {
            date_default_timezone_set('Asia/Jakarta');
            $this->Date = date('d-m-Y');
        }
        if (!$this->Time) {
            date_default_timezone_set('Asia/Jakarta');
            $this->Time = date('H:i:s');
        }
        if (!$this->Read) {
            $this->Read = 'Unread';
        }
    }
    public function canDelete($member = null){
        return true;
    }
}