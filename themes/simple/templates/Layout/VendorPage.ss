<% if $Vendor %>
    <style>
        /* General Styles (Not Needed) */
              @import url(https://fonts.googleapis.com/css?family=Roboto:300);
  
              .clear {
              clear:both;
              }
              .description {
              text-align:center;
              font-size:1.5em;
              margin:50px;
              }
              .ticketHolder {
              display: block;
              margin: 10px auto;
              float: left;
              height: 100px;
              }
              section.couponContainer {
              min-width:250px;
              clear: both;
              }
              .coupon {
              margin:0 auto;
              max-width: 180px;
              padding: 20px 0;
              border: 2px solid #910000;
              border-width: 1px 0;
              position:relative;
              background: rgb(201,12,18);
              
              transition:All 0.2549s ease;
              -webkit-transition:All 0.2549s ease;
              -moz-transition:All 0.2549s ease;
              -o-transition:All 0.2549s ease;
              
              }
              .coupon:hover {
              box-shadow: 0 0 15px #555;
              transform: rotate(360deg) scale(1.1);
              -webkit-transform: rotate(360deg) scale(1.1);
              -moz-transform: rotate(360deg) scale(1.1);
              -o-transform: rotate(360deg) scale(1.1);
              -ms-transform: rotate(360deg) scale(1.1);
              }
              .coupon .inner{
              font-family: 'Roboto', sans-serif;
              position: relative;
              padding: 0px 40px;
              margin: 0 -20px;
              background: rgb(201,12,18);
              border: 2px solid #910000;
              border-width: 0 1px;
              }
              .coupon .inner div {
              color:#efefef;
              font-size: 1.1em;
              margin: 0;
              text-align:center;
              }
              .savings {
              font-size:1.8em!important;
              padding: 8px 0;
              }
              .coupon .inner div.couponCode {
              font-size:2em;
              color:#fff;
              line-height: 1em;
              }
              .coupon:before, .coupon:after,
              .coupon .inner:before, .coupon .inner:after {
              box-sizing: border-box;
              content:'';
              position: absolute;
              width: 80px;
              height: 80px;
              border: 20px solid rgb(201,12,18);
              border-radius: 50%;
              background: transparent;
              box-shadow: inset 0 0 0 2px #910000;
              }
              .coupon:before{
              top: -40px;
              left: -60px;
              clip: rect(40px, auto, auto, 40px); /* CSS 2.1 way - deprecated */
              -webkit-clip-path: rectangle(50%, 50%, 100%, 100%, 0, 0); /* CSS 3 */
              }
              .coupon:after{
              top: -40px;
              right: -59px;
              clip: rect(40px, 40px, auto, auto);
              -webkit-clip-path: rectangle(0, 50%, 50%, 100%, 0, 0);
              }
              .coupon .inner:before {
              bottom: -60px;
              left: -40px;
              clip: rect(auto, auto, 40px, 40px);
              -webkit-clip-path: rectangle(50%, 0, 100%, 50%, 0, 0);
              }
              .coupon .inner:after {
              bottom: -60px;
              right: -40px;
              clip: rect(auto, 40px, 40px, auto);
              -webkit-clip-path: rectangle(0, 0, 50%, 50%, 0, 0);
              }
              .noFloat {
              float:none;
              }
              .reveal {
              display:none;
              }
              .coupon:hover .reveal {
              display:block;
              }
              .coupon:hover .savings {
              display:none;
              }
            @media (max-width: 768px) {
          
              .primary-btn {
                line-height: 1.5 !important;
                padding: 0 0.4rem !important;
              }
            }
          
            @media (max-width: 576px) {
             
              .primary-btn {
                font-size: 0.7rem;
                line-height: 1.4 !important;
                padding: 0 0.3rem !important;
              }
            }
    </style>
    
    <section class="banner-area organic-breadcrumb" style ="background: url($SiteConfig.Background.getURL()) center no-repeat;background-size: cover; position: relative ">
        <div class="container">
            <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
            
            </div>
        </div>
    </section>
    
    <div class="pt-5 pb-3" style ="background-color: #fff;">
        <div class="container">
            <div class="row">
                <div class="col-4 d-flex p-3" style="background-color: #f5f5f5; gap:1.2rem; border-radius: 10px;">
                    <div class="col-5">
                        <% with $Vendor.ProfilImage %>
                            <img alt="Profile img" src="$URL" class="img-fluid" style="border-radius: 50%;">
                        <% end_with %>
                    </div>
                    <h5 class="mt-2">$Vendor.Name</h5> 

                </div>
                <div class="col-8 d-flex flex-column justify-content-between">
                    <div class="d-flex align-items-center" style="gap: 8px;">
                        <i class='bx bxs-store' style="color: darkorange; font-size:17px"></i>
                        <p class="m-0">Product : $Count</p>
                    </div>
                    <div class="d-flex align-items-center" style="gap: 8px;">
                        <i class='bx bxs-star' style="color: #FDD835; font-size:17px"></i>
                        <p class="m-0">Rating :</p>
                        <p class="m-0">$OverralAverage</p>
                    </div>
                    <div class="d-flex align-items-center" style="gap: 8px;">
                        <i class='bx bx-log-in' style="font-size:17px"></i>
                        <p class="m-0">Bergabung :</p>
                        <p class="m-0" data-date="$Vendor.Created" id="since"></p>
                    </div>
                </div>
            </div>
        </div>
        <section class="order_details py-2">
            <div class= "myorder text-center mt-2 pb-3" id="myOrder" style="box-shadow: 0 10px 10px rgba(153, 153, 153, 0.1) !important;">
                <nav class=" d-flex flex-wrap navihistory container" id="navtabs">
                    <h5 id="navUtama" class="navi-item" style="cursor: pointer; margin-bottom:0 !important;">Halaman Utama</h5>
                    <h5 id="navProduct" class="navi-item" style="cursor: pointer;  margin-bottom:0 !important;" >Produk</h5>
                </nav>
            </div>
        </section>
        <div class="tab-content mt-3 pb-3" id="nav-tabContent" style="background-color:#fff; ">
            <%-- Halaman Utama --%>
                <div id="awal" class="Awal">
                    <div class="container">
                        <div class="d-flex row ">
                            <% loop $Promo %>
                                <div class="col">
                                    <section class="couponContainer">
                                        <section class="ticketHolder noFloat">
                                        <div class="coupon">
                                            <div class="inner">
                                            <div class="savings">Save $Diskon %</div>
                                            <div class="reveal">
                                                <div>Coupon Code:</div>
                                                <div class="couponCode">$Code</div>
                                            </div>
                                            </div>
                                        </div>
                                        <div class="clear"></div>
                                        </section>   
                                    </section>
                                </div>
                            <% end_loop %>
                        </div>
                    </div>
                    <% if $ProductObjects %>
                    <div class="container mt-5" >
                        <div class="d-flex justify-content-between mb-2">
                            <h6>KAMU MUNGKIN SUKA</h6>
                        <a href="#" style="color:#777777;">Lihat Semua ></a>
                        </div>
                        <div class="row">
                        <% loop $ProductObjects.Limit(4) %>
                                        <a href="{$BaseHref}/productdetails/view/$ID">
                                            <div class="col-lg-3 col-md-4 col-sm-6  ">
                                                <div class="single-product">
                                                    <% with $ProductImages.First %>
                                                        <img src="$URL" class="img-fluid" style="object-fit: cover; aspect-ratio: 4/3;">
                                                    <% end_with %>
                                                    <div class="product-details">
                                                        <h6>$Title</h6>
                                                        <div class="price">
                                                            <% if $Promotion %>
                                                                <h6>$minPriceDiscounted</h6>
                                                                <h6 class="l-through">$minPrice</h6>
                                                            <% else %>
                                                                <h6>$minPrice</h6>
                                                            <% end_if %>
                                                        </div>
                                                        <div class="prd-bottom">
                
                                                            <a  class="social-info">
                                                                <span class="ti-bag"></span>
                                                                <p class="hover-text">add to bag</p>
                                                            </a>
                                                            <a  class="social-info">
                                                                <span class="lnr lnr-heart"></span>
                                                                <p class="hover-text">Wishlist</p>
                                                            </a>
                                                            <a  class="social-info">
                                                                <span class="lnr lnr-sync"></span>
                                                                <p class="hover-text">compare</p>
                                                            </a>
                                                            <a  class="social-info">
                                                                <span class="lnr lnr-move"></span>
                                                                <p class="hover-text">view more</p>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    <% end_loop %>
                                    <% else %>
                                        <div class="container mt-5" >
                                            <div class="d-flex justify-content-between mb-2">
                                                <h6>KAMU MUNGKIN SUKA</h6>
                                            <a href="#" style="color:#777777;">Lihat Semua ></a>
                                            </div>
                                            <div class="row " style="justify-content:center;">
                                            <div class="col-lg-3 col-md-4 col-sm-6  ">
                                            <p>Product Kosong</P>
                                            </div>
                                        </div>
                            <% end_if %>
                        </div>
                    </div>
               
                    
                    <% if $MainBannerPromos.exists %>
                        <% loop $MainBannerPromos %>
                            <div class="container">
                                <% with $Banner %>
                                    <img src="$URL" class="img-fluid" width="100%" height="700">
                                <% end_with %>
                    
                                <!-- Promo Products -->
                                <div class="row mt-3">
                                    <% loop $Products.Limit(4) %>
                                        <a href="{$BaseHref}/productdetails/view/$ID">
                                            <div class="col-lg-3 col-md-4 col-sm-6">
                                                <div class="single-product">
                                                    <% with $ProductImages.First %>
                                                        <img src="$URL" class="img-fluid" style="object-fit: cover; aspect-ratio: 4/3;">
                                                    <% end_with %>
                                                    <div class="product-details">
                                                        <h6>$Title</h6>
                                                        <div class="price">
                                                            <% if $Promotion %>
                                                                <h6>$minPriceDiscounted</h6>
                                                                <h6 class="l-through">$minPrice</h6>
                                                            <% else %>
                                                                <h6>$minPrice</h6>
                                                            <% end_if %>
                                                        </div>
                                                        <div class="prd-bottom">
                                                            <a class="social-info">
                                                                <span class="ti-bag"></span>
                                                                <p class="hover-text">add to bag</p>
                                                            </a>
                                                            <a class="social-info">
                                                                <span class="lnr lnr-heart"></span>
                                                                <p class="hover-text">Wishlist</p>
                                                            </a>
                                                            <a class="social-info">
                                                                <span class="lnr lnr-sync"></span>
                                                                <p class="hover-text">compare</p>
                                                            </a>
                                                            <a class="social-info">
                                                                <span class="lnr lnr-move"></span>
                                                                <p class="hover-text">view more</p>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    <% end_loop %>
                                </div>
                            </div>
                        <% end_loop %>
                    <% end_if %>

                    <div class="container">
                        <% if $BestSeller %>
                        <div class="d-flex justify-content-between mb-2">
                            <h6>Best Seller</h6>
                            <a href="#" style="color:#777777;">Lihat Semua ></a>
                        </div>
                        <div class="row">
                                <% loop $BestSeller.Limit(4) %>
                                        <a href="{$BaseHref}/productdetails/view/$ID">
                                            <div class="col-lg-3 col-md-4 col-sm-6  ">
                                                <div class="single-product">
                                                    <% with $ProductImages.First %>
                                                        <img src="$URL" class="img-fluid" style="object-fit: cover; aspect-ratio: 4/3;">
                                                    <% end_with %>
                                                    <div class="product-details">
                                                        <h6>$Title</h6>
                                                        <div class="price">
                                                            <% if $Promotion %>
                                                                <h6>$minPriceDiscounted</h6>
                                                                <h6 class="l-through">$minPrice</h6>
                                                            <% else %>
                                                                <h6>$minPrice</h6>
                                                            <% end_if %>
                                                        </div>
                                                        <div class="prd-bottom">
                
                                                            <a  class="social-info">
                                                                <span class="ti-bag"></span>
                                                                <p class="hover-text">add to bag</p>
                                                            </a>
                                                            <a  class="social-info">
                                                                <span class="lnr lnr-heart"></span>
                                                                <p class="hover-text">Wishlist</p>
                                                            </a>
                                                            <a  class="social-info">
                                                                <span class="lnr lnr-sync"></span>
                                                                <p class="hover-text">compare</p>
                                                            </a>
                                                            <a  class="social-info">
                                                                <span class="lnr lnr-move"></span>
                                                                <p class="hover-text">view more</p>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    <% end_loop %>
                                </div>
                            <% end_if %>
                    </div>

                    <% if $SubBannerPromos.exists %>
                        <% loop $SubBannerPromos %>
                            <div class="container">
                                <% with $Banner %>
                                    <img src="$URL" class="img-fluid" width="100%" height="700">
                                <% end_with %>
                    
                                <!-- Promo Products -->
                                <div class="row mt-3">
                                    <% loop $Products.Limit(4) %>
                                        <a href="{$BaseHref}/productdetails/view/$ID">
                                            <div class="col-lg-3 col-md-4 col-sm-6">
                                                <div class="single-product">
                                                    <% with $ProductImages.First %>
                                                        <img src="$URL" class="img-fluid" style="object-fit: cover; aspect-ratio: 4/3;">
                                                    <% end_with %>
                                                    <div class="product-details">
                                                        <h6>$Title</h6>
                                                        <div class="price">
                                                            <% if $Promotion %>
                                                                <h6>$minPriceDiscounted</h6>
                                                                <h6 class="l-through">$minPrice</h6>
                                                            <% else %>
                                                                <h6>$minPrice</h6>
                                                            <% end_if %>
                                                        </div>
                                                        <div class="prd-bottom">
                                                            <a class="social-info">
                                                                <span class="ti-bag"></span>
                                                                <p class="hover-text">add to bag</p>
                                                            </a>
                                                            <a class="social-info">
                                                                <span class="lnr lnr-heart"></span>
                                                                <p class="hover-text">Wishlist</p>
                                                            </a>
                                                            <a class="social-info">
                                                                <span class="lnr lnr-sync"></span>
                                                                <p class="hover-text">compare</p>
                                                            </a>
                                                            <a class="social-info">
                                                                <span class="lnr lnr-move"></span>
                                                                <p class="hover-text">view more</p>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    <% end_loop %>
                                </div>
                            </div>
                        <% end_loop %>
                    <% end_if %>
                    <% if $SubBanner2Promos.exists %>
                        <% loop $SubBanner2Promos %>
                            <div class="container">
                                <% with $Banner %>
                                    <img src="$URL" class="img-fluid" width="100%" height="700">
                                <% end_with %>
                    
                                <!-- Promo Products -->
                                <div class="row mt-3">
                                    <% loop $Products.Limit(4) %>
                                        <a href="{$BaseHref}/productdetails/view/$ID">
                                            <div class="col-lg-3 col-md-4 col-sm-6">
                                                <div class="single-product">
                                                    <% with $ProductImages.First %>
                                                        <img src="$URL" class="img-fluid" style="object-fit: cover; aspect-ratio: 4/3;">
                                                    <% end_with %>
                                                    <div class="product-details">
                                                        <h6>$Title</h6>
                                                        <div class="price">
                                                            <% if $Promotion %>
                                                                <h6>$minPriceDiscounted</h6>
                                                                <h6 class="l-through">$minPrice</h6>
                                                            <% else %>
                                                                <h6>$minPrice</h6>
                                                            <% end_if %>
                                                        </div>
                                                        <div class="prd-bottom">
                                                            <a class="social-info">
                                                                <span class="ti-bag"></span>
                                                                <p class="hover-text">add to bag</p>
                                                            </a>
                                                            <a class="social-info">
                                                                <span class="lnr lnr-heart"></span>
                                                                <p class="hover-text">Wishlist</p>
                                                            </a>
                                                            <a class="social-info">
                                                                <span class="lnr lnr-sync"></span>
                                                                <p class="hover-text">compare</p>
                                                            </a>
                                                            <a class="social-info">
                                                                <span class="lnr lnr-move"></span>
                                                                <p class="hover-text">view more</p>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    <% end_loop %>
                                </div>
                            </div>
                        <% end_loop %>
                    <% end_if %>
                    <% if $SubBanner3Promos.exists %>
                        <% loop $SubBanner3Promos %>
                            <div class="container">
                                <% with $Banner %>
                                    <img src="$URL" class="img-fluid" width="100%" height="700">
                                <% end_with %>
                    
                                <!-- Promo Products -->
                                <div class="row mt-3">
                                    <% loop $Products.Limit(4) %>
                                        <a href="{$BaseHref}/productdetails/view/$ID">
                                            <div class="col-lg-3 col-md-4 col-sm-6">
                                                <div class="single-product">
                                                    <% with $ProductImages.First %>
                                                        <img src="$URL" class="img-fluid" style="object-fit: cover; aspect-ratio: 4/3;">
                                                    <% end_with %>
                                                    <div class="product-details">
                                                        <h6>$Title</h6>
                                                        <div class="price">
                                                            <% if $Promotion %>
                                                                <h6>$minPriceDiscounted</h6>
                                                                <h6 class="l-through">$minPrice</h6>
                                                            <% else %>
                                                                <h6>$minPrice</h6>
                                                            <% end_if %>
                                                        </div>
                                                        <div class="prd-bottom">
                                                            <a class="social-info">
                                                                <span class="ti-bag"></span>
                                                                <p class="hover-text">add to bag</p>
                                                            </a>
                                                            <a class="social-info">
                                                                <span class="lnr lnr-heart"></span>
                                                                <p class="hover-text">Wishlist</p>
                                                            </a>
                                                            <a class="social-info">
                                                                <span class="lnr lnr-sync"></span>
                                                                <p class="hover-text">compare</p>
                                                            </a>
                                                            <a class="social-info">
                                                                <span class="lnr lnr-move"></span>
                                                                <p class="hover-text">view more</p>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    <% end_loop %>
                                </div>
                            </div>
                        <% end_loop %>
                    <% end_if %>
                    
        
                    <div class="container">
                        <% if $BestRating  %>
                            <div class="d-flex justify-content-between mb-2">
                                <h6>Best Rating</h6>
                                <a href="#" style="color:#777777;">Lihat Semua ></a>
                            </div>
                            <div class="row">
                                <% loop $BestRating.Limit(4) %>
                                        <a href="{$BaseHref}/productdetails/view/$ID">
                                            <div class="col-lg-3 col-md-4 col-sm-6  ">
                                                <div class="single-product">
                                                    <% with $ProductImages.First %>
                                                        <img src="$URL" class="img-fluid" style="object-fit: cover; aspect-ratio: 4/3;">
                                                    <% end_with %>
                                                    <div class="product-details">
                                                        <h6>$Title</h6>
                                                        <div class="price">
                                                            <% if $Promotion %>
                                                                <h6>$minPriceDiscounted</h6>
                                                                <h6 class="l-through">$minPrice</h6>
                                                            <% else %>
                                                                <h6>$minPrice</h6>
                                                            <% end_if %>
                                                        </div>
                                                        <div class="prd-bottom">
                
                                                            <a  class="social-info">
                                                                <span class="ti-bag"></span>
                                                                <p class="hover-text">add to bag</p>
                                                            </a>
                                                            <a  class="social-info">
                                                                <span class="lnr lnr-heart"></span>
                                                                <p class="hover-text">Wishlist</p>
                                                            </a>
                                                            <a  class="social-info">
                                                                <span class="lnr lnr-sync"></span>
                                                                <p class="hover-text">compare</p>
                                                            </a>
                                                            <a  class="social-info">
                                                                <span class="lnr lnr-move"></span>
                                                                <p class="hover-text">view more</p>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    <% end_loop %>
                            </div>
                        <% end_if %>
                    </div>
                </div>
                <%-- Product --%>
                <div class="container Akhir py-3" id="akhir">
                    <div class="row">
                        <div class="col-xl-3 col-lg-4 col-md-5">
                            <div class="sidebar-categories">
                                <h6 class="py-2" id="refreshfilter" data-id="$Vendor.Pathname" style="cursor: pointer;">Refresh Filter</h6>
                                <div class="head">Browse Categories</div>
                                    <ul class="main-categories">
                                        <% if $Category %>
                                            <% loop $Category %>
                                                <li class="main-nav-list">
                                                    <a data-toggle="collapse" data-target="#collapseExample-$ID" aria-expanded="false" aria-controls="collapseExample" href="#">
                                                        <span class="lnr lnr-arrow-right"></span>$Title <span class="number">($ProductSubCategory.Count)</span>
                                                    </a>
                                                    <ul class="collapse" id="collapseExample-$ID" data-toggle="collapse" aria-expanded="false" aria-controls="category-$ID">
                                                        <% if $ProductSubCategory %>
                                                            <% loop $ProductSubCategory %>
                                                                <li class="main-nav-list child">
                                                                    <a href="#" data-id="$ID" class="subcategory-link">$Title <span class="number">($ProductObject.Count)</span></a>
                                                                </li>
                                                            <% end_loop %>
                                                        <% else %>
                                                            <li class="main-nav-list child py-2">This SubCategory is Coming Soon</li>
                                                        <% end_if %>
                                                    </ul>
                                                </li>
                                            <% end_loop %>
                                        <% else %>
                                            <li class="main-nav-list child py-2">This Category is Coming Soon</li>  
                                        <% end_if %>
                                    </ul>
                                </div>
                                <div class="sidebar-filter mt-50">
                                    <div class="top-filter-head">Product Filters</div>
                                        <div class="common-filter">
                                            <div class="head">Brands</div>
                                            <form id="filterForm" action="#">
                                                <ul>
                                                    <li class="filter-list">
                                                        <input class="pixel-radio" type="radio" id="allbrand" name="brand" value="all" <% if $CurrentFilter == 'all' %>checked<% end_if %>>
                                                        <label for="allbrand">All <span>($Count)</span></label>
                                                    </li>
                                                    <% loop $Brand %>
                                                        <li class="filter-list">
                                                            <input class="pixel-radio" type="radio" id="$Title.LowerCase" data-id="$ID" name="brand" value="$ID" <% if $CurrentFilter == $ID %>checked<% end_if %>>
                                                            <label for="$Title.LowerCase">$Title <span>($ProductCount)</span></label>
                                                        </li>
                                                    <% end_loop %>
                                                </ul>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                        <div class="col-xl-9 col-lg-8 col-md-7">
                            <!-- Start Filter Bar -->
                            <div class="filter-bar d-flex flex-wrap align-items-center">
                                <div class="sorting">
                                    <select name="sort" id="sortSelect">
                                        <option value="1" <% if $CurrentSort == 1 %>selected<% end_if %>>Default</option>
                                        <option value="2" <% if $CurrentSort == 2 %>selected<% end_if %>>Harga: Terendah - Tertinggi</option>
                                        <option value="3" <% if $CurrentSort == 3 %>selected<% end_if %>>Harga: Tertinggi - Terendah</option>
                                    </select>
                                </div>
                                <div class="sorting mr-auto">
                                    <form method="post" id="myForm" action="{$BaseHref}/vendorpage">
                                        <select id="filtera" class="selectpicker filter-class" name="filter">
                                            <option value="">Show $CurrentLength</option>
                                            <option value="12">Show 12</option>
                                            <option value="9">Show 9</option>
                                            <option value="6">Show 6</option>
                                        </select>
                                    </form>
                                </div>
                                <% with  $PaginatedProduct %>
                                    <nav class="blog-pagination justify-content-center d-flex " style="left: 50%;padding: 0 !important;">
                                        <% if $MoreThanOnePage %>
                                            <div class="pagination">
                                            <% if $NotFirstPage %>
                                                <a href="$PrevLink" class="prev-arrow"><i class="fa fa-long-arrow-left" aria-hidden="true"></i></a>
                                            <% end_if %>
                                            <% loop $PaginationSummary(10) %>
                                                <% if $Link %>
                                                    <a href="$Link" class="page-link">$PageNum</a>
                                                <% else %>
                                                <span class="bg-secondary ">...</span>
                                            <% end_if %>
                                            <% end_loop %>
                                            <% if $NotLastPage %>
                                                <a href="$NextLink" class="next-arrow"><i class="fa fa-long-arrow-right" aria-hidden="true"></i></a>
                                            <% end_if %>
                                        </div>
                                        <% end_if %>
                                    </nav>
                                <% end_with %>
                            </div>
                            <!-- End Filter Bar -->
                            <!-- Start Best Seller -->
                            <section class="lattest-product-area pb-40 category-list">
                                <div class="row">
                                    <!-- single product -->
                                     <% if $PaginatedProduct %>
                                        
                                        <% loop $PaginatedProduct %>
                                           <div class="col-lg-4 col-md-6">
                                               <div class="single-product">
                                                   <a href="{$BaseHref}/productdetails/view/$ID">
                                                   <% with $ProductImages.First %>
                                                       <img src="$URL" class="img-fluid" style="object-fit: cover; aspect-ratio: 4/3">
                                                   <% end_with %>
                                                   </a>
                                                   <div class="product-details">
                                                       <h6>$Title</h6>
                                                       <div class="price">
                                                           <% if $Promotion %>
                                                               <h6>$minPriceDiscounted</h6>
                                                               <h6 class="l-through">$minPrice</h6>
                                                           <% else %>
                                                               <h6>$minPrice</h6>
                                                           <% end_if %>
                                                       </div>
                                                       <div class="prd-bottom">
                       
                                                           <a  class="social-info">
                                                               <span class="ti-bag"></span>
                                                               <p class="hover-text">add to bag</p>
                                                           </a>
                                                           <a  class="social-info">
                                                               <span class="lnr lnr-heart"></span>
                                                               <p class="hover-text">Wishlist</p>
                                                           </a>
                                                           <a class="social-info">
                                                               <span class="lnr lnr-sync"></span>
                                                               <p class="hover-text">compare</p>
                                                           </a>
                                                           <a  class="social-info">
                                                               <span class="lnr lnr-move"></span>
                                                               <p class="hover-text">view more</p>
                                                           </a>
                                                       </div>
                                                   </div>
                                               </div>
                                           </div>
                                        <% end_loop %>
                                        <% else %>
                                            
                                     <% end_if %>
                            </section>
                            <!-- End Best Seller -->
                            <!-- Start Filter Bar -->
                            <div class="filter-bar d-flex flex-wrap align-items-right">
                                <div class="sorting mr-auto">
                                </div>
                                <% with  $PaginatedProduct %>
                                    <nav class="blog-pagination justify-content-center d-flex " style="left: 50%;padding: 0 !important;">
                                        <% if $MoreThanOnePage %>
                                            <div class="pagination">
                                            <% if $NotFirstPage %>
                                                <a href="$PrevLink" class="prev-arrow"><i class="fa fa-long-arrow-left" aria-hidden="true"></i></a>
                                            <% end_if %>
                                            <% loop $PaginationSummary(10) %>
                                                <% if $Link %>
                                                    <a href="$Link" class="page-link">$PageNum</a>
                                                <% else %>
                                                <span class="bg-secondary ">...</span>
                                            <% end_if %>
                                            <% end_loop %>
                                            <% if $NotLastPage %>
                                                <a href="$NextLink" class="next-arrow"><i class="fa fa-long-arrow-right" aria-hidden="true"></i></a>
                                            <% end_if %>
                                        </div>
                                        <% end_if %>
                                    </nav>
                                <% end_with %>
                            </div>
                            <!-- End Filter Bar -->
                        </div>
                    </div>
            </div>
        </div>
<% else %>
    <p>jsjadj</p>
<% end_if %>
<script>
    $('.nav-item#shop').addClass('active');
    function timeSince(date) {
    const now = new Date();
    const seconds = Math.floor((now - date) / 1000);

    const intervals = {
        tahun: 31536000,
        bulan: 2592000,
        hari: 86400,
        jam: 3600,
        menit: 60,
    };

    for (const [unit, value] of Object.entries(intervals)) {
        const timePassed = Math.floor(seconds / value);
        if (timePassed >= 1) {
            return `${timePassed} ${unit}${timePassed > 1 ? '' : ''} lalu`;
        }
    }

    return "just now";
    }

    const event = document.querySelector('#since');
    const inputDate = new Date((event.dataset.date).replace(' ', 'T'));
    const pastDate = new Date(inputDate);  
    var ss = timeSince(pastDate);
    event.textContent = ss;
</script>
