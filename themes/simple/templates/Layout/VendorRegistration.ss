<style>
    .css{
        width:100%;
        margin-top: .5rem;
    }
    canvas {
        display: block;
        margin: 10px 0;
        width: 300px;
        height: 300px; 
        border: 2px solid #343a40;
        background-color: #f8f9fa;
        margin-left:auto;
        margin-right:auto;
        margin-bottom: 20px;
    }
    input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}
      input {
        font-family: verdana;
        font-size: 12pt;
      }
      .custom-upload-button {
        display: inline-block;
        font-size: 12pt;
        font-family: Verdana, sans-serif;
        color: white;
        background-color: #007bff;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    .custom-upload-button:hover {
        background-color: #0056b3;
    }
    input[type="file"] {
        display: none;
    }
</style>

<section class="banner-area organic-breadcrumb" style ="background: url($SiteConfig.Background.getURL()) center no-repeat;background-size: cover; position: relative ">
    <div class="container">
        <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
            <div class="col-first">
                <h1>Registration</h1>
                <nav class="d-flex align-items-center">
                    <a href="{$BaseHref}">Home<span class="lnr lnr-arrow-right"></span></a>
                    <a href="{$BaseHref}/tracking">Registration</a>
                </nav>
            </div>
        </div>
    </div>
</section>
<!-- End Banner Area -->

<div class="container shadow p-3 mt-5 mb-5 bg-white rounded" style="    padding-bottom: 2rem !important;">
    <div class="header pt-3">
        <h3>Profile Toko</h3>
        <span class="text-muted">Lihat Profil Toko dan Status Toko</span>
        <hr>
    </div>
    <div class="content pb-5">
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item">
                <a class="nav-link nav-linked" name="tabs" id="home-tab" data-toggle="tab" href="home" role="tab"
                    aria-controls="home" aria-selected="true"value="Description">Informasi Dasar</a>
            </li>
            
        </ul>
        <div class="tab-content" id="myTabContent">
            <div class="tab-pane fade" id="home" role="tabpanel" aria-labelledby="home-tab">
                <% if not $Toko %>
                    <form method="post" id="profileform">
                        <div class="row">
                                <div class="col-5 mt-4 text-center">
                                    <h3 class="text-center">Upload Profile Toko</h3>
                                    <canvas id= "canv1" src="$ImageBase64"  width="1300" height="1300"></canvas>
        
                                    <label for="finput" class="custom-upload-button text-center primary-btn" style="border-radius: 5px; border: none">Upload Image</label>
                                    <input type="file" multiple="false" name="image" accept="image/*" id="finput" onchange="upload()" required>
                                    <img id="img" class="d-none" src="">
                                </div>
                                <div class="col-7 mt-5">
                                        <div class="form-group">
                                        <label for="namatoko">Nama Toko</label>
                                        <input type="text" class="form-control" name="namatoko" id="namatoko" aria-describedby="namatoko" placeholder="Nama Toko"  required>
                                        </div>
                                        <div class="form-group">
                                        <label for="namatoko">Email</label>
                                        <input type="email" class="form-control" name="Email" id="Email" aria-describedby="Email" placeholder="Email"  required>
                                        </div>
                                        <div class="form-group">
                                        <label for="namatoko">Nomer HandPhone</label>
                                        <input type="text" class="form-control" name="NomerHandPhone" id="NomerHandPhone" minlength="10" maxlength="13" aria-describedby="nomorhandphone"  value="$NomerHandPhone" placeholder="Nomer HandPhone" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="deksripsitoko">Deskripsi Toko</label>
                                            <textarea class="form-control" id="deskripsitoko" name="deskripsitoko" placeholder="Deskripsi Toko" rows="3"  required></textarea>
                                        </div>
                                        <div class="form-group">
                                            <select id="provinsi" class=" country_select css province_select" >
                                            <option class="css" value="0">Choose Province</option>
                                            <ul class="list css">
                                                
                                            </ul>
                                            </select>
                                        </div>
                                        <div class="form-group mt-2" style="width:100%;">
                                            <select id="regency" class="country_select css regency_select" >
                                            <option class="css" value="0">Choose regency</option>
                                            <ul class="list">
                                                
                                            </ul>
                                            </select>
                                        </div>
                                </div>
                        </div>
                            <button type="submit" value="submit" class="primary-btn float-right mt-2 mr-2" style="border-radius: 5px; border: none">Create</button>
                    </form>
                    <% else %>
                        <form method="post" id="editprofileform">
                            <div class="row">
                                <% loop $Toko %>
                                    <div class="col-5 mt-4 text-center">
                                        <h3 class="text-center">Profile Toko</h3>
                                        <canvas id= "canv1" src="$ImageBase64"  width="1300" height="1300"></canvas>
            
                                        <label for="finput" class="custom-upload-button text-center primary-btn" style="border-radius: 5px; border: none">Change Image</label>
                                        <input type="file" multiple="false" name="image" accept="image/*" id="finput" onchange="upload()" >
                                        <img id="img" class="d-none" src="$ImageBase64">
                                    </div>
                                    <div class="col-7 mt-5">
                                            <div class="form-group">
                                            <label for="namatoko">Nama Toko</label>
                                            <input type="text" class="form-control" name="namatoko" id="namatoko" aria-describedby="namatoko" placeholder="Nama Toko" value="$NamaToko" required>
                                            </div>
                                            <div class="form-group">
                                            <label for="namatoko">Email</label>
                                            <input type="email" class="form-control" name="Email" id="Email" aria-describedby="Email" placeholder="Email" value="$Email" required>
                                            </div>
                                            <div class="form-group">
                                            <label for="namatoko">Nomer HandPhone</label>
                                            <input type="text" class="form-control" name="NomerHandPhone" id="NomerHandPhone" minlength="10" maxlength="13" aria-describedby="nomorhandphone"  value="$NomerHandPhone" placeholder="Nomer HandPhone" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="deksripsitoko">Deskripsi Toko</label>
                                                <textarea class="form-control" id="deskripsitoko" name="deskripsitoko" placeholder="Deskripsi Toko" rows="3"  required>$DeskripsiToko</textarea>
                                            </div>
                                            <div class="form-group">
                                                <select id="provinsi" class=" country_select css province_select" >
                                                <option class="css" value="0">Choose Province</option>
                                                <ul class="list css">
                                                    
                                                </ul>
                                                </select>
                                            </div>
                                            <div class="form-group mt-2" style="width:100%;">
                                                <select id="regency" class="country_select css regency_select" >
                                                <option class="css" value="0">Choose regency</option>
                                                <ul class="list">
                                                    
                                                </ul>
                                                </select>
                                            </div>
                                    </div>
                                <% end_loop %>
                            </div>
                                <button type="submit" value="submit" class="primary-btn float-right mt-2 mr-2" style="border-radius: 5px; border: none">Simpan</button>
                        </form>
                <% end_if %>
            </div>
        </div>
    </div>

   
    
</div>
<script src="https://www.dukelearntoprogram.com/course1/common/js/image/SimpleImage.js"></script>
<script>
    function upload(){
        var imgcanvas = document.getElementById("canv1");
        var fileinput = document.getElementById("finput");
        var image = new SimpleImage(fileinput);
        var hiddenInput = document.getElementById("img");
        image.drawTo(imgcanvas);
        

        var reader = new FileReader();

        reader.onload = function(event){
            var imagesrc = event.target.result;
            hiddenInput.src = imagesrc;
        };

        reader.readAsDataURL(fileinput.files[0]);
      }
</script>

<% loop $Toko %>
    <script>
      var imgcanvas = "$ImageBase64";
      var canvas = document.getElementById("canv1");
      var img = new SimpleImage(imgcanvas);
      img.drawTo(canvas)
      
    </script>
<% end_loop %>





