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
                <h1>Blog Page</h1>
                <nav class="d-flex align-items-center">
                    <a href="{$BaseHref}">Home<span class="lnr lnr-arrow-right"></span></a>
                    <a href="{$BaseHref}/blog">Blog</a>
                </nav>
            </div>
        </div>
    </div>
</section>
<!-- End Banner Area -->

<!--================Blog Categorie Area =================-->
<section class="blog_categorie_area">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 mt-2">
                <div class="categories_post">
                    <img src="$resourceURL('themes/simple/images/blog/cat-post/cat-post-3.jpg')" alt="post">
                    <div class="categories_details kecil">
                        <div class="categories_text">
                            <a href="blog-details.html">
                                <h5>Social Life</h5>
                            </a>
                            <div class="border_line"></div>
                            <p>Enjoy your social life together</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-2">
                <div class="categories_post">
                    <img src="$resourceURL('themes/simple/images/blog/cat-post/cat-post-2.jpg')" alt="post">
                    <div class="categories_details">
                        <div class="categories_text">
                            <a href="blog-details.html">
                                <h5>Politics</h5>
                            </a>
                            <div class="border_line"></div>
                            <p>Be a part of politics</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-2">
                <div class="categories_post">
                    <img src="$resourceURL('themes/simple/images/blog/cat-post/cat-post-1.jpg')" alt="post">
                    <div class="categories_details">
                        <div class="categories_text">
                            <a href="blog-details.html">
                                <h5>Food</h5>
                            </a>
                            <div class="border_line"></div>
                            <p>Let the food be finished</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!--================Blog Categorie Area =================-->

<!--================Blog Area =================-->
<section class="blog_area" style="padding-bottom: 5rem;">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 " style="padding-bottom: 5rem;">
                <div class="blog_left_sidebar" style="height:100%; position:relative;">
                    <% if $Result.ID != null%>
                        <% loop $Result %>
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
                        <% else %>
                            <article class="row blog_item " style="position:relative;">
                               
                            </article>
                    <% end_if %> 
                    <% include Pagination %>
                </div>
            </div>
           <% include BlogSideBar %>
        </div>
    </div>
</section>
<!--================Blog Area =================-->