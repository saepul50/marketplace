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
        return Permission::check('CMS_ACCESS_ModelAdmin');
    }
    
    public function getEditForm($id = null, $fields = null) {
        $form = parent::getEditForm($id, $fields);
        // Customize the form if needed
        return $form;
    }
    public function getList(){
        $list = parent::getList();
        $member = Security::getCurrentUser();
        if ($member->ID !== 1) {
            $list = BlogAdd::get()->filter('CreatedBy', $member->ID);
            // Debug::show($filter);
            
        } else if($member->ID == 1){
            $list = BlogAdd::get();
        }
        return $list;
    }
}