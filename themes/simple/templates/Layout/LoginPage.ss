<!-- Start Banner Area -->
<section class="banner-area organic-breadcrumb" style ="background: url($SiteConfig.Background.getURL()) center no-repeat;background-size: cover; position: relative ">
    <div class="container">
        <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
            <div class="col-first">
                <h1>Login</h1>
                <nav class="d-flex align-items-center">
                    <a href="{$BaseHref}">Home<span class="lnr lnr-arrow-right"></span></a>
                    <a href="{$BaseHref}/login">Login</a>
                </nav>
            </div>
        </div>
    </div>
</section>
<!-- End Banner Area -->

<!--================Login Box Area =================-->
<section class="login_box_area section_gap">
    <div class="container login" id="loginpageId">
        <div class="row">
            <div class="col-lg-6">
                <div class="login_box_img">
                    <img class="img-fluid" src="$SiteConfig.LoginImage.getURL()" alt="">
                    <div class="hover">
                        <h4>New to our website?</h4>
                        <p>There are advances being made in science and technology everyday, and a good example of this is the</p>
                        <button class="primary-btn" id="showRegister" style="border: none;">Create an Account</button>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="login_form_inner" style="padding-top: 110px !important;">
                    <h3>Log in to enter</h3>
                    <form class="row login_form"  method="post" id="loginForm" >
                        <div class="col-md-12 form-group">
                            <input type="email" class="form-control" id="emaillogin" placeholder="Email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email'" required value="<% if $Member %>$Member.Email<% else %><% end_if %>">
                        </div>
                        <div class="col-md-12 form-group">
                            <input type="password" class="form-control" id="passwordlogin" name="password" placeholder="Password" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Password'" required value="<% if $Member %>$Member.FirstName<% else %><% end_if %>">
                        </div>
                        <div class="col-md-12 form-group">
                            <div class="creat_account">
                                <input type="checkbox" id="f-option2" name="selector" required >
                                <label for="f-option2">Keep me logged in</label>
                            </div>
                        </div>
                        <div class="col-md-12 form-group">
                            <button id="loginn" class="primary-btn">Log In</button>
                            <a style="cursor:pointer;" data-toggle="modal" data-target="#exampleModalCenter">Forgot Password?</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="container register" id="registerpageId" style="display: none;">
        <div class="row">
            <div class="col-lg-6">
                <div class="login_form_inner p-0">
                    <h3 class="m-0 pt-4">Registrasi</h3>
                    <form class="row login_form" method="post" id="contactForm1" novalidate="novalidate">
                        <div class="col-md-12 form-group">
                            <input type="text" class="form-control" id="username" placeholder="Username" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Username'">
                        </div>
                        <div class="col-md-12 form-group">
                            <input type="text" class="form-control" id="surname" placeholder="Surname" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Surname'">
                        </div>
                        <div class="col-md-12 form-group">
                            <input type="text" class="form-control" id="emailregister" placeholder="Email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email'">
                        </div>
                        <div class="col-md-12 form-group">
                            <input type="password" class="form-control" id="passwordregister" placeholder="Password" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Password'">
                        </div>
                        <div class="col-md-12 form-group">
                            <input type="password" class="form-control" id="confirmpassword" placeholder="Confirm Password" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Confirm Password'">
                        </div>
                        <div class="col-md-12 form-group">
                            <button id="register" class="primary-btn">register</button>
                        </div>  
                    </form>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="login_box_imge">
                    <img class="img-fluid" src="$SiteConfig.LoginImage.getURL()" alt="">
                    <div class="hover">
                        <h4>New to our website?</h4>
                        <p>There are advances being made in science and technology everyday, and a good example of this is the</p>
                        <button class="primary-btn" id="showLogin" style="border: none;">Login an Account</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%-- Modal Forget PassWord --%>

<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <form  method="post" id="forgetpass">
                <div class="modal-header">
                    <h5 class="modal-title text-center">Masukkan Password Baru</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group d-flex align-items-center" style="gap: 1rem;">
                        <label class="m-0 labell" style="width: 12rem;">Email</label>
                        <input type="email" class="form-control" id="inputEmail4" placeholder="Email">
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
    document.getElementById('showRegister').addEventListener('click', function() {
        document.getElementById('loginpageId').style.display = 'none';
        document.getElementById('registerpageId').style.display = 'block';
    });

    document.getElementById('showLogin').addEventListener('click', function() {
        document.getElementById('registerpageId').style.display = 'none';
        document.getElementById('loginpageId').style.display = 'block';
    });
    $('.nav-item#login').addClass('active');
</script>