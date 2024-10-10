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
        'CategoryList',
        'filter'
    ];

    public function CategoryList()
    {
        return BlogCategory::getCategoriesWithCounts();
    }

    public function index(HTTPRequest $request)
    {
        $member = Security::getCurrentUser();
        
        if (!$member) {
            return $this->redirect(Director::absoluteBaseURL() . '/login');
        }
    
        // Fetch categories
        $categori = BlogCategory::get();
        
        // Debug::show($categori);
        if (!$categori || $categori->count() === 0) {
            $categori = null;
        }
        $contents = BlogAdd::get();
        if ($contents->exists()) {
            foreach ($contents as $content) {
                $comments = BlogComment::get()->filter('BlogAddID', $content->ID);
                $countcomment = $comments->count();
                $countreply = CommentReply::get()->filter('BlogAddID', $content->ID)->count();
                $content->CountComment = $countreply + $countcomment;
                $content->write();
            }
        } else {
            $contents = null;
        }
        if ($search = $request->postVar('search')) {
            $activeFilters = ArrayList::create();
            $activeFilters->push(ArrayData::create([
                'Label' => "'$search'"
            ]));
            $contents = $contents->filter([
                'Title:PartialMatch' => $search
            ]);
        }
        if (!$contents || !$contents->exists()) {
            $contents = BlogAdd::get(); 
        }
        $paginated = PaginatedList::create(
            $contents,
            $this->getRequest()
        )->setPageLength(4)->setPaginationGetVar('s');
    
       
        $categoriesWithCounts = null;
        if ($categori) {
            $categoriesWithCounts = BlogCategory::getCategoriesWithCounts();
        }

      
        return [
            'BlogCategoriesWithCounts' => $categoriesWithCounts,
            'Result' => $paginated,
            'Latestpost' => BlogAdd::get()->sort('Created', 'DESC'),
            'ActiveFilter' => $activeFilters ?? null,
            'Categori' => $categori->sort('Count', 'DESC')->filter('Count:GreaterThan', 0),
            'Popularpost' => BlogAdd::get()->sort('ViewCount', 'DESC'),
            'Content' => $contents
        ];
    }

    
    public function filter(HTTPRequest $request){
        $p = $request->param('ID');
        $categori = BlogCategory::get()->filter('Title' , $p)->first();
        if($categori){
        $object = $categori->BlogAdds();
        Debug::show($object);
        }

    }

    public function BlogDetail(HTTPRequest $request)
    {
        
        $member = Security::getCurrentUser();
        // Debug::show($member);
        if (!$member) {
            return $this->redirect(Director::absoluteBaseURL() . '/login');
        } else {
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
            // Debug::show($categories);
            $contents->ViewCount += 1;
            $contents->write();

            BlogCategory::getCategoriesWithCounts();
            
            // Debug::show($Createdby);
            return $this->customise([
                'Latestpost' => $latestpost,
                'Popularpost' => $popularpost,
                'CreatedBy' => $Createdby,
                'Member' => $member,
                'IDMember' => $member->ID,
                'Comment' => $comments,
                'CommentID' => $comments->ID,
                'Categori' => $categori,
                'Blog' => $contents,
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

    public function IsAuthor() {
        $member = Security::getCurrentUser();
        if ($member && $member->inGroup(1)) {
            return true;
        }
        return false;
    }
}