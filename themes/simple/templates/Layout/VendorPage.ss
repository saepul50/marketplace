<% if $Vendor %>
    <style>
        .card {
            width: 100%;
            max-width: 400px;
            height: auto;
            border-radius: 5px;
            background-color: #488bf7;
            text-transform: uppercase;
            font-family: cursive;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 5px;
            position: relative;
            overflow: hidden;
            color: #fff;
          }
        
          .card::after {
            content: "";
            width: 20px;
            height: 90%;
            position: absolute;
            right: 0;
            background-image: radial-gradient(circle at center, #fff 60%, #488bf7 60% 100%);
            --size: 5px;
            background-size: var(--size) var(--size);
            background-repeat: repeat-y;
            background-position: center;
            transform: translateY(0px);
            padding-block: 6px;
          }
          @media (max-width: 768px) {
            .card {
              max-width: 100%;
              height: auto;
            }
        
            .card h6, .card p {
              font-size: 0.8rem;
            }
        
            .primary-btn {
              line-height: 1.5 !important;
              padding: 0 0.4rem !important;
            }
          }
        
          @media (max-width: 576px) {
            .card {
              max-width: 100%;
            }
        
            .card h6, .card p {
              font-size: 0.7rem;
            }
        
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
                <%-- <div class="col-first">
                    <h1>Registration</h1>
                    <nav class="d-flex align-items-center">
                        <a href="{$BaseHref}">Home<span class="lnr lnr-arrow-right"></span></a>
                        <a href="{$BaseHref}/tracking">Registration</a>
                    </nav>
                </div> --%>
            </div>
        </div>
    </section>
    
    <div class=" " style ="background-color: white; padding-top: 10rem;">
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
                <div class="col-8 ">
                    <div class="d-flex ml-1"  >
                        <span class="lnr lnr-store mt-1" style="font-size:17px"></span>
                        <p class="ml-2">Product : </p>
                    </div>
                    <div class="d-flex ml-1" >
                        <span class="lnr lnr-star mt-1"  style="font-size:17px"></span>
                        <p class="ml-2">Rating : </p>
                        <p> 10</p>
                    </div>
                    <div class="d-flex ml-1" >
                    <span class="lnr lnr-star mt-1"  style="font-size:17px"></span>
                    <p class="ml-2">Bergabung  : </p>
                    <p> 10 Tahun lalu</p>
                </div>
                </div>
            </div>
        </div>
        <section class="order_details py-4">
            <div class= "myorder text-center mt-2" id="myOrder">
                <nav class=" d-flex flex-wrap navihistory container">
                    <h5 id="navSemua" class="navi-item" style="cursor: pointer; margin-bottom:0 !important;">Halaman Utama</h5>
                    <h5 id="navPending" class="navi-item" style="cursor: pointer;  margin-bottom:0 !important;">Produk</h5>
                </nav>
            </div>
        </section>
    </div>
        <div class="tab-content py-5    " id="nav-tabContent" style="background-color:#f5f5f5; ">
            <div class="container Semua" id="semua">
                <div class="container py-4" id="kupon" style="background-color:white;" > 
                    <div class="rows">
                        <div class="d-flex row container" style="gap:15px; font-size:10px;">
                            <div class="card col-6 col-md-6 col-lg-3 row d-flex" style="flex-direction:row !important; margin-left:.2rem;">
                              <div class="col-7  col-md-5 mt-1">
                                <h6 class="fw-bold">Diskon 15%</h6>
                                <p style="margin-bottom:0 !important;">MIN. blj Rp.0 s/d Rp 35RB</p>
                                <p>Berakhir Dalam : 10 Menit</p>
                              </div>
                              <div class="col-5 col-md-7 d-flex align-items-center">
                                <button class="primary-btn" style="color:black; border-radius:25px !important; line-height:2 !important; padding:0 .5rem !important; background:#488bf7 !important;">Klaim</button>
                              </div>
                            </div>
                          </div>
                    </div>
                </div>   
                
                <div class="container mt-5" >
                    <div class="d-flex justify-content-between mb-2">
                        <h6>KAMU MUNGKIN SUKA</h6>
                        <a href="#" style="color:#777777;">Lihat Semua ></a>
                    </div>
                    <div class="row">
                        <% loop $ProductObjects.Limit(7) %>
                            <% if $ProductCategoryID = 2 %>
                                <a href="{$BaseHref}/productdetails/view/$ID">
                                    <div class="col-lg-3 col-md-6">
                                        <div class="single-product">
                                            <% with $ProductImages.First %>
                                                <img src="$URL" class="img-fluid" style="object-fit: cover;">
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
        
                                                    <a href="" class="social-info">
                                                        <span class="ti-bag"></span>
                                                        <p class="hover-text">add to bag</p>
                                                    </a>
                                                    <a href="" class="social-info">
                                                        <span class="lnr lnr-heart"></span>
                                                        <p class="hover-text">Wishlist</p>
                                                    </a>
                                                    <a href="" class="social-info">
                                                        <span class="lnr lnr-sync"></span>
                                                        <p class="hover-text">compare</p>
                                                    </a>
                                                    <a href="" class="social-info">
                                                        <span class="lnr lnr-move"></span>
                                                        <p class="hover-text">view more</p>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                                <% end_if %>
                            <% end_loop %>
                    </div>
                    <div class="banner-product">
                         <img alt="Profile img" src="$SiteConfig.Banner.getURL()" class="img-fluid">
                         <div class="row mt-5">
                            <% loop $ProductObjects.Limit(7) %>
                                <% if $ProductCategoryID = 2 %>
                                    <a href="{$BaseHref}/productdetails/view/$ID">
                                        <div class="col-lg-3 col-md-6">
                                            <div class="single-product">
                                                <% with $ProductImages.First %>
                                                    <img src="$URL" class="img-fluid" style="object-fit: cover;">
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
            
                                                        <a href="" class="social-info">
                                                            <span class="ti-bag"></span>
                                                            <p class="hover-text">add to bag</p>
                                                        </a>
                                                        <a href="" class="social-info">
                                                            <span class="lnr lnr-heart"></span>
                                                            <p class="hover-text">Wishlist</p>
                                                        </a>
                                                        <a href="" class="social-info">
                                                            <span class="lnr lnr-sync"></span>
                                                            <p class="hover-text">compare</p>
                                                        </a>
                                                        <a href="" class="social-info">
                                                            <span class="lnr lnr-move"></span>
                                                            <p class="hover-text">view more</p>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                    <% end_if %>
                                <% end_loop %>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container Pending" id="pending">
                <div class="container" style="padding-bottom: 5rem;">
                    <div class="row">
                        <div class="col-xl-3 col-lg-4 col-md-5">
                            <div class="sidebar-categories">
                                <div class="head">Browse Categories</div>
                                <ul class="main-categories">
                                    <% loop $Category %>
                                        <li class="main-nav-list">
                                            <a data-toggle="collapse" data-target="#collapseExample-$ID" aria-expanded="false" aria-controls="collapseExample" href="#">
                                                <span class="lnr lnr-arrow-right"></span>$Title <span class="number">($ProductSubCategory.Count)</span>
                                            </a>
                                            <ul class="collapse" id="collapseExample-$ID" data-toggle="collapse" aria-expanded="false" aria-controls="category-$ID">
                                                <% if $ProductSubCategory.exists %>
                                                    <% loop $ProductSubCategory %>
                                                        <li class="main-nav-list child">
                                                            <a href="#" data-id="$ID" class="subcategory-link">$Title <span class="number">($ProductObject.Count)</span></a>
                                                        </li>
                                                    <% end_loop %>
                                                <% else %>
                                                    <li class="main-nav-list child py-2">This Category is Coming Soon</li>
                                                <% end_if %>
                                            </ul>
                                        </li>
                                    <% end_loop %>
                                </ul>
                            </div>
                            <%-- <div class="sidebar-filter mt-50">
                                <div class="top-filter-head">Product Filters</div>
                                <div class="common-filter">
                                    <div class="head">Brands</div>
                                    <form id="filterForm" action="#">
                                        <ul>
                                            <li class="filter-list">
                                                <input class="pixel-radio" type="radio" id="allbrand" name="brand" value="all" <% if $CurrentFilter == 'all' %>checked<% end_if %>>
                                                <label for="allbrand">All <span>($PaginatedProduct.Count)</span></label>
                                            </li>
                                            <% loop $Brand %>
                                                <li class="filter-list">
                                                    <input class="pixel-radio" type="radio" id="$Title.LowerCase" data-id="$ID" name="brand" value="$ID" <% if $CurrentFilter == $ID %>checked<% end_if %>>
                                                    <label for="$Title.LowerCase">$Title <span>($Product.Count)</span></label>
                                                </li>
                                            <% end_loop %>
                                        </ul>
                                    </form>
                                </div>
                            </div> --%>
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
                                    <form method="post" id="myForm" action="{$BaseHref}/shopcategory">
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
                                     <% loop $PaginatedProduct %>
                                        <div class="col-lg-4 col-md-6">
                                            <div class="single-product">
                                                <% with $ProductImages.First %>
                                                    <img src="$URL" class="img-fluid" style="object-fit: cover; aspect-ratio: 4/3">
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
                    
                                                        <a href="{$BaseHref}/productdetails/view/$ID" class="social-info">
                                                            <span class="ti-bag"></span>
                                                            <p class="hover-text">add to bag</p>
                                                        </a>
                                                        <a href="{$BaseHref}/productdetails/view/$ID" class="social-info">
                                                            <span class="lnr lnr-heart"></span>
                                                            <p class="hover-text">Wishlist</p>
                                                        </a>
                                                        <a href="{$BaseHref}/productdetails/view/$ID" class="social-info">
                                                            <span class="lnr lnr-sync"></span>
                                                            <p class="hover-text">compare</p>
                                                        </a>
                                                        <a href="{$BaseHref}/productdetails/view/$ID" class="social-info">
                                                            <span class="lnr lnr-move"></span>
                                                            <p class="hover-text">view more</p>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                     <% end_loop %>
                            </section>
                            <!-- End Best Seller -->
                            <!-- Start Filter Bar -->
                            <div class="filter-bar d-flex flex-wrap align-items-center">
                                <div class="sorting mr-auto">
                                    <%-- <form method="post" id="myForm1" action="{$BaseHref}/shopcategory/filter">
                                        <select id="filteras" class="selectpicker filter-class" name="filter" onchange="submitForm2()">
                                            <option value="12">Show 12</option>
                                            <option value="9">Show 9</option>
                                            <option value="6">Show 6</option>
                                        </select>
                                    </form> --%>
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
        </div>
        <% else %>
        <p>jsjadj</p>
<% end_if %>