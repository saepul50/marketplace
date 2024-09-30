<%-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js" integrity="sha512-DUC8yqWf7ez3JD1jszxCWSVB0DMP78eOyBpMa5aJki1bIRARykviOuImIczkxlj1KhVSyS16w2FSQetkD4UU2w==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<link href="https://cdn.jsdelivr.net/npm/izitoast@1.4.0/dist/css/iziToast.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.0/dist/sweetalert2.all.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.0/dist/sweetalert2.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/owl.carousel@2.3.4/dist/owl.carousel.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/owl.carousel@2.3.4/dist/assets/owl.carousel.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<% require themedCSS("linearicons") %>
<% require themedCSS('magnific-popup') %>
<% require themedCSS('main') %>
<% require themedCSS('font-awesome.min') %>
<% require themedCSS('themify-icons') %>
<% require themedCSS('bootstrap') %>
<% require themedCSS('owl.carousel') %>
<% require themedCSS('nice-select') %>
<% require themedCSS('nouislider.min') %>
<% require themedCSS('ion.rangeSlider') %>
<% require themedCSS('ion.rangeSlider.skinFlat') %>
<% require themedCSS('main') %>
<% require themedCSS('linearicons') %>
<% require themedCSS('font-awesome.min') %>
<% require themedCSS('themify-icons') %>
<% require themedCSS('bootstrap') %>
<% require themedCSS('owl.carousel') %>
<% require themedCSS('nice-select') %>
<% require themedCSS('nouislider.min') %>
<% require themedCSS('ion.rangeSlider.skinFlat') %>
<% require themedCSS('magnific-popup') %>










<style>
    body {
        font-family: 'Arial', sans-serif;
    }
    a:hover{
        background-color:#d8e4eb;
    }
    .sidebar {
        position: fixed;
        top: 0;
        bottom: 0;
        left: 0;
        z-index: 100;
        box-shadow: inset -1px 0 0 rgba(0, 0, 0, 0.1);
    }
    .sidebar-sticky {
        position: -webkit-sticky;
        position: sticky;
        top: 0;
        height: 100vh;
    }
    .nav-link.active {
        color: #007bff;
    }
    .content {
        margin-left: 12.8rem;
    }
    .main{
        flex: 1 1 auto;
    }
    .hidden {
        display: none;
    }
    .show{
        display :block !important;
    }
    .item{
        display:none;
    }
    .primary-btn{
        background: -webkit-linear-gradient(90deg, #ffba00 0%, #ff6c00 100%);
        background: -moz-linear-gradient(90deg, #ffba00 0%, #ff6c00 100%);
        background: -o-linear-gradient(90deg, #ffba00 0%, #ff6c00 100%);
        background: linear-gradient(90deg, #ffba00 0%, #ff6c00 100%);
    }
    .primary-btn {
  position: relative;
  overflow: hidden;
  color: #fff;
  border-radius: 5px;
  display: inline-block;
  font-weight: 500;
  cursor: pointer;
  -webkit-transition: all 0.3s ease 0s;
  -moz-transition: all 0.3s ease 0s;
  -o-transition: all 0.3s ease 0s;
  transition: all 0.3s ease 0s; }
  .primary-btn:before {
    position: absolute;
    left: -145px;
    top: 0;
    height: 100%;
    width: 100%;
    content: "";
    background: #000;
    opacity: 0;
    -webkit-transform: skew(40deg);
    -moz-transform: skew(40deg);
    -ms-transform: skew(40deg);
    -o-transform: skew(40deg);
    transform: skew(40deg);
    -webkit-transition: all 0.3s ease 0s;
    -moz-transition: all 0.3s ease 0s;
    -o-transition: all 0.3s ease 0s;
    transition: all 0.3s ease 0s; }
  .primary-btn:hover {
    color: #fff; }
    .primary-btn:hover:before {
      left: 180px;
      opacity: .3; }
</style>

<nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar" style="padding-left:0 !important; padding-right:0!important;">
    <div class="p-3 text-center" style="background-color:#005a93; border-bottom: solid black;border-bottom-width: 1.5px;">
        <h6 class="text-light fw-bold">Karma</h6>
    </div>
    <div class="text-center p-3 d-flex justify-content-between text-light" style="background-color:#005a93; border-bottom: solid black;border-bottom-width: 1.5px;">
        <div class="ml-4">
            <img class="image" style="border-radius:50%;" id="image" src="$SiteConfig.Unknown.getURL()" width="50" height="50" alt="Default image">
            <span>Nama Toko</span>
        </div>
        <i class="fa fa-sign-out mt-3" style="font-size:20px;" aria-hidden="true"></i>
    </div>
    <div class="sidebar-sticky">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link active d-flex p-2 active" href="#" id="navDashboard">
                    <i class="fa fa-home mt-2 ml-5" aria-hidden="true" style="font-size:25px;"></i>
                    <p class="ml-2 mt-2">Dashboard</p>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link d-flex p-2" href="#" id="navProducts">
                    <i class="fa fa-shopping-cart ml-1 mt-2" aria-hidden="true" style="font-size:25px;margin-left: 3.1rem !important;"></i>
                    <p class="ml-2 mt-2">Products</p>
                </a>
            </li>
             <li class="nav-item">
                <a class="nav-link d-flex p-2" href="#" id="navorder">
                    <i class="fa fa-shopping-bag ml-1 mt-2" aria-hidden="true" style="font-size:25px;margin-left: 3.3rem !important;"></i>
                    <p class="ml-2 mt-2">Order</p>
                </a>
            </li>
            
        </ul>
    </div>
</nav>


<main role="main" class="content">
    <div  class="show item" id="dashboardContent">
        <div class="header" style="background-color: #f4f6f8; border-bottom: solid black;border-bottom-width: 1.5px; padding:.854rem;" >
            <h5 class="ml-1">Dashboard</h5>
        </div>
        <div class=" ml-5 mt-3 mr-5 Semua" id="semua">
            <div class="d-flex justify-content-between">
                <p class="fw-bold">Status Pesanan</p>
                <a class="text-muted">Riwayat Penjualan ></a>
            </div>
            <div class="mt-2 d-flex justify-content-between text-center">
                <div class="p-4">
                    <p>0</p>
                    <p>Perlu Dikirim</p>
                </div>
                <div class="p-4">
                    <p>0</p>
                    <p>Pembatalan</p>
                </div>
                <div class="p-4">
                    <p>0</p>
                    <p>Pengembalian</p>
                </div>
                <div class="p-4">
                    <p>0</p>
                    <p>Penilaian perlu dibalas</p>
                </div>
            </div>
        </div>
    </div>
    <div class=" item" id="productsContent">
        <div class="header" style="background-color: #f4f6f8; border-bottom: solid black;border-bottom-width: 1.5px; padding:.854rem;" >
            <h5 class="ml-1">Product</h5>
        </div>
        <div class=" container mt-3">
        <button id="" class="primary-btn " type="button" style="">Add Product +</button>
        </div>
    </div>
    <div class=" item " id="orderContent">
        <div class="header" style="background-color: #f4f6f8; border-bottom: solid black;border-bottom-width: 1.5px; padding:.854rem;" >
            <h5 class="ml-1">Order</h5>
        </div>
        <div class="container mt-3">
            <p>Ld.</p>
        </div>
    </div>
</main>

<script>
    document.getElementById("navDashboard").addEventListener("click", function() {
        var elements = document.getElementsByClassName("show");
        Array.from(elements).forEach(function(element) {
            element.classList.remove("show");
        });
        document.getElementById("dashboardContent").classList.add("show");
    });

    document.getElementById("navProducts").addEventListener("click", function() {
        var elements = document.getElementsByClassName("show");
        Array.from(elements).forEach(function(element) {
            element.classList.remove("show");
        });
        document.getElementById("productsContent").classList.add("show");
    });
     document.getElementById("navorder").addEventListener("click", function() {
        var elements = document.getElementsByClassName("show");
        Array.from(elements).forEach(function(element) {
            element.classList.remove("show");
        });
        document.getElementById("orderContent").classList.add("show");
    });
</script>




<% require themedJavascript('jquery.ajaxchimp.min') %>
<% require themedJavascript('jquery.nice-select.min') %>
<% require themedJavascript('jquery.sticky') %>
<% require themedJavascript('nouislider.min') %>
<% require themedJavascript('countdown') %>
<% require themedJavascript('jquery.magnific-popup.min') %>
<% require themedJavascript('owl.carousel.min') %>
<% require themedJavascript('gmaps.min') %>
<% require themedJavascript('main') %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.12.4/dist/sweetalert2.all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/izitoast@1.4.0/dist/js/iziToast.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/dayjs@1/dayjs.min.js"></script> --%>