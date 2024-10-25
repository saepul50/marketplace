<!-- Start Banner Area -->
    <style>
        .cardVariant .variantItem {
            cursor: pointer !important;
            transition: 0.4s ease-in-out !important;
        }
        .cardVariant .active {
            border: 1px solid orange;
            background-color: #e9e9e9;
        }  
        .table td{
            border-top: none;
            border-bottom: 1px solid #dee2e6;
        }
        .table tbody+tbody{
            border-top: none;
        }
        .link-vendor h4, .link-vendor i {
            color: #777;
        }
        a:hover .link-vendor h4, a:hover .link-vendor i {
            color: black;
        }
    </style>
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
    <div class="container" style="background-color: #f5f5f5;">
        <div class="cart_inner">
            <div class="table-responsive p-5">
                <table class="table">
                <% if $Member %>
                    <p class="d-none" id="MemberFirstname">$member.FirstName</p>
                    <p class="d-none" id="MemberLastname">$member.LastName</p>
                    <p class="d-none" id="MemberEmail">$member.Email</p>
                <% end_if %>
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
                            <% with $Vendor %>
                                <td class="p-0 py-2" style="border-bottom: none;"></td>
                                <tbody style="background-color: #fff; margin-top: 1rem;">
                                    <tr>
                                        <td class="pb-1 pt-3" style="border-bottom: none; border-radius: 15px 0 0 0;">
                                            <div class="d-flex align-items-center">
                                                <input type="checkbox" class="productCheckbox masterVendorCheckbox mr-3" data-vendor-id="$ID">
                                                <a class="" href="/marketplace/venn/$Pathname" style="text-decoration: none;">
                                                    <div class="link-vendor d-flex align-items-center" style="transition: color 0.3s ease; cursor: pointer;">
                                                        <i class='bx bx-store pr-2' style="font-size: 24px;"></i>
                                                        <h4 class="m-0" style="font-size: 18px;">$Name</h4>
                                                        <i class='bx bx-chevron-right' style="font-size: 24px;"></i>
                                                    </div>
                                                </a>
                                            </div>
                                        </td>
                                        <td style="border-bottom: none;"></td>
                                        <td style="border-bottom: none;"></td>
                                        <td style="border-bottom: none; border-radius: 0 15px 0 0;"></td>
                                    </tr>
                                    <% loop $Up.Products %>
                                    <tr class="cartProduct">
                                        <td class="col-6">
                                            <%-- <p>$ProductID</p> --%>
                                            <div class="media d-flex align-items-center">
                                                <input type="checkbox" class="productCheckbox" data-id="$Product.ID" data-vendor="$ID">
                                                <div class="d-flex col-10 col-md-4">
                                                    <a href="/marketplace/productdetails/$Product.ID" style="text-decoration: none;">
                                                        <img id="productCheckoutImage" src="$Product.ProductImages.First.URL" alt="" class="img-fluid">
                                                    </a>
                                                </div>
                                                <div class="media-body d-flex flex-column" style="gap: 1rem;">
                                                    <p id="productCheckoutID" class="d-none">$Product.ID</p>
                                                    <p id="productCheckoutVendorID" class="d-none">$Up.ID</p>
                                                    <p id="productCheckoutTitle" style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap">$Product.Title</p>
                                                    <div class="d-flex align-items-center py-1 pl-3 pr-2" id="variantChoose" data-cart="$ID" data-id="$Product.ID" data-variant="$Variant.ID" style="background-color: #f5f5f5; border-radius: 3px; cursor: pointer; width: max-content;">
                                                        <p class="deskripsi m-0">size: </p>
                                                        <p class="pl-1" id="productCheckoutVariant" data-id="$Variant.ID" data-weight="$Variant.Weight">$ProductVariant</p>
                                                        <i class='bx bx-chevron-down' style="font-size: 25px;"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <h5 id="itemPrice">$Variant.Price</h5>  
                                        </td>
                                        <td style="position: relative;">
                                            <div class="product_count">
                                                <input type="text" name="qty" inputmode="numeric" id="quantityInput" class="input-text qty" value="$ProductQuantity" min="1" data-stock="$Variant.Stock">
                                                <button class="increase items-count m-0" type="button" id="incrementButton">
                                                    <i class="lnr lnr-chevron-up"></i>
                                                </button>
                                                <button class="reduced items-count m-0" type="button" id="decrementButton">
                                                    <i class="lnr lnr-chevron-down"></i>
                                                </button>
                                            </div>
                                            <span class="pt-1" id="stockWarning" style="position: absolute; display:none; color:red; font-size: 9px; left: -8px;">Sudah mencapai maks stock produk</span>
                                        </td>
                                        <td>
                                            <h5 id="totalPriceCheckout"></h5>
                                            <h5 class="totalPriceNFCheckout d-none" id="totalPriceNFCheckout"></h5>
                                        </td>
                                    </tr>
                                    <% end_loop %>
                                    <tr>
                                        <td class="p-2" style="border-bottom: none; border-radius: 0 0 0 15px;"></td>
                                        <td class="p-2" style="border-bottom: none;"></td>
                                        <td class="p-2" style="border-bottom: none;"></td>
                                        <td class="p-2" style="border-bottom: none; border-radius: 0 0 15px 0;"></td>
                                    </tr>
                                </tbody>
                            <% end_with %>
                        <% end_loop %>
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
                        <tr class="out_button_area">
                            <td style="border-bottom: none;">
                                <input type="checkbox" id="bottomMasterCheckbox">
                            </td>
                            <td style="border-bottom: none;">
                            </td>
                            <td style="border-bottom: none;">
                            </td>
                            <td style="border-bottom: none;">
                                <div class="checkout_btn_inner d-flex justify-content-end align-items-center gap-2">
                                    <%-- <a class="gray_btn fw-bold " style="font-size: x-small" href="#"><strong>Continue Shopping</strong></a> --%>
                                    <a class="pr-5" style="color: red; cursor: pointer;" id="remove">Remove Product</a>
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
</div>
<div id="VariantShow" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
        </div>
    </div>
</div>

<!--================End Cart Area =================-->
<script>
    $('.nav-item#shop').addClass('active');
</script>