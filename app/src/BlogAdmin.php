<?php 
use SilverStripe\Admin\ModelAdmin;
use SilverStripe\Security\Permission;
use SilverStripe\Security\Security;

class BlogAdmin extends ModelAdmin{
    private static $menu_title = 'Blog';

    private static $url_segment = 'blog';
    private static $menu_icon_class = '';

    private static $managed_models = [
        BlogCategory::class,
        BlogAdd::class
    ];



    public function canView($member = null)
    {
        return Permission::check('CMS_ACCESS_BlogAdmin');
    }

    public function canCreate($member = null)
    {
        return Permission::check('CMS_ACCESS_BLogAdmin');
    }
    
    public function getEditForm($id = null, $fields = null) {
        $form = parent::getEditForm($id, $fields);
        // Customize the form if needed

        $form->setFormMethod('POST');
        return $form;
    }
    public function getList() {
        $list = parent::getList();
        $member = Security::getCurrentUser();

        // Check which model we're working with
        $modelClass = $this->modelClass;

        // Apply filtering based on the current user
        if ($member->ID !== 1) {
            if ($modelClass === BlogAdd::class) {
                // Filter BlogAdd DataObjects by the creator
                $list = BlogAdd::get()->filter('CreatedBy', $member->ID);
            } elseif ($modelClass === BlogCategory::class) {
                // Allow all BlogCategory for non-admin users (modify as needed)
                $list = BlogCategory::get();
            }
        } else if ($member->ID == 1) {
            // Admin user (ID 1), show all entries
            if ($modelClass === BlogAdd::class) {
                $list = BlogAdd::get();
            } elseif ($modelClass === BlogCategory::class) {
                $list = BlogCategory::get();
            }
        }

        return $list;
    }
}