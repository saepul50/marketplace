<div class="col-lg-4">
    <div class="blog_right_sidebar">
        <aside class="single_sidebar_widget search_widget">
            <form method="post" action="{$Basehref}/marketplace/blog">
                <div class="input-group">
                    <input type="text" class="form-control" id="search" name="search"placeholder="Search Posts" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Search Posts'">
                    <span class="input-group-btn">
                        <button class="btn btn-default" type="submit"><i class="lnr lnr-magnifier"></i></button>
                    </span>
                </div><!-- /input-group -->
                <% if $ActiveFilter %>
                    <% loop $ActiveFilter %>
                    <p class="ml-3">Searching for $Label</p>
                    <% end_loop %>
                <% end_if %>
            </form>
            <% if $Groups %>
            <a href="{$BaseHref}/admin" class="btn mt-2" style="font-size: 18px; line-height: 25px; background: #ffba00; color: #fff;  width: 100%; border-radius:50px; margin-bottom: 30px;">Add New Blog</a>
            <% else %>
            <a href="" class="btn mt-2 disabled" style="font-size: 18px; line-height: 25px; background: #ffba00; color: #fff;  width: 100%; border-radius:50px; margin-bottom: 30px;">Add New Blog</a>
            <% end_if %>
            <%-- <div class="br"></div> --%>
        </aside>
       <%-- <% if $Author %>
            <aside class="single_sidebar_widget author_widget">
                <% with $Image %>
                    <% if $ProfileImage.exists %>
                        <img class="author_img rounded-circle" id="image" src="$ProfileImage.getURL()" alt="$Name's profile image" width="120" height="120">
                    <% else %>
                        <img class="author_img rounded-circle" id="image" src="$SiteConfig.Unknown.getURL()" alt="Default image" width="120" height="120">
                    <% end_if %>
                <% end_with %>
                <h4>$Author</h4>
                <div class="social_icon">
                    <a href="#"><i class="fa fa-facebook"></i></a>
                    <a href="#"><i class="fa fa-twitter"></i></a>
                    <a href="#"><i class="fa fa-github"></i></a>
                    <a href="#"><i class="fa fa-behance"></i></a>
                </div>
                <p>Boot camps have its supporters andit sdetractors. Some people do not understand why you
                    should have to spend money on boot camp when you can get. Boot camps have itssuppor
                    ters andits detractors.</p>
                <div class="br"></div>
            </aside>
        <% end_if %> --%>
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
                            <p>$Sample</p>
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