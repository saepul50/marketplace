<?php 
use SilverStripe\Dev\Debug;
use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\DB;

class BlogCategory extends DataObject {
    private static $db = [
        'Title' => 'Text',
        'Sample' => 'Varchar'
    ];

    private static $belongs_many_many = [
        'BlogAdd' => BlogAdd::class,
    ];

    public static function getCategoriesWithCounts() {
        // Query to get counts of blog categories
        $results = DB::query("
            SELECT BlogCategoryID, COUNT(*) AS OccurrenceCount
            FROM blogadd_blogcategories
            GROUP BY BlogCategoryID
        ");
    
        // Prepare an array to store counts
        $counts = [];
        foreach ($results as $result) {
            $counts[$result['BlogCategoryID']] = $result['OccurrenceCount'];
        }
    
        // Check if there are any counts, if not return an empty DataList
        if (empty($counts)) {
            return BlogCategory::get()->filter('ID', 0); // Return empty set
        }
    
        // Filter categories based on the BlogCategoryID that has counts
        $categories = BlogCategory::get()->filter('ID', array_keys($counts));
    
        // Update the Sample field with the count values
        foreach ($categories as $category) {
            $category->Sample = $counts[$category->ID];
            $category->write();  // Save the updated Sample field to the database
        }
    
        return $categories;
    }
    

    public function canView($member = null)
    {
        return true;
    }
    public function canEdit($member = null) {
        // Mencegah pengeditan untuk semua pengguna
        return false;
    }
}

