<?php

use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;

    class ProductCheckoutObject extends DataObject{
        private static $db = [
            'OrderID'=>'Varchar(255)',
            'ProductCartID' => 'Int',
            'ProductID' => 'Int',
            'ProductTitle' => 'Text',
            'ProductImage' => 'Varchar(255)',
            'ProductVariant'=> 'Text',
            'ProductVariantID' => 'Int',
            'ProductVariantWeight' => 'Float',
            'ProductPrice' => 'Text',
            'ProductQuantity' => 'Int',
            'ProductTotalPrice' => 'Text',
            'ProductSubTotalPrice' => 'Text',
            'ProductCostShipping' => 'Text',
            'ProductFinalPrice' => 'Text',
        ];
        private static $has_one = [
            'Member' => Member::class,
            'HeaderCheckout' => ProductCheckoutHeaderObject::class
        ];
        private static $summary_fields = [
            'ProductTitle' => 'Product Name'
        ];
    }