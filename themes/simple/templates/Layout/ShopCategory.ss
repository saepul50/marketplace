<body id="category">
<!-- Start Banner Area -->
<section class="banner-area organic-breadcrumb" style ="background: url($SiteConfig.Background.getURL()) center no-repeat;background-size: cover; position: relative ">
    <div class="container">
        <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
            <div class="col-first">
                <h1>Shop Category page</h1>
                <nav class="d-flex align-items-center">
                    <a href="{$BaseHref}">Home<span class="lnr lnr-arrow-right"></span></a>
                    <a href="{$BaseHref}/shopcategory">Shop<span class="lnr lnr-arrow-right"></span></a>
                    <a href="#">Fashon Category</a>
                </nav>
            </div>
        </div>
    </div>
</section>
<!-- End Banner Area -->
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
            <div class="sidebar-filter mt-50">
                <div class="top-filter-head">Product Filters</div>
                <div class="common-filter">
                    <div class="head">Brands</div>
                    <form id="filterForm">
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
                <%-- <div class="common-filter">
                    <div class="head">Color</div>
                    <form action="#">
                        <ul>
                            <li class="filter-list"><input class="pixel-radio" type="radio" id="black" name="color"><label for="black">Black<span>(29)</span></label></li>
                            <li class="filter-list"><input class="pixel-radio" type="radio" id="balckleather" name="color"><label for="balckleather">Black
                                    Leather<span>(29)</span></label></li>
                            <li class="filter-list"><input class="pixel-radio" type="radio" id="blackred" name="color"><label for="blackred">Black
                                    with red<span>(19)</span></label></li>
                            <li class="filter-list"><input class="pixel-radio" type="radio" id="gold" name="color"><label for="gold">Gold<span>(19)</span></label></li>
                            <li class="filter-list"><input class="pixel-radio" type="radio" id="spacegrey" name="color"><label for="spacegrey">Spacegrey<span>(19)</span></label></li>
                        </ul>
                    </form>
                </div> --%>
                <%-- <div class="common-filter">
                    <div class="head">Price</div>
                    <div class="price-range-area">
                        <div id="price-range"></div>
                        <div class="value-wrapper d-flex">
                            <div class="price">Price:</div>
                            <span>$</span>
                            <div id="lower-value"></div>
                            <div class="to">to</div>
                            <span>$</span>
                            <div id="upper-value"></div>
                        </div>
                    </div>
                </div> --%>
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
            <section class="lattest-product-area category-list">
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

<% include DealsOfTheWeek %>
</body>

    <script>
        $('.nav-item#shop').addClass('active');
    </script>