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
            transition: background-color 0.2s ease-in;
            cursor: pointer;
        }
        .SideBar .sidechat .listchat:hover {
            background-color: #fff;
        }

        .SideBar .sidechat.selected .listchat {
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
<div class="container d-flex my-5" style="background-color: #e8f0f2; border-radius: 20px; height: 700px;">
    <div class="SideBar col-4 p-0" style="margin-left: -1rem; border-radius: 25px; background-color: #f2f2f2;">
        <div class="header pl-5 py-4">
            <h4 class="m-0" style="color: #000">Chat</h4>
            <div class="input-group pt-3 pr-5">
                <div class="input-group-prepend">
                    <span class="input-group-text" id="inputGroup-sizing-default"><i class='bx bx-search' ></i></span>
                </div>
                <input type="text" class="form-control" placeholder="Cari Pengguna" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default" style="box-shadow: none;">
            </div>
        </div>
        <% if $ChatList %>
            <% loop $ChatList.Sort('LastEdited', DESC) %>
                <% if $ReceiverID == CurrentMember.ID %>
                    <div class="sidechat" data-receiver="$SenderID" data-sender="$CurrentMember.ID">
                <% else %>
                    <div class="sidechat" data-receiver="$ReceiverID" data-sender="$CurrentMember.ID">
                <% end_if %>
                    <div class="listchat px-1 py-2 d-flex align-items-center" style="border-radius: 30px;">
                        <div class="col-3">
                        <% if $ReceiverID == $CurrentMember.ID %>
                            <% if $Vendor.exists %>
                                <% with $Vendor.ProfilImage %>
                                    <img src="$Up.Vendor.ProfilImage.URL" class="img-fluid" style="border-radius: 50%; object-fit: cover; aspect-ratio: 1/1;">
                                <% end_with %>
                            <% else %>
                                <% with $Sender.ProfileImage %>
                                    <img src="$URL" class="img-fluid" style="border-radius: 50%; object-fit: cover; aspect-ratio: 1/1;">
                                <% end_with %>
                            <% end_if %>
                        <% else %>
                            <% if $Vendor.exists %>
                                <% with $Vendor.ProfilImage %>
                                    <img src="$Up.Vendor.ProfilImage.URL" class="img-fluid" style="border-radius: 50%; object-fit: cover; aspect-ratio: 1/1;">
                                <% end_with %>
                            <% else %>
                                <% with $Receiver.ProfileImage %>
                                    <img src="$URL" class="img-fluid" style="border-radius: 50%; object-fit: cover; aspect-ratio: 1/1;">
                                <% end_with %>
                            <% end_if %>
                        <% end_if %>
                        </div>
                        <div class="d-flex flex-column justify-content-between py-1 col-9 px-0 pr-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <% if $Vendor.exists %>
                                    <h5 class="m-0" style="font-weight: 400; color: #000;">$Vendor.Name</h5>
                                <% else %>
                                    <h5 class="m-0" style="font-weight: 400; color: #000;">$chatMain.FirstName</h5>
                                <% end_if %>
                                
                                <% if $Vendor.exists %>
                                    <p class="m-0" style="font-size: 13px; font-weight: 500; color: darkorange; background-color: #ffa5004a; padding: .2rem .4rem; border-radius: 10px;">penjual</p>
                                <% end_if %>
                                
                                <% if $Date %>
                                    <p class="m-0" style="font-size: 12px;">$Date.Format('d/M')</p>
                                <% end_if %>
                            </div>
                            <% if $LastMessage %>
                                <p class="m-0" style="color: #707070;">$LastMessage.Message</p>
                            <% end_if %>
                        </div>
                    </div>
                </div>
            <% end_loop %>
        <% else_if $chatMain %>
            <div class="sidechat">
                <div class="listchat px-1 py-2 d-flex align-items-center" style="border-radius: 30px;">
                    <div class="col-3">
                        <% with $Vendor.ProfilImage %>
                            <img src="$URL" class="img-fluid" style="border-radius: 50%; object-fit: cover; aspect-ratio: 1/1;">
                        <% end_with %>
                    </div>
                    <div class="d-flex flex-column justify-content-between py-1 col-9 px-0 pr-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="m-0" style="font-weight: 400; color: #000;">$Vendor.Name</h5>
                            <p class="m-0" style="font-size: 13px; font-weight: 500; color: darkorange; background-color: #ffa5004a; padding: .2rem .4rem; border-radius: 10px;">penjual</p>
                        </div>
                    </div>
                </div>
            </div>
        <% end_if %>
    </div>

    <div class="mainchat col-8 d-flex flex-column justify-content-between px-0">
        <div class="listchat py-1 pl-3 pt-4 d-flex align-items-center">
            <% if $chatMain %>
                <% if $SenderVendor %>
                    <img src="$Vendor.ProfilImage.URL" class="img-fluid mr-3 " style="border-radius: 50%; width: 60px; height: 60px; object-fit: cover;">
                <% else %>
                    <img src="$chatMain.ProfileImage.URL" class="img-fluid mr-3 " style="border-radius: 50%; width: 60px; height: 60px; object-fit: cover;">
                <% end_if %>
                <div class="d-flex flex-column justify-content-around py-3 col-10 px-0 pr-3">
                    <div class="d-flex align-items-center">
                        <% if $SenderVendor %>
                            <h5 class="m-0" style="font-weight: 400; color: #000;">$Vendor.Name</h5>
                        <% else %>
                            <h5 class="m-0" style="font-weight: 400; color: #000;">$chatMain.FirstName</h5>
                        <% end_if %>
                        <% if $SenderVendor %>
                            <p class="m-0 ml-3" style="font-size: 13px; font-weight: 500; color: darkorange; background-color: #ffa5004a; padding: .2rem .4rem; border-radius: 10px;">penjual</p>
                        <% end_if %>
                    </div>
                    <%-- <p class="m-0" style="color: #707070;">
                        <% with $chatMain %>
                            <% if $isOnline %>
                                Online
                            <% else_if $LastLogin %>
                                Terakhir online $LastLogin.Format('d-m-Y H:i:s')
                            <% else %>
                                Tidak pernah login
                            <% end_if %>
                        <% end_with %>
                    </p> --%>
                </div>
            </div>

            <div class="chat-content px-3 flex-grow-1 overflow-auto d-flex flex-column-reverse" style="max-height: calc(100vh - 150px); overflow-y: auto;">
                <% if $Messages %>
                    <% loop $Messages %>
                        <% if $Sender.ID == $CurrentMember.ID %>
                            <div class="d-flex align-items-end justify-content-end mb-3">
                                <div class="bubble-right" style="background-color: #d1ecf1; padding: 10px 15px; border-radius: 20px; max-width: 70%; word-break: break-word;">
                                    <p class="m-0" style="color: #000;">$Message</p>
                                    <small class="d-flex justify-content-end">$Time.Format('HH.MM')</small>
                                </div>
                            </div>
                        <% else %>
                            <div class="d-flex align-items-center mb-3">
                                <% if $IsVendor %>
                                    <% with $Up.Vendor.ProfilImage %>
                                        <img src="$URL" class="img-fluid mr-3" style="border-radius: 50%; width: 40px;">
                                    <% end_with %>
                                <% else %>
                                    <% with $Sender.ProfileImage %>
                                        <img src="$URL" class="img-fluid mr-3" style="border-radius: 50%; width: 40px;">
                                    <% end_with %>
                                <% end_if %>
                                <div class="bubble-left" style="background-color: #fff; padding: 10px 15px; border-radius: 20px; max-width: 70%; word-break: break-word;">
                                    <p class="m-0" style="color: #000;">$Message</p>
                                    <small class="d-flex justify-content-end">$Time.Format('HH.MM')</small>
                                </div>
                            </div>
                        <% end_if %>
                    <% end_loop %>
                <% end_if %>
            <% else_if $ChatVendor %>
            <p>b</p>
                <% with $ChatVendor.ProfilImage %>
                    <img src="$URL" class="img-fluid mr-3 " style="border-radius: 50%; width: 60px; height: 60px; object-fit: cover;">
                <% end_with %>
                <div class="d-flex flex-column justify-content-around py-3 col-10 px-0 pr-3">
                    <div class="d-flex align-items-center">
                        <h5 class="m-0" style="font-weight: 400; color: #000;">$ChatVendor.Name</h5>
                        <p class="m-0 ml-3" style="font-size: 13px; font-weight: 500; color: darkorange; background-color: #ffa5004a; padding: .2rem .4rem; border-radius: 10px;">penjual</p>
                    </div>
                </div>
            <% end_if %>
        </div>

        <div class="chat-input px-3 py-2">
            <form id="SendChat" data-receiver="$Receiver" data-sender="$CurrentUser">
                <div class="input-group">
                    <input type="text" name="Message" class="form-control" placeholder="Tulis pesan..." style="box-shadow: none; border-radius: 20px;">
                    <div class="input-group-append">
                        <button type="submit" data-owner="" class="input-group-text bg-transparent border-0" style="cursor: pointer;">
                            <i class='bx bx-send' style="font-size: 24px; color: #000;"></i>
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>