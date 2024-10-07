<?php 
use SilverStripe\Control\Email\Email;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Security\Security;
use SilverStripe\SiteConfig\SiteConfig;
class ContactPageController extends PageController{
    
    private static $allowed_actions = [
        'mail'
    ];

    public function index() {
        $data = $this->nepo(); // Call the nepo() method from PageController

        return [
            'Notif' => $data['Notif'],
            'Product' => $data['Product'],
            'Count' => $data['Count'],
        ];
    }
    public function mail(HTTPRequest $request)
    {
        // Get POST data
        $data = $request->postVars();
        $subject = $request->postVar('subject');
        $email = $request->postVar('email');
        // Debug::show($data); // Display the POST data for debugging
        $siteconfig = SiteConfig::current_site_config();
        // Debug::show($siteconfig);
        $send = $siteconfig->Email;
       
        
        $message = $data['message'] ?? null;
        if ($message && $send) {
            // Process the email
            $emailObj = Email::create()
                ->setFrom($email)
                ->setTo($send)
                ->setSubject($subject)
                ->setBody('From: '. $email.'<br> Message: '. $message);

            try {
                $emailObj->send();
                return "Email sent successfully!";
            } catch (\Exception $e) {
                return "Failed to send email: " . $e->getMessage();
            }
        } else {
            return "Email and message are required.";
        }
    }

}