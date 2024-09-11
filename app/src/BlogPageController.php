<?php

use SilverStripe\Control\Director;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\Security\Member;
use SilverStripe\Security\Security;


class BlogPageController extends PageController
{
    private static $allowed_actions = [
        'BlogDetail',
        'handelComment',
        'handelreply',
    ];
    public function index()
    {
        $categori = BlogCategory::get();
        $contents = BlogAdd::get();

        foreach ($contents as $content) {
            $categories = $content->BlogCategories();
            // Debug::show($categories);

        }
        // $product = BlogAdd::get()->byID($productID);
        return [
            'Categori' => $categori,
            'Content' => $contents
        ];
    }

    public function BlogDetail(HTTPRequest $request)
    {
        $member = Security::getCurrentUser();
        if (!$member) {
            return $this->redirect(Director::absoluteBaseURL() . '/login');
        } else {
            $k = $request->param('ID');
            $categori = BlogCategory::get();
            $contents = BlogAdd::get()->byID($k);
            $comment = BlogComment::get()->filter('BlogAddID', $k);
            $countcomment = $comment->count();
            $member = Member::get()->filter('ID', $comment->ID);



            $previousblog = BlogAdd::get()->filter('ID:LessThan', $k)->sort('ID DESC')->first();
            $nextblog = BlogAdd::get()->filter('ID:GreaterThan', $k)->sort('ID ASC')->first();

            if ($contents) {
                $categories = $contents->BlogCategories();
            }

            Debug::show($comment->ID);
            return $this->customise([
                'Member' => $member,
                'Comment' => $comment,
                'CommentID' => $comment->ID,
                'Categori' => $categori,
                'Blog' => $contents,
                'ID' => $k,
                'Count' => $countcomment,
                'NextBlog' => $nextblog ? $nextblog->Link() : null,
                'PrevBlog' => $previousblog ? $previousblog->Link() : null,
                'NextTitle' => $nextblog ? $nextblog->Title : '',
                'PrevTitle' => $previousblog ? $previousblog->Title : '',
            ])->renderWith(["BlogDetailPage", "Page"]);
        }
    }

    public function handelComment(HTTPRequest $request)
    {
        $member = Security::getCurrentUser();
        if (!$member) {
            return $this->redirect(Director::absoluteBaseURL() . '/login');
        } else {
            $data = $request->postVars();
            // Debug::show($data);
            $comment = BlogComment::create();
            $comment->MemberID = $member->ID;
            $comment->BlogAddID = $data['ID'];
            $comment->Name = $data['Name'];
            $comment->Comment = $data['Message'];
            $comment->write();


            return json_encode([
                'success' => true,
                'message' => 'Success'
            ]);
        }
    }
    
    public function handelreply(HTTPRequest $request) {
        $member = Security::getCurrentUser();
        if (!$member) {
            return $this->redirect(Director::absoluteBaseURL() . '/login');
        } else {
            $data = $request->postVars();
            Debug::show($data);
            $comment = BlogComment::create();
            $comment->MemberID = $member->ID;
            $comment->BlogAddID = $data['ID'];
            $comment->Name = $data['Name'];
            $comment->Comment = $data['Message'];
            $comment->write();


            return json_encode([
                'success' => true,
                'message' => 'Success'
            ]);
        }
    }


}