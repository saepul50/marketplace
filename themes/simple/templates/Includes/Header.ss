	<style>
		.bx-shopping-bag,
		.bx-chat,
		.bx-bell {
		position: relative;
		}

		.bx-shopping-bag .cart-count,
		.bx-chat .chat-count,
		.bx-bell .notification-count {
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
		.notip-item{
			background-color: #fff;
			transition: background-color .4s ease-out;
		}
		.notip-item:hover{
			background-color: whitesmoke;
		}
	</style>
<header class="header_area sticky-header">
	<div class="main_menu">
		<nav class="navbar navbar-expand-lg navbar-light main_box">
			<div class="container">
				 <% with $SiteConfig %>
				 <a class="navbar-brand logo_h" href="{$BaseHref}"><img src="$Image.getURL()" alt=""></a>
				 <% end_with %>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
				 aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
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
							</ul>
						</li>
						<li class="nav-item" id="blog"><a class="nav-link" href="{$BaseHref}/blog">Blog</a></li>
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
							<a href="{$BaseHref}/cart" class="cart" style="color: #000;">
								<span class="cart" style=" outline: none !important; box-shadow: none;"></span>
								<i class='bx bx-shopping-bag' style="font-size: 18px;"><% if $CartData %><span class="cart-count">$CartData</span><% end_if %></i>
							</a>
						</li>
						<li class="nav-item">
							<div id="chaticons" style="cursor: pointer;">
								<span class="chat" style=" outline: none !important; box-shadow: none;"></span>
								<i class='bx bx-chat' style="font-size: 18px;"><% if $ChatNotif %><span class="chat-count">$ChatNotif</span><% end_if %></i>
							</div>
						</li>
						<li class="nav-item submenu dropdown">
							<div class="notif" style="cursor: pointer;">
								<span class="notif" style=" outline: none !important; box-shadow: none;"></span>
								<i class='bx bx-bell' style="font-size: 18px;"><% if $Notification %><span class="notification-count">$Notification.Count</span> <% else %><% end_if %></i>
							</div>
							<div class="dropdown-menu dropdown-menu-right" id="fate" style=" width: 30rem;  padding-bottom: 0 !important;">
								<h5 class="text-muted m-0 py-2 pt-0 pl-4 pb-4">Notifikasi Baru Diterima</h5>
								<% if $Notification %>
									<% loop $Notification.Limit(8) %>
												<a href="{$BaseHref}/confirm/order/$Notification.HeaderCheckout.OrderID?detailOrder=true" style="color: #000;">
													<div class="notifs d-flex align-items-center justify-content-between p-2"  style="border-bottom: 1px solid #ddd; background-color: rgba(255, 165, 0, 0.04);">
														<div class="d-flex align-items-center">
															<div class="col-3">
																<% if $HeaderCheckout.Items.First %>
																	<% loop $HeaderCheckout.Items.First %>
																		<img src="$ProductImage" class="img-fluid">
																	<% end_loop %>
																<% end_if %>
															</div>
															<div class="content ml-4 d-flex ">
																<div style="inline-size: 100%; overflow-wrap: break-word;">
																	<h6 class="header fw-bold" style="font-weight: bold;">$Title</h6>
																	<p class="deskripsi m-0" style="font-size: 14px;">$Message</p>
																</div>
															</div>
														</div>
														<div class="">
															<a href="{$BaseHref}/confirm/order/$HeaderCheckout.OrderID?detailOrder=true" style="color: #000"><i class='bx bx-chevron-down' style="font-size: 40px;"></i></a>
														</div>
													</div>
												</a>
									<% end_loop %>
								<% end_if %>
								<a href="{$BaseHref}/usernotif" class="text-center " style="color:black;">
									<div class="text-center" style="border-top: 1px solid rgba(0, 0, 0, .09);border-bottom: 1px solid rgba(0, 0, 0, .09);padding: 5px;">
										Tampilkan Semua
									</div>
								</a>
							</div>
						</li>
						<li class="nav-item">
							<span class="search" style=" outline: none !important; box-shadow: none;"></span>
							<i class='bx bx-search' style="font-size: 18px;" id="search"></i>
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
		<div id="search_history" class="search_input pt-5" style="position: fixed; padding-bottom: .01rem; background-color: #fff; text-align: left; box-shadow: 0px 0px 5px #fff; width: 100%; max-width: 1200px; left: 50%; transform: translateX(-50%);">
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