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
<section class="checkout_area section_gap" id="checkout_area">
    <div class="container">
        <% if $CheckoutProductData %>
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
                <form method="post" id="Couponform">

                    <input type="text" placeholder="Enter coupon code" id="Couponin" name="Coupon" value="">
                <button  type="submit" class="tp_btn"  >Apply Coupon</button>
                </form>
            </div>
            <div class="billing_details">
                <div class="row">
                    <div class="col-lg-6">
                        <h3>Billing Details</h3>
                        <form class="row contact_form" action="#" method="post" novalidate="novalidate" id="checkout-form">
                            <div class="col-md-6 form-group p_star">
                                <input type="text" class="form-control" id="first" name="name" placeholder="First Name" <% if $CheckoutProductData %>value=$Member.FirstName<% end_if %>>
                            </div>
                            <div class="col-md-6 form-group p_star">
                                <input type="text" class="form-control" id="last" name="name"  placeholder="Last Name" <% if $CheckoutProductData %>value=$Member.Surname<% end_if %>>
                            </div>
                            <%-- <div class="col-md-12 form-group">
                                <input type="text" class="form-control" id="company" name="company" placeholder="Company name">
                            </div> --%>
                            <div class="col-md-6 form-group p_star">
                                <input type="text" class="form-control" id="numberinput" name="numberinput" placeholder="Phone" required maxlength="14" minlength="12" value="<% if $AddressData %><% loop $AddressData %>$Number<% end_loop %><% end_if %>">
                            </div>
                            <div class="col-md-6 form-group p_star">
                                <input type="text" class="form-control" id="email" name="compemailany"  placeholder="Email" <% if $CheckoutProductData %>value=$Member.Email<% end_if %>>
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
                                    <div class="singlecheckoutpervendor px-4 py-3 mt-2"style="background-color: #fff; border-radius: 10px;">
                                        <li style="font-weight: 500;" id="vendorIDProductCheckout" data-vendor="$Vendor.ID"><i class='bx bx-store'></i> $Vendor.Name</li>
                                        <% loop $Products %>
                                            <li class="listDataProduct">
                                                <a>$ProductTitle <% if $ProductVariant %>($ProductVariant)<% end_if %> 
                                                    <span class="last" id="variantP" data-weight="$ProductVariantWeight" data-price="$ProductPrice">x $ProductQuantity &nbsp;&nbsp; $ProductPrice</span>
                                                </a>
                                                <p class="d-none" id="productID">$ProductID</p>
                                                <p class="d-none" id="vendorID">$VendorID</p>
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
                                        <li class="listDataProduct">
                                            <a>Pengiriman
                                                <span class="last" id="TotalShippingPerVendor" data-weight="$ProductVariantWeight">&nbsp;&nbsp; $ProductPrice</span>
                                                <span class="d-none" id="TotalShippingPerVendorNF" data-weight="$ProductVariantWeight">&nbsp;&nbsp; $ProductPrice</span>
                                            </a>
                                            <a style="border-bottom: none;">Total Pesanan
                                                <span class="last" id="TotalPerVendor" data-weight="$ProductVariantWeight">&nbsp;&nbsp; $ProductPrice</span>
                                            </a>
                                        </li>
                                    </div>
                                <% end_loop %>
                            </ul>
                            <ul class="list list_2 pt-3">
                                <label id="time" class="d-none"></label>
                                <label id="orderID" class="d-none"></label>
                                <li><a>Subtotal <span id="subTotalPriceProduct"></span></a></li>
                                <li>
                                    <a>Diskon 
                                        <span id="Diskon">
                                    <% if $Diskon %>
                                        <% loop $Diskon %> 
                                            $Diskon %
                                        <% end_loop %>
                                    <% end_if %>
                                        0%
                                    <% end_if %>
                                        </span>
                                    </a>
                                </li>
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
        <% else %>
            <h5 class="m-0 d-flex justify-content-center ">Lakukan Checkout Product!</h5>
        <% end_if %>
    </div>
</section>
<section class="invoice_payment" id="invoice_payment" style="max-width: 600px; margin: 40px auto; background-color: #f7f7f7; border: 1px solid #e0e0e0; border-radius: 12px; padding: 25px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <p>sdsdfsdfsdfss</p>
    <% with $CheckoutHeader %>
        <% if $ProofImage.exists %>
            <h2 style="text-align: center; color: #333; font-size: 24px; font-weight: bold; margin-bottom: 20px;">Pembayaran</h2>
            <% if $Bank == 'BCA' %>
                <div class="d-flex justify-content-between">
                    <div class="d-flex">
                        <div class="col-2 p-2" style="background-color: #fff; border-radius: 20px;">
                            <img src="public/_resources/themes/simple/images/banner/Logo-BCA-PNG.png" class="img-fluid">
                        </div>
                        <div class="pl-3 d-flex flex-column justify-content-center">
                            <h6 class="m-0" style="margin: 5px 0; color: #333;">$Bank</h6>
                            <h6 class="m-0 py-1" style="margin: 5px 0; color: #333;">$SiteConfig.Title</h6>
                        </div>
                    </div>
                    <div class="d-flex align-items-center">
                        <i class='bx bxs-check-circle' style="color: darkorange; font-size: 40px;"></i>
                    </div>
                </div>
                <label class="mt-3 py-2 px-3" style="position: relative; background-color: #fff; border-radius: 20px; width: 100%;"><h6 class="m-0" style="color: #000;">12345678</h6><i class='bx bx-copy' style="position: absolute; top: 10px; right: 15px; font-size: 20px; cursor: pointer;"></i></label>
            <% else_if $Bank == 'BRI' %>
                <div class="d-flex justify-content-between">
                    <div class="d-flex">
                        <div class="col-2 p-2" style="background-color: #fff; border-radius: 20px;">
                            <img src="public/_resources/themes/simple/images/banner/Logo-BCA-PNG.png" class="img-fluid">
                        </div>
                        <div class="pl-3 d-flex flex-column justify-content-center">
                            <h6 class="m-0" style="margin: 5px 0; color: #333;">$Bank</h6>
                            <h6 class="m-0 py-1" style="margin: 5px 0; color: #333;">$SiteConfig.Title</h6>
                        </div>
                    </div>
                    <div class="d-flex align-items-center">
                        <i class='bx bxs-check-circle' style="color: darkorange; font-size: 40px;"></i>
                    </div>
                </div>
                <label class="mt-3 py-2 px-3" style="position: relative; background-color: #fff; border-radius: 20px; width: 100%;"><h6 class="m-0" style="color: #000;">123456789</h6><i class='bx bx-copy' style="position: absolute; top: 10px; right: 15px; font-size: 20px; cursor: pointer;"></i></label>
            <% else_if $Bank == 'Mandiri' %>
                <div class="d-flex justify-content-between">
                    <div class="d-flex">
                        <div class="col-2 p-2" style="background-color: #fff; border-radius: 20px;">
                            <img src="public/_resources/themes/simple/images/banner/Logo-BCA-PNG.png" class="img-fluid">
                        </div>
                        <div class="pl-3 d-flex flex-column justify-content-center">
                            <h6 class="m-0" style="margin: 5px 0; color: #333;">$Bank</h6>
                            <h6 class="m-0 py-1" style="margin: 5px 0; color: #333;">$SiteConfig.Title</h6>
                        </div>
                    </div>
                    <div class="d-flex align-items-center">
                        <i class='bx bxs-check-circle' style="color: darkorange; font-size: 40px;"></i>
                    </div>
                </div>
                <label class="mt-3 py-2 px-3" style="position: relative; background-color: #fff; border-radius: 20px; width: 100%;"><h6 class="m-0" style="color: #000;">12345678910</h6><i class='bx bx-copy' style="position: absolute; top: 10px; right: 15px; font-size: 20px; cursor: pointer;"></i></label>
            <% end_if %>

            <div class="pt-3" style="margin-bottom: 30px;">
                <h3 style="color: #666; font-size: 18px; border-bottom: 1px solid #ddd; padding-bottom: 10px; margin-bottom: 15px;">Detail Pembayaran</h3>
                <p style="margin: 8px 0; color: #333;"><strong>Invoice:</strong></p>
                <label class="mt-1 py-2 px-3" style="position: relative; background-color: #fff; border-radius: 20px; width: 100%;"><h6 class="m-0" style="color: #404040;">$OrderID</h6><i class='bx bx-copy' style="position: absolute; top: 10px; right: 15px; font-size: 20px; cursor: pointer;"></i></label>
                <p style="margin: 8px 0; color: #333;"><strong>Nama:</strong></p>
                <label class="mt-1 py-2 px-3" style="position: relative; background-color: #fff; border-radius: 20px; width: 100%;"><h6 class="m-0" style="color: #404040;">$CustomerName</h6></label>
                <p style="margin: 8px 0; color: #333;"><strong>Total Pembayaran:</strong></p>
                <label class="mt-1 py-2 px-3" style="position: relative; background-color: #fff; border-radius: 20px; width: 100%;"><h6 class="m-0" style="color: #404040;">$FinalPrice</h6></label>
            </div>

            <div style="margin-bottom: 30px;">
                <h3 style="color: #666; font-size: 18px; border-bottom: 1px solid #ddd; padding-bottom: 10px; margin-bottom: 15px;">Bukti Pembayaran</h3>
                <a class="d-flex justify-content-center" data-toggle="modal" data-target="#imageModal" style="cursor: pointer;">
                    <div class="col-5 p-0">
                        <img src="$ProofImage.URL" class="img-fluid">
                    </div>
                </a>
                <div class="modal fade" id="imageModal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content" style="background: none; border: none;">
                            <div class="modal-header" style="border-bottom: none;">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body" style="background: none;">
                                <img id="modal-image" src="$ProofImage.URL" class="img-fluid" style="width: 100%; height: auto;"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <% else %>
            <h2 style="text-align: center; color: #333; font-size: 24px; font-weight: bold; margin-bottom: 20px;">Pembayaran</h2>
            
            <% if $Bank == 'BCA' %>
                <div class="d-flex">
                    <div class="col-2 p-2" style="background-color: #fff; border-radius: 20px;">
                        <img src="public/_resources/themes/simple/images/banner/Logo-BCA-PNG.png" class="img-fluid">
                    </div>
                    <div class="pl-3 d-flex flex-column justify-content-center">
                        <h6 class="m-0" style="margin: 5px 0; color: #333;">$Bank</h6>
                        <h6 class="m-0 py-1" style="margin: 5px 0; color: #333;">$SiteConfig.Title</h6>
                    </div>
                </div>
                <label class="mt-3 py-2 px-3" style="position: relative; background-color: #fff; border-radius: 20px; width: 100%;"><h6 class="m-0" style="color: #000;">12345678</h6><i class='bx bx-copy' style="position: absolute; top: 10px; right: 15px; font-size: 20px; cursor: pointer;"></i></label>
            <% else_if $Bank == 'BRI' %>
                <div class="d-flex">
                    <div class="col-2 p-2" style="background-color: #fff; border-radius: 20px;">
                        <img src="public/_resources/themes/simple/images/banner/logo-bri-png-transparan-jasalogocepat-01.png" class="img-fluid">
                    </div>
                    <div class="pl-3 d-flex flex-column justify-content-center">
                        <h6 class="m-0" style="margin: 5px 0; color: #333;">$Bank</h6>
                        <h6 class="m-0" style="margin: 5px 0; color: #333;">123456789</h6>
                        <h6 class="m-0 py-1" style="margin: 5px 0; color: #333;">$SiteConfig.Title</h6>
                    </div>
                </div>
                <label class="mt-3 py-2 px-3" style="position: relative; background-color: #fff; border-radius: 20px; width: 100%;"><h6 class="m-0" style="color: #000;">123456789</h6><i class='bx bx-copy' style="position: absolute; top: 10px; right: 15px; font-size: 20px; cursor: pointer;"></i></label>
            <% else_if $Bank == 'Mandiri' %>
                <div class="d-flex">
                    <div class="col-2 p-2" style="background-color: #fff; border-radius: 20px;">
                        <img src="public/_resources/themes/simple/images/banner/png-clipart-logo-bank-mandiri-credit-card-bank-text-logo.png" class="img-fluid">
                    </div>
                    <div class="pl-3 d-flex flex-column justify-content-center">
                        <h6 class="m-0" style="margin: 5px 0; color: #333;">$Bank</h6>
                        <h6 class="m-0 py-1" style="margin: 5px 0; color: #333;">$SiteConfig.Title</h6>
                    </div>
                </div>
                <label class="mt-3 py-2 px-3" style="position: relative; background-color: #fff; border-radius: 20px; width: 100%;"><h6 class="m-0" style="color: #000;">12345678910</h6><i class='bx bx-copy' style="position: absolute; top: 10px; right: 15px; font-size: 20px; cursor: pointer;"></i></label>
            <% end_if %>

            <div class="pt-3" style="margin-bottom: 30px;">
                <h3 style="color: #666; font-size: 18px; border-bottom: 1px solid #ddd; padding-bottom: 10px; margin-bottom: 15px;">Detail Pembayaran</h3>
                <p style="margin: 8px 0; color: #333;"><strong>Invoice:</strong></p>
                <label class="mt-1 py-2 px-3" style="position: relative; background-color: #fff; border-radius: 20px; width: 100%;"><h6 class="m-0" style="color: #404040;"></h6>$OrderID<i class='bx bx-copy' style="position: absolute; top: 10px; right: 15px; font-size: 20px; cursor: pointer;"></i></label>
                <p style="margin: 8px 0; color: #333;"><strong>Nama:</strong></p>
                <label class="mt-1 py-2 px-3" style="position: relative; background-color: #fff; border-radius: 20px; width: 100%;"><h6 class="m-0" style="color: #404040;">$CustomerName</h6></label>
                <p style="margin: 8px 0; color: #333;"><strong>Total Pembayaran:</strong></p>
                <label class="mt-1 py-2 px-3" style="position: relative; background-color: #fff; border-radius: 20px; width: 100%;"><h6 class="m-0" style="color: #404040;">$FinalPrice</h6></label>
            </div>

            <div style="margin-bottom: 30px;">
                <h3 style="color: #666; font-size: 18px; border-bottom: 1px solid #ddd; padding-bottom: 10px; margin-bottom: 15px;">Upload Bukti Pembayaran</h3>
                <a data-toggle="modal" data-target="#imageModal">
                    <img id="image-preview" style="display:none; width: 200px; cursor:pointer;"/>
                </a>
                <form id="payment_form" class="form-group d-grid py-2">
                    <div class="">
                        <label class="text-center genric-btn primary-border px-3 py-0" style="line-height: 30px;" for="transfer-image">Unggah</label>
                        <input class="d-none" type="file" id="transfer-image" name="transferImage" accept="image/*" required style="border:none;">
                    </div>
                </form>
                <div class="modal fade" id="imageModal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                        <div class="modal-content" style="background: none; border: none;">
                            <div class="modal-header" style="border-bottom: none;">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body" style="background: none;">
                                <img id="modal-image" src="" class="img-fluid" style="width: 100%; height: auto;"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div style="text-align: center;">
                <button class="primary-btn" style="border: none; border-radius: 0;" id="manualtfpaymentbtn" data-id="$OrderID">Kirim</button>
            </div>
        <% end_if %>
    <% end_with %>
</section>
<script>
    $('.nav-item#shop').addClass('active');
</script>
<!--================End Checkout Area =================-->