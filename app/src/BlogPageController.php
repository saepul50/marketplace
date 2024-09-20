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
        $member = Security::getCurrentUser();
        // Debug::show($member);
        if (!$member) {
            return $this->redirect(Director::absoluteBaseURL() . '/login');
        } else {
        $categori = BlogCategory::get();
        $contents = BlogAdd::get();
        $latestpost = BlogAdd::get()->sort('Created', 'DESC');
        $popularpost = BlogAdd::get()->sort('ViewCount', 'DESC');
        $activeFilters = ArrayList::create();



        // Debug::show($popularpost);
        foreach ($contents as $content) {
            $categories = $content->BlogCategories();

        }
        foreach ($contents as $content) {

            $comments = BlogComment::get()->filter('BlogAddID', $content->ID);
            $countcomment = $comments->count();
            $countreply = CommentReply::get()->filter('BlogAddID', $content->ID)->count();
            $counttotal = [];
            $content->CountComment = $countreply + $countcomment;
            $Createdby = BlogAdd::get()->column('CreatedBy');
            
            $content->write();
            
        }
        
            // Debug::show($Createdby);

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

        if($member){
            $grup = $member->Groups();
            // Debug::show($grup);
        }


        return [
            BlogCategory::getCategoriesWithCounts(),
            'Result' => $paginated,
            'Latestpost' => $latestpost,
            'ActiveFilter' => $activeFilters,
            'Categori' => $categori,
            'Groups' => $grup,
            'Popularpost' => $popularpost,
            'Content' => $contents,
            'Count' => $counttotal,
            'CreatedBy' => $Createdby,
        ];
    }
    }

    public function BlogDetail(HTTPRequest $request)
    {
        
        $member = Security::getCurrentUser();
        // Debug::show($member);
        if (!$member) {
            return $this->redirect(Director::absoluteBaseURL() . '/login');
        } else {
            if($member){
                $grup = $member->Groups();
                // Debug::show($grup);
            }
            $k = $request->param('ID');
            $contents = BlogAdd::get()->byID($k);
            $categori = BlogCategory::get();
            $comments = BlogComment::get()->filter('BlogAddID', $k);
            $countcomment = $comments->count();
            $countreply = CommentReply::get()->filter('BlogAddID', $k)->count();
            $counttotal = [];
            $counttotal = $countreply + $countcomment;
            $member = Member::get()->filter('ID', $comments->ID);
            $Createdby = BlogAdd::get()->column('CreatedBy');
            $latestpost = BlogAdd::get()->sort('Created', 'DESC');
            $popularpost = BlogAdd::get()->sort('ViewCount', 'DESC');
            foreach ($comments as $comment) {
                $comment->CommentReply = CommentReply::get()->filter('BlogCommentID', $comment->ID);
            }
            $previousblog = BlogAdd::get()->filter('ID:LessThan', $k)->sort('ID DESC')->first();
            $nextblog = BlogAdd::get()->filter('ID:GreaterThan', $k)->sort('ID ASC')->first();
            // Debug::show($member);

            if ($contents) {
                $categories = $contents->BlogCategories();
            }
            $contents->ViewCount += 1;
            $contents->write();

            
            // Debug::show($Createdby);
            return $this->customise([
                BlogCategory::getCategoriesWithCounts(),
                'Latestpost' => $latestpost,
                'Popularpost' => $popularpost,
                'CreatedBy' => $Createdby,
                'Member' => $member,
                'Comment' => $comments,
                'CommentID' => $comments->ID,
                'Categori' => $categori,
                'Blog' => $contents,
                'Groups' => $grup,
                'ID' => $k,
                'Count' => $counttotal,
                'ImageNextBlog' => $nextblog ? $nextblog->HeaderImage : null,
                'ImagePrevBlog' => $previousblog ? $previousblog->HeaderImage : null,
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
            $comment->Comment = $data['Message'];
            $comment->write();


            return json_encode([
                'success' => true,
                'message' => 'Success'
            ]);
        }
    }


}