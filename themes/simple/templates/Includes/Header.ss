	<style>
		.ti-bag {
		position: relative;
		}

		.ti-bag .cart-count {
			position: absolute;
			display: flex;
			justify-content: center;
			align-items: flex-start;
			width: 18px;
			height: 18px;
			line-height: 1rem !important;
			top: -8px;
			right: -10px; 
			background-color: red;
			border-radius: 50%;
			color: #fff !important; 
			font-size: 14px;
			font-weight: bold;
		}

		
		#history_list li.selected{
			background-color: #f5f5f5 !important;
		}
		.notip-item:hover{
			background-color:whitesmoke;
			color:black;
		}
		.badge {
			position: absolute;
			display: flex;
			justify-content: center;
			align-items: flex-start;
			width: 18px;
			height: 17px;
			line-height: 0.8em !important;
			top: 24px;
			right: -7px;
			background-color: red;
			border-radius: 50%;
			color: #fff !important;
			font-size: 14px;
			font-weight: bold;
		}
	</style>
<header class="header_area sticky-header">
	<div class="main_menu">
		<nav class="navbar navbar-expand-lg navbar-light main_box">
			<div class="container">
				<!-- Brand and toggle get grouped for better mobile display -->
				 <% with $SiteConfig %>
				 <a class="navbar-brand logo_h" href="{$BaseHref}"><img src="$Image.getURL()" alt=""></a>
				 <% end_with %>
				 <%-- <a href="$LogoutURL">ppp</a> --%>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
				 aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse offset" id="navbarSupportedContent">
					<ul class="nav navbar-nav menu_nav ml-auto">
						<li class="nav-item" id="home"><a class="nav-link" href="">Home</a></li>
						<li class="nav-item submenu dropdown" id="shop">
							<a href="" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
							 aria-expanded="false">Shop</a>
							<ul class="dropdown-menu">
								<li class="nav-item shopcategory productdetails productcheckout cart confirm" id=""><a class="nav-link" href="{$BaseHref}/shopcategory">Shop Category</a></li>
								<li class="nav-item"><a class="nav-link" href="{$BaseHref}/productdetails">Product Details</a></li>
								<li class="nav-item"><a class="nav-link" href="{$BaseHref}/productcheckout">Product Checkout</a></li>
								<li class="nav-item"><a class="nav-link" href="{$BaseHref}/cart">Shopping Cart</a></li>
								<li class="nav-item"><a class="nav-link" href="{$BaseHref}/confirm">Shopping History</a></li>
								<li class="nav-item"><a class="nav-link" href="{$BaseHref}/shopresult">Shopping Result</a></li>
							</ul>
						</li>
						<li class="nav-item submenu dropdown" id="blog">
							<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
							 aria-expanded="false">Blog</a>
							<ul class="dropdown-menu">
								<li class="nav-item"><a class="nav-link" href="{$BaseHref}/blog">Blog</a></li>
								<%-- <li class="nav-item"><a class="nav-link" href="{$BaseHref}/blog-detail">Blog Details</a></li> --%>
							</ul>
						</li>
						<li class="nav-item submenu dropdown" id="pages">
							<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
							 aria-expanded="false">Pages</a>
							<ul class="dropdown-menu">
								<li class="nav-item"><a class="nav-link" href="{$BaseHref}/login">Login</a></li>
								<li class="nav-item"><a class="nav-link" href="{$BaseHref}/tracking">Tracking</a></li>
							</ul>
						</li>
						<li class="nav-item" id="contact"><a class="nav-link" href="{$BaseHref}/contact">Contact</a></li>
						<li class="nav-item" id="profile"><a class="nav-link" href="{$BaseHref}/profile">Profile</a></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li class="nav-item">
							<a href="{$BaseHref}/cart" class="cart">
								<span class="ti-bag"><% if $CartData %><span class="cart-count">$CartData</span><% end_if %></span>
							</a>
						</li>
						<li class="nav-item">
						<span class="search" style=" outline: none !important; box-shadow: none;"></span>
							<span class="lnr lnr-magnifier " id="search"></span>
						</li>
						<li class="nav-item submenu dropdown">
							<div class="cart">
								<span class="ti-bell"><% if $CountNotif %><span class="badge">$CountNotif</span> <% else %>	 <% end_if %></span>
							</div>
							<div class="dropdown-menu dropdown-menu-right" id="fate" style=" width: 30rem;  padding-bottom: 0 !important;">
									<h5 class="text-muted " style="padding:10px;">Notifikasi Baru Diterima</h5>
									<% if  $nepo %>
									<% loop $Notif.Limit(8) %>
										<% if $Status == 'Dikemas' %>
											<a href="{$BaseHref}/confirm/order/$Order/$ID?detailOrder=true" style="color: black !important">
											<div class=" d-flex p-2  notip-item  mt-2">
												<div class="content  d-flex justify-content-between " style="width:85%;">
													<div style="inline-size: 100%; overflow-wrap: break-word;">
														<h6 class="header fw-bol ml-2" style="font-weight:bold;">Pesanan Anda Sudah Dikemas Dan Siap Dikirim</h6>
													</div>
												</div>
											</div>
											</a>
										<% else_if  $Status == 'Dikirim' %>
											<a href="{$BaseHref}/confirm/order/$Order/$ID?detailOrder=true" style="color: black !important">
											<div class=" d-flex    p-2  notip-item mt-2">
												<div class="content  d-flex justify-content-between " style="width:85%;">
													<div style="inline-size: 100%; overflow-wrap: break-word;">
														<h6 class="header fw-bold ml-2" style="font-weight:bold;">Pesanan Anda Sudah Diberikan ke Jasa Pengantaran</h6>
														
													</div>
												</div>
											</div>
											</a>
										<% else_if  $Status == 'Selesai' %>
											<a href="{$BaseHref}/confirm/order/$Order/$ID?detailOrder=true" style="color: black !important">
											<div class=" d-flex   p-2 notip-item mt-2">
												<div class="content  d-flex justify-content-between " style="width:85%;">
													<div style="inline-size: 100%; overflow-wrap: break-word;">
														<h6 class="header fw-bold ml-2" style="font-weight:bold;">Pesanan Anda Sudah Sampai Ditujuan </h6>
														
													</div>
												</div>
											</div>
											</a>
										<% else_if  $Status == 'Dibatalkan' %>
											<a href="{$BaseHref}/confirm/order/$Order/$ID?detailOrder=true" style="color: black !important">
											<div class=" d-flex  p-2 notip-item  mt-2">
												<div class="content  d-flex justify-content-between " style="width:85%;">
													<div style="inline-size: 100%; overflow-wrap: break-word;">
														<h6 class="header fw-bold ml-2" style="font-weight:bold;">Waduh Maaf Ya Orderan Kamu Dibatalkan  </h6>

													</div>
												</div>
											</div>
											</a>
										<% end_if %>
									<% end_loop %>
								
								<% end_if %>
								<a href="{$BaseHref}/usernotif" class="text-center " style="color:black;">
									<div class="text-center" style="border-top: 1px solid rgba(0, 0, 0, .09);border-bottom: 1px solid rgba(0, 0, 0, .09);padding: 5px;">
										Tampilkan Semua
									</div>
								</a>
							</div>
						</li>
						</ul>
					</div>
				</div>
			</nav>
		</div>
		<div id="search_column">
			<div class="search_input mb-5" id="search_input_box">
				<div class="container">
					<form class="d-flex justify-content-between" id="searchForm">
						<input type="text" class="form-control" id="search_input" placeholder="Search Here">
						<button type="submit" class="btn"></button>
						<span class="lnr lnr-cross" id="close_search" title="Close Search"></span>
					</form>
				</div>
			</div>
			<div id="search_history" class="search_input pt-5" style="padding-bottom: .01rem; background-color: #fff; text-align: left; box-shadow: 0px 0px 5px #fff;">
				<div class="container">
					<ul id="history_list">
						<% loop $ProductObjects %>
							
						<% end_loop %> 
					</ul>
				</div>
			</div>
		</div>
	</header>
	<!-- End Header Area -->