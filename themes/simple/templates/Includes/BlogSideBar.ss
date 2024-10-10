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
            <% if $IsAuthor %>
            <a href="{$BaseHref}/admin/blog" class="btn mt-2" style="font-size: 18px; line-height: 25px; background: #ffba00; color: #fff;  width: 100%; border-radius:50px; margin-bottom: 30px;">Add New Blog</a>
            <% else %>
            <a href="" class="btn mt-2 disabled" style="font-size: 18px; line-height: 25px; background: #ffba00; color: #fff;  width: 100%; border-radius:50px; margin-bottom: 30px;">Add New Blog</a>
            <% end_if %>
            <%-- <div class="br"></div> --%>
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