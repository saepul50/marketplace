<?php

use SilverStripe\Control\Director;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\Security\Member;
use SilverStripe\Security\Security;

class ProductDetailsController extends PageController
{
    protected function init()
    {
        parent::init();
        $member = Security::getCurrentUser();
        // Debug::show($member);
        // die();
        if (!$member) {
            return $this->redirect('login');
        }
    }
    private static $allowed_actions = [
        'getSubCategories',
        'view',
        'comment',
        'productcomment',
        'productreply',
    ];
    public function getSubCategories($request)
    {
        if ($request->isAjax()) {
            $categoryID = $request->param('ID');
            if ($categoryID) {
                $subCategories = ShopSubCategoryObject::get()->filter('ProductCategoryID', $categoryID)->map('ID', 'Title')->toArray();
                return json_encode($subCategories);
            }
        }
        return $this->httpError(400, 'Invalid request');
    }
    public function view(HTTPRequest $request)
    {
        $id = $request->param('ID');
        $product = ProductObject::get()->byID($id);
        $comments = ProductComment::get()->filter('ProductObjectID' , $id);
        $member = Member::get()->filter('ID', $comments->MemberID);
        foreach ($comments as $comment) {
            $comment->CommentReply = ProductReply::get()->filter('ProductCommentID', $comment->ID);
        }
        return $this->customise([
            'Product' => $product,
            'Comment' => $comments,
            'Member' => $member,
            'ID' => $id,
        ])->renderWith(['ProductDetails', 'Page']);
    }


    public function productcomment(HTTPRequest $request)
    {
        $member = Security::getCurrentUser();
        if (!$member) {
            return $this->redirect(Director::absoluteBaseURL() . '/login');
        } else {
            $data = $request->postVars();
            // Debug::show($data);
            $comment = ProductComment::create();
            $comment->MemberID = $member->ID;
            $comment->ProductObjectID = $data['ID'];
            $comment->Comment = $data['Message'];
            $comment->write();


            return json_encode([
                'success' => true,
                'message' => 'Success'
            ]);
        }
    }

    public function productreply(HTTPRequest $request){


        $member = Security::getCurrentUser();
        if (!$member) {
            return $this->redirect(Director::absoluteBaseURL() . '/login');
        } else {
        $data = $request->postVars();

        $comment = ProductReply::create();
        $comment->MemberID = $member->ID;
        $comment->SendTo = $data['Send'];
        $comment->Comment= $data['Message'];
        $comment->ProductCommentID = $data['CommentID'];
        $comment->ProductObjectID = $data['ID'];
        $comment->write();
        return json_encode([
            'success' => true,
            'message' => 'Success'
        ]);
        }
    }

}