<section class="banner-area organic-breadcrumb" style ="background: url($SiteConfig.Background.getURL()) center no-repeat;background-size: cover; position: relative ">
    <div class="container">
        <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
            <div class="col-first">
            </div>
        </div>
    </div>
</section>
<!-- End Banner Area -->

<div class="container p-0">
    <div class="content py-4">
    <% if $GroupedNotifs %>
        <% loop $GroupedNotifs %>
            <% if $Read == 'Unread' %>
                <div class="notifs d-flex align-items-center justify-content-between px-4 py-3"  style="border-bottom: 1px solid #ddd; background-color: rgba(255, 165, 0, 0.04);">
                    <div class="d-flex">
                        <div class="col-2">
                            <% if $HeaderCheckout.Items.First %>
                                <% with $HeaderCheckout.Items.First %>
                                    <img src="$ProductImage" class="img-fluid">
                                <% end_with %>
                            <% end_if %>
                        </div>
                        <% loop $Notifications %>
                            <div class="content ml-4 d-flex ">
                                <div style="inline-size: 100%; overflow-wrap: break-word;">
                                    <h5 class="header fw-bold" style="font-weight:bold;">$Title</h5>
                                    <p class="deskripsi m-0">$Message $Up.HeaderCheckout.Vendor.Name</p>
                                    <p>$Date $Time</p>
                                </div>
                            </div>
                        <% end_loop %>
                    </div>
                    <div class="">
                        <a href="{$BaseHref}/confirm/order/$HeaderCheckout.OrderID?detailOrder=true" style="color: #000"><i class='bx bx-chevron-down' style="font-size: 40px;"></i></a>
                    </div>
                </div>
            <% else %>
                <div class="notifs d-flex align-items-center justify-content-between px-4 py-3"  style="border-bottom: 1px solid #ddd;">
                    <div class="d-flex">
                        <div class="col-2">
                            <% if $HeaderCheckout.Items.First %>
                                <% loop $HeaderCheckout.Items.First %>
                                    <img src="$ProductImage" class="img-fluid">
                                <% end_loop %>
                            <% end_if %>
                        </div>
                        <div class="content ml-4 d-flex ">
                            <div style="inline-size: 100%; overflow-wrap: break-word;">
                                <h5 class="header fw-bold" style="font-weight:bold;">$Title</h5>
                                <p class="deskripsi m-0">$Message</p>
                                <p>$Date $Time</p>
                            </div>
                        </div>
                    </div>
                    <div class="">
                        <a href="{$BaseHref}/confirm/order/$HeaderCheckout.OrderID?detailOrder=true" style="color: #000"><i class='bx bx-chevron-down' style="font-size: 40px;"></i></a>
                    </div>
                </div>
            <% end_if %>
        <% end_loop %>
    <% else %>
        <h5 class="m-0 d-flex justify-content-center">Tidak ada notifikasi</h5>
    <% end_if %>
    </div>
</div>