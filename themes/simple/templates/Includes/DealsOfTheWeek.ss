<!-- Start related-product Area -->
<section class="related-product-area section_gap_bottom">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6 text-center">
                <div class="section-title">
                    <h1>Deals of the Week</h1>
                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore
                        magna aliqua.</p>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-9">
                <div class="row">
                    <% loop $PromotionObjects %>
                         <% if $ShowPromotion2 %>
                            <div class="col-lg-4 col-md-4 col-sm-6 mb-20">
                                <div class="single-related-product d-flex">
                                    <% with $Object %>
                                        
                                        <div class="desc">
                                            <a href="#" class="title">$Title</a>
                                            <div class="price">
                                                <h6>$189.00</h6>
                                                <h6 class="l-through">$210.00</h6>
                                            </div>
                                        </div>
                                    <% end_with   %>
                                </div>
                            </div>
                        <% end_if %>
                    <% end_loop %>

                </div>
            </div>
            <div class="col-lg-3">
                <div class="ctg-right">
                    <a href="#" target="_blank">
                        <img class="img-fluid w-100" src="$ResourceURL('themes/simple/images/category/c5.jpg')">
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- End related-product Area -->