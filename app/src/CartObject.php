<?php
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;

    class CartObject extends DataObject{
        private static $db = [
            'ProductID' => 'Int',
            'ProductTitle' => 'Text',
            'ProductImage' => 'Varchar',
            'ProductCategoryId' => 'Int',
            'ProductVariant' => 'Text',
            'ProductVariantID' => 'Int',
            'ProductVariantWeight' => 'Float',
            'ProductPrice' => 'Text',
            'ProductQuantity' => 'Int'
        ];
        private static $has_one = [
            'Member' => Member::class
        ];
    }