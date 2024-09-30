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
    .form-control:focus{
        box-shadow: none;
        border: 1px solid #eee;
    }
    .form-group label{
        display: inline-block;
        font-size: 14px;
        font-weight: normal;
        color: #777777;
        font-family: "Roboto", sans-serif;
    }
    input{
        display: inline-block;
        border: none;
        width: 100px;
        font-size: 12px;
        color: #777777;
        font-family: "Roboto", sans-serif;
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
                    aria-controls="home" aria-selected="true">Atur Informasi Toko</a>
            </li>
        </ul>
        <div class="tab-content" id="myTabContent">
            <div class="tab-pane fade" id="home" role="tabpanel" aria-labelledby="home-tab">
                <form>
                    <div class="row">
                        <div class="col-5 mt-4 text-center">
                            <h3 class="text-center">Upload Profile Toko</h3>
                            <div class="form-group d-grid">
                            <a data-toggle="modal" data-target="#imageModal" class="d-flex justify-content-center">
                                <img id="image-preview" style="display:none; cursor:pointer;" class="img-fluid"/>
                            </a>
                            <div class="pt-3">
                                <label class="text-center genric-btn primary-border" for="transfer-image">Choose Profile Image:</label>
                            </div>
                                <div class="">
                                    <input type="file" id="transfer-image" name="transferImage" accept="image/*" required style="border:none;">
                                </div>
                            </div>
                            <div class="modal fade" id="imageModal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                                    <div class="modal-content" style="background: none; border: none;">
                                        <div class="modal-header" style="border-bottom: none;">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body" style="background: none;">
                                            <img id="modal-image" src="" class="img-fluid" style="width: 100%; height: auto;"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-7 mt-5">
                            <div class="form-group">
                                <label>Nama Toko</label>
                                <input type="text" class="form-control" name="vendorname" id="vendorname" placeholder="My Vendor" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="deksripsitoko">Deskripsi Toko</label>
                                <textarea class="form-control" id="vendordesc" name="vendordesc" placeholder="Description" rows="3"  required></textarea>
                            </div>
                            <button type="button" class="genric-btn primary-border" data-toggle="modal" data-target="#alamatbaru">Atur Alamat Toko</button>
                            <%-- <button type="button" class="genric-btn primary-border" data-toggle="modal" data-target="#otpcode">OTP</button> --%>
                        </div>
                        <div class="modal fade" id="alamatbaru" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                <h5 class="modal-title">Alamat Baru</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                </div>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label>Email</label>
                                        <input type="email" class="form-control" name="EmailOwner" id="EmailOwner" placeholder="Vendor@gmail.com" data-required="true">
                                    </div>
                                    <div class="form-group">
                                        <label>Handphone</label>
                                        <input type="text" class="form-control" name="numberinput" id="numberinput" placeholder="012345678910" minlength="12" maxlength="14" data-required="true">
                                    </div>
                                    <div class="form-group">
                                        <label>Province</label>
                                        <select id="provinsi" class="py-0 m-0 country_select css province_select" >
                                            <option class="css" value="0">Choose Province</option>
                                            <ul class="list">
                                                
                                            </ul>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label class="pt-3">Regency</label>
                                        <select id="regency" class=" py-0 m-0 country_select css regency_select" >
                                            <option class="css" value="0">Choose regency</option>
                                            <ul class="list">
                                                
                                            </ul>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label class="pt-3">Address Detail</label>
                                        <input type="text" class="form-control" name="address" id="address" placeholder="Jl. alamat" data-required="true">
                                    </div>
                                    <div class="form-group">
                                        <label>Postal</label>
                                        <input type="text" class="form-control postalcode" name="postal" id="postal" placeholder="60172" data-required="true" readonly>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="genric-btn default-border" data-dismiss="modal">Close</button>
                                </div>
                            </div>
                            </div>
                        </div>
                        <div class="modal fade" id="otpcode" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
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
                                        <button id="sentotp" class="primary-btn float-right" style="border-radius: 3px; border: none; line-height: 2.5rem">Sent</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <button id="newVendor" class="primary-btn float-right mt-2 mr-2" style="border-radius: 3px; border: none">Create</button>
                </form>
            </div>
        </div>
    </div>

   
    
</div>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var listRajoProv = document.getElementById('provinsi');
            var listRajoReg = document.getElementById('regency');
            var ulListProv = listRajoProv.parentElement.querySelector('.list');
            var ulListReg = listRajoReg.parentElement.querySelector('.list');

            if (ulListProv) {
                ulListProv.classList.add('css');
            }
            if (ulListReg) {
                ulListReg.classList.add('css');
            }
        });
    </script>