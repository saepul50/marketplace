<style>
    .textarea:focus{
        box-shadow: none !important;
        border-color:black !important;
    }
    .coupon .kanan {
        border-left: 1px dashed #ddd;
        width: 40% !important;
        position:relative;
    }

    .coupon .kanan .info::after, .coupon .kanan .info::before {
        content: '';
        position: absolute;
        width: 20px;
        height: 20px;
        background: white;
        border-radius: 100%;
    }
    .coupon .kanan .info::before {
        top: -10px;
        left: -10px;
    }

    .coupon .kanan .info::after {
        bottom: -10px;
        left: -10px;
    }
    .coupon .time {
        font-size: 1.6rem;
    }
</style>
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
                                        <li style="font-weight: 500;" class="vendorIDProductCheckout" data-vendor="$Vendor.ID" data-origin="$Vendor.RegencyID"><i class='bx bx-store'></i> $Vendor.Name</li>
                                        <% loop $Products %>
                                            <li class="listDataProduct">
                                                <a>$ProductTitle <% if $ProductVariant %>($ProductVariant)<% end_if %> 
                                                    <span class="last variantP variantP-$Up.Vendor.ID" data-quantity="$ProductQuantity" data-weight="$ProductVariantWeight" data-price="$ProductPrice">x $ProductQuantity &nbsp;&nbsp; $ProductPrice</span>
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
                                            <a data-toggle="modal" data-target="#Notes-{$Vendor.ID}" style="cursor: pointer; position: relative;" class="">Notes
                                                <span class="m-0 NotesMessage" id="Notes-message-{$Vendor.ID}">&nbsp;</span>
                                            </a>
                                            <a data-toggle="modal" data-target="#OpsiPengiriman-$Vendor.ID" style="cursor: pointer; position: relative;" class="pl-3">Opsi Pengiriman<i class='bx bx-dots-vertical-rounded' style="position: absolute; top: 11px; left: 0px;"></i>
                                                <span class="m-0" id="OpsiSelect-$Vendor.ID">&nbsp;</span>
                                            </a>
                                        </li>
                                        <li class="listDataProduct">
                                            <a>Pengiriman
                                                <span class="last TotalShippingPerVendor TotalShippingPerVendor-$Vendor.ID" data-weight="$ProductVariantWeight">&nbsp;&nbsp; $ProductPrice</span>
                                            </a>
                                            <a data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Diskon 
                                                <span id="Diskon-$Vendor.ID">
                                                </span>
                                            </a>
                                            <div class="dropdown-menu container" style="width:35rem;">
                                                <h3 class="dropdown-header">Voucher Dari $Vendor.Name</h3>
                                                <div class="container">
                                                    <div class="search-code d-flex justify-content-around">
                                                        <p class="mt-1">Tambah Voucher</p>
                                                        <input type="text" name="code" class="code-coupon" placeholder="Kode Voucher Toko"
                                                            style="border: 1px solid #ccc; border-radius: 4px; padding: 8px;">
                                                        <input type="hidden" name="vendor" class="Vendor" id="Vendor" value="$Vendor.ID">
                                                        <button type="button" class="genric-btn primary-border search-coupon">Pakai</button>
                                                    </div>
                                                    <% if $Discounts %>
                                                    <%-- <p>$Discounts.Code</p> --%>
                                                    <%-- <p>ksfka</p> --%>
                                                    <div class="">
                                                        <% loop $Discounts %>
                                                            
                                                            <div class="coupon rounded mb-3 d-flex justify-content-between mt-4" style="background-color:#E9EED9;">
                                                                <div class="kiri p-3">
                                                                    <div class="icon-container">
                                                                        <div class="icon-container_box">
                                                                            <img src="data:image/png;base64,..." width="85" alt="coupon-icon" class="" />
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="tengah py-3 d-flex w-100 justify-content-start">
                                                                    <div>
                                                                        <span class="badge badge-success">Valid</span>
                                                                        <h3 class="lead pb-2 mb-0">$Diskon% Coupon</h3>
                                                                        <p class="text-muted mb-0">This Coupon Have Exp Date (<span data-date="$ExpDate" class="since">$ExpDate</span>) And Maximum use. Go Use it!!</p>
                                                                    </div>
                                                                </div>
                                                                <div class="kanan">
                                                                    <div class="info ml-3 mr-3 d-flex justify-content-center" style="margin-top: 2.7rem !important">
                                                                            <div class="form-check">
                                                                                <input class="form-check-input position-static" type="radio" 
                                                                                name="selectedCoupon" 
                                                                                id="blankRadio$ID"
                                                                                data-coupon-id="$Up.Vendor.ID" 
                                                                                data-diskon="$Diskon"
                                                                                style="height: 2rem; scale: 1.5; accent-color: orange;"
                                                                                aria-label="Coupon $Code" >
                                                                            </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        <% end_loop %>
                                                    </div>
                                                    <% end_if %>
                                                </div>
                                                <%-- <div class=" container dropdown-footer d-flex justify-content-end">
                                                    <button type="button" class="genric-btn primary-border " id="getDiskon">OK</button>
                                                </div> --%>
                                            </div>                                            
                                            <a style="border-bottom: none;">Total Pesanan
                                                <span class="last TotalPerVendor TotalPerVendor-$Vendor.ID" data-weight="$ProductVariantWeight">&nbsp;&nbsp; $ProductPrice</span>
                                            </a> 
                                        </li> 
                                        <div class="modal fade" id="OpsiPengiriman-$Vendor.ID" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                                                <div class="modal-content p-2">
                                                    <div class="modal-header" style="border-bottom: none;">
                                                        <h5 class="modal-title">Opsi Pengiriman</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body d-flex" style="height: 20rem;">
                                                        <div class="">
                                                            <div class="payment_item active">
                                                                <div class="radion_btn">
                                                                    <input type="radio" id="f-option9-$Vendor.ID" name="selectorcourir-$Vendor.ID" checked>
                                                                    <label for="f-option9-$Vendor.ID" data-opt="jne">JNE</label>
                                                                    <div class="check"></div>
                                                                </div>
                                                            </div>
                                                            <div class="payment_item">
                                                                <div class="radion_btn">
                                                                    <input type="radio" id="f-option10-$Vendor.ID" name="selectorcourir-$Vendor.ID">
                                                                    <label for="f-option10-$Vendor.ID" data-opt="pos">POS Indonesia</label>
                                                                    <div class="check"></div>
                                                                </div>
                                                            </div>
                                                            <div class="payment_item">
                                                                <div class="radion_btn">
                                                                    <input type="radio" id="f-option11-$Vendor.ID" name="selectorcourir-$Vendor.ID">
                                                                    <label for="f-option11-$Vendor.ID" data-opt="tiki">TIKI</label>
                                                                    <div class="check"></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="payment_item">
                                                            <p class="m-0 p-0">Courir Option<span class="rajoCostOption-$Vendor.ID p-0 m-0 pt-2"></span></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="modal fade" id="Notes-{$Vendor.ID}" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                                                <div class="modal-content p-2">
                                                    <div class="modal-header" style="border-bottom: none;">
                                                        <h5 class="modal-title">Notes Product</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body" style="height: 20rem;">
                                                        <form method="post" class="note-form" data-vendor-id="{$Vendor.ID}">
                                                            <textarea class="textarea form-control mb-2" style="height:15rem;" name="Notes" id="Notes-product-{$Vendor.ID}" rows="1" placeholder="Notes Product"></textarea>
                                                            <button type="submit" style="border:none; border-radius: 0; font-size: 12px; padding: .8rem; line-height: .5rem" class="primary-btn saveNote" data-vendor-id="{$Vendor.ID}">Add Notes</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div> 
                                                                           
                                    </div>
                                <% end_loop %>
                            </ul>
                            <ul class="list list_2 pt-3">
                                <label id="time" class="d-none"></label>
                                <label id="orderID" class="d-none"></label>
                                <li><a>Subtotal Produk <span id="subTotalPriceProduct"></span></a></li>
                                <%-- <li><a>Subtotal <span><% loop $CheckoutProductData %><% if $Pos == 1 %>$ProductSubTotalNFPrice<% end_if %><% end_loop %></span></a></li> --%>
                                <li><a>Shipping <span id="shippingProduct"></span></a></li>
                                
                                <li class="d-none"><a><span id="shippingNFProduct"></span></a></li>
                                <li><a>Total <span id="finalPriceProduct"></span></a></li>
                                <li class="d-none"><a>Total <span id="finalPriceNFProduct"></span></a></li>
                                <%-- <li class="d-none"><a>Diskon 
                                    <span id="Diskon">
                                    <% if $Diskon %>
                                        <% loop $Diskon %> 
                                            $Diskon %
                                        <% end_loop %>
                                    <% else %>
                                        0%
                                    <% end_if %>
                                    </span>
                                </a></li> --%>
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
                                    <p class="customerEmail m-0 p-0 px-3">Email: <span><% if $AddressData %><% loop $AddressData %>$Email<% end_loop %><% end_if %></span></p>
                                    <p class="customerHandphone m-0 p-0 px-3">Handphone: <span><% if $AddressData %><% loop $AddressData %>$Number<% end_loop %><% end_if %></span></p>
                                    <p class="customerAddress m-0 p-0 px-3 pb-3">Alamat: <span><% if $AddressData %><% loop $AddressData %>$AddressDetail, $Address, $Postal<% end_loop %><% end_if %></span></p>
                                    <p class="regency d-none"><% if $AddressData %><% loop $AddressData %>$Regency<% end_loop %><% end_if %></p>
                                    <p class="province d-none"><% if $AddressData %><% loop $AddressData %>$Province<% end_loop %><% end_if %></p>
                                </div>
                            </div>                                
                            <div class="payment_item active">
                                <div class="radion_btn">
                                    <input type="radio" id="f-option6" value="manualtf" name="selectorpayment" checked>
                                    <label for="f-option6">Manual Transfer </label>
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
                        <img src="public/_resources/themes/simple/images/banner/Logo-BCA-PNG.png" class="img-fluid">
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
                        <img src="public/_resources/themes/simple/images/banner/Logo-BCA-PNG.png" class="img-fluid">
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
<div id="loading"  style="display: none; position: fixed;display:flex; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 9999;  justify-content: center; align-items: center; overflow:hidden;">
    <script src="https://unpkg.com/@dotlottie/player-component@latest/dist/dotlottie-player.mjs" type="module"></script> 
    <dotlottie-player src="https://lottie.host/b08c7610-119e-4cce-9012-d6090e49248d/rQgFzzs9P8.json" background="transparent" speed="1" style="width: 500px; height: 500px;" loop autoplay></dotlottie-player>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        function timeSince(date) {
            const now = new Date();
            const seconds = Math.floor((date - now) / 1000);
            const intervals = {
                tahun: 31536000,
                bulan: 2592000,
                hari: 86400,
                jam: 3600,
                menit: 60,
            };
            console.log(seconds);
            for (const [unit, value] of Object.entries(intervals)) {
                const timePassed = Math.floor(seconds / value);
                if (timePassed >= 1) {
                    return `${timePassed} ${unit} lagi`;
                }
            }
            return "Sebentar Lagi";
        }
    
        function updateTimeSince() {
            const elements = document.querySelectorAll('.since');
            console.log(elements);
            elements.forEach((element) => {
                const dateString = element.dataset.date;
                const inputDate = new Date(dateString);
                if (isNaN(inputDate.getTime())) {
                    element.textContent = "Invalid date";
                    return;
                }
                const timePassed = timeSince(inputDate) ;
                element.textContent = `${timePassed} ` ;
            });
        }
        updateTimeSince();
    });
    $('.nav-item#shop').addClass('active');



</script>
<!--================End Checkout Area =================-->