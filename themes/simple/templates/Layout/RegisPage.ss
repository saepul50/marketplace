<!-- Start Banner Area -->
<section class="banner-area organic-breadcrumb" style ="background: url($SiteConfig.Background.getURL()) center no-repeat;background-size: cover; position: relative ">
    <div class="container">
        <div class="breadcrumb-banner d-flex flex-wrap align-items-center justify-content-end">
            <div class="col-first">
                <h1>Register</h1>
                <nav class="d-flex align-items-center">
                    <a href="{$BaseHref}">Home<span class="lnr lnr-arrow-right"></span></a>
                    <a href="{$BaseHref}/regis">Register</a>
                </nav>
            </div>
        </div>
    </div>
</section>
<!-- End Banner Area -->

<%-- regis --%>
<section class="login_box_area section_gap">
    <div class="container">
        <div class="row">
            <div class="col-lg-6">
                <div class="login_box_img">
                    <img class="img-fluid" src="$SiteConfig.LoginImage.getURL()" alt="">
                    <div class="hover">
                        <h4>New to our website?</h4>
                        <p>There are advances being made in science and technology everyday, and a good example of this is the</p>
                        <a class="primary-btn" href="{$BaseHref}/login">Do You Have Account?</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="login_form_inner" style="padding-top:20px !important;">
                    <h3>Registrasi</h3>
                    <form class="row login_form"  method="post" id="regisform" >
                        <div class="col-md-12 form-group">
                            <input type="text" class="form-control" id="firstname" name="firstname" placeholder="FirstName" onfocus="this.placeholder = ''" onblur="this.placeholder = 'FirstName'" required>
                        </div>
                         <div class="col-md-12 form-group">
                            <input type="text" class="form-control" id="Surname" name="Surname" placeholder="Username" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Username'" required>
                        </div>
                         <div class="col-md-12 form-group">
                            <input type="email" class="form-control" id="email" name="email" placeholder="Email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email'" required>
                        </div>                        
                        <div class="col-md-12 form-group">
                            <input type="password" class="form-control" id="password" name="password" placeholder="Password" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Password'"  minlength="8" required>
                        </div>
                        <div class="col-md-12 form-group">
                            <input type="password" class="form-control" id="password2" name="password2" placeholder="Confirm Password" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Confirm Password'"  minlength="8" required>
                        </div>
                        <div class="col-md-12 form-group">
                            <div class="creat_account">
                                <input type="checkbox" id="f-option2" name="selector">
                                <label for="f-option2">Keep me logged in</label>
                            </div>
                        </div>
                        <div class="col-md-12 form-group">
                            <button type="submit" value="submit" class="primary-btn">Log In</button>
                            <a href="#">Forgot Password?</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>


<script>
    $(document).ready(function () {
  $("#regisform").submit(function () {
    $.post("http://localhost/marketplace/regis/prosesregister", 
    {
        FirstName: $("#firstname").val(),
        Email: $("#email").val(),
        Username: $("#Surname").val(),
        Password: $("#password").val(),
        ConfirmPassword: $("#password2").val()
    })
      .done(function (data) {
        var response = JSON.parse(data);
        if (response.success) {
          Swal.fire({
            title: "SUCCESS",
            text: "Click to go log in page",
            icon: "success",
            confirmButtonColor: "#3085d6",
            confirmButtonText: "GO"
          }).then((result) => {
            if (result.isConfirmed) {
              window.location.href = "http://localhost/marketplace/login"; // Replace with your actual redirect URL
            }
          });
        } else {
          Swal.fire({
            icon: "error",
            title: "Oops...",
            text: response.message,
            showConfirmButton: false,
            timer: 1500
          });
        }

      }).fail(function () {
        Swal.fire({
          icon: "error",
          title: "Error",
          text: "There was an issue with your registration. Please try again later.",
          confirmButtonColor: "#d33",
        });
      });

    return false; // Ensure no form submission (and thus no refresh)
  });
});
</script>


