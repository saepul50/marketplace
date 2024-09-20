<?php
use SilverStripe\Assets\Image;
use SilverStripe\ORM\DataObject;

    class ProductCheckoutHeaderObject extends DataObject{
        private static $db = [
            'OrderID'=>'Varchar(255)',
            'CustomerName'=> 'Text',
            'CustomerFullName'=> 'Text',
            'CustomerEmail'=> 'Varchar',
            'CustomerHandphone'=> 'Varchar',
            'CustomerAddress'=> 'Text',
            'CustomerNotes'=> 'Text',
            'FinalPrice'=> 'Text',
            'Bank' => 'Text',
            'Status' => 'Enum("Pending,Processing,Completed,Cancelled", "Pending")',
            'TimeCheckout'=> 'Text',
            'PaymentMethod' => 'Text'
        ];
        private static $has_many = [
            'Items'=> ProductCheckoutObject::class,
        ];
        private static $has_one = [
            'ProofImage' => Image::class
        ];
        private static $summary_fields = [
            'OrderID'=>'No. Resi',
            'Customername'=> 'Nama Customer',
            'TimeCheckout' => 'Waktu Pemesanan',
            'StatusBadge' => 'Status',
            'PaymentMethod' => 'Pembayaran'
        ];
    }