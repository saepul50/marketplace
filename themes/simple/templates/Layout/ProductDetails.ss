<% require themedJavascript('main') %>
	<style>
		.stars {
			font-size: 30px;

		}

		.star {
			cursor: pointer;
			margin: 0 5px;
		}

		.one {
			color: #FBD600;
		}

		.two {
			color: #FBD600;
		}

		.three {
			color: #FBD600;
		}

		.four {
			color: #FBD600;
		}

		.five {
			color: #FBD600;
		}
	</style>
	<!-- Start Banner Area -->
	<section class="banner-area organic-breadcrumb"
		style="background: url($SiteConfig.Background.getURL()) center no-repeat;background-size: cover; position: relative ">
		<div class="container">
			<div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
				<div class="col-first">
					<h1>Product Details</h1>
					<nav class="d-flex align-items-center">
						<a href="{$BaseHref}">Home<span class="lnr lnr-arrow-right"></span></a>
						<a href="{$BaseHref}/shopcategory">Shop<span class="lnr lnr-arrow-right"></span></a>
						<a href="{$BaseHref}/productdetails">product-details</a>
					</nav>
				</div>
			</div>
		</div>
	</section>
	<!-- End Banner Area -->
	<% if $Product %>
		<!--================Single Product Area =================-->
		<div class="product_image_area">
			<div class="container">
				<div class="row s_product_inner">
					<div class="col-lg-6">
						<div class="s_Product_carousel">
							<% loop $Product.ProductImages %>
								<div class="single-prd-item ">
									<img src="$URL" alt="$Product.ProductImages.First.Title" class="img-fluid"
										style="object-fit: cover;">
								</div>
								<% end_loop %>
						</div>
					</div>
					<% with $Product.ProductImages.First %>
						<img id="productImage" src="$URL" class="img-fluid" style="display: none;">
						<% end_with %>
							<div class="col-lg-5 offset-lg-1">
								<div class="s_product_text mt-0">
									<h3 id="productTitle">$Product.Title</h3>
									<p class="d-none" id="productId">$Product.ID</p>
									<p class="d-none" id="productCategoriID">$Product.ProductCategory.ID</p>
									<% if $Product.Promotion %>
										<h2 class="mb-1 ppprice">$Product.rangePriceDiscounted</h2>
										<h6 class="l-through my-1 nnprice">$Product.rangePrice</h6>
										<% else %>
											<h2 class="ppprice" id="productPrice">$Product.rangePrice</h2>
											<% end_if %>
												<ul class="list">
													<% if $Product.ProductCategory && $Product.totalStock> 0 %>
														<li><a class="active" href="#"><span>Category</span> :
																$Product.ProductCategory.Title</a></li>
														<li><a href="#"><span>Availibility</span> : In Stock</a></li>
														<% else_if $Product.totalStock < 1 %>
															<li><a class="active" href="#"><span>Category</span> :
																	$Product.ProductCategory.Title</a></li>
															<li><a href="#"><span>Availibility</span> : Out Of Stock</a>
															</li>
															<% end_if %>
												</ul>
												<p class="m-0 p-0 py-3">$Product.Features</p>
												<div class="product_count mb-3">
													<label for="qty">Quantity:</label>
													<input type="text" name="qty" id="sst" maxlength="12" value="1"
														title="Quantity:" class="input-text qty"
														onkeypress="return event.charCode >= 48 && event.charCode <= 57"
														oninput="var sst = parseInt(this.value); if (isNaN(sst) || sst < 1) this.value = 1;">

													<button
														onclick="var result = document.getElementById('sst'); var sst = parseInt(result.value); if (!isNaN(sst)) result.value = sst + 1; return false;"
														class="increase items-count" type="button">
														<i class="lnr lnr-chevron-up"></i>
													</button>

													<button
														onclick="var result = document.getElementById('sst'); var sst = parseInt(result.value); if (!isNaN(sst) && sst > 1) result.value = sst - 1; return false;"
														class="reduced items-count" type="button" style="bottom: 0;">
														<i class="lnr lnr-chevron-down"></i>
													</button>
												</div>
												<% if $Product.ProductCategory.ID=1 %>
													<div class="cardVariant pb-2 d-flex align-items-center">
														<% loop $Product.ProductVariants.sort(VariantName) %>
															<div class="variantItem m-0 p-0 mr-2 d-flex align-items-center"
																style="border: 2px solid #ccc;" data-id="$ID"
																data-stock="$Stock" data-price="$NormalPrice"
																data-discount="$DiscountedPrice" data-weight="$Weight">
																<h6 class="d-flex align-items-center p-1 m-0" id="variantName" style="color:#000">$VariantName</h6>
															</div>
														<% end_loop %>
													</div>
													<% end_if %>
														<div class="card_area d-flex align-items-center">
															<button class="primary-btn" id="addCart"
																style="border:none;">Add to Cart</button>
															<a class="icon_btn" href="#"><i
																	class="lnr lnr lnr-diamond"></i></a>
															<a class="icon_btn" href="#"><i
																	class="lnr lnr lnr-heart"></i></a>
														</div>
								</div>
							</div>
				</div>
			</div>
		</div>
		<!--================End Single Product Area =================-->

		<!--================Product Description Area =================-->
		<section class="product_description_area">
			<div class="container">
				<ul class="nav nav-tabs" id="myTab" role="tablist">
					<li class="nav-item">
						<a class="nav-link nav-linked" name="tabs" id="home-tab" data-toggle="tab" href="home" role="tab"
							aria-controls="home" aria-selected="true"value="Description">Description</a>
					</li>
					<li class="nav-item">
						<a class="nav-link nav-linked" name="tabs" id="profile-tab" data-toggle="tab" href="profile" role="tab"
							aria-controls="profile" aria-selected="false" value="This Product">This Product</a>
					</li>
					<li class="nav-item">
						<a class="nav-link nav-linked"  name="tabs" id="contact-tab" data-toggle="tab" href="contact" role="tab"
							aria-controls="contact" aria-selected="false" value="Comments">Comments</a>
					</li>
					<li class="nav-item">
						<a class="nav-link nav-linked"  name="tabs" id="review-tab" data-toggle="tab" href="review" role="tab"
							aria-controls="review" aria-selected="false" value="Reviews">Reviews</a>
					</li>
				</ul>
				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade" id="home" role="tabpanel" aria-labelledby="home-tab">
						<p>$Product.Description</p>
					</div>
					<div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
						<div class=" d-flex px-3">
							<div class="col-6 col-md-1">
								<p class="m-0 pb-1">Eksplor:&nbsp;</p>
							</div>
							<div class="col-6 col-md-11">
								<a href="" style="color: #ffba00; font-weight: 500;">
									<p class="m-0 pb-1">$Product.ProductBrands.Title</p>
								</a>
								<a href="" style="color: #ffba00; font-weight: 500;">
									<p class="m-0 pb-1">$Product.ProductCategory.Title</p>
								</a>
							</div>
						</div>
					</div>
					<div class="tab-pane fade  " id="contact" role="tabpanel" aria-labelledby="contact-tab">
						<div class="row">
							<div class="col-lg-6">
								<div class="comment_list">
									<% loop $Comment %>
										<div class="review_item">
											<div class="media">
												<div class="d-flex">
													<% with $Member %>
														<% if $ProfileImage.exists %>
															<img class="image" id="image" src="$ProfileImage.getURL()"
																alt="$Name's profile image">
															<% else %>
																<img class="image" id="image"
																	src="$SiteConfig.Unknown.getURL()"
																	alt="Default image">
																<% end_if %>
																	<% end_with %>
												</div>
												<div class="media-body">
													<h4>$Member.Surname</h4>
													<h5>$Created</h5>
													<a class="reply_btn" href="#" data-toggle="modal"
														data-target="#exampleModal" data-productcomentid="$ID"
														data-name="$Member.FirstName">Reply</a>
												</div>
											</div>
											<p>$Comment</p>
										</div>

										<% if $CommentReply.exists %>
											<% loop $CommentReply %>
												<div class="review_item reply">
													<div class="media">
														<div class="d-flex">
															<% with $Member %>
																<% if $ProfileImage.exists %>
																	<img class="image" id="image"
																		src="$ProfileImage.getURL()"
																		alt="$Name's profile image">
																	<% else %>
																		<img class="image" id="image"
																			src="$resourceURL('themes/simple/images/blog/unknown.png')"
																			alt="Default image">
																		<% end_if %>
																			<% end_with %>
														</div>
														<div class="media-body">
															<h4 id="takename">$Member.FirstName</h4>
															<h5>$Created </h5>
															<a href="" class="reply_btn " data-toggle="modal"
																data-target="#exampleModal"
																data-productcomentid="$Up.ID" data-takename='#takename'
																data-name="$Member.FirstName">reply</a>
														</div>
													</div>
													<p><b id="sendto">$SendTo</b> $Comment</p>
												</div>
											<% end_loop %>
										<% end_if %>
									<% end_loop %>
									<% with  $Comment %>
										<nav class="blog-pagination justify-content-center d-flex " style="left: 50%;padding: 0 !important;">
											<% if $MoreThanOnePage %>
												<ul class="pagination">
													<% if $NotFirstPage %>
														<li class="page-item">
															<a href="#" class="page-link" aria-label="Previous">
																<span aria-hidden="true">
																	<span class="lnr lnr-chevron-left"></span>
																</span>
															</a>
														</li>
													<% end_if %>
													<% loop $PaginationSummary(10) %>
													<li class="page-item " style="list-style-type: none; ">
														<% if $Link %>
															<a class="page-link "
															   href="$Link">$PageNum</a>
														<% else %>
															<span class="bg-secondary ">...</span>
														<% end_if %>
													</li>
												<% end_loop %>
										
													<% if $NotLastPage %>
														<li class="page-item">
															<a href="#" class="page-link" aria-label="Next">
																<span aria-hidden="true">
																	<span class="lnr lnr-chevron-right"></span>
																</span>
															</a>
														</li>
													<% end_if %>
												</ul>
											<% end_if %>
										</nav>
										<% end_with %>
								</div>
							</div>
							<div class="col-lg-6">
								<div class="review_box">
									<h4>Post a comment</h4>
									<form class="row contact_form" method="post" id="kkls">
										<div class="col-md-12">
											<div class="form-group">
												<textarea class="form-control" id="slsd" rows="1"
													placeholder="Message"></textarea>
												<input type="hidden" id="asdasda" name="ProductIDs" value="$ID">
											</div>
										</div>
										<div class="col-md-12 text-right">
											<button type="submit" class="btn primary-btn">Submit Now</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
					<div class="tab-pane fade" id="review" role="tabpanel" aria-labelledby="review-tab">
						<div class="row">
							<div class="col-lg-6">
								<div class="row total_rate">
									<div class="col-6">
										<div class="box_total">
											<h5>Overall</h5>
											<h4>$Ave</h4>
											<h6>($Count Reviews)</h6>
										</div>
									</div>
									
									<div class="col-6">
										<div class="rating_list">
											<h3>Based on $Count Reviews</h3>
											<ul class="list">
												<li><a href="#">1 Star
												<i class="fa fa-star"></i>
												<i class="fa fa-star-o"></i>
												<i class="fa fa-star-o"></i>
												<i class="fa fa-star-o"></i>
												<i class="fa fa-star-o"></i>
											$One</a>
											</li>
												<li><a href="#">2 Star 
												<i class="fa fa-star"></i>
												<i class="fa fa-star"></i>
												<i class="fa fa-star-o"></i>
												<i class="fa fa-star-o"></i>
												<i class="fa fa-star-o"></i>
											$Two</a>
											</li>
												<li><a href="#">3 Star 
												<i class="fa fa-star"></i>
												<i class="fa fa-star"></i>
												<i class="fa fa-star"></i>
												<i class="fa fa-star-o"></i>
												<i class="fa fa-star-o"></i>
											$Three</a>
											</li>
												<li><a href="#">4 Star 
												<i class="fa fa-star"></i>
												<i class="fa fa-star"></i>
												<i class="fa fa-star"></i>
												<i class="fa fa-star"></i>
												<i class="fa fa-star-o"></i>
												$Four</a>
												</li>
												<li><a href="#">5 Star
														<i class="fa fa-star"></i>
														<i class="fa fa-star"></i>
														<i class="fa fa-star"></i>
														<i class="fa fa-star"></i>
														<i class="fa fa-star"></i>
													$Five</a>
												</li>
											</ul>
										</div>
										
										<div class="d-flex " style="gap:10px;">
											<label for="filter" class="mt-2">Urutkan</label>
											<form id="rating-filter-form" action="" method="get">
												<select name="sort" id="rating-filter" class="selectpicker" onchange="saveSelectionAndSubmit()" style="display:block !important;">
													<option value="Latest">Latest</option>
													<option value="Highest Rating">Highest Rating</option>
													<option value="Lowest Rating">Lowest Rating</option>
												</select>
											</form>
										</div>
									</div>
								</div>
								<div class="review_list" id="filtered">
									<div id="Rating" name="Rating">
										<% loop $Ratings %>
											<div class="review_item">
												<div class="media">
													<div class="d-flex">
														<% with $Member %>
															<% if $ProfileImage.exists %>
																<img class="image" id="image" src="$ProfileImage.getURL()" alt="$Name's profile image">
															<% else %>
																<img class="image" id="image" src="$SiteConfig.Unknown.getURL()" alt="Default image">
															<% end_if %>
														<% end_with %>
													</div>
													<div class="media-body">
														<h4>$Member.FirstName</h4>
														<% loop $FilledStars %>
															<i class="fa fa-star"></i>
														<% end_loop %>
														<% loop $EmptyStars %>
															<i class="fa fa-star-o"></i>
														<% end_loop %>
													</div>
												</div>
												<p>$Message</p>
											</div>
										<% end_loop %>
										
								</div>
										<% with  $Ratings %>
											<nav class="blog-pagination justify-content-center d-flex " style="left: 50%;padding: 0 !important;">
												<% if $MoreThanOnePage %>
													<ul class="pagination">
														<% if $NotFirstPage %>
															<li class="page-item">
																<a href="#" class="page-link" aria-label="Previous">
																	<span aria-hidden="true">
																		<span class="lnr lnr-chevron-left"></span>
																	</span>
																</a>
															</li>
														<% end_if %>
														<% loop $PaginationSummary(10) %>
														<li class="page-item " style="list-style-type: none; ">
															<% if $Link %>
																<a class="page-link "
																   href="$Link">$PageNum</a>
															<% else %>
																<span class="bg-secondary ">...</span>
															<% end_if %>
														</li>
													<% end_loop %>
											
														<% if $NotLastPage %>
															<li class="page-item">
																<a href="#" class="page-link" aria-label="Next">
																	<span aria-hidden="true">
																		<span class="lnr lnr-chevron-right"></span>
																	</span>
																</a>
															</li>
														<% end_if %>
													</ul>
												<% end_if %>
											</nav>
											<% end_with %>
								</div>
							</div>
							<div class="col-lg-6">
								<div class="review_box">
									<h4>Add a Review</h4>
									<p>Your Rating:</p>
									<div class="d-flex">
										<div class="rating d-none">
											<span id="rating">0</span>/5
										</div>
										<div class="stars " id="stars">
											<span class="star" data-value="1"><i class="fa fa-star"></i></span>
											<span class="star" data-value="2"><i class="fa fa-star"></i></span>
											<span class="star" data-value="3"><i class="fa fa-star"></i></span>
											<span class="star" data-value="4"><i class="fa fa-star"></i></span>
											<span class="star" data-value="5"><i class="fa fa-star"></i></span>
										</div>
									</div>
									<form class="row contact_form" method="post" id="reviewform">
										<div class="col-md-12">
											<div class="form-group">
												<textarea class="form-control" name="reviewmsg" id="reviewmsg" rows="1"
													placeholder="Review" onfocus="this.placeholder = ''"
													onblur="this.placeholder = 'Review'" required></textarea>
												<input type="hidden" id="ratingValue" name="ratingValue" value="0">
												<input type="hidden" id="ID" name="ID" value="$ID">
											</div>
										</div>
										<div class="col-md-12 text-right">
											<button type="submit" value="submit" class="primary-btn">Submit Now</button>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!--================End Product Description Area =================-->

		<!-- Start related-product Area -->
		<section class="related-product-area section_gap_bottom">
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-lg-6 text-center">
						<div class="section-title">
							<h1>Deals of the Week</h1>
							<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
								incididunt ut labore et dolore
								magna aliqua.</p>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-9">
						<div class="row">
							<div class="col-lg-4 col-md-4 col-sm-6 mb-20">
								<div class="single-related-product d-flex">
									<a href="#"><img src="" alt=""></a>
									<div class="desc">
										<a href="#" class="title">Black lace Heels</a>
										<div class="price">
											<h6>$189.00</h6>
											<h6 class="l-through">$210.00</h6>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-4 col-md-4 col-sm-6 mb-20">
								<div class="single-related-product d-flex">
									<a href="#"><img src="" alt=""></a>
									<div class="desc">
										<a href="#" class="title">Black lace Heels</a>
										<div class="price">
											<h6>$189.00</h6>
											<h6 class="l-through">$210.00</h6>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-4 col-md-4 col-sm-6 mb-20">
								<div class="single-related-product d-flex">
									<a href="#"><img src="" alt=""></a>
									<div class="desc">
										<a href="#" class="title">Black lace Heels</a>
										<div class="price">
											<h6>$189.00</h6>
											<h6 class="l-through">$210.00</h6>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-4 col-md-4 col-sm-6 mb-20">
								<div class="single-related-product d-flex">
									<a href="#"><img src="" alt=""></a>
									<div class="desc">
										<a href="#" class="title">Black lace Heels</a>
										<div class="price">
											<h6>$189.00</h6>
											<h6 class="l-through">$210.00</h6>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-4 col-md-4 col-sm-6 mb-20">
								<div class="single-related-product d-flex">
									<a href="#"><img src="" alt=""></a>
									<div class="desc">
										<a href="#" class="title">Black lace Heels</a>
										<div class="price">
											<h6>$189.00</h6>
											<h6 class="l-through">$210.00</h6>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-4 col-md-4 col-sm-6 mb-20">
								<div class="single-related-product d-flex">
									<a href="#"><img src="" alt=""></a>
									<div class="desc">
										<a href="#" class="title">Black lace Heels</a>
										<div class="price">
											<h6>$189.00</h6>
											<h6 class="l-through">$210.00</h6>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-4 col-md-4 col-sm-6">
								<div class="single-related-product d-flex">
									<a href="#"><img src="" alt=""></a>
									<div class="desc">
										<a href="#" class="title">Black lace Heels</a>
										<div class="price">
											<h6>$189.00</h6>
											<h6 class="l-through">$210.00</h6>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-4 col-md-4 col-sm-6">
								<div class="single-related-product d-flex">
									<a href="#"><img src="" alt=""></a>
									<div class="desc">
										<a href="#" class="title">Black lace Heels</a>
										<div class="price">
											<h6>$189.00</h6>
											<h6 class="l-through">$210.00</h6>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-4 col-md-4 col-sm-6">
								<div class="single-related-product d-flex">
									<a href="#"><img src="" alt=""></a>
									<div class="desc">
										<a href="#" class="title">Black lace Heels</a>
										<div class="price">
											<h6>$189.00</h6>
											<h6 class="l-through">$210.00</h6>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-3">
						<div class="ctg-right">
							<a href="#" target="_blank">
								<img class="img-fluid d-block mx-auto" src="$SiteConfig.SuperSaleImage.getURL()" alt="">
							</a>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- End related-product Area -->

		<%-- Modal --%>
			<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
				aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">New message to </h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<form method="post" id="productcommentreply">
							<div class="modal-body">
								<div class="form-group">
									<input type="hidden" id="productcommentid-reply" name="productcommentid-reply"
										value="">
									<input type="hidden" id="nama-reply" name="nama-reply" value="">
									<input type="hidden" id="ProductObjectID" name="ProductObjectID" value="$ID">
									<label for="message-text" class="col-form-label">Message:</label>
									<textarea class="form-control" id="message-reply" required></textarea>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary "
									style="position: relative;overflow: hidden;color: #fff;padding: 0 30px;line-height: 50px;border-radius: 50px;display: inline-block;text-transform: uppercase;font-weight: 500;cursor: pointer;"
									data-dismiss="modal">Close</button>
								<button type="submit" class="primary-btn">Send message</button>
							</div>
						</form>
					</div>
				</div>
			</div>
			<% else %>
			<p class="d-flex justify-content-center">Product Invalid</p>
			<% end_if %>

		<script>
			const savedSort = localStorage.getItem('selectedSort');
			if (savedSort) {
				document.getElementById('rating-filter').value = savedSort;
				$("option").addClass("selected");
				}		
				$('.nav-item#shop').addClass('active');
		</script>