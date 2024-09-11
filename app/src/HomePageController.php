<?php 
use SilverStripe\Security\Security; 


class HomePageController extends PageController{
    
    protected function init()
        {
            parent::init();
            $member = Security::getCurrentUser();
            if (!$member) {
            return $this->redirect('login');
            }
        }
         
}