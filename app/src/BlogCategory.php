<?php 
use SilverStripe\AssetAdmin\Forms\UploadField;
use SilverStripe\Assets\Image;
use SilverStripe\Dev\Debug;
use SilverStripe\Forms\ReadonlyField;
use SilverStripe\ORM\DataObject;
use SilverStripe\ORM\DB;

class BlogCategory extends DataObject {
    private static $db = [
        'Title' => 'Varchar',
        'Deskripsi' => 'Varchar(50)',
        'Count' => 'Varchar'
    ];


    private static $has_one = [
        'Image' => Image::class
    ];

    private static $owns = [
        'Image'
    ];
    private static $belongs_many_many = [
        'BlogAdds' => BlogAdd::class,
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
            $category->Count = $counts[$category->ID];
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
        return true ;
    }

    public function getCMSFields(){
       $fields = parent::getCMSFields();

       $fields->addFieldToTab('Root.Main',UploadField::create('Image','Image'));
       $fields->addFieldToTab('Root.Main', ReadonlyField::create('Count'));
       $fields->removeByName(array('BlogAdd'));


       return $fields;

    }
}

