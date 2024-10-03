    <style>
        .mainchat {
            height: 700px;
            max-height: 700px;
        }
        .chat-content {
            flex-grow: 1;
            overflow-y: auto;
            max-height: calc(700px - 10px);
        }
        .SideBar .sidechat .listchat{
            background-color: transparent;
            transition: .2s ease-in;
            cursor: pointer;
        }
        .SideBar .sidechat .listchat:hover{
            background-color: #fff;
        }
    </style>
<section class="banner-area organic-breadcrumb"
    style="background: url($SiteConfig.Background.getURL()) center no-repeat;background-size: cover; position: relative ">
    <div class="container">
        <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
            <div class="col-first">
                <h1>Chat</h1>
                <nav class="d-flex align-items-center">
                    <a href="{$BaseHref}">Home<span class="lnr lnr-arrow-right"></span></a>
                    <a href="{$BaseHref}/chat">Chat</a>
                </nav>
            </div>
        </div>
    </div>
</section>
<% if $UserID != $ChatID %>
<p>$ChatID</p>
<p>$Vendors.Vendor.ID</p>
<div class="container d-flex my-5" style="background-color: #e8f0f2; border-radius: 20px; height: 700px;">
    <div class="SideBar col-4 p-0">
        <div class="header pl-3 py-4">
            <h4 class="m-0" style="color: #000">Chat</h4>
            <div class="input-group pt-3 pr-5">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="inputGroup-sizing-default"><i class='bx bx-search' ></i></span>
                </div>
                <input type="text" class="form-control" placeholder="Cari Pengguna" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" style="box-shadow: none;">
            </div>
        </div>
        <% loop $Chat %> 
            <% if $ToID == $Up.UserID  %>
                <div class="sidechat">
                    <div class="listchat px-1 py-2 d-flex align-items-center" style="border-radius: 30px;">
                        <div class="col-3">
                            <% with $Up.Vendor.ProfilImage %>
                                <img src="$URL" class="img-fluid" style="border-radius: 50%; object-fit: cover; aspect-ratio: 1/1;">
                            <% end_with %>
                        </div>
                        <div class="d-flex flex-column justify-content-between py-1 col-9 px-0 pr-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <h5 class="m-0" style="font-weight: 400; color: #000;">$Vendor.Name</h5>
                                <% if $Vendor %>
                                    <p class="m-0" style="font-size: 13px; font-weight: 500; color: darkorange; background-color: #ffa5004a; padding: .2rem .4rem; border-radius: 10px;">penjual</p>
                                <% else %>
                                <% end_if %>
                                <% if $Date %>                        
                                    <p class="m-0" style="font-size: 12px;">1 Okt</p>
                                <% end_if %>
                            </div>
                            <% if $Message %>
                                <p class="m-0" style="color: #707070;">Bisa dikirim hari ini</p>
                            <% end_if %>
                        </div>
                    </div>
                </div>
            <% else %>
            <% end_if %>
        <% end_loop %>
    </div>
    <div class="mainchat col-8 d-flex flex-column justify-content-between px-0">
        <div class="listchat py-1 d-flex align-items-center">
            <% with $Vendor.ProfilImage %>
                <img src="$URL" class="img-fluid mr-3 " style="border-radius: 50%; width: 60px; height: 60px; object-fit: cover;">
            <% end_with %>
            <div class="d-flex flex-column justify-content-around py-3 col-10 px-0 pr-3">
                <div class="d-flex align-items-center">
                    <h5 class="m-0" style="font-weight: 400; color: #000;">$Vendor.Name</h5>
                    <p class="m-0 ml-5" style="font-size: 13px; font-weight: 500; color: darkorange; background-color: #ffa5004a; padding: .2rem .4rem; border-radius: 10px;">penjual</p>
                </div>
                <p class="m-0" style="color: #707070;">Terakhir online 29 menit yang lalu</p>
            </div>
        </div>

        <div class="chat-content px-3 flex-grow-1 overflow-auto d-flex flex-column-reverse" style="max-height: calc(100vh - 150px); overflow-y: auto;">
            <% if $Vendor %>
                <% if $User.ID == UserID %>
                    <div class="d-flex align-items-end justify-content-end mb-3">
                        <div class="bubble-right" style="background-color: #d1ecf1; padding: 10px 15px; border-radius: 20px; max-width: 70%; word-break: break-word;">
                            <p class="m-0" style="color: #000;">Tidak perlu, sudah lengkap.</p>
                        </div>
                    </div>
                <% else %>
                    <div class="d-flex align-items-start mb-3">
                        <% with $Vendor.ProfilImage %>
                            <img src="$URL" class="img-fluid mr-3" style="border-radius: 50%; width: 40px;">
                        <% end_with %>
                        <div class="bubble-left" style="background-color: #fff; padding: 10px 15px; border-radius: 20px; max-width: 70%; word-break: break-word;">
                            <p class="m-0" style="color: #000;">Bisa dikirim hari ini, ada yang perlu ditambahkan? ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafffffffffffffffffffffffffffffffffffffffffffffffffffff</p>
                        </div>
                    </div>
                <% end_if %>
            <% else %>
                <% if $User.ID == UserID %>
                    <div class="d-flex align-items-end justify-content-end mb-3">
                        <div class="bubble-right" style="background-color: #d1ecf1; padding: 10px 15px; border-radius: 20px; max-width: 70%; word-break: break-word;">
                            <p class="m-0" style="color: #000;">Tidak perlu, sudah lengkap.</p>
                        </div>
                    </div>
                <% else %>
                    <div class="d-flex align-items-start mb-3">
                        <% with $Vendor.ProfilImage %>
                            <img src="$URL" class="img-fluid mr-3" style="border-radius: 50%; width: 40px;">
                        <% end_with %>
                        <div class="bubble-left" style="background-color: #fff; padding: 10px 15px; border-radius: 20px; max-width: 70%; word-break: break-word;">
                            <p class="m-0" style="color: #000;">Bisa dikirim hari ini, ada yang perlu ditambahkan? ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafffffffffffffffffffffffffffffffffffffffffffffffffffff</p>
                        </div>
                    </div>
                <% end_if %>
            <% end_if %>
        </div>

        <div class="chat-input px-3 py-2">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Tulis pesan..." style="box-shadow: none; border-radius: 20px;">
                <div class="input-group-append">
                    <span class="input-group-text bg-transparent border-0" style="cursor: pointer;">
                        <i class='bx bx-send' style="font-size: 24px; color: #000;"></i>
                    </span>
                </div>
            </div>
        </div>
    </div>
</div>
<% else %>
    <p>a</p>
<% end_if %>