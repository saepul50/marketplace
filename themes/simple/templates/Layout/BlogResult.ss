<style>
    @media (max-width: 990px){
    .categories_post .categories_details {
    position: absolute;
    top: 20px;
    left: 180px !important;
    right: 180px !important;
    bottom: 20px;
    background: rgba(34, 34, 34, 0.8);
    color: #fff;
    transition: all 0.3s linear;
    display: flex;
    align-items: center;
    justify-content: center;
    }
    }
    @media (max-width: 767px){
    .categories_post .categories_details {
    position: absolute;
    top: 20px;
    left: 90px !important;
    right: 90px !important;
    bottom: 20px;
    background: rgba(34, 34, 34, 0.8);
    color: #fff;
    transition: all 0.3s linear;
    display: flex;
    align-items: center;
    justify-content: center;
        }
    
    }
    @media (max-width: 490px){
    .categories_post .categories_details {
    position: absolute;
    top: 20px;
    left: 50px !important;
    right: 50px !important;
    bottom: 20px;
    background: rgba(34, 34, 34, 0.8);
    color: #fff;
    transition: all 0.3s linear;
    display: flex;
    align-items: center;
    justify-content: center;
        }
    }
    @media (max-width: 380px){
    .categories_post .categories_details {
    position: absolute;
    top: 20px;
    left: 20px !important;
    right: 20px !important;
    bottom: 20px;
    background: rgba(34, 34, 34, 0.8);
    color: #fff;
    transition: all 0.3s linear;
    display: flex;
    align-items: center;
    justify-content: center;
        }
    }
</style>


<!-- Start Banner Area -->
   <section class="banner-area organic-breadcrumb" style ="background: url($SiteConfig.Background.getURL()) center no-repeat;background-size: cover; position: relative ">
    <div class="container">
        <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
            <div class="col-first">
                <h1>Blog Result</h1>
                <nav class="d-flex align-items-center">
                    <a href="{$BaseHref}">Home<span class="lnr lnr-arrow-right"></span></a>
                    <a href="{$BaseHref}/blog">Blog</a>
                </nav>
            </div>
        </div>
    </div>
</section>
<!-- End Banner Area -->


<!--================Blog Area =================-->
<section class="blog_area mt-5" style="padding-bottom: 5rem;">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 " style="padding-bottom: 5rem;">
                <div class="blog_left_sidebar" style="height:100%; position:relative;">
                        <% loop $Blog %>
                            <article class="row blog_item " style="position:relative;">
                                <div class="col-md-3">
                                    <div class="blog_info text-right left-sm fw-bold">
                                        <div class="post_tag">
                                            <% loop $BlogCategories %>
                                            <a href="#">$Title </a>
                                            <% end_loop %>
                                        </div>
                                        <ul class="blog_meta list event" data-date="$Created">
                                            <li><a href="#">$CreatedBy<i class="lnr lnr-user"></i></a></li>
                                            <li><a href="#" class="date"><i class="lnr lnr-calendar-full"></i></a></li>
                                            <li><a href="#">$ViewCount Views<i class="lnr lnr-eye"></i></a></li>
                                            <li><a href="#">$CountComment Comments<i class="lnr lnr-bubble"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-md-9">
                                    <div class="blog_post">
                                            <img src="$ImageThumbnail.getURL()" alt="Image Thumbnail">  
                                            <div class="blog_details">
                                                <a href="{$BaseHref}/blog/blogdetail/$ID">
                                                    <h2>$Title</h2>
                                                </a>
                                                <p>$Summary</p>
                                                <a href="{$BaseHref}/blog/blogdetail/$ID" class="white_bg_btn">View More</a>
                                            </div>                       
                                    </div>
                                </div>
                            </article>
                        <% end_loop %>
                    <% include Pagination %>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="blog_right_sidebar">
                    <aside class="single_sidebar_widget search_widget">
                        <% if $IsAuthor %>
                        <a href="{$BaseHref}/admin/blog" class="btn mt-2" style="font-size: 18px; line-height: 25px; background: #ffba00; color: #fff;  width: 100%; border-radius:50px; margin-bottom: 30px;">Add New Blog</a>
                        <% else %>
                        <a href="" class="btn mt-2 disabled" style="font-size: 18px; line-height: 25px; background: #ffba00; color: #fff;  width: 100%; border-radius:50px; margin-bottom: 30px;">Add New Blog</a>
                        <% end_if %>
                    </aside>
                    <aside class="single_sidebar_widget popular_post_widget">
                        <h3 class="widget_title">Popular Post</h3>         
                        <% loop $Popularpost.Limit(5) %>
                            <div class="media post_item">
                                <img src="$ImageThumbnail.getURL()" alt="post" width="100px" height="60px">
                                <div class="media-body">
                                    <a href="{$BaseHref}/blog/blogdetail/$ID">
                                        <h3>$Title</h3>
                                    </a>
                                    <div class="time-sidebar" data-date="$Created">
                                    <p class="date-sidebar"></p>
                                    </div>
                                </div>
                            </div>
                        <% end_loop %>  
            
                        <div class="br"></div>
                    </aside>
                    <aside class="single_sidebar_widget popular_post_widget">
                        <h3 class="widget_title">Latest Post</h3>         
                        <% loop $Latestpost.Limit(5) %>
                            <div class="media post_item">
                                <img src="$ImageThumbnail.getURL()" alt="post" width="100px" height="60px">
                                <div class="media-body">
                                    <a href="{$BaseHref}/blog/blogdetail/$ID">
                                        <h3>$Title</h3>
                                    </a>
                                    <div class="time-sidebar" data-date="$Created">
                                    <p class="date-sidebar"></p>
                                    </div>
                                </div>
                            </div>
                        <% end_loop %>  
            
                        <div class="br"></div>
                    </aside>
                    <aside class="single_sidebar_widget ads_widget">
                        <a href="#"><img class="img-fluid" src="$resourceURL('themes/simple/images/blog/add.jpg')" alt=""></a>
                        <div class="br"></div>
                    </aside>
                    <aside class="single_sidebar_widget post_category_widget">
                        <h4 class="widget_title">Post Catgories</h4>
                        <ul class="list cat-list">
                            <% loop $CategoryList %>
                                <li>
                                    <a href="#" class="d-flex justify-content-between">
                                        <p>$Title</p>
                                        <p>$Count</p>
                                    </a>
                                </li>
                            <% end_loop %>
                        </ul>
                        <div class="br"></div>
                    </aside>
                    <aside class="single-sidebar-widget tag_cloud_widget">
                        <h4 class="widget_title">Tag Clouds</h4>
                        <ul class="list">
                            <% loop $Categori %>
                            <li><a href="#">$Title</a></li>
                            <% end_loop %>
                            
                        </ul>
                    </aside>
                </div>
            </div>
        </div>
    </div>
</section>
<!--================Blog Area =================-->