  <!-- Start Banner Area -->
  <section class="banner-area organic-breadcrumb" style ="background: url($SiteConfig.Background.getURL()) center no-repeat;background-size: cover; position: relative ">
    <div class="container">
        <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
            <div class="col-first">
                <h1>Checkout</h1>
                <nav class="d-flex align-items-center">
                    <a href="{$BaseHref}">Home<span class="lnr lnr-arrow-right"></span></a>
                    <a href="{$BaseHref}/productdetails">Checkout</a>
                </nav>
            </div>
        </div>
    </div>
</section>
<!-- End Banner Area -->

<!--================Checkout Area =================-->
<section class="checkout_area section_gap">
    <div class="container">
        <%-- <div class="returning_customer">
            <div class="check_title">
                <h2>Returning Customer? <a href="{$BaseHref}/login">Click here to login</a></h2>
            </div>
            <p>If you have shopped with us before, please enter your details in the boxes below. If you are a new
                customer, please proceed to the Billing & Shipping section.</p>
            <form class="row contact_form" action="#" method="post" novalidate="novalidate">
                <div class="col-md-6 form-group p_star">
                    <input type="text" class="form-control" id="name" name="name" placeholder="Email">

                </div>
                <div class="col-md-6 form-group p_star">
                    <input type="password" class="form-control" id="password" name="password"  placeholder="Password">
                </div>
                <div class="col-md-12 form-group">
                    <button type="submit" value="submit" class="primary-btn">login</button>
                    <div class="creat_account">
                        <input type="checkbox" id="f-option" name="selector">
                        <label for="f-option">Remember me</label>
                    </div>
                    <a class="lost_pass" href="#">Lost your password?</a>
                </div>
            </form>
        </div> --%>
        <div class="cupon_area">
            <div class="check_title">
                <h2>Have a coupon? <a>Enter your code below</a></h2>
            </div>
            <input type="text" placeholder="Enter coupon code">
            <a class="tp_btn" href="#">Apply Coupon</a>
        </div>
        <div class="billing_details">
            <div class="row">
                <div class="col-lg-6">
                    <h3>Billing Details</h3>
                    <form class="row contact_form" action="#" method="post" novalidate="novalidate" id="checkout-form">
                        <div class="col-md-6 form-group p_star">
                            <input type="text" class="form-control" id="first" name="name" placeholder="First Name" <% if $CheckoutProductData %>value=<% loop $CheckoutProductData %>"$MemberFirstname"<% end_loop %><% end_if %>>
                        </div>
                        <div class="col-md-6 form-group p_star">
                            <input type="text" class="form-control" id="last" name="name"  placeholder="Last Name" <% if $CheckoutProductData %>value=<% loop $CheckoutProductData %>"$MemberLastname"<% end_loop %><% end_if %>>
                        </div>
                        <%-- <div class="col-md-12 form-group">
                            <input type="text" class="form-control" id="company" name="company" placeholder="Company name">
                        </div> --%>
                        <div class="col-md-6 form-group p_star">
                            <input type="text" class="form-control" id="numberinput" name="numberinput" placeholder="Phone" required maxlength="14" minlength="12" value="<% if $AddressData %><% loop $AddressData %>$Number<% end_loop %><% end_if %>">
                        </div>
                        <div class="col-md-6 form-group p_star">
                            <input type="text" class="form-control" id="email" name="compemailany"  placeholder="Email" <% if $CheckoutProductData %>value=<% loop $CheckoutProductData %>"$MemberEmail"<% end_loop %><% end_if %>>
                        </div>
                        <div class="col-md-12 form-group p_star">
                            <select class="country_select province_select">
                                <option value="0">Choose Province</option>
                                <ul class="list">
                                    
                                </ul>
                            </select>
                        </div>
                        <div class="col-md-12 form-group p_star">
                            <select class="country_select regency_select">
                                <option value="0">Choose regency</option>
                                <ul class="list">
                                    
                                </ul>
                            </select>
                        </div>
                        <div class="col-md-12 form-group p_star">
                            <input type="text" class="form-control" id="add1" name="add1"  placeholder="Address Details" value="<%  if $AddressData %><%  loop $AddressData %>$AddressDetail<% end_loop %><% end_if %>" required>
                        </div>
                        <%-- <div class="col-md-12 form-group p_star">
                            <input type="text" class="form-control" id="add2" name="add2"  placeholder="Address Line 2">
                        </div> --%>
                        <%-- <div class="col-md-12 form-group p_star">
                            <input type="text" class="form-control" id="city" name="city"  placeholder="Town/City">
                        </div> --%>
                        <div class="col-md-12 form-group">
                            <input type="text" class="form-control postalcode" id="zip" name="zip" placeholder="Postalcode" required value="<% if $AddressData %><% loop $AddressData %>$Postal<% end_loop %><% end_if %>">
                        </div>
                        <%-- <div class="col-md-12 form-group">
                            <div class="creat_account">
                                <input type="checkbox" id="f-option2" name="selector">
                                <label for="f-option2">Create an account?</label>
                            </div>
                        </div> --%>
                        <div class="col-md-12 form-group">
                            <%-- <div class="creat_account">
                                <h3>Shipping Details</h3>
                                <input type="checkbox" id="f-option3" name="selector">
                                <label for="f-option3">Ship to a different address?</label>
                            </div> --%>
                            <textarea class="form-control" name="message" id="message" rows="1" placeholder="Order Notes"></textarea>
                        </div>
                    </form>
                    <button style="border:none; border-radius: 0; font-size: 12px; padding: .8rem; line-height: .5rem" class="primary-btn" id="saveData">Save my data</button>
                </div>
                <div class="col-lg-6">
                    <div class="order_box">
                        <h2>Your Order</h2>
                        <ul class="list">
                            <li><a>Product <span>Total</span></a></li>
                            <% loop $CheckoutProductData %>
                                <li class="listDataProduct">
                                    <a>$ProductTitle <% if $ProductVariant %>($ProductVariant)<% end_if %> 
                                        <span class="last" id="variantP" data-weight="$ProductVariantWeight">x $ProductQuantity &nbsp;&nbsp; $ProductPrice</span>
                                    </a>
                                    <label id="time" class="d-none"></label>
                                    <label id="orderID" class=""></label>
                                    <p class="d-none" id="productID">$ProductID</p>
                                    <p class="d-none" id="productTitle">$ProductTitle</p>
                                    <p class="d-none" id="productCartID">$ProductCartID</p>
                                    <p class="d-none" id="productImage">$ProductImage</p>
                                    <p class="d-none" id="productVariant">$ProductVariant</p>
                                    <p class="d-none" id="productVariantID">$ProductVariantID</p>
                                    <p class="d-none" id="productPrice">$ProductPrice</p>
                                    <p class="d-none" id="productQuantity">$ProductQuantity</p>
                                    <p class="d-none" id="productTotalPrice">$ProductTotalPrice</p>
                                    <p class="d-none" id="productSubTotalPrice">$ProductSubTotalPrice</p>
                                    <p class="d-none" id="productSubTotalPriceNF">$ProductSubTotalNFPrice</p>
                                </li>
                            <% end_loop %>
                        </ul>
                        <ul class="list list_2">
                            <li><a>Subtotal <span id="subTotalPriceProduct"><% loop $CheckoutProductData %><% if $Pos == 1 %>$ProductSubTotalPrice<% end_if %><% end_loop %></span></a></li>
                            <%-- <li><a>Subtotal <span><% loop $CheckoutProductData %><% if $Pos == 1 %>$ProductSubTotalNFPrice<% end_if %><% end_loop %></span></a></li> --%>
                            <li><a>Shipping <span id="shippingProduct"></span></a></li>
                            <li class="d-none"><a><span id="shippingNFProduct"></span></a></li>
                            <li><a>Total <span id="finalPriceProduct"></span></a></li>
                            <li class="d-none"><a>Total <span id="finalPriceNFProduct"></span></a></li>
                        </ul>
                        <div class="payment_item py-2">
                            <div class="radion_btn">
                                <input type="radio" id="f-option5" name="selectordata">
                                <label for="f-option5">Check data pengiriman</label>
                                <div class="check"></div>
                            </div>
                            <div class="" id="fulldata">
                                <p class="customerName m-0 p-0 px-3 pt-3">Nama: <span><% if $AddressData %><% loop $AddressData %>$FName<% end_loop %><% end_if %></span></p>
                                <p class="customerFullName m-0 p-0 px-3">Nama lengkap: <span><% if $AddressData %><% loop $AddressData %>$FName $LName<% end_loop %><% end_if %></span></p>
                                <p class="customerEmail m-0 p-0 px-3">Email: <span><% if $CheckoutProductData %><% loop $CheckoutProductData %><% if $Pos == 1 %>$MemberEmail<% end_if %><% end_loop %><% end_if %></span></p>
                                <p class="customerHandphone m-0 p-0 px-3">Handphone: <span><% if $AddressData %><% loop $AddressData %>$Number<% end_loop %><% end_if %></span></p>
                                <p class="customerAddress m-0 p-0 px-3 pb-3">Alamat: <span><% if $AddressData %><% loop $AddressData %>$AddressDetail, $Address, $Postal<% end_loop %><% end_if %></span></p>
                                <p class="regency d-none"><% if $AddressData %><% loop $AddressData %>$Regency<% end_loop %><% end_if %></p>
                                <p class="province d-none"><% if $AddressData %><% loop $AddressData %>$Province<% end_loop %><% end_if %></p>
                            </div>
                        </div>
                        <div class="d-flex">
                            <div class="payment_item active">
                                <div class="radion_btn">
                                    <input type="radio" id="f-option9" name="selectorcourir" checked>
                                    <label for="f-option9" data-opt="jne">JNE </label>
                                    <div class="check"></div>
                                </div>
                            </div>
                            <div class="payment_item">
                                <div class="radion_btn">
                                    <input type="radio" id="f-option10" name="selectorcourir">
                                    <label for="f-option10" data-opt="pos">POS Indonesia </label>
                                    <div class="check"></div>
                                </div>
                            </div>
                            <div class="payment_item active">
                                <div class="radion_btn">
                                    <input type="radio" id="f-option11" name="selectorcourir">
                                    <label for="f-option11" data-opt="tiki">TIKI </label>
                                    <div class="check"></div>
                                </div>
                            </div>
                        </div>
                        <div class="payment_item">
                            <p class="">Courir Option<span class="d-flex flex-wrap rajoCostOption p-0 m-0 pt-2"></span></p>
                        </div>
                            
                        <div class="payment_item active">
                            <div class="radion_btn">
                                <input type="radio" id="f-option6" value="manualtf" name="selectorpayment" checked>
                                <label for="f-option6">Manual Transfer </label>
                                <img src="img/product/card.jpg" alt="">
                                <div class="check"></div>
                            </div>
                            <p class="nooption nooptionmanualtf">Pay via manual transfer with bank.</p>
                            <p class="optiondisplay optiondisplaymanualtf py-1">
                                <span id="norek"></span>
                                <span class="d-grid paymentOptionDisplayManual">
                                </span>
                            </p>
                        </div>
                        <div class="payment_item">
                            <div class="radion_btn">
                                <input type="radio" id="f-option7" value="duitku" name="selectorpayment">
                                <label for="f-option7">Duitku </label>
                                <img src="img/product/card.jpg" alt="">
                                <div class="check"></div>
                            </div>
                            <p class="nooption nooptionduitku">Pay via duitku with many payment method</p>
                            <p class="optiondisplay optiondisplayduitku py-1">
                                <span class="d-grid paymentOptionDisplayDuitku">
                                    
                                </span>
                            </p>
                        </div>
                        <div class="payment_item">
                            <div class="radion_btn">
                                <input type="radio" id="f-option8" value="cod" name="selectorpayment">
                                <label for="f-option8">Cash on Delivery </label>
                                <img src="img/product/card.jpg" alt="">
                                <div class="check"></div>
                            </div>
                            <p>Pay via Cash On Delivery</p>
                        </div>
                        <div class="creat_account">
                            <input type="checkbox" id="f-option4" name="terms">
                            <label for="f-option4">I’ve read and accept the </label>
                            <a href="#">terms & conditions*</a>
                        </div>
                        <button class="primary-btn" style="border: none;" type="submit" id="checkoutbtn" form="checkout-form">Checkout</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!--================End Checkout Area =================-->