<?php
use SilverStripe\ORM\DataObject;


class Promo extends DataObject {
    private static $db = [
        'Diskon' => 'Int',
        'Code' => 'Varchar',
    ];

}