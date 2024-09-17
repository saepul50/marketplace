<% require themedJavascript('kevin') %>
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




<section class="blog_area single-post-area section_gap">
  
    <div class="container">
        <div class="row">
            <div class="col-lg-8 posts-list">
                <div class="single-post row">
                    <% with $Blog  %>
                    <div class="col-lg-12">
                        <div class="feature-img">
                            <img class="img-fluid" src="$HeaderImage.getURL()" alt="Header Image">
                        </div>
                    </div>
                    <div class="col-lg-3  col-md-3">
                        <div class="blog_info text-right">
                            <div class="post_tag">
                                <% loop $BlogCategories %>
                                <a href="#">$Title,</a>
                                <% end_loop %>
                            </div>
                            <ul class="blog_meta list">
                                <li><a href="#">Mark wiens<i class="lnr lnr-user"></i></a></li>
                                <li><a href="#">12 Dec, 2018<i class="lnr lnr-calendar-full"></i></a></li>
                                <li><a href="#">1.2M Views<i class="lnr lnr-eye"></i></a></li>
                                <li><a href="#">$Up.Count Comments<i class="lnr lnr-bubble"></i></a></li>
                            </ul>
                            <ul class="social-links">
                                <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                                <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                                <li><a href="#"><i class="fa fa-github"></i></a></li>
                                <li><a href="#"><i class="fa fa-behance"></i></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-9 col-md-9 blog_details">
                        $Content
                    </div>
                    <div class="col-lg-12">
                        <div class="quotes">
                            $Quotes
                        </div>
                        <%-- <div class="row">
                            <div class="col-6">
                                <img class="img-fluid" src="img/blog/post-img1.jpg" alt="">
                            </div>
                            <div class="col-6">
                                <img class="img-fluid" src="img/blog/post-img2.jpg" alt="">
                            </div>
                            <div class="col-lg-12 mt-25">
                                <p>
                                    MCSE boot camps have its supporters and its detractors. Some people do not
                                    understand why you should have to spend money on boot camp when you can get the
                                    MCSE study materials yourself at a fraction of the camp price. However, who has
                                    the willpower.
                                </p>
                                <p>
                                    MCSE boot camps have its supporters and its detractors. Some people do not
                                    understand why you should have to spend money on boot camp when you can get the
                                    MCSE study materials yourself at a fraction of the camp price. However, who has
                                    the willpower.
                                </p>
                            </div>
                        </div> --%>
                    </div>
                    <% end_with %>
                </div>
           
                <div class="navigation-area">
                    <div class="row">
                        <% if $PrevBlog %>
                            <div class="col-lg-6 col-md-6 col-12 nav-left flex-row d-flex justify-content-start align-items-center">
                                <div class="thumb">
                                    <a href="{$BaseHref}/blog/$PrevBlog"><img class="img-fluid" src="$resourceURL('themes/simple/images/blog/prev.jpg')" alt=""></a>
                                </div>
                                <div class="arrow">
                                    <a href="{$BaseHref}/blog/$PrevBlog"><span class="lnr text-white lnr-arrow-left"></span></a>
                                </div>
                                <div class="detials">
                                    <p>Prev Post</p>
                                    <a href="{$BaseHref}/blog/$PrevBlog">
                                        <h4>$PrevTitle</h4>
                                    </a>
                                </div>
                            </div>
                        <% else %>
                            <div class="col-lg-6 col-md-6 col-12 nav-left flex-row d-flex justify-content-start align-items-center">
                              
                            </div>
                        <% end_if %>
                        <% if $NextBlog %>
                            <div class="col-lg-6 col-md-6 col-12 nav-right flex-row d-flex justify-content-end align-items-center">
                                <div class="detials">
                                    <p>Next Post</p>
                                    <a href="{$BaseHref}/blog/$NextBlog">
                                        <h4>$NextTitle</h4>
                                    </a>
                                </div>
                                <div class="arrow">
                                    <a href="{$BaseHref}/blog/$NextBlog"><span class="lnr text-white lnr-arrow-right"></span></a>
                                </div>
                                <div class="thumb">
                                    <a href="{$BaseHref}/blog/$NextBlog"><img class="" src="$resourceURL('themes/simple/images/blog/next.jpg')" alt=""></a>
                                </div>
                            </div>
                        <% else %>
                            
                        <% end_if %>
                    </div>
                </div>
                
                <div class="comments-area">
                    <h4>$Count Comments</h4>
                    <% loop $Comment %> 
                        <div class="comment-list">
                            <div class="single-comment justify-content-between d-flex">
                                <div class="user justify-content-between d-flex">
                                    <div class="thumb image-comment">
                                        <% with $Member %>
                                            <% if $ProfileImage.exists %>
                                                <img class="image" id="image" src="$ProfileImage.getURL()" alt="$Name's profile image">
                                            <% else %>
                                                <img class="image" id="image" src="$SiteConfig.Unknown.getURL()" alt="Default image">
                                            <% end_if %>
                                        <% end_with %>
                                    </div>
                                    <div class="desc">
                                        <h5><a href="#">$Member.FirstName</a></h5>
                                        <p class="date">$Created</p>
                                        <p class="comment">
                                            $Comment
                                        </p>
                                    </div>
                                </div>
                                <div class="reply-btn">
                                <button  class="btn-reply text-uppercase" data-toggle="modal" data-target="#exampleModal" data-commentid="$ID" data-name="$Member.FirstName">Reply</button>
                                </div>
                            </div>
                        </div>
                        <% if $CommentReply.exists %>
                            <% loop $CommentReply %>
                                <div class="comment-list left-padding">
                                    <div class="single-comment justify-content-between d-flex">
                                        <div class="user justify-content-between d-flex">
                                            <div class="thumb">
                                                <% with $Member %>
                                                    <% if $ProfileImage.exists %>
                                                        <img class="image" id="image" src="$ProfileImage.getURL()" alt="$Name's profile image">
                                                    <% else %>
                                                        <img class="image" id="image" src="$resourceURL('themes/simple/images/blog/unknown.png')" alt="Default image">
                                                    <% end_if %>
                                                <% end_with %>
                                            </div>
                                            <div class="desc">
                                                <h5><a href="#" id="takename">$Member.FirstName</a></h5>
                                                <p class="date">$Created </p>
                                                <p class="comment">
                                                <b id="sendto">$SendTo</b> $Comment
                                                </p>
                                            </div>
                                        </div>
                                        <div class="reply-btn">
                                            <a href="" class="btn-reply text-uppercase" data-toggle="modal" data-target="#exampleModal" data-commentid="$Up.ID" data-takename='#takename' data-name="$Member.FirstName">reply</a>
                                        </div>
                                    </div>
                                </div>
                            <% end_loop %>
                        <% end_if %>
                    
                    <% end_loop %>
                    
                </div>
                <div class="comment-form">
                    <h4>Leave a Comment</h4>
                    <form method="post" id="blogcomment">
                        <div class="form-group form-inline">
                            <div class="form-group col-lg-12 col-md-12 name">
                                <input type="text" class="form-control" id="name" name="name" placeholder="Enter Name" onfocus="this.placeholder = ''"
                                    onblur="this.placeholder = 'Enter Name'">
                                <input type="hidden" id="BlogAddID" name="BlogAddID" value="$ID">
                            </div>
                        </div>
                        <div class="form-group">
                            <textarea class="form-control mb-10" rows="5" id="message" name="message" placeholder="Messege"
                                onfocus="this.placeholder = ''" onblur="this.placeholder = 'Messege'" required></textarea>
                        </div>
                        <button type="submit" value="submit" class="primary-btn">Post Comment</button>
                    </form>
                </div>
            </div>
            <% include BlogSideBar %>
        </div>
    </div>
</section>
<%-- Modal --%>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">New message to </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form method="post" id="replycomment">
      <div class="modal-body">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Name:</label>
            <input type="text" class="form-control" id="name-reply"  required>
            <input type="hidden" id="commentID-reply" name="commentID-reply" value="" >
            <input type="hidden" id="nama-reply" name="nama-reply" value="" >
            <input type="hidden" id="BlogAddID" name="BlogAddID" value="$ID">
          </div>
          <div class="form-group">
            <label for="message-text" class="col-form-label">Message:</label>
            <textarea class="form-control" id="message-reply" required></textarea>
          </div>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn btn-secondary " style="position: relative;overflow: hidden;color: #fff;padding: 0 30px;line-height: 50px;border-radius: 50px;display: inline-block;text-transform: uppercase;font-weight: 500;cursor: pointer;" data-dismiss="modal">Close</button>
            <button type="submit" class="primary-btn">Send message</button>
        </div>
        </form>
    </div>
  </div>
</div>




