<?php

use SilverStripe\Control\Director;
use SilverStripe\Control\HTTPRequest;
use SilverStripe\Dev\Debug;
use SilverStripe\ORM\ArrayList;
use SilverStripe\ORM\DB;
use SilverStripe\ORM\PaginatedList;
use SilverStripe\Security\Member;
use SilverStripe\Security\Security;
use SilverStripe\View\ArrayData;


class BlogPageController extends PageController
{
    private static $allowed_actions = [
        'BlogDetail',
        'handelComment',
        'handelreply',
        'CategoryList'
    ];

    public function CategoryList()
    {
        return BlogCategory::getCategoriesWithCounts();
    }

    public function index(HTTPRequest $request)
    {
        $categori = BlogCategory::get();
        $contents = BlogAdd::get();
        $latestpost = BlogAdd::get()->sort('Created', 'DESC');
        $activeFilters = ArrayList::create();



        // Debug::show($comments);
        foreach ($contents as $content) {
            $categories = $content->BlogCategories();

        }
        foreach ($contents as $content) {

            $comments = BlogComment::get()->filter('BlogAddID', $content->ID);
            $countcomment = $comments->count();
            $countreply = CommentReply::get()->filter('BlogAddID', $content->ID)->count();
            $counttotal = [];
            $content->CountComment = $countreply + $countcomment;
            $Createdby = Member::get()->filter('ID', $contents->ID);
            
            // Debug::show($content);
            $content->write();
        }


        if ($search = $request->postVar('search')) {
            $activeFilters->push(ArrayData::create([
                'Label' => "'$search'"
            ]));
            $contents = $contents->filter([
                'Title:PartialMatch' => $search
            ]);
        }
        if (!$contents->exists()) {
            $contents = BlogAdd::get();
        }

        // Debug::show($contents);
        $paginated = PaginatedList::create(
            $contents,
            $this->getRequest()
        )->setPageLength(4)->setPaginationGetVar('s');



        return [
            BlogCategory::getCategoriesWithCounts(),
            'Result' => $paginated,
            'Latestpost' => $latestpost,
            'Categori' => $categori,
            'Content' => $contents,
            'Count' => $counttotal,
        ];
    }

    public function BlogDetail(HTTPRequest $request)
    {
        $member = Security::getCurrentUser();
        // Debug::show($member);
        if (!$member) {
            return $this->redirect(Director::absoluteBaseURL() . '/login');
        } else {
            $k = $request->param('ID');
            $categori = BlogCategory::get();
            $contents = BlogAdd::get()->byID($k);
            $comments = BlogComment::get()->filter('BlogAddID', $k);
            $countcomment = $comments->count();
            $countreply = CommentReply::get()->filter('BlogAddID', $k)->count();
            $counttotal = [];
            $counttotal = $countreply + $countcomment;
            $member = Member::get()->filter('ID', $comments->ID);
            $Createdby = Member::get()->filter('ID', $contents->ID);

            Debug::show($Createdby);
            $latestpost = BlogAdd::get()->sort('Created', 'DESC');
            foreach ($comments as $comment) {
                $comment->CommentReply = CommentReply::get()->filter('BlogCommentID', $comment->ID);
            }
            // Debug::show($comment);
            $previousblog = BlogAdd::get()->filter('ID:LessThan', $k)->sort('ID DESC')->first();
            $nextblog = BlogAdd::get()->filter('ID:GreaterThan', $k)->sort('ID ASC')->first();

            if ($contents) {
                $categories = $contents->BlogCategories();
            }

            // Debug::show($counttotal);
            return $this->customise([
                BlogCategory::getCategoriesWithCounts(),
                'Latestpost' => $latestpost,
                'CreatedBy' => $Createdby,
                'Member' => $member,
                'Comment' => $comments,
                'CommentID' => $comments->ID,
                'Categori' => $categori,
                'Blog' => $contents,
                'ID' => $k,
                'Count' => $counttotal,
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

    public function handelreply(HTTPRequest $request)
    {
        $member = Security::getCurrentUser();
        if (!$member) {
            return $this->redirect(Director::absoluteBaseURL() . '/login');
        } else {
            $data = $request->postVars();
            $title = $request->postVar('Send');
            // $member = Member::get()->filter('Surname', $title);
            // Debug::show($data);
            $comment = CommentReply::create();
            $comment->MemberID = $member->ID;
            $comment->BlogAddID = $data['ID'];
            $comment->SendTo = $title;
            $comment->BlogCommentID = $data['CommentID'];
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