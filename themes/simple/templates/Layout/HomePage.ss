	<!-- start banner Area -->
	<section class="banner-area  organic-breadcrumb" style ="  background: url($SiteConfig.HomeImage.getURL()) center no-repeat;">
		<div class="container">
			<div class="row fullscreen align-items-center justify-content-start">
				<div class="col-lg-12">
					<div class="active-banner-slider owl-carousel">
						<!-- single-slide -->
						<% loop $PromotionObjects %>
							<% if $ShowPromotion1 %>
								<div class="row single-slide align-items-center d-flex">
									<div class="col-lg-5 col-md-6">
										<div class="banner-content">
											<h1>$PromoText1 <br>$PromoText2!</h1>
											<p>$PromoText3</p>
											<div class="add-bag d-flex align-items-center">
												<a class="add-btn" href=""><span class="lnr lnr-cross"></span></a>
												<span class="add-text text-uppercase">Add to Bag</span>
											</div>
										</div>
									</div>
									<div class="col-lg-7">
										<div class="banner-img">
											<% if $ProductImagesInputID %>
												<img src="$ProductImagesInput.Link" class="" alt="" style="object-fit: cover;">
											<% else %>
												<img src="$ProductImages.Link" class="" alt="" style="object-fit: cover;">
											<% end_if %>
										</div>
									</div>
								</div>
							<% end_if %>
						<% end_loop %>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- End banner Area -->

	<!-- start features Area -->
	<section class="features-area section_gap">
		<div class="container">
			<div class="row features-inner">
				<!-- single features -->
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="single-features">
						<div class="f-icon">
						</div>
						<% if $Member %>
						<h6>Free Delivery</h6>
						<% end_if %>
						<p>Free Shipping on all order</p>
					</div>
				</div>
				<!-- single features -->
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="single-features">
						<div class="f-icon">
						</div>
						<h6>Return Policy</h6>
						<p>Free Shipping on all order</p>
					</div>
				</div>
				<!-- single features -->
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="single-features">
						<div class="f-icon">
						</div>
						<h6>24/7 Support</h6>
						<p>Free Shipping on all order</p>
					</div>
				</div>
				<!-- single features -->
				<div class="col-lg-3 col-md-6 col-sm-6">
					<div class="single-features">
						<div class="f-icon">
						</div>
						<h6>Secure Payment</h6>
						<p>Free Shipping on all order</p>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- end features Area -->

	<!-- Start category Area -->
	<section class="category-area">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-lg-8 col-md-12">
					<div class="row">
						<div class="col-lg-8 col-md-8">
							<div class="single-deal">
								<div class="overlay"></div>
								<img class="img-fluid w-100" src="$ResourceURL('themes/simple/images/category/crunning.jpg')">
								<a href="" class="img-pop-up" target="_blank">
									<div class="deal-details">
										<h6 class="deal-title">Product for Running</h6>
									</div>
								</a>
							</div>
						</div>
						<div class="col-lg-4 col-md-4">
							<div class="single-deal">
								<div class="overlay"></div>
								<img class="img-fluid w-100" src="$ResourceURL('themes/simple/images/category/c2.jpg')">
								<a href="" class="img-pop-up" target="_blank">
									<div class="deal-details">
										<h6 class="deal-title">Sneaker for Sports</h6>
									</div>
								</a>
							</div>
						</div>
						<div class="col-lg-4 col-md-4">
							<div class="single-deal">
								<div class="overlay"></div>
								<img class="img-fluid w-100" src="$ResourceURL('themes/simple/images/category/ccouple.jpg')">
								<a href="" class="img-pop-up" target="_blank">
									<div class="deal-details">
										<h6 class="deal-title">Product for Couple</h6>
									</div>
								</a>
							</div>
						</div>
						<div class="col-lg-8 col-md-8">
							<div class="single-deal">
								<div class="overlay"></div>
							<img class="img-fluid w-100" src="$ResourceURL('themes/simple/images/category/ccasual.jpg')">
								<a href="" class="img-pop-up" target="_blank">
									<div class="deal-details">
										<h6 class="deal-title">Sneaker for Casual</h6>
									</div>
								</a>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="single-deal">
						<div class="overlay"></div>
						<img class="img-fluid w-100" src="$ResourceURL('themes/simple/images/category/c5.jpg')">
						<a href="img/category/c5.jpg" class="img-pop-up" target="_blank">
							<div class="deal-details">
								<h6 class="deal-title">Sneaker for Sports</h6>
							</div>
						</a>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- End category Area -->

	<!-- start product Area -->
	<section class="owl-carousel active-product-area section_gap">
		<!-- single product slide -->
		<div class="single-product-slider">
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-lg-6 text-center">
						<div class="section-title">
							<h1>Latest Products</h1>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et
								dolore
								magna aliqua.</p>
						</div>
					</div>
				</div>
				<div class="row">
					<!-- single product -->
					<% loop $ProductObjects.Limit(8) %>
						<% if $ProductCategoryID = 1 %>
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
		<!-- single product slide -->
		<div class="single-product-slider">
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-lg-6 text-center">
						<div class="section-title">
							<h1>Coming Products</h1>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et
								dolore
								magna aliqua.</p>
						</div>
					</div>
				</div>
				<div class="row">
					<% loop $ProductObjects.Limit(8) %>
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
	</section>
	<!-- end product Area -->

	<!-- Start exclusive deal Area -->
	<section class="exclusive-deal-area">
		<div class="container-fluid">
			<div class="row justify-content-center align-items-center">
				<div class="col-lg-6 no-padding exclusive-left" style="background: url($SiteConfig.HotDealImage.getURL()) center no-repeat;  background-size: cover; text-align: center; padding: 275px 0;">
					<div class="row clock_sec clockdiv" id="clockdiv">
						<div class="col-lg-12">
							<h1>Exclusive Hot Deal Ends Soon!</h1>
							<p>Who are in extremely love with eco friendly system.</p>
						</div>
						<div class="col-lg-12">
							<div class="row clock-wrap">
								<div class="col clockinner1 clockinner">
									<h1 class="days">150</h1>
									<span class="smalltext">Days</span>
								</div>
								<div class="col clockinner clockinner1">
									<h1 class="hours">23</h1>
									<span class="smalltext">Hours</span>
								</div>
								<div class="col clockinner clockinner1">
									<h1 class="minutes">47</h1>
									<span class="smalltext">Mins</span>
								</div>
								<div class="col clockinner clockinner1">
									<h1 class="seconds">59</h1>
									<span class="smalltext">Secs</span>
								</div>
							</div>
						</div>
					</div>
					<a href="" class="primary-btn">Shop Now</a>
				</div>
				<div class="col-lg-6 no-padding exclusive-right">
					<div class="active-exclusive-product-slider">
						<!-- single exclusive carousel -->
						<div class="single-exclusive-slider">
							<div class="product-details">
								<div class="price">
									<h6>$150.00</h6>
									<h6 class="l-through">$210.00</h6>
								</div>
								<h4>addidas New Hammer sole
									for Sports person</h4>
								<div class="add-bag d-flex align-items-center justify-content-center">
									<a class="add-btn" href=""><span class="ti-bag"></span></a>
									<span class="add-text text-uppercase">Add to Bag</span>
								</div>
							</div>
						</div>
						<!-- single exclusive carousel -->
						<div class="single-exclusive-slider">
							<div class="product-details">
								<div class="price">
									<h6>$150.00</h6>
									<h6 class="l-through">$210.00</h6>
								</div>
								<h4>addidas New Hammer sole
									for Sports person</h4>
								<div class="add-bag d-flex align-items-center justify-content-center">
									<a class="add-btn" href=""><span class="ti-bag"></span></a>
									<span class="add-text text-uppercase">Add to Bag</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- End exclusive deal Area -->

	<!-- Start brand Area -->
	<section class="brand-area section_gap">
		<div class="container">
			<div class="row">
				<a class="col single-img" href="#">
				</a>
				<a class="col single-img" href="#">
				</a>
				<a class="col single-img" href="#">
				</a>
				<a class="col single-img" href="#">
				</a>
				<a class="col single-img" href="#">
				</a>
			</div>
		</div>
	</section>
	<!-- End brand Area -->

	<% include DealsOfTheWeek %>
	<script>
		$('.nav-item#home').addClass('active');
	</script>