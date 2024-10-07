<section class="banner-area organic-breadcrumb" style ="background: url($SiteConfig.Background.getURL()) center no-repeat;background-size: cover; position: relative ">
    <div class="container">
        <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
            <div class="col-first">
            </div>
        </div>
    </div>
</section>
<!-- End Banner Area -->



<div class="container  my-4" style="background-color:whitesmoke;">
    <div class="header p-2" style="border-bottom: 1px solid rgba(0, 0, 0, .09);">
        <h5>Notifikasi</h5>
    </div>
    <div class="content p-3">
        <% loop $AllNotif %>
            
            <% if $Status == 'Dikemas' %>
                <div class="container d-flex  mt-2">
                    <%-- <div class="">
                        <% if $Product.Image %>
                            <img alt="product" width="100" height="100" src="$URL">
                        <% end_if %>
        
                    </div> --%>
                    <div class="content ml-4 d-flex justify-content-between " style="width:85%;">
                        <div style="inline-size: 100%; overflow-wrap: break-word;">
                            <h5 class="header fw-bold" style="font-weight:bold;">Pesanan Anda Sudah Dikemas Dan Siap Dikirim</h5>
                            <p class="deskripsi" style="margin: 0 !important;">Pesanan Anda Telah Dikemas Dan Siap Diberikan Ke Jasa Pengiriman</p>
                            <p>$LastEdited</p>
                        </div>
                    </div>
                    <div class="">
                    <a href="{$BaseHref}/confirm/order/$Order?detailOrder=true"><button  class="ml-auto mt-3" style="flex-shrink:0;">Check</button></a>
                    </div>
                </div>
            <% else_if  $Status == 'Dikirim' %>
                <div class="container d-flex  mt-2">
                    <%-- <div class="">
                        <img alt="product" width="100" height="100" src="$resourceURL('themes/simple/images/Xiaomi.png')">
                    </div> --%>
                    <div class="content ml-4 d-flex justify-content-between " style="width:85%;">
                        <div style="inline-size: 100%; overflow-wrap: break-word;">
                            <h5 class="header fw-bold" style="font-weight:bold;">Pesanan Anda Sudah Diberikan ke Jasa Pengantaran</h5>
                            <p class="deskripsi" style="margin: 0 !important;">Pesanan Anda Sudah Di Jasa Pengantaran dan Dalam Perjalanan Ke Tujuan</p>
                            <p>$LastEdited</p>
                        </div>
                    </div>
                    <div class="">
                    <a href="{$BaseHref}/confirm/order/$Order?detailOrder=true"><button  class="ml-auto mt-3" style="flex-shrink:0;">Check</button></a>
                    </div>
                </div>
            <% else_if  $Status == 'Selesai' %>
                <div class="container d-flex  mt-2">
                    <%-- <div class="">
                        <img alt="product" width="100" height="100" src="$resourceURL('themes/simple/images/Xiaomi.png')">
                    </div> --%>
                    <div class="content ml-4 d-flex justify-content-between " style="width:85%;">
                        <div style="inline-size: 100%; overflow-wrap: break-word;">
                            <h5 class="header fw-bold" style="font-weight:bold;">Pesanan Anda Sudah Sampai Ditujuan </h5>
                            <p class="deskripsi" style="margin: 0 !important;">Pesanan Anda Sudah Sampai DiTujuan</p>
                            <p>$LastEdited</p>
                        </div>
                    </div>
                    <div class="">
                    <a href="{$BaseHref}/confirm/order/$Order?detailOrder=true"><button  class="ml-auto mt-3" style="flex-shrink:0;">Check</button></a>
                    </div>
                </div>
            <% else_if  $Status == 'Dibatalkan' %>
                <div class="container d-flex  mt-2">
                    <%-- <div class="">
                        <img alt="product" width="100" height="100" src="$resourceURL('themes/simple/images/Xiaomi.png')">
                    </div> --%>
                    <div class="content ml-4 d-flex justify-content-between " style="width:85%;">
                        <div style="inline-size: 100%; overflow-wrap: break-word;">
                            <h5 class="header fw-bold" style="font-weight:bold;">Waduh Maaf Ya Orderan Kamu Dibatalkan  </h5>
                            <p class="deskripsi" style="margin: 0 !important;">Coba Tanyakan Ke Penjual atau baca lagi peraturan pembelian ya</p>
                            <p>$LastEdited</p>
                        </div>
                    </div>
                    <div class="">
                   <a href="{$BaseHref}/confirm/order/$Order?detailOrder=true"><button  class="ml-auto mt-3" style="flex-shrink:0;">Check</button></a>
                    </div>
                </div>
            <% end_if %>
        <% end_loop %>
        
    </div>
</div>