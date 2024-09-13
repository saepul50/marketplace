  <!-- Start Banner Area -->
  <section class="banner-area organic-breadcrumb" style ="background: url($SiteConfig.Background.getURL()) center no-repeat;background-size: cover; position: relative ">
    <div class="container">
        <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
            <div class="col-first">
                <h1>Shopping Cart</h1>
                <nav class="d-flex align-items-center">
                    <a href="{$BaseHref}">Home<span class="lnr lnr-arrow-right"></span></a>
                    <a href="{$BaseHref}/cart">Cart</a>
                </nav>
            </div>
        </div>
    </div>
</section>
<!-- End Banner Area -->

<!--================Cart Area =================-->
<section class="cart_area">
    <div class="container">
        <div class="cart_inner">
            <div class="table-responsive">
                <table class="table">
                    <% if $Cart %>
                    <thead>
                        <tr>
                            <th scope="col">Product</th>
                            <th scope="col">Price</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Total</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% loop $Cart %>
                        <tr class="cartProduct">
                            <td class="col-6">
                                <div class="media d-flex align-items-center">
                                    <input type="checkbox" class="productCheckbox" data-id="$ID">
                                    <div class="d-flex col-10 col-md-4">
                                        <img id="productCheckoutImage" src="$ProductImage" alt="" class="img-fluid">
                                    </div>
                                    <div class="media-body">
                                        <p id="productCheckoutID" class="d-none">$ProductID</p>
                                        <p id="productCheckoutTitle">$ProductTitle</p>
                                        <% if $ProductCategoryId = 1 %>
                                            <p id="productCheckoutVariant" data-id="$ProductVariantID">size: $ProductVariant</p>
                                        <% else %>
                                            <p id="productCheckoutVariant" data-id="$ProductVariantID">$ProductVariant</p>
                                        <% end_if %>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <h5 id="itemPrice">$ProductPrice</h5>
                            </td>
                            <td>
                                <div class="product_count">
                                    <input type="text" name="qty" inputmode="numeric" id="quantityInput" class="input-text qty" value="$ProductQuantity" min="1">
                                    <button class="increase items-count m-0" type="button" id="incrementButton">
                                        <i class="lnr lnr-chevron-up"></i>
                                    </button>
                                    <button class="reduced items-count m-0" type="button" id="decrementButton">
                                        <i class="lnr lnr-chevron-down"></i>
                                    </button>
                                </div>
                            </td>
                            <td>
                                <h5 id="totalPriceCheckout"></h5>
                                <h5 class="totalPriceNFCheckout d-none" id="totalPriceNFCheckout"></h5>
                            </td>
                        </tr>
                    <% end_loop %>
                        <%-- <tr class="bottom_button">
                            <td>

                            </td>
                            <td>

                            </td>
                            <td>

                            </td>
                            <td>
                                <div class="cupon_text d-flex align-items-center">
                                    <input type="text" placeholder="Coupon Code">
                                    <a class="primary-btn" href="#">Apply</a>
                                    <a class="gray_btn" href="#" style="font-size:small">Close Coupon</a>
                                </div>
                            </td>
                        </tr> --%>
                        <tr>
                            <td>

                            </td>
                            <td>

                            </td>
                            <td>
                                <h5>Subtotal</h5>
                            </td>
                            <td>
                                <h5 id="subTotalPriceCheckout"></h5>
                                <h5 class="d-none" id="subTotalPriceNFCheckout"></h5>
                            </td>
                        </tr>
                        <%-- <tr class="shipping_area">
                            <td>
                                <h5>Payment</h5>
                                <div class="payment_box">
                                    <ul class="list">
                                        <li class="active"><a>Manual Transfer</a></li>
                                        <li><a>Cash On Delivery</a></li>
                                        <li><a>Duitku</a></li>
                                    </ul>
                                </div>
                                <div class="payment_box pt-5">
                                    <div class="payment">
                                        <div class="col-12">
                                            <div class="bg-light p-4 border shadow">
                                                <form class="w-100">
                                                    <div class="container ps-4 m-0">
                                                        <div class="row p-0">
                                                            <div class="p-2">  
                                                                <span>Metode Pembayaran</span>
                                                                <div class="card m-2">
                                                                    <div class="accordion" id="accordionExample">
                                                                        <div class="card">
                                                                            <div class="card-header p-0" id="headingBank">
                                                                                <h2 class="mb-0">
                                                                                    <button class="btn btn-light btn-block text-left collapsed p-3 rounded-0 border-bottom-custom" type="button" data-toggle="collapse" data-target="#collapseBank" aria-expanded="false" aria-controls="collapseBank">
                                                                                        <div class="d-flex align-items-center justify-content-between">
                                                                                            <span>Pilih pembayaran</span>
                                                                                        </div>
                                                                                    </button>
                                                                                </h2>
                                                                            </div>
                                                                            <div id="collapseBank" class="collapse" aria-labelledby="headingBank" data-parent="#accordionExample">
                                                                                <div id="paymentOptions" class="card-body payment-card-body d-flex flex-column">
                                                                                    <!-- Opsi pembayaran bisa ditambahkan di sini -->
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td>
            
                            </td>
                            <td style="left: -250px">
                                <h5>Shipping</h5>
                            </td>
                            <td>
                                <div class="shipping_box">
                                    <ul class="list">
                                        <li><a href="#">Flat Rate: $5.00</a></li>
                                        <li><a href="#">Free Shipping</a></li>
                                        <li><a href="#">Flat Rate: $10.00</a></li>
                                        <li class="active"><a href="#">Local Delivery: $2.00</a></li>
                                    </ul>
                                    <h6>Calculate Shipping <i class="fa fa-caret-down" aria-hidden="true"></i></h6>
                                    <select class="shipping_select">
                                        <option value="1">Bangladesh</option>
                                        <option value="2">India</option>
                                        <option value="4">Pakistan</option>
                                    </select>
                                    <select class="shipping_select">
                                        <option value="1">Select a State</option>
                                        <option value="2">Select a State</option>
                                        <option value="4">Select a State</option>
                                    </select>
                                    <input type="text" placeholder="Postcode/Zipcode">
                                </div>
                            </td>
                        </tr> --%>
                        <tr class="out_button_area">
                            <td>

                                <input type="checkbox" id="bottomMasterCheckbox">
                            </td>
                            <td>

                            </td>
                            <td>
                            </td>
                            <td>
                                <div class="checkout_btn_inner d-flex justify-content-end align-items-center gap-2">
                                    <%-- <a class="gray_btn fw-bold " style="font-size: x-small" href="#"><strong>Continue Shopping</strong></a> --%>
                                    <a class="primary-btn" id="proceedCheckout">Proceed to checkout</a>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                    <% else %>
                        <h5 class="d-flex justify-content-center">Nothing Product In Cart</h5>
                    <% end_if %>
                </table>
            </div>
        </div>
    </div>
</section>
<!--================End Cart Area =================-->