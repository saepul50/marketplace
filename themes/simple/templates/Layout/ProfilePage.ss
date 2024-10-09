    <style>
        .form-control{
            color: #000 !important;
            font-weight: 400 !important;
            font-size: 1rem !important;
        }
        .labell{
            width: 6rem;
        }
        #email-label{
            font-weight: 500;
        }
        .otp-input-wrapper {
            display: flex;
            justify-content: center;
            gap: 10px;
        }

        .otp-input {
            width: 40px;
            height: 50px;
            text-align: center;
            font-size: 24px;
            border: 1px solid #ccc;
            border-radius: 5px;
            text-transform: uppercase;
        }
    </style>
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
<section id="ProfileMainpage">
    <div class="py-2" style="background-color: #f2f2f2;">
        <div class="py-3" style="background-color: #fff">
            <a href="{$BaseHref}/profile/?account" class="d-flex justify-content-between align-items-center col-10"  style="color:black;">
                <div class="d-flex ml-2">
                    <i class='bx bx-user' style="color: darkblue; font-size: 26px;"></i>
                    <p class="ml-3 m-0" style="font-weight: 500;">Akun Saya</p>
                </div>
            </a>
        </div>
        <% if $Vendor %>
            <div class="py-3 d-flex align-items-center" style="background-color: #fff">
                <a href="{$BaseHref}/venn/$Vendor.Pathname" class="d-flex justify-content-between align-items-center col-10"  style="color:black;">
                    <div class="d-flex ml-2">
                        <i class='bx bx-store' style="font-size: 30px; color: darkorange;"></i>
                        <p class="ml-3 m-0 d-flex align-items-center" style="font-weight: 500;">Toko Saya</p>
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
                        <i class='bx bx-store' style="font-size: 30px; color: darkorange;"></i>
                        <p class="ml-3 m-0" style="font-weight: 500;">Mulai Jual</p>
                    </div>
                </a>
                <a href="{$BaseHref}/vendorregistration" class="col-2 d-flex justify-content-end">
                    <p class="mr-3 m-0" style="color: #000;">Registrasi Gratis ></p>
                </a>
            </div>
        <% end_if %>
        <div class="py-3" style="background-color: #fff">
            <a href="{$BaseHref}/confirm" class="d-flex justify-content-between align-items-center col-10"  style="color:black;">
                <div class="d-flex ml-2">
                    <i class='bx bx-time-five' style="color: red; font-size: 26px;"></i>
                    <p class="ml-3 m-0" style="font-weight: 500;">History Order</p>
                </div>
            </a>
        </div>
    </div>
</section>
<section id="ProfileAccountSec" style="background-color: #fafafa;">
    <div style="height: .5rem;"></div>
    <div class="container d-flex px-5 py-4 my-5" style="background-color: #fff;">
        <div class="leftProfile col-8" style="border-right: 2px solid #eee;">
            <div class="header my-3 py-1" style="border-bottom: 2px solid #eee;">
                <h5 class="m-0" style="font-weight: 500; color: #000;">Profil Saya</h5>
                <p class="m-0" style="font-weight: 400; color: #000;">Kelola informasi profil Anda untuk mengontrol, melindungi, dan mengamankan akun</p>
            </div>
            <div class="mainProfile py-4">
                <form class="contact_form" id="profilechange">
                    <div class="form-group d-flex align-items-center" style="gap: 1rem;">
                        <label class="m-0 labell">FirstName</label>
                        <input class="d-none" type="text" class="form-control" id="userid" value="<% if $Account %>$Account.ID<% end_if %>">
                        <input type="text" class="form-control" id="firstname" required value="<% if $Account %>$Account.FirstName<% end_if %>">
                    </div>
                    <div class="form-group d-flex align-items-center" style="gap: 1rem;">
                        <label class="m-0 labell">LastName</label>
                        <input type="text" class="form-control" id="lastname" value="<% if $Account %>$Account.Surname<% end_if %>">
                    </div>
                    <div class="form-group d-flex align-items-center" style="gap: 1rem;">
                        <label class="m-0 labell">Email</label>
                        <label class="m-0" id="email-label"><% if $Account %>$Account.Email<% end_if %></label>
                        <h6 class="m-0" style="color: blue !important; font-size: 12px; font-weight: 500; text-decoration: underline; cursor: pointer;" id="reqChangePass">ganti password</h6>
                    </div>
                    <button type="submit" class="primary-btn" style="border: none; border-radius: 3px;">Simpan</button>
                </form>
            </div>
        </div>
        <div class="rightProfile d-flex flex-column align-items-center justify-content-center col-4">
            <div class="mainProfileImage p-0 d-flex flex-column align-items-center">
                <div class="imagep col-10">
                    <img id="image-preview" src="$Account.ProfileImage.URL" class="img-fluid" style="border-radius: 50%; aspect-ratio: 1/1; object-fit: cover;">
                </div>
                <label class="text-center genric-btn primary-border mt-2" for="transfer-image">Pilih Gambar</label>
                <input class="d-none" type="file" id="transfer-image" name="transferImage" accept="image/*" required style="border:none;">
                <%-- <button type="submit" class="genric-btn primary-border mt-3" style="border: none; border-radius: 3px;">Pilih Foto</button> --%>
            </div>
        </div>
    </div>
    <div style="height: .5rem;"></div>
</section>
<div class="modal fade" id="OTPCodeChangePass" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form id="sentOTPChangePass">
                <div class="modal-header">
                    <h5 class="modal-title text-center">Masukkan Kode OTP</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="otp-input-wrapper">
                        <input type="text" maxlength="1" class="otp-input" id="otp1">
                        <input type="text" maxlength="1" class="otp-input" id="otp2">
                        <input type="text" maxlength="1" class="otp-input" id="otp3">
                        <input type="text" maxlength="1" class="otp-input" id="otp4">
                        <input type="text" maxlength="1" class="otp-input" id="otp5">
                        <input type="text" maxlength="1" class="otp-input" id="otp6">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="genric-btn default-border" data-dismiss="modal">Close</button>
                    <button type="submit" class="genric-btn primary-border" style="border-radius: 3px; border: none; line-height: 2.5rem">Sent</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="modal fade" id="ChangePass" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <form class="contact_form" id="sentOTPChangePass">
                <div class="modal-header">
                    <h5 class="modal-title text-center">Masukkan Password Baru</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group d-flex align-items-center" style="gap: 1rem;">
                        <label class="m-0 labell" style="width: 12rem;">Password Baru</label>
                        <input type="text" class="form-control" id="newpass" required>
                    </div>
                    <div class="form-group d-flex align-items-center" style="gap: 1rem;">
                        <label class="m-0 labell" style="width: 12rem;">Konfirmasi Password</label>
                        <input type="text" class="form-control" id="confpass" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="genric-btn default-border" data-dismiss="modal">Close</button>
                    <button type="submit" class="genric-btn primary-border">Sent</button>
                </div>
            </form>
        </div>
    </div>
</div>
    <script>
        $('.nav-item#profile').addClass('active');
    </script>