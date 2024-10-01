

<section class="banner-area organic-breadcrumb" style ="background: url($SiteConfig.Background.getURL()) center no-repeat;background-size: cover; position: relative ">
    <div class="container">
        <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
            <div class="col-first">
                <h1>Profile</h1>
                <nav class="d-flex align-items-center">
                    <a href="{$BaseHref}">Home<span class="lnr lnr-arrow-right"></span></a>
                    <a href="{$BaseHref}/profile">Profile</a>
                </nav>
            </div>
        </div>
    </div>
</section>
<section>
    <div class="py-2" style="background-color: #f2f2f2;">
        <% if $Vendor %>
            <div class="py-3 d-flex align-items-center" style="background-color: #fff">
                <a href="{$BaseHref}/venn/$Vendor.Pathname" class="d-flex justify-content-between align-items-center col-10"  style="color:black;">
                    <div class="d-flex ml-2">
                        <span class="lnr lnr-store fs-1" style="font-size: 30px; color: darkorange;"></span>
                        <p class="ml-3 m-0 d-flex align-items-center">Toko Saya</p>
                    </div>
                </a>
                <a href="{$BaseHref}/admin" class="col-2 d-flex justify-content-end">
                    <p class="mr-3 m-0" style="color: #000;">Kelola Toko ></p>
                </a>
            </div>
        <% else %>
            <div class="py-3 d-flex align-items-center" style="background-color: #fff">
                <a href="{$BaseHref}/vendorregistration" class="d-flex justify-content-between align-items-center col-10"  style="color:black;">
                    <div class="d-flex ml-2">
                        <span class="lnr lnr-store fs-1" style="font-size: 30px; color: darkorange;"></span>
                        <p class="ml-3 m-0">Mulai Jual</p>
                    </div>
                </a>
                <a href="{$BaseHref}/vendorregistration" class="col-2 d-flex justify-content-end">
                    <p class="mr-3 m-0" style="color: #000;">Registrasi Gratis ></p>
                </a>
            </div>
        <% end_if %>
        <div class="py-3" style="background-color: #fff">
            <a href="{$BaseHref}/history" class="d-flex justify-content-between align-items-center col-10"  style="color:black;">
                <div class="d-flex ml-2">
                    <span class="lnr lnr-history fs-1" style="color: darkblue; font-size: 26px;"></span>
                    <p class="ml-3 m-0">History Order</p>
                </div>
            </a>
        </div>
    </div>
</section>
<script>
    $('.nav-item#profile').addClass('active');
</script>