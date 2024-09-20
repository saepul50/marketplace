<?php 
use SilverStripe\ORM\ArrayList;
use SilverStripe\ORM\DataObject;
use SilverStripe\Security\Member;


class ProductRating extends DataObject{
    private static $db = [
        'Rating' => 'Int',
        'Message' => 'Varchar',
    ];

    private static $has_one = [
        "ProductObject" => ProductObject::class,
        "Member" => Member::class
    ];

    public function getFilledStars() {
        if(!$this->Rating || $this->Rating  <= 0){
            return new ArrayList();
        }
        return new ArrayList(range(1, $this->Rating)); // e.g., 1 to 3 for a 3-star rating
    }
    public function getEmptyStars() {
        if($this->Rating < 5){
        $filledstar = $this->Rating ? $this->Rating : 0;
        return new ArrayList(range(1,5 - $filledstar));
        }
        return new ArrayList();
    }
}