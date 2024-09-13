<?php 
use SilverStripe\Dev\Debug;
use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\DB;

class BlogCategory extends DataObject {
    private static $db = [
        'Title' => 'Text',
        'Sample' => 'Varchar'  // This will store the occurrence count
    ];

    private static $belongs_many_many = [
        'BlogAdd' => BlogAdd::class,
    ];

    public static function getCategoriesWithCounts() {
        $results = DB::query("
            SELECT BlogCategoryID, COUNT(*) AS OccurrenceCount
            FROM blogadd_blogcategories
            GROUP BY BlogCategoryID
        ");

        $counts = [];
        foreach ($results as $result) {
            $counts[$result['BlogCategoryID']] = $result['OccurrenceCount'];
        }
        $categories = BlogCategory::get()->filterAny([
            'ID' => array_keys($counts)  // Filter categories with matching IDs
        ]);
        foreach ($categories as $category) {
            $category->Sample = $counts[$category->ID];

            $category->write();
        }

        // foreach ($categories as $category) {
        //     Debug::show($category->Title . ' - Occurrence Count: ' . $counts[$category->ID]);
        // }

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

