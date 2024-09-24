<?php

use SilverStripe\Control\Director;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\ORM\PaginatedList;
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
        'review',
        'filter',
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
        $members = Security::getCurrentUser();
        $id = $request->param('ID');
    
    
        $product = ProductObject::get()->byID($id);
        $variant = ProductVariantObject::get()->filter('ProductID', $product->ID);
        $comments = ProductComment::get()->filter('ProductObjectID', $id);
        $rating = ProductRating::get()->filter('ProductObjectID', $id);
        $count = $rating->count();
        $five = $rating->filter('Rating', 5)->count();
        $four = $rating->filter('Rating', 4)->count();
        $three = $rating->filter('Rating', 3)->count();
        $two = $rating->filter('Rating', 2)->count();
        $one = $rating->filter('Rating', 1)->count();
        $ave = $rating->avg('Rating');
        $formatave = number_format($ave, 2);
        $sortOption = $request->getVar('sort');
        $ratings = ProductRating::get()->filter('ProductObjectID', $id);
        if ($sortOption == 'Highest Rating') {
            $ratings = $ratings->sort('Rating', 'DESC');
        } elseif ($sortOption == 'Lowest Rating') {
            $ratings = $ratings->sort('Rating', 'ASC');
        } else {
            $ratings = $ratings->sort('Created', 'DESC');
        }
        // Debug::show($variant);
        // die();
        

        $paginatedRatings = PaginatedList::create($ratings, $this->getRequest())
            ->setPageLength(10)
            ->setPaginationGetVar('s');
        
        $paginatedcomment = PaginatedList::create($comments, $this->getRequest())
        ->setPageLength(10)
        ->setPaginationGetVar('s');
        foreach ($comments as $comment) {
            $comment->CommentReply = ProductReply::get()->filter('ProductCommentID', $comment->ID);
        }
        $membersID =  $rating->column('MemberID');
        if(!empty($membersID)){
        $members = Member::get()->filter('ID', $membersID);
        } else {
            $members = null;
        }
        // Debug::show($members);

        return $this->customise([
            'Product' => $product,
            'Comment' => $paginatedcomment,
            'Ratings' => $paginatedRatings,
            'Members' => $members,
            'Count' => $count,
            'Five' => $five,
            'Four' => $four,
            'Three' => $three,
            'Two' => $two,
            'One' => $one,
            'Ave' => $formatave,
            'ID' => $id,
        ])->renderWith(['ProductDetails', 'Page']);
    }
    
    // $previousblog ? $previousblog->Link() : null

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

    public function review(HTTPRequest $request){
        $member = Security::getCurrentUser();
        if (!$member) {
            return $this->redirect(Director::absoluteBaseURL() . '/login');
        } else {
        $data = $request->postVars();
        // Debug::show(s$data);

        $comment = ProductRating::create();
        $comment->MemberID = $member->ID;
        $comment->Rating = $data['Rating'];
        $comment->ProductObjectID = $data['ID'];
        $comment->Message = $data['Review'];
        $comment->write();

        return json_encode([
            'success' => true,
            'message' => 'Success'
        ]);
     }
    }



}