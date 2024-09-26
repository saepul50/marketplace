<style>
    .stars {
    font-size: 30px;
    }
    .star {
    cursor: pointer;
    margin: 0 5px;
    }
    .one {
    color: #ffff06;
    }
    .two {
    color: #ffff06;
    }
    .three {
    color: #ffff06;
    }
    .four {
    color: #ffff06;
    }
    .five {
    color: #ffff06;
    }
 </style>
 <!-- Start Banner Area -->
 <section class="banner-area organic-breadcrumb" style ="background: url($SiteConfig.Background.getURL()) center no-repeat;background-size: cover; position: relative ">
    <div class="container">
       <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
          <div class="col-first">
             <h1>History Checkout</h1>
             <nav class="d-flex align-items-center">
                <a href="{$BaseHref}">Home<span class="lnr lnr-arrow-right"></span></a>
                <a href="{$BaseHref}/confirm">History Checkout</a>
             </nav>
          </div>
       </div>
    </div>
 </section>
 <!-- End Banner Area -->
 <!--================Order Details Area =================-->
 <% if $HistoryData %>
 <section class="order_details section_gap pt-2">
    <div class= "myorder" id="myOrder">
       <nav class="py-2 pt-5 d-flex justify-content-around flex-wrap navihistory">
          <h5 id="navSemua" class="navi-item" style="cursor: pointer;">Semua</h5>
          <h5 id="navPending" class="navi-item" style="cursor: pointer;">Pending</h5>
          <h5 id="navProses" class="navi-item" style="cursor: pointer;">Proses</h5>
          <h5 id="navSelesai" class="navi-item" style="cursor: pointer;">Selesai</h5>
          <h5 id="navCanceled" class="navi-item" style="cursor: pointer;">Canceled</h5>
       </nav>
       <div class="container Semua" id="semua">
          <%-- <h3 class="title_confirmation">Thank you. Your order has been received.</h3> --%>
          <%-- <div class="row order_d_inner">
             <div class="col-lg-4">
                 <div class="details_item">
                     <h4>Order Info</h4>
                     <ul class="list">
                         <li><a href="#"><span>Order number</span> : 60235</a></li>
                         <li><a href="#"><span>Date</span> : Los Angeles</a></li>
                         <li><a href="#"><span>Total</span> : USD 2210</a></li>
                         <li><a href="#"><span>Payment method</span> : Check payments</a></li>
                     </ul>
                 </div>
             </div>
             <div class="col-lg-4">
                 <div class="details_item">
                     <h4>Billing Address</h4>
                     <ul class="list">
                         <li><a href="#"><span>Street</span> : 56/8</a></li>
                         <li><a href="#"><span>City</span> : Los Angeles</a></li>
                         <li><a href="#"><span>Country</span> : United States</a></li>
                         <li><a href="#"><span>Postcode </span> : 36952</a></li>
                     </ul>
                 </div>
             </div>
             <div class="col-lg-4">
                 <div class="details_item">
                     <h4>Shipping Address</h4>
                     <ul class="list">
                         <li><a href="#"><span>Street</span> : 56/8</a></li>
                         <li><a href="#"><span>City</span> : Los Angeles</a></li>
                         <li><a href="#"><span>Country</span> : United States</a></li>
                         <li><a href="#"><span>Postcode </span> : 36952</a></li>
                     </ul>
                 </div>
             </div>
             </div> --%>
          <% loop $HistoryData %>
            <% if $Status == 'Completed' %>
                <a href="{$BaseHref}/confirm/order/$OrderID?detailOrder=true" style="text-decoration: none; color: inherit;">
                    <div class="order_details_table">
                       <div class="d-flex justify-content-between px-3">
                          <h2>Order Details</h2>
                          <h2 id="asli" value="$OrderID">$OrderID</h2>
                       </div>
                       <p class="d-flex justify-content-end px-3" style="color: darkorange;" scope="col">$Status</p>
                       <div class="table-responsive">
                          <table class="table">
                             <thead>
                                <tr>
                                   <th scope="col"></th>
                                   <th scope="col">Product</th>
                                   <th scope="col">Quantity</th>
                                   <th scope="col"></th>
                                   <%-- <th scope="col">Final Price</th> --%>
                                </tr>
                             </thead>
                             <tbody>
                                <% loop $items %>
                                <tr>
                                   <td class="col-1">
                                      <img src="$ProductImage" class="img-fluid">
                                   </td>
                                   <td class="col-2">
                                   <p class="d-none" id="ProductIDAsli" value="$ProductID">$ProductID</p>
                                      <p>$ProductTitle</p>
                                   </td>
                                   <td class="col-6">
                                      <h5>x $ProductQuantity</h5>
                                   </td>
                                   <td class="col">
                                   <button type="button"   class="btn btn-outline-warning showModalButton" style=""  data-toggle="modal" data-target="#exampleModalCenter" data-title="$ProductTitle" data-get="$Up.OrderID" data-image="$ProductImage" data-variant="$ProductVariant" data-id="$ProductID" data-quantity="$ProductQuantity">Nilai</button>
                                 </td>
                                </tr>
                                <% end_loop %>
                                <tr>
                                   <td></td>
                                   <td>
                                      <h4>Total</h4>
                                   </td>
                                   <td>
                                      <p>$FinalPrice</p>
                                   </td>
                                 <td></td>
                                </tr>
                             </tbody>
                          </table>
                       </div>
                    </div>
               </a>



               <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                  <div class="modal-dialog modal-dialog-centered" role="document">
                     <div class="modal-content">
                        <div class="modal-body">
                           <div class="row">
                              <div class="col-2">
                                 <img src="" id="image" class="img-fluid" >
                              </div>
                              <div class="col-10">
                                 <h6 id="title" value=""></h6>
                                 <h6 class="text-muted" id="variants" value=""></h6>
                              </div>
                           </div>
                           <div class="review_box">
                              <h4>Add a Review</h4>
                              <p>Your Rating:</p>
                              <div class="d-flex">
                                 <div class="rating d-none">
                                    <span id="rating">0</span>/5
                                 </div>
                                 <div class="stars " id="stars">
                                    <span class="star" data-value="1">★</span>
                                    <span class="star" data-value="2">★</span>
                                    <span class="star" data-value="3">★</span>
                                    <span class="star" data-value="4">★</span>
                                    <span class="star" data-value="5">★</span>
                                 </div>
                              </div>
                              <form class="row contact_form" method="post" id="reviewform">
                                 <div class="col-md-12">
                                    <div class="form-group">
                                       <textarea class="form-control" name="reviewmsg" id="reviewmsg" rows="1"
                                          placeholder="Review" onfocus="this.placeholder = ''"
                                          onblur="this.placeholder = 'Review'" required style="height: 200px;"></textarea>
                                       <input type="hidden" id="ratingValue" name="ratingValue" value="0">
                                       <input type="hidden" id="ID" name="ID" value="">
                                       <input type="hidden" id="OrderID" name="ID" value="">
                                    </div>
                                 </div>
                                 <div class="col-md-12 text-right">
                                    <button type="submit" value="submit" id="modalConfirmButton" class="primary-btn">Submit Now</button>
                                 </div>
                              </form>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            <% else %>
                <a href="{$BaseHref}/confirm/order/$OrderID?detailOrder=true" style="text-decoration: none; color: inherit;">
                   <div class="order_details_table">
                      <div class="d-flex justify-content-between px-3">
                         <h2>Order Details</h2>
                         <h2>$OrderID</h2>
                      </div>
                      <p class="d-flex justify-content-end px-3" style="color: darkorange;" scope="col">$Status</p>
                      <div class="table-responsive">
                        <table class="table">
                           <thead>
                              <tr>
                                 <th scope="col"></th>
                                 <th scope="col">Product</th>
                                 <th scope="col">Quantity</th>
                                 <th scope="col"></th>
                                 <%-- <th scope="col">Final Price</th> --%>
                              </tr>
                           </thead>
                           <tbody>
                              <% loop $items %>
                              <tr>
                                 <td class="col-1">
                                    <img src="$ProductImage" class="img-fluid">
                                 </td>
                                 <td class="col-2">
                                    <p>$ProductTitle</p>
                                 </td>
                                 <td class="col-6">
                                    <h5>x $ProductQuantity</h5>
                                 </td>
                                 <td class="col">
                               </td>
                              </tr>
                              <% end_loop %>
                              <tr>
                                 <td></td>
                                 <td>
                                    <h4>Total</h4>
                                 </td>
                                 <td>
                                    <p>$FinalPrice</p>
                                 </td>
                               <td></td>
                              </tr>
                           </tbody>
                        </table>
                      </div>
                   </div>
                </a>
            <% end_if %>
          <% end_loop %>
       </div>
       <div class="container Pending" id="pending">
          <% loop $HistoryData %>
          <% if $Status == 'Pending' %>
          <div class="order_details_table">
             <div class="d-flex justify-content-between px-3">
                <h2>Order Details</h2>
                <h2>$OrderID</h2>
             </div>
             <p class="d-flex justify-content-end px-3" style="color: darkorange;" scope="col">$Status</p>
             <div class="table-responsive">
               <table class="table">
                  <thead>
                     <tr>
                        <th scope="col"></th>
                        <th scope="col">Product</th>
                        <th scope="col">Quantity</th>
                        <th scope="col"></th>
                        <%-- <th scope="col">Final Price</th> --%>
                     </tr>
                  </thead>
                  <tbody>
                     <% loop $items %>
                     <tr>
                        <td class="col-1">
                           <img src="$ProductImage" class="img-fluid">
                        </td>
                        <td class="col-2">
                           <p>$ProductTitle</p>
                        </td>
                        <td class="col-6">
                           <h5>x $ProductQuantity</h5>
                        </td>
                        <td class="col">
         
                      </td>
                     </tr>
                     <% end_loop %>
                     <tr>
                        <td></td>
                        <td>
                           <h4>Total</h4>
                        </td>
                        <td>
                           <p>$FinalPrice</p>
                        </td>
                      <td></td>
                     </tr>
                  </tbody>
               </table>
             </div>
          </div>
          <% end_if %>
          <% end_loop %>
       </div>
       <div class="container Proses" id="proses">
          <% loop $HistoryData %>
          <% if $Status == 'Processing' %>
          <div class="order_details_table">
             <div class="d-flex justify-content-between px-3">
                <h2>Order Details</h2>
                <h2>$OrderID</h2>
             </div>
             <p class="d-flex justify-content-end px-3" style="color: darkorange;" scope="col">$Status</p>
             <div class="table-responsive">
               <table class="table">
                  <thead>
                     <tr>
                        <th scope="col"></th>
                        <th scope="col">Product</th>
                        <th scope="col">Quantity</th>
                        <th scope="col"></th>
                        <%-- <th scope="col">Final Price</th> --%>
                     </tr>
                  </thead>
                  <tbody>
                     <% loop $items %>
                     <tr>
                        <td class="col-1">
                           <img src="$ProductImage" class="img-fluid">
                        </td>
                        <td class="col-2">
                           <p>$ProductTitle</p>
                        </td>
                        <td class="col-6">
                           <h5>x $ProductQuantity</h5>
                        </td>
                        <td class="col">
                      </td>
                     </tr>
                     <% end_loop %>
                     <tr>
                        <td></td>
                        <td>
                           <h4>Total</h4>
                        </td>
                        <td>
                           <p>$FinalPrice</p>
                        </td>
                      <td></td>
                     </tr>
                  </tbody>
               </table>
             </div>
          </div>
          <% end_if %>
          <% end_loop %>
       </div>
       <div class="container Selesai" id="selesai">
          <% loop $HistoryData %>
          <% if $Status == 'Completed' %>
            <a href="{$BaseHref}/confirm/order/$OrderID?detailOrder=true" style="text-decoration: none; color: inherit;">
               <div class="order_details_table">
                  <div class="d-flex justify-content-between px-3">
                     <h2>Order Details</h2>
                     <h2 id="asli" value="$OrderID">$OrderID</h2>
                  </div>
                  <p class="d-flex justify-content-end px-3" style="color: darkorange;" scope="col">$Status</p>
                  <div class="table-responsive">
                     <table class="table">
                        <thead>
                           <tr>
                              <th scope="col"></th>
                              <th scope="col">Product</th>
                              <th scope="col">Quantity</th>
                              <th scope="col"></th>
                              <%-- <th scope="col">Final Price</th> --%>
                           </tr>
                        </thead>
                        <tbody>
                           <% loop $items %>
                           <tr>
                              <td class="col-1">
                                 <img src="$ProductImage" class="img-fluid">
                              </td>
                              <td class="col-2">
                              <p class="d-none" id="ProductIDAsli" value="$ProductID">$ProductID</p>
                                 <p>$ProductTitle</p>
                              </td>
                              <td class="col-6">
                                 <h5>x $ProductQuantity</h5>
                              </td>
                              <td class="col">
                              <button type="button" class="btn btn-outline-warning showModalButton" style=""  data-toggle="modal" data-target="#exampleModalCenter" data-title="$ProductTitle" data-get="$Up.OrderID" data-image="$ProductImage" data-variant="$ProductVariant" data-id="$ProductID" data-quantity="$ProductQuantity">Nilai</button>
                            </td>
                           </tr>
                           <% end_loop %>
                           <tr>
                              <td></td>
                              <td>
                                 <h4>Total</h4>
                              </td>
                              <td>
                                 <p>$FinalPrice</p>
                              </td>
                            <td></td>
                           </tr>
                        </tbody>
                     </table>
                  </div>
               </div>
          </a>
          <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
               <div class="modal-content">
                  <div class="modal-body">
                     <div class="row">
                        <div class="col-2">
                           <img src="" id="image" class="img-fluid" >
                        </div>
                        <div class="col-10">
                           <h6 id="title" value=""></h6>
                           <h6 class="text-muted" id="variants" value=""></h6>
                        </div>
                     </div>
                     <div class="review_box">
                        <h4>Add a Review</h4>
                        <p>Your Rating:</p>
                        <div class="d-flex">
                           <div class="rating d-none">
                              <span id="rating">0</span>/5
                           </div>
                           <div class="stars " id="stars">
                              <span class="star" data-value="1">★</span>
                              <span class="star" data-value="2">★</span>
                              <span class="star" data-value="3">★</span>
                              <span class="star" data-value="4">★</span>
                              <span class="star" data-value="5">★</span>
                           </div>
                        </div>
                        <form class="row contact_form" method="post" id="reviewform">
                           <div class="col-md-12">
                              <div class="form-group">
                                 <textarea class="form-control" name="reviewmsg" id="reviewmsg" rows="1"
                                    placeholder="Review" onfocus="this.placeholder = ''"
                                    onblur="this.placeholder = 'Review'" required style="height: 200px;"></textarea>
                                 <input type="hidden" id="ratingValue" name="ratingValue" value="0">
                                 <input type="hidden" id="ID" name="ID" value="">
                                 <input type="hidden" id="OrderID" name="ID" value="">
                              </div>
                           </div>
                           <div class="col-md-12 text-right">
                              <button type="submit" value="submit" id="modalConfirmButton" class="primary-btn">Submit Now</button>
                           </div>
                        </form>
                     </div>
                  </div>
               </div>
            </div>
         </div>
          <% end_if %>
          <% end_loop %>
       </div>
       <div class="container Canceled" id="canceled">
          <% loop $HistoryData %>
          <% if $Status == 'Cancelled' %>
          <div class="order_details_table">
             <div class="d-flex justify-content-between px-3">
                <h2>Order Details</h2>
                <h2>$OrderID</h2>
             </div>
             <p class="d-flex justify-content-end px-3" style="color: darkorange;" scope="col">$Status</p>
             <div class="table-responsive">
               <table class="table">
                  <thead>
                     <tr>
                        <th scope="col"></th>
                        <th scope="col">Product</th>
                        <th scope="col">Quantity</th>
                        <th scope="col"></th>
                        <%-- <th scope="col">Final Price</th> --%>
                     </tr>
                  </thead>
                  <tbody>
                     <% loop $items %>
                     <tr>
                        <td class="col-1">
                           <img src="$ProductImage" class="img-fluid">
                        </td>
                        <td class="col-2">
                           <p>$ProductTitle</p>
                        </td>
                        <td class="col-6">
                           <h5>x $ProductQuantity</h5>
                        </td>
                        <td class="col">
                     
                      </td>
                     </tr>
                     <% end_loop %>
                     <tr>
                        <td></td>
                        <td>
                           <h4>Total</h4>
                        </td>
                        <td>
                           <p>$FinalPrice</p>
                        </td>
                      <td></td>
                     </tr>
                  </tbody>
               </table>
             </div>
          </div>
          <% end_if %>
          <% end_loop %>
       </div>
    </div>
    <% loop $CheckoutHeader %>
        <% if $Status == 'Completed' %>
            <div class="detailOrder order_details_table w-100" id="detailOrder">
            <div class="detailContain">
                <div class="navtop d-flex justify-content-between px-3 py-2">
                    <a href="{$BaseHref}/confirm" style="text-decoration: none; color: inherit;">
                        <div class="textleft d-flex align-items-center" style="cursor: pointer">
                        <span class="fs-4">﹤</span>
                        <p class="m-0">Kembali</p>
                        </div>
                    </a>
                    <div class="textright d-flex align-items-center">
                        <p class="m-0 pr-4">No. Pesanan &nbsp; <span style="font-weight: 600;">$OrderID</span></p>
                        <p class="m-0" style="color: darkorange; font-weight: 500; text-transform: uppercase;">Pesanan $Status</p>
                    </div>
                </div>
                <div class="road" style="margin-top: .1rem;">
                    <div class="d-flex justify-content-around align-items-center">
                        <div class="icon-wrapper">
                        <i class='bx bxs-receipt'></i>
                        </div>
                        <div class="icon-wrapper">
                        <i class='bx bxs-wallet-alt'></i>
                        </div>
                        <div class="icon-wrapper">
                        <i class='bx bxs-truck'></i>
                        </div>
                    </div>
                </div>
                <div class="text1" style="margin-top: .1rem;">
                    <div class="d-flex justify-content-between align-items-center py-3 px-3">
                        <h5 class="m-0">Terimakasih telah berbelanja di SS!</h5>
                    </div>
                </div>
                <div class="Orders">
                    <div class="delivery d-flex flex-column py-3 px-3">
                        <div class="col-8 col-md-6">
                        <h6>Alamat Pengiriman</h6>
                        <p class="m-0 py-1">$CustomerName</p>
                        <p class="m-0">$CustomerHandphone</p>
                        <p class="m-0">$CustomerAddress</p>
                        </div>
                    </div>
                    <div class="allproduct d-flex flex-column py-3 px-3">
                        <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th scope="col">Product</th>
                                    <th scope="col">Quantity</th>
                                    <th scope="col">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% loop $items %>
                                <tr>
                                    <td class="col-1">
                                    <img src="$ProductImage" class="img-fluid">
                                    </td>
                                    <td>
                                    <p>$ProductTitle ($ProductVariant)</p>
                                    </td>
                                    <td>
                                    <h5>x $ProductQuantity</h5>
                                    </td>
                                    <td>
                                    <p>$ProductPrice</p>
                                    </td>
                                </tr>
                                <% end_loop %>
                                <tr>
                                    <td></td>
                                    <td>
                                    <h4>Subtotal</h4>
                                    </td>
                                    <td>
                                    <h5></h5>
                                    </td>
                                    <td>
                                    <p><% loop $Items.First %>$ProductSubTotalPrice<% end_loop %></p>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                    <h4>Shipping</h4>
                                    </td>
                                    <td>
                                    <h5></h5>
                                    </td>
                                    <td>
                                    <p>Flat rate: <% loop $Items.First %>$ProductCostShipping<% end_loop %></p>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                    <h4>Total</h4>
                                    </td>
                                    <td>
                                    <h5></h5>
                                    </td>
                                    <td>
                                    <p>$FinalPrice</p>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        </div>
                        <div class="d-flex paymentinfo py-2" style="border-top: 1px solid #cdcdcd;">
                        <div class="d-flex align-items-center py-2 px-3 w-100" style="background-color: #FFFEFB; border: 1px solid #F3DB97;">
                            <i class='bx bx-bell'></i>
                            <p class="m-0 ps-3 d-flex">Terimakasih telah berbelanja semoga barang sampai dengan aman dan tepat waktu</p>
                        </div>
                        </div>
                        <div class="d-flex payment py-2" style="border-top: 1px solid #cdcdcd;">
                        <div class="col-8 d-flex flex-column align-items-end" >
                            <p class="m-0">Metode Pembayaran</p>
                        </div>
                        <div class="col-4 d-flex flex-column align-items-end">
                            <p class="m-0">$PaymentMethod</p>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
        <% else_if $Status == 'Pending' %>
            <div class="detailOrder order_details_table w-100" id="detailOrder">
                <div class="detailContain">
                    <div class="navtop d-flex justify-content-between px-3 py-2">
                        <a href="{$BaseHref}/confirm" style="text-decoration: none; color: inherit;">
                            <div class="textleft d-flex align-items-center" style="cursor: pointer">
                            <span class="fs-4">﹤</span>
                            <p class="m-0">Kembali</p>
                            </div>
                        </a>
                        <div class="textright d-flex align-items-center">
                            <p class="m-0 pr-4">No. Pesanan &nbsp; <span style="font-weight: 600;">$OrderID</span></p>
                            <p class="m-0" style="color: darkorange; font-weight: 500; text-transform: uppercase;">Pesanan $Status</p>
                        </div>
                    </div>
                    <div class="road" style="margin-top: .1rem;">
                        <div class="d-flex justify-content-around align-items-center">
                            <div class="icon-wrapper">
                            <i class='bx bxs-receipt'></i>
                            </div>
                            <div class="icon-wrapper">
                            <i class='bx bxs-wallet-alt'></i>
                            </div>
                            <div class="icon-wrapper">
                            <i class='bx bxs-truck'></i>
                            </div>
                        </div>
                    </div>
                    <div class="text1" style="margin-top: .1rem;">
                        <div class="d-flex justify-content-between align-items-center py-3 px-3">
                            <h5 class="m-0">Terimakasih telah berbelanja di SS!</h5>
                        </div>
                    </div>
                    <div class="Orders">
                        <div class="delivery d-flex flex-column py-3 px-3">
                            <div class="col-8 col-md-6">
                            <h6>Alamat Pengiriman</h6>
                            <p class="m-0 py-1">$CustomerName</p>
                            <p class="m-0">$CustomerHandphone</p>
                            <p class="m-0">$CustomerAddress</p>
                            </div>
                        </div>
                        <div class="allproduct d-flex flex-column py-3 px-3">
                            <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th></th>
                                        <th scope="col">Product</th>
                                        <th scope="col">Quantity</th>
                                        <th scope="col">Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% loop $items %>
                                    <tr>
                                        <td class="col-1">
                                        <img src="$ProductImage" class="img-fluid">
                                        </td>
                                        <td>
                                        <p>$ProductTitle ($ProductVariant)</p>
                                        </td>
                                        <td>
                                        <h5>x $ProductQuantity</h5>
                                        </td>
                                        <td>
                                        <p>$ProductPrice</p>
                                        </td>
                                    </tr>
                                    <% end_loop %>
                                    <tr>
                                        <td></td>
                                        <td>
                                        <h4>Subtotal</h4>
                                        </td>
                                        <td>
                                        <h5></h5>
                                        </td>
                                        <td>
                                        <p><% loop $Items.First %>$ProductSubTotalPrice<% end_loop %></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                        <h4>Shipping</h4>
                                        </td>
                                        <td>
                                        <h5></h5>
                                        </td>
                                        <td>
                                        <p>Flat rate: <% loop $Items.First %>$ProductCostShipping<% end_loop %></p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td>
                                        <h4>Total</h4>
                                        </td>
                                        <td>
                                        <h5></h5>
                                        </td>
                                        <td>
                                        <p>$FinalPrice</p>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            </div>
                            <div class="d-flex paymentinfo py-2" style="border-top: 1px solid #cdcdcd;">
                            <div class="d-flex align-items-center py-2 px-3 w-100" style="background-color: #FFFEFB; border: 1px solid #F3DB97;">
                                <i class='bx bx-bell'></i>
                                <p class="m-0 ps-3 d-flex">Mohon lakukan pembayaran sebesar <span class="pl-2 d-flex align-items-center" style="color: darkorange; font-weight: 500;">$FinalPrice</span></p>
                            </div>
                            </div>
                            <div class="d-flex payment py-2" style="border-top: 1px solid #cdcdcd;">
                            <div class="col-8 d-flex flex-column align-items-end" >
                                <p class="m-0">Metode Pembayaran</p>
                            </div>
                            <div class="col-4 d-flex flex-column align-items-end">
                                <p class="m-0">$PaymentMethod</p>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        <% end_if %>
    <% end_loop %>



    <% if $ShowDetailOrder %>
      <script>
          $(document).ready(function() {
              $('#myOrder').hide();
              $('#detailOrder').show();
          });
      </script>
  <% else %>
      <script> 
          $(document).ready(function() {
              $('#myOrder').show();
              $('#detailOrder').hide();
          });
      </script>
  <% end_if %>
  </section>
  <!--================End Order Details Area =================-->
  <% else %>
  <h5 class="d-flex justify-content-center p-4">Nothing History Purchace</h5>
  <% end_if %>
  <script>
      $('.nav-item#shop').addClass('active');
  </script>