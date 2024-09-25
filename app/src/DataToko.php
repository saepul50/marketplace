<?php
use SilverStripe\Assets\Image;
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;


class DataToko extends DataObject{
    private static $db = [
        'NamaToko' => 'Varchar',
        'Email' => 'Varchar',
        'NomerHandPhone' => 'Varchar',
        'DeskripsiToko' => 'Varchar',
        'ImageBase64' => 'Text',
        'ProvinsiID' => 'Int',
        'RegencyID' => 'Int',
    ];


    private static $has_one = [
        'Member' => Member::class,
    ];

    private static $owns =[

    ];


}