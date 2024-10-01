const stars = document.querySelectorAll(".star");
const rating = document.getElementById("rating");
const ratingDisplay = document.getElementById('rating');
const ratingValueInput = document.getElementById('ratingValue');
stars.forEach((star) => {
  star.addEventListener("click", () => {
    const value = parseInt(star.getAttribute("data-value"));
    rating.innerText = value;

    // Remove all existing classes from stars
    stars.forEach((s) => s.classList.remove("one",
      "two",
      "three",
      "four",
      "five"));

    // Add the appropriate class to 
    // each star based on the selected star's value
    stars.forEach((s, index) => {
      if (index < value) {
        s.classList.add(getStarColorClass(value));
      }
    });

    // Remove "selected" class from all stars
    stars.forEach((s) => s.classList.remove("selected"));
    // Add "selected" class to the clicked star
    star.classList.add("selected");
  });
});
$(document).ready(function () {
  "use strict";
  $("#filtera").change(function (event) {
    event.preventDefault(); // Prevents the form from doing a default refresh
    var selected = $("#filtera").val();
    if (selected == '') {
      return;
    }
    $.post("/marketplace/shopcategory/filter", {
      select: $("#filtera").val(),
    })
      .done(function (data) {
        var response = JSON.parse(data);
        if (response.success) {
          Swal.fire({
            title: "SUCCESS",
            text: "Success",
            icon: "success",
            timer: 1000
          })
          setInterval(href, 1000);

          function href() {
            location.reload();
          }
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
          text: "There was an issue  Please try again later.",
          confirmButtonColor: "#d33",
        });
      });
  })
  var currentParams = new URLSearchParams(window.location.search);
  var pathname = window.location.pathname;
  var parts = pathname.split('/');
  var selectedBrand = currentParams.get('filter');
  var selectedSubCategory = currentParams.get('subcategory');
  // console.log(selectedSubCategory)
  if (selectedBrand) {
    $('#filterForm input[name="brand"]').each(function () {
      if ($(this).val() === selectedBrand) {
        $(this).prop('checked', true);
      }
    });
  }

  if (selectedSubCategory) {
    $('.subcategory-link').each(function () {
      // console.log($(this).data('id') == selectedSubCategory)
      if ($(this).data('id') == selectedSubCategory) {
        $(this).addClass('active').css('color', '#ffba00');
        const collapseElement = $(this).closest('ul.collapse');
        if (collapseElement.length) {
          collapseElement.collapse('show');
        }
      }
    });
  }
  $("input[name='selectorcancelled']").on('change', function() {
    if ($("#f-option17").is(':checked')) {
        $("#additionalReason").show();
    } else {
        $("#additionalReason").hide();
    }
  });
  $('#buybtn').on('click', function (e) {
    alert('dfs');
    e.preventDefault();
  });
  $('#cancelledbtn').on('click', function (e) {
    e.preventDefault();
    var orderid = $(this).data('orderid');
    var request = 'batal';
    var selectedOption = $("input[name='selectorcancelled']:checked").next('label').text();
    var additionalReason = $("#additionalReason").val();
    if (selectedOption === "Lainnya... ") {
      if(!additionalReason){
        iziToast.warning({ position: "bottomRight", title: 'Caution', message: 'Isi alasan pembatalan' });
      }
    }
    $.post("/marketplace/confirm/service", {
      Request: request,
      OrderID: orderid
    })
    .done(function (data) {
      var response = JSON.parse(data);
      if (response.success) {
        $('#cancelbtn').modal('hide');
        iziToast.success({
          icon: 'fa fa-check',
          timeout: 2000,
          title: 'Sukses',
          message: 'Pesanan telah dibatalkan',
          position: 'bottomRight',
          onClosed: function () {
            window.location.href = '/marketplace/confirm/';
          }
        });
      } else {
        iziToast.warning({ position: "bottomRight", title: 'Caution', message: 'Failed' });
      }

    }).fail(function () {
      iziToast.error({ position: "bottomRight", title: 'Error', message: 'Error' });
    });

    return false;
  });
  $('.subcategory-link').on('click', function (e) {
    e.preventDefault();
    $('.subcategory-link').removeClass('active');
    $(this).addClass('active');

    const collapseElement = $(this).closest('ul.collapse');
    if (collapseElement.length) {
      collapseElement.collapse('show');
    }
  });
  $('#sortSelect').on('change', function (e) {
    e.preventDefault();
    var sortValue = $(this).val();
    var currentParams = new URLSearchParams(window.location.search);
    currentParams.set('sort', sortValue);
    window.location.href = window.location.pathname + '?' + currentParams.toString();
  });
  $('#filterForm input[name="brand"]').on('change', function (e) {
    e.preventDefault();
    var selectedBrand = $(this).val();
    var currentParams = new URLSearchParams(window.location.search);
    currentParams.set('filter', selectedBrand);
    window.location.href = window.location.pathname + '?' + currentParams.toString();
  });
  $('.main-nav-list.child a').on('click', function (e) {
    e.preventDefault();
    var subCategoryID = $(this).data('id');
    var currentParams = new URLSearchParams(window.location.search);
    currentParams.set('subcategory', subCategoryID);
    window.location.href = window.location.pathname + '?' + currentParams.toString();
  });

  const events = document.querySelectorAll('.event');
  events.forEach(event => {
    const icon = '<i class="lnr lnr-calendar-full"></i>'
    const date = dayjs(event.dataset.date).format('D MMM YYYY');
    const dateElement = event.querySelector('.date');
    dateElement.innerHTML = ${date} ${icon};

  });
  const sidebar = document.querySelectorAll('.time-sidebar');
  sidebar.forEach(event => {
    const date = dayjs(event.dataset.date).format('D MMM YYYY');
    const dateElement = event.querySelector('.date-sidebar');
    dateElement.innerHTML = ${date};

  });


  const myForm = $("#myForm");
  $(".submit").click(function () {

    myForm.submit();

  });


  //blogg
  $("#blogcomment").submit(function (event) {
    event.preventDefault(); // Prevents the form from doing a default refresh

    $.post("/marketplace/blog/handelComment", {
      Name: $("#name").val(),
      Message: $("#message").val(),
      ID: $("#BlogAddID").val(),
    })
      .done(function (data) {
        var response = JSON.parse(data);
        if (response.success) {
          Swal.fire({
            title: "SUCCESS",
            text: "Success",
            icon: "success",
            timer: 1000
          })
          setInterval(href, 1500);

          function href() {
            location.reload();
          }
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
          text: "There was an issue  Please try again later.",
          confirmButtonColor: "#d33",
        });
      });

    return false;
  });
  function generateOTP(length = 6) {
    let otp = '';
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'; // Huruf kapital dan angka
    
    for (let i = 0; i < length; i++) {
        const randomIndex = Math.floor(Math.random() * characters.length);
        otp += characters[randomIndex];
    }
    return otp;
  }
  $("#newVendor").on('click', function (event) {
    event.preventDefault();

    var isValid = true;

    var vendorName = $('#vendorname').val();
    var vendorDescription = $('#vendordesc').val();
    var fileInput = $('#transfer-image')[0].files[0];

    if (vendorName === '' || vendorDescription === '') {
        iziToast.warning({
            position: "bottomRight",
            title: 'Caution',
            message: 'Nama Vendor dan Deskripsi harus diisi!'
        });
        isValid = false;
    } else if (!fileInput) {
        iziToast.warning({
            position: "bottomRight",
            title: 'Caution',
            message: 'Harap upload gambar profil toko!'
        });
        isValid = false;
    }

    if (isValid) {
        var vendorAddressDet = $('#address').val();
        var vendorProv = parseInt($('.province_select .list .selected').data('value'));
        var vendorReg = parseInt($('.regency_select .list .selected').data('value'));
        var vendorPost = $('#postal').val();
        var vendorEmail = $('#EmailOwner').val();
        var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        var vendorPhone = $('#numberinput').val();

        isValid = true;

        if (vendorAddressDet === '' || isNaN(vendorProv) || isNaN(vendorReg) || vendorPost === '') {
            iziToast.warning({
                position: "bottomRight",
                title: 'Caution',
                message: 'Harap isi semua field alamat!'
            });
            isValid = false;
        } else if (!emailPattern.test(vendorEmail)) {
            iziToast.warning({
                position: "bottomRight",
                title: 'Caution',
                message: 'Harap masukkan format email yang benar!'
            });
            isValid = false;
        } else if (vendorPhone.length < 12 || vendorPhone.length > 13 || !/^\d+$/.test(vendorPhone)) {
            iziToast.warning({
                position: "bottomRight",
                title: 'Caution',
                message: 'Nomor handphone harus terdiri dari 12-13 digit angka!'
            });
            isValid = false;
        }

        $('#alamatbaru').find('input[data-required="true"]').each(function () {
            if ($(this).val() === '') {
                var fieldName = $(this).attr('name');
                iziToast.warning({
                    position: "bottomRight",
                    title: 'Caution',
                    message: 'Field ' + fieldName + ' harus diisi!, Atur Alamat Toko'
                });
                isValid = false;
            }
        });
    }

    if (isValid) {
      var formData = new FormData();
      var otpCode = generateOTP();
      var vendorEmail = $('#EmailOwner').val();
      var dataVendor = {
        CodeOTP: otpCode,
        VendorEmail: vendorEmail
      };
      formData.append('DataVendor', JSON.stringify(dataVendor));
      $.ajax({
        url: '/marketplace/vendorregistration/codeotp',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function (results) {
          iziToast.success({
            icon: 'fa fa-check',
            timeout: 3500,
            title: 'Sukses',
            message: 'Wait for Second, OTP will Expired for 30 second!',
            position: 'bottomRight',
            onClosed: function () {
              $('#otpcode').modal('show');
            }
          });
        },
        error: function (xhr, status, error) {
          iziToast.error({
              title: 'Error',
              message: error,
              position: 'bottomRight'
          });
        }
      });
    }
  });
  const otpInputs = $('.otp-input');

  otpInputs.on('input', function() {
    $(this).val($(this).val().toUpperCase());

    if ($(this).val().length > 0) {
        $(this).next('.otp-input').focus();
    }
  });

  otpInputs.on('keydown', function(e) {
    if (e.key === 'Backspace' && $(this).val().length === 0) {
        $(this).prev('.otp-input').focus();
    }
  });

  $('#sentotp').on('click', function(e) {
    e.preventDefault();
    let otpCode = '';
    otpInputs.each(function() {
      otpCode += $(this).val();
    });
    var formData = new FormData();
    var vendorName = $('#vendorname').val();
    var vendorDescription = $('#vendordesc').val();
    var fileInput = $('#transfer-image')[0].files[0];
    var vendorProv = parseInt($('.province_select .list .selected').data('value'));
    var vendorReg = parseInt($('.regency_select .list .selected').data('value'));
    var vendorPost = $('#postal').val();
    var vendorEmail = $('#EmailOwner').val();
    var vendorPhone = $('#numberinput').val();
    var vendorAddress = $('.province_select .list .selected').html() + ', ' + $('.regency_select .list .selected').html();
    var vendorAddressDet = $('#address').val();
    var dataVendor = {
        VendorName: vendorName,
        VendorDescription: vendorDescription,
        VendorEmail: vendorEmail,
        VendorPhone: vendorPhone,
        VendorAddress: vendorAddress,
        VendorAddressDetail: vendorAddressDet,
        VendorProv: vendorProv,
        VendorReg: vendorReg,
        VendorPost: vendorPost,
        CodeOTP: otpCode
    };
    formData.append('DataVendor', JSON.stringify(dataVendor));
    formData.append('VendorImage', fileInput);
    $.ajax({
      url: '/marketplace/vendorregistration/newVendor',
      type: 'POST',
      data: formData,
      processData: false,
      contentType: false,
      success: function (results) {
        var response = JSON.parse(results);
        if(response.success){
          iziToast.success({
            icon: 'fa fa-check',
            timeout: 3500,
            title: 'Sukses',
            message: 'Registrasi vendor berhasil!',
            position: 'bottomRight',
            onClosed: function () {
                return false;
                // window.location.href = "/marketplace/";
            }
          });
        }else{
          iziToast.error({
            title: 'Error',
            message: response.message,
            position: 'bottomRight'
          });
        }
      },
      error: function (xhr, status, error) {
        iziToast.error({
            title: 'Error',
            message: error,
            position: 'bottomRight'
        });
      }
    });
  });
  $("#editprofileform").submit(function (event) {
    event.preventDefault(); // Prevents the form from doing a default refresh
    var province = parseInt($('.province_select .list .selected').data('value'));
    var regency = parseInt($('.regency_select .list .selected').data('value'));
    $.post("/marketplace/vendorregistration/handeleditprofile", {
      NamaToko: $("#namatoko").val(),
      Email: $("#Email").val(),
      NomerHandPhone: $("#NomerHandPhone").val(),
      Message: $("#deskripsitoko").val(),
      Image: $("#img").attr('src'),
      Provinsi: province,
      Regency: regency,
      ProvinsiTitle: province2,
      RegencyTitle: regency2,

    })
      .done(function (data) {
        var response = JSON.parse(data);
        if (response.success) {
          Swal.fire({
            title: "SUCCESS",
            text: "Success",
            icon: "success",
            timer: 1000
          })
          setInterval(href, 1500);

          function href() {
            location.reload();
          }
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
          text: "There was an issue  Please try again later.",
          confirmButtonColor: "#d33",
        });
      });

    return false;
  });

  $("#replycomment").off(function (event) {
    event.preventDefault();

    $.post("/marketplace/blog/handelreply", {
      Send: $("#nama-reply").val(),
      Message: $("#message-reply").val(),
      CommentID: $("#commentID-reply").val(),
      ID: $("#BlogAddID").val(),
    })
      .done(function (data) {
        var response = JSON.parse(data);
        if (response.success) {
          Swal.fire({
            title: "SUCCESS",
            text: "Success",
            icon: "success",
            timer: 1000
          })
          setInterval(href, 1500);

          function href() {
            location.reload();
          }
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
          text: "There was an issue  Please try again later.",
          confirmButtonColor: "#d33",
        });
      });

    return false;
  });

  $('.btn-reply').on('click', function () {
    var CommentID = $(this).data('commentid');
    var ReplyID = $(this).data('replyid');
    var CommentName = $(this).data('name');
    $('#commentID-reply').val(CommentID);
  })

  $('#exampleModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget)
    var recipient = button.data('name')
    $('#nama-reply').val(recipient);
    var modal = $(this)
    modal.find('.modal-title').text('New message to ' + recipient)
  })

  //product
  $("#reviewform").submit(function (event) {
    event.stopPropagation()

    const rating = document.getElementById("ratingValue");
    let angka = rating.getAttribute('value');
    console.log(angka);
    if (parseInt(angka) === 0) {
      Swal.fire({
        icon: "error",
        title: "Oops...",
        text: "Input Rating First",
        showConfirmButton: false,
      });
    } else {
      $.post("/marketplace/productdetails/review", {
        Review: $("#reviewmsg").val(),
        Rating: $("#ratingValue").val(),
        ID: $("#ID").val(),
      })
        .done(function (data) {
          var response = JSON.parse(data);
          if (response.success) {
            Swal.fire({
              title: "SUCCESS",
              text: "Review submitted successfully!",
              icon: "success",
              timer: 1000,
            });
            document.getElementById('reviewmsg').value = null;
            stars.forEach((s) => s.classList.remove("one",
              "two",
              "three",
              "four",
              "five",
              "selected"));
            setInterval(href, 1500);

            function href() {
              location.reload();
            }
          } else {
            Swal.fire({
              icon: "error",
              title: "Oops...",
              text: response.message,
              showConfirmButton: false,
              timer: 1500
            });
          }
        })
        .fail(function () {
          Swal.fire({
            icon: "error",
            title: "Error",
            text: "There was an issue submitting the review. Please try again later.",
            confirmButtonColor: "#d33"
          });
        });
    }
  });
  // PRODUCT
  $("#kkls").submit(function (event) {
    event.preventDefault();

    $.post("/marketplace/productdetails/productcomment", {
      Message: $("#slsd").val(),
      ID: $("#asdasda").val(),
    })
      .done(function (data) {
        var response = JSON.parse(data);
        if (response.success) {
          Swal.fire({
            title: "SUCCESS",
            text: "Success",
            icon: "success",
            timer: 1000
          })
          setInterval(href, 1500);

          function href() {
            location.reload();
          }
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
          text: "There was an issue  Please try again later.",
          confirmButtonColor: "#d33",
        });
      });

    return false; // Ensure no form submission (and thus no refresh)
  });
$("#editprofileform").submit(function (event) {
  event.preventDefault(); // Prevents the form from doing a default refresh
  var province = parseInt($('.province_select .list .selected').data('value'));
  var regency = parseInt($('.regency_select .list .selected').data('value'));
  $.post("/marketplace/vendorregistration/handeleditprofile", {
    NamaToko: $("#namatoko").val(),
    Email: $("#Email").val(),
    NomerHandPhone: $("#NomerHandPhone").val(),
    Message: $("#deskripsitoko").val(),
    Image: $("#img").attr('src'),
    Provinsi: province,
    Regency: regency,
    ProvinsiTitle: province2,
    RegencyTitle: regency2,

  })
    .done(function (data) {
      var response = JSON.parse(data);
      if (response.success) {
        Swal.fire({
          title: "SUCCESS",
          text: "Success",
          icon: "success",
          timer: 1000
        })
        setInterval(href, 1500);

        function href() {
          location.reload();
        }
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
        text: "There was an issue  Please try again later.",
        confirmButtonColor: "#d33",
      });
    });

  return false;
});

$("#replycomment").off(function (event) {
  event.preventDefault();

  $.post("/marketplace/blog/handelreply", {
    Send: $("#nama-reply").val(),
    Message: $("#message-reply").val(),
    CommentID: $("#commentID-reply").val(),
    ID: $("#BlogAddID").val(),
  })
    .done(function (data) {
      var response = JSON.parse(data);
      if (response.success) {
        Swal.fire({
          title: "SUCCESS",
          text: "Success",
          icon: "success",
          timer: 1000
        })
        setInterval(href, 1500);

        function href() {
          location.reload();
        }
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
        text: "There was an issue  Please try again later.",
        confirmButtonColor: "#d33",
      });
    });

  return false;
});

$('.btn-reply').on('click', function () {
  var CommentID = $(this).data('commentid');
  var ReplyID = $(this).data('replyid');
  var CommentName = $(this).data('name');
  $('#commentID-reply').val(CommentID);
})

$('#exampleModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget)
  var recipient = button.data('name')
  $('#nama-reply').val(recipient);
  var modal = $(this)
  modal.find('.modal-title').text('New message to ' + recipient)
})

//product
$("#reviewform").submit(function (event) {
  event.preventDefault();
  const rating = document.getElementById("ratingValue");
  let angka = rating.getAttribute('value');
  console.log(angka);
  if (parseInt(angka) === 0) {
    Swal.fire({
      icon: "error",
      title: "Oops...",
      text: "Input Rating First",
      showConfirmButton: false,
    });
  } else {
    $.post("/marketplace/productdetails/review", {
      Review: $("#reviewmsg").val(),
      Rating: $("#ratingValue").val(),
      ID: $("#ID").val(),
    })
      .done(function (data) {
        var response = JSON.parse(data);
        if (response.success) {
          Swal.fire({
            title: "SUCCESS",
            text: "Review submitted successfully!",
            icon: "success",
            timer: 1000,
          });
          document.getElementById('reviewmsg').value = null;
          stars.forEach((s) => s.classList.remove("one",
            "two",
            "three",
            "four",
            "five",
            "selected"));
          setInterval(href, 1500);

          function href() {
            location.reload();
          }
        } else {
          Swal.fire({
            icon: "error",
            title: "Oops...",
            text: response.message,
            showConfirmButton: false,
            timer: 1500
          });
        }
      })
      .fail(function () {
        Swal.fire({
          icon: "error",
          title: "Error",
          text: "There was an issue submitting the review. Please try again later.",
          confirmButtonColor: "#d33"
        });
      });
  }
});
// PRODUCT
$("#kkls").submit(function (event) {
  event.preventDefault();

  $.post("/marketplace/productdetails/productcomment", {
    Message: $("#slsd").val(),
    ID: $("#asdasda").val(),
  })
    .done(function (data) {
      var response = JSON.parse(data);
      if (response.success) {
        Swal.fire({
          title: "SUCCESS",
          text: "Success",
          icon: "success",
          timer: 1000
        })
        setInterval(href, 1500);

        function href() {
          location.reload();
        }
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
        text: "There was an issue  Please try again later.",
        confirmButtonColor: "#d33",
      });
    });

  return false; // Ensure no form submission (and thus no refresh)
});


$("#productcommentreply").off(function (event) {
  event.preventDefault(); // Prevents the form from doing a default refresh

  $.post("/marketplace/productdetails/productreply", {
    Send: $("#nama-reply").val(),
    Message: $("#message-reply").val(),
    CommentID: $("#productcommentid-reply").val(),
    ID: $("#ProductObjectID").val(),
  })
    .done(function (data) {
      var response = JSON.parse(data);
      if (response.success) {
        Swal.fire({
          title: "SUCCESS",
          text: "Success",
          icon: "success",
          timer: 1000
        })
        setInterval(href, 1000);

        function href() {
          location.reload();
        }
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
        text: "There was an issue  Please try again later.",
        confirmButtonColor: "#d33",
      });
    });

  return false; // Ensure no form submission (and thus no refresh)
});
$('#exampleModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget)
  var recipient = button.data('name')
  var CommentID = button.data('productcomentid')
  $('#productcommentid-reply').val(CommentID);
  $('#nama-reply').val(recipient);
  var modal = $(this)
  modal.find('.modal-title').text('New message to ' + recipient)
})
var window_width = $(window).width(),
  window_height = window.innerHeight,
  header_height = $(".default-header").height(),
  header_height_static = $(".site-header.static").outerHeight(),
  fitscreen = window_height - header_height;


$(".fullscreen").css("height", window_height)
$(".fitscreen").css("height", fitscreen);

//------- Active Nice Select --------//

$('select').niceSelect();

$('.navbar-nav li.dropdown').hover(function () {
  $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeIn(500);
}, function () {
  $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeOut(500);
});

$('.img-pop-up').magnificPopup({
  type: 'image',
  gallery: {
    enabled: true
  }
});


// refresh not delete tabs 



const SelectedTabs = localStorage.getItem('SelectedTabs');
if (SelectedTabs) {
  const tabs = document.querySelectorAll('.nav-link.nav-linked');
  if (tabs.length > 0) {
    tabs.forEach(tab => {
      if (tab.getAttribute('value') === SelectedTabs) {
        tab.classList.add('active');
      } else {
        tab.classList.remove("active");
      }
    })
  }
}
const SelectedContent = localStorage.getItem('SelectedContent');
if (SelectedContent) {
  const tabs = document.querySelectorAll('div.tab-pane');
  if (tabs.length > 0) {
    tabs.forEach(tab => {
      if (tab.getAttribute('id') === SelectedContent) {
        tab.classList.add("show", "active");
      } else {
        tab.classList.remove("show", "active");
      }
    })
  }
}
$("#myTab").click(function () {
  const activeTab = document.querySelector('.nav-link.nav-linked.active');
  if (activeTab) {
    let value = activeTab.getAttribute('value');
    localStorage.setItem('SelectedTabs', value);
  } else {
    console.log("No active tab found.");
  }

  const contenttab = document.querySelector('div.tab-pane.active');
  if (contenttab) {
    var sam = contenttab.getAttribute('id');
    localStorage.setItem('SelectedContent', sam);
  } else {
    console.log("No active tab found.");
  }
});

// Search Toggle
$("#search_input_box").hide();
$("#search").on("click", function () {
  $("#search_input_box").slideToggle();
  $("#search_input").focus();
});
$("#close_search").on("click", function () {
  $('#search_input_box').slideUp(500);
});

/*==========================
javaScript for sticky header
============================*/
$(".sticky-header").sticky();

/*=================================
Javascript for banner area carousel
==================================*/
$(".active-banner-slider").owlCarousel({
  items: 1,
  autoplay: true,
  autoplayTimeout: 3000,
  loop: true,
  nav: true,
  navText: [
    "<img src='_resources/themes/simple/images/banner/prev.png'>",
    "<img src='_resources/themes/simple/images/banner/next.png'>"
  ],
  dots: false
});

/*=================================
Javascript for product area carousel
==================================*/
$(".active-product-area").owlCarousel({
  items: 1,
  autoplay: false,
  autoplayTimeout: 5000,
  loop: true,
  nav: true,
  navText: [
    "<img src='_resources/themes/simple/images/banner/prev.png'>",
    "<img src='_resources/themes/simple/images/banner/next.png'>"
  ],
  dots: false
});

/*=================================
Javascript for single product area carousel
==================================*/
$(".s_Product_carousel").owlCarousel({
  items: 1,
  autoplay: false,
  autoplayTimeout: 5000,
  loop: true,
  nav: false,
  dots: true
});

/*=================================
Javascript for exclusive area carousel
==================================*/
$(".active-exclusive-product-slider").owlCarousel({
  items: 1,
  autoplay: false,
  autoplayTimeout: 5000,
  loop: true,
  nav: true,
  dots: false
});

//--------- Accordion Icon Change ---------//

$('.collapse').on('shown.bs.collapse', function () {
  $(this).parent().find(".lnr-arrow-right").removeClass("lnr-arrow-right").addClass("lnr-arrow-left");
}).on('hidden.bs.collapse', function () {
  $(this).parent().find(".lnr-arrow-left").removeClass("lnr-arrow-left").addClass("lnr-arrow-right");
});

// Select all links with hashes
$('.main-menubar a[href*="#"]')
  // Remove links that don't actually link to anything
  .not('[href="#"]')
  .not('[href="#0"]')
  .click(function (event) {
    // On-page links
    if (
      location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '')
      &&
      location.hostname == this.hostname
    ) {
      // Figure out element to scroll to
      var target = $(this.hash);
      target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
      // Does a scroll target exist?
      if (target.length) {
        // Only prevent default if animation is actually gonna happen
        event.preventDefault();
        $('html, body').animate({
          scrollTop: target.offset().top - 70
        }, 1000, function () {
          // Callback after animation
          // Must change focus!
          var $target = $(target);
          $target.focus();
          if ($target.is(":focus")) { // Checking if the target was focused
            return false;
          } else {
            $target.attr('tabindex', '-1'); // Adding tabindex for elements not focusable
            $target.focus(); // Set focus again
          };
        });
      }
    }
  });



// -------   Mail Send ajax

$(document).ready(function () {
  var form = $('#booking'); // contact form
  var submit = $('.submit-btn'); // submit button
  var alert = $('.alert-msg'); // alert div for show alert message

  // form submit event
  form.on('submit', function (e) {
    e.preventDefault(); // prevent default form submit

    $.ajax({
      url: 'booking.php', // form action url
      type: 'POST', // form submit method get/post
      dataType: 'html', // request type html/json/xml
      data: form.serialize(), // serialize form data
      beforeSend: function () {
        alert.fadeOut();
        submit.html('Sending....'); // change submit button text
      },
      success: function (data) {
        alert.html(data).fadeIn(); // fade in response data
        form.trigger('reset'); // reset form
        submit.attr("style", "display: none !important");; // reset submit button text
      },
      error: function (e) {
        console.log(e)
      }
    });
  });
});




$(document).ready(function () {
  $('#mc_embed_signup').find('form').ajaxChimp();
});



if (document.getElementById("js-countdown")) {

  var countdown = new Date("October 17, 2018");

  function getRemainingTime(endtime) {
    var milliseconds = Date.parse(endtime) - Date.parse(new Date());
    var seconds = Math.floor(milliseconds / 1000 % 60);
    var minutes = Math.floor(milliseconds / 1000 / 60 % 60);
    var hours = Math.floor(milliseconds / (1000 * 60 * 60) % 24);
    var days = Math.floor(milliseconds / (1000 * 60 * 60 * 24));

    return {
      'total': milliseconds,
      'seconds': seconds,
      'minutes': minutes,
      'hours': hours,
      'days': days
    };
  }

  function initClock(id, endtime) {
    var counter = document.getElementById(id);
    var daysItem = counter.querySelector('.js-countdown-days');
    var hoursItem = counter.querySelector('.js-countdown-hours');
    var minutesItem = counter.querySelector('.js-countdown-minutes');
    var secondsItem = counter.querySelector('.js-countdown-seconds');

    function updateClock() {
      var time = getRemainingTime(endtime);

      daysItem.innerHTML = time.days;
      hoursItem.innerHTML = ('0' + time.hours).slice(-2);
      minutesItem.innerHTML = ('0' + time.minutes).slice(-2);
      secondsItem.innerHTML = ('0' + time.seconds).slice(-2);

      if (time.total <= 0) {
        clearInterval(timeinterval);
      }
    }

    updateClock();
    var timeinterval = setInterval(updateClock, 1000);
  }

  initClock('js-countdown', countdown);

};



$('.quick-view-carousel-details').owlCarousel({
  loop: true,
  dots: true,
  items: 1,
})



//----- Active No ui slider --------//



$(function () {

  if (document.getElementById("price-range")) {

    var nonLinearSlider = document.getElementById('price-range');

    noUiSlider.create(nonLinearSlider, {
      connect: true,
      behaviour: 'tap',
      start: [500, 4000],
      range: {
        // Starting at 500, step the value by 500,
        // until 4000 is reached. From there, step by 1000.
        'min': [0],
        '10%': [500, 500],
        '50%': [4000, 1000],
        'max': [10000]
      }
    });


    var nodes = [
      document.getElementById('lower-value'), // 0
      document.getElementById('upper-value')  // 1
    ];

    // Display the slider value and how far the handle moved
    // from the left edge of the slider.
    nonLinearSlider.noUiSlider.on('update', function (values, handle, unencoded, isTap, positions) {
      nodes[handle].innerHTML = values[handle];
    });

  }

});


//-------- Have Cupon Button Text Toggle Change -------//

$('.have-btn').on('click', function (e) {
  e.preventDefault();
  $('.have-btn span').text(function (i, text) {
    return text === "Have a Coupon?" ? "Close Coupon" : "Have a Coupon?";
  })
  $('.cupon-code').fadeToggle("slow");
});

$('.load-more-btn').on('click', function (e) {
  e.preventDefault();
  $('.load-product').fadeIn('slow');
  $(this).fadeOut();
});





//------- Start Quantity Increase & Decrease Value --------//




var value,
  quantity = document.getElementsByClassName('quantity-container');

function createBindings(quantityContainer) {
  var quantityAmount = quantityContainer.getElementsByClassName('quantity-amount')[0];
  var increase = quantityContainer.getElementsByClassName('increase')[0];
  var decrease = quantityContainer.getElementsByClassName('decrease')[0];
  increase.addEventListener('click', function () { increaseValue(quantityAmount); });
  decrease.addEventListener('click', function () { decreaseValue(quantityAmount); });
}

function init() {
  for (var i = 0; i < quantity.length; i++) {
    createBindings(quantity[i]);
  }
};

function increaseValue(quantityAmount) {
  value = parseInt(quantityAmount.value, 10);

  console.log(quantityAmount, quantityAmount.value);

  value = isNaN(value) ? 0 : value;
  value++;
  quantityAmount.value = value;
}

function decreaseValue(quantityAmount) {
  value = parseInt(quantityAmount.value, 10);

  value = isNaN(value) ? 0 : value;
  if (value > 0) value--;

  quantityAmount.value = value;
}

init();

//------- End Quantity Increase & Decrease Value --------//

/----------------------------------------------------/
/*  Google map js
  /----------------------------------------------------/

if ($("#mapBox").length) {
  var $lat = $("#mapBox").data("lat");
  var $lon = $("#mapBox").data("lon");
  var $zoom = $("#mapBox").data("zoom");
  var $marker = $("#mapBox").data("marker");
  var $info = $("#mapBox").data("info");
  var $markerLat = $("#mapBox").data("mlat");
  var $markerLon = $("#mapBox").data("mlon");
  var map = new GMaps({
    el: "#mapBox",
    lat: $lat,
    lng: $lon,
    scrollwheel: false,
    scaleControl: true,
    streetViewControl: false,
    panControl: true,
    disableDoubleClickZoom: true,
    mapTypeControl: false,
    zoom: $zoom,
    styles: [
      {
        featureType: "water",
        elementType: "geometry.fill",
        stylers: [
          {
            color: "#dcdfe6"
          }
        ]
      },
      {
        featureType: "transit",
        stylers: [
          {
            color: "#808080"
          },
          {
            visibility: "off"
          }
        ]
      },
      {
        featureType: "road.highway",
        elementType: "geometry.stroke",
        stylers: [
          {
            visibility: "on"
          },
          {
            color: "#dcdfe6"
          }
        ]
      },
      {
        featureType: "road.highway",
        elementType: "geometry.fill",
        stylers: [
          {
            color: "#ffffff"
          }
        ]
      },
      {
        featureType: "road.local",
        elementType: "geometry.fill",
        stylers: [
          {
            visibility: "on"
          },
          {
            color: "#ffffff"
          },
          {
            weight: 1.8
          }
        ]
      },
      {
        featureType: "road.local",
        elementType: "geometry.stroke",
        stylers: [
          {
            color: "#d7d7d7"
          }
        ]
      },
      {
        featureType: "poi",
        elementType: "geometry.fill",
        stylers: [
          {
            visibility: "on"
          },
          {
            color: "#ebebeb"
          }
        ]
      },
      {
        featureType: "administrative",
        elementType: "geometry",
        stylers: [
          {
            color: "#a7a7a7"
          }
        ]
      },
      {
        featureType: "road.arterial",
        elementType: "geometry.fill",
        stylers: [
          {
            color: "#ffffff"
          }
        ]
      },
      {
        featureType: "road.arterial",
        elementType: "geometry.fill",
        stylers: [
          {
            color: "#ffffff"
          }
        ]
      },
      {
        featureType: "landscape",
        elementType: "geometry.fill",
        stylers: [
          {
            visibility: "on"
          },
          {
            color: "#efefef"
          }
        ]
      },
      {
        featureType: "road",
        elementType: "labels.text.fill",
        stylers: [
          {
            color: "#696969"
          }
        ]
      },
      {
        featureType: "administrative",
        elementType: "labels.text.fill",
        stylers: [
          {
            visibility: "on"
          },
          {
            color: "#737373"
          }
        ]
      },
      {
        featureType: "poi",
        elementType: "labels.icon",
        stylers: [
          {
            visibility: "off"
          }
        ]
      },
      {
        featureType: "poi",
        elementType: "labels",
        stylers: [
          {
            visibility: "off"
          }
        ]
      },
      {
        featureType: "road.arterial",
        elementType: "geometry.stroke",
        stylers: [
          {
            color: "#d6d6d6"
          }
        ]
      },
      {
        featureType: "road",
        elementType: "labels.icon",
        stylers: [
          {
            visibility: "off"
          }
        ]
      },
      {},
      {
        featureType: "poi",
        elementType: "geometry.fill",
        stylers: [
          {
            color: "#dadada"
          }
        ]
      }
    ]
  });
}
iziToast.settings({
  timeout: 3000,
  resetOnHover: true,
  transitionIn: 'fadeInUp',
  transitionOut: 'fadeOutDown',
  position: 'topRight',
});
$("#loginn").on('click', function (event) {
  event.preventDefault();
  $.post("/marketplace/login/proseslogin",
    {
      Email: $("#emaillogin").val(),
      Password: $("#passwordlogin").val()
    })
    .done(function (data) {
      var response = JSON.parse(data);
      if (response.success) {
        iziToast.success({
          icon: 'fa fa-user',
          title: 'Sukses Login',
          position: 'bottomRight',
          onClosed: function () {
            window.location.href = "";
          }
        });
      } else {
        iziToast.error({ title: 'Gagal Login', message: 'Cek Kembali Username & Password', position: 'bottomRight' });
      }
    }).fail(function () {
      iziToast.error({ title: 'Error', message: 'Terjadi Kesalahan', position: 'bottomRight' });
    });
});

$("#blogcomment").submit(function (event) {
  event.preventDefault(); // Prevents the form from doing a default refresh

  $.post("/blog/handelComment", {
    Name: $("#name").val(),
    Message: $("#message").val(),
    ID: $("#BlogAddID").val(),
  })
    .done(function (data) {
      var response = JSON.parse(data);
      if (response.success) {
        Swal.fire({
          title: "SUCCESS",
          text: "Success",
          icon: "success",
          timer: 1000
        })
        setInterval(href, 1500);

        function href() {
          location.reload();
        }
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
        text: "There was an issue  Please try again later.",
        confirmButtonColor: "#d33",
      });
    });

  return false; // Ensure no form submission (and thus no refresh)
});


$("#replycomment").submit(function (event) {
  event.preventDefault(); // Prevents the form from doing a default refresh

  $.post("/marketplace/blog/handelreply", {
    Name: $("#name-reply").val(),
    Send: $("#nama-reply").val(),
    Message: $("#message-reply").val(),
    CommentID: $("#commentID-reply").val(),
    ID: $("#BlogAddID").val(),
  })
    .done(function (data) {
      var response = JSON.parse(data);
      if (response.success) {
        Swal.fire({
          title: "SUCCESS",
          text: "Success",
          icon: "success",
          timer: 1000
        })
        setInterval(href, 1500);

        function href() {
          location.reload();
        }
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
        text: "There was an issue  Please try again later.",
        confirmButtonColor: "#d33",
      });
    });

  return false; // Ensure no form submission (and thus no refresh)
});

$('.btn-reply').on('click', function () {
  var CommentID = $(this).data('commentid');
  var ReplyID = $(this).data('replyid');
  var CommentName = $(this).data('name');
  $('#commentID-reply').val(CommentID);
})

$('#exampleModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget)
  var recipient = button.data('name')
  $('#nama-reply').val(recipient);
  var modal = $(this)
  modal.find('.modal-title').text('New message to ' + recipient)
})



// PRODUCT
$("#kkls").submit(function (event) {
  event.preventDefault(); // Prevents the form from doing a default refresh

  $.post("/marketplace/productdetails/productcomment", {
    Message: $("#slsd").val(),
    ID: $("#asdasda").val(),
  })
    .done(function (data) {
      var response = JSON.parse(data);
      if (response.success) {
        Swal.fire({
          title: "SUCCESS",
          text: "Success",
          icon: "success",
          timer: 1000
        })
        setInterval(href, 1500);

        function href() {
          location.reload();
        }
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
        text: "There was an issue  Please try again later.",
        confirmButtonColor: "#d33",
      });
    });

  return false; // Ensure no form submission (and thus no refresh)
});



$('#exampleModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget)
  var recipient = button.data('name')
  var CommentID = button.data('productcomentid')
  $('#productcommentid-reply').val(CommentID);
  $('#nama-reply').val(recipient);
  var modal = $(this)
  modal.find('.modal-title').text('New message to ' + recipient)
});

$("#register").on('click', function (event) {
  event.preventDefault();

  $.post("/marketplace/login/prosesregistrasi", {
    FirstName: $("#username").val(),
    SurName: $("#surname").val(),
    Email: $("#emailregister").val(),
    Password: $("#passwordregister").val(),
    ConfirmPassword: $("#confirmpassword").val()
  })
    .done(function (data) {
      var response = JSON.parse(data);
      if (response.success) {
        iziToast.success({
          icon: 'fa fa-user',
          title: 'Sukses Registrasi Akun',
          position: 'bottomRight',
          onClosed: function () {
            window.location.href = "/marketplace/login";
          }
        });
      } else {
        iziToast.error({ title: 'Gagal Registrasi Akun', message: 'Cek Kembali Username & Password', position: 'bottomRight' });
      }

    }).fail(function () {
      iziToast.error({ title: 'Error', position: 'bottomRight' });
    });
});
$("#addCart").on('click', function (e) {
  e.preventDefault();
  var formData = new FormData();
  var ProductItem = [];
  var activeSubvariant = $('.variantItem.active');
  // console.log(activeSubvariant)
  var categoryId = document.querySelector('#productCategoriID').textContent;
  // console.log(categoryId)
  // return false;
  if (categoryId == 2) {
    // alert("2");
    // return false
    $.post("/marketplace/cart/addcart", {
      ProductID: $("#productId").text(),
      ProductTitle: $("#productTitle").text(),
      ProductImage: $("#productImage").attr("src"),
      ProductCategoryID: $("#productCategoriID").text(),
      ProductVariant: activeSubvariant.find('#variantName').text(),
      ProductVariantID: activeSubvariant.data('id'),
      ProductVariantWeight: activeSubvariant.data('weight'),
      ProductPrice: $(".ppprice").text(),
      ProductQuantity: $("#sst").val(),
    })
      .done(function (data) {
        var response = JSON.parse(data);
        // console.log(response)
        if (response.success) {
          iziToast.success({
            timeout: 2000,
            title: 'Product berhasil dimasukkan ke keranjang',
            position: 'bottomRight'
          });
        } else {
          iziToast.warning({ position: "bottomRight", title: 'Caution', message: 'Pilih Product Sebelum Checkout' });
        }
      })
      .fail(function () {
        iziToast.error({ title: 'Error', position: 'bottomRight' });
      });
  } else if (activeSubvariant.length > 0) {
    // alert("1");
    // return false
    $.post("/marketplace/cart/addcart", {
      ProductID: $("#productId").text(),
      ProductTitle: $("#productTitle").text(),
      ProductImage: $("#productImage").attr("src"),
      ProductCategoryID: $("#productCategoriID").text(),
      ProductVariant: activeSubvariant.find('#variantName').text(),
      ProductVariantID: activeSubvariant.data('id'),
      ProductVariantWeight: activeSubvariant.data('weight'),
      ProductPrice: $(".ppprice").text(),
      ProductQuantity: $("#sst").val(),
    })
      .done(function (data) {
        var response = JSON.parse(data);
        console.log(response)
        if (response.success) {
          iziToast.success({
            timeout: 2000,
            title: 'Product berhasil dimasukkan ke keranjang',
            position: 'bottomRight',
          });
        } else {
          iziToast.warning({ position: "bottomRight", title: 'Caution', message: 'Pilih Product Sebelum Checkout' });
        }
      })
      .fail(function () {
        iziToast.error({ title: 'Error', position: 'bottomRight' });
      });
  } else {
    iziToast.warning({ title: 'Choose Variant!', position: 'bottomRight' });
    return;
  }
});
$("#proceedCheckout").on('click', function (e) {
  // console.log("Tombol proceedCheckout diklik");
  e.preventDefault();
  var selectedProducts = [];
  var formData = new FormData();
  $(".productCheckbox:checked").each(function () {
    var productData = {
      ProductCartID: $(this).data("id"),
      ProductID: $(this).closest('.cartProduct').find('#productCheckoutID').text(),
      ProductTitle: $(this).closest('.cartProduct').find('#productCheckoutTitle').text(),
      ProductImage: $(this).closest('.cartProduct').find('#productCheckoutImage').attr("src"),
      ProductVariant: $(this).closest('.cartProduct').find('#productCheckoutVariant').text(),
      ProductVariantID: $(this).closest('.cartProduct').find('#productCheckoutVariant').data('id'),
      ProductVariantWeight: $(this).closest('.cartProduct').find('#productCheckoutVariant').data('weight'),
      ProductPrice: $(this).closest('.cartProduct').find('#itemPrice').text(),
      ProductTotalPrice: $(this).closest('.cartProduct').find('#totalPriceCheckout').text(),
      ProductQuantity: $(this).closest('.cartProduct').find('#quantityInput').val(),
      ProductSubTotalPrice: $('#subTotalPriceCheckout').text(),
      ProductSubTotalPriceNF: $('#subTotalPriceNFCheckout').text(),
      MemberFirstName: $('#MemberFirstname').text(),
      MemberLastName: $('#MemberLastname').text(),
      MemberEmail: $('#MemberEmail').text(),
    };
    selectedProducts.push(productData);
  });
  // console.log(selectedProducts)
  formData.append('ProductCheckoutDatas', JSON.stringify(selectedProducts));
  // return false;
  $.ajax({
    url: "/marketplace/productcheckout/static",
    type: "POST",
    data: formData,
    contentType: false,
    processData: false,
    success: function (data) {
      var response = JSON.parse(data);
      if (response.success) {
        iziToast.success({
          timeout: 1000,
          title: 'Tunggu Sebentar',
          position: 'bottomRight',
          onClosed: function () {
            window.location.href = '/marketplace/productcheckout'
          }
        });
      } else {
        iziToast.warning({ position: "bottomRight", title: 'Caution', message: 'Pilih Product Sebelum Checkout' });
      }
    },
    error: function () {
      iziToast.error({ title: 'Error', position: 'bottomRight' });
    }
  });
});
$("#remove").on('click', function (event) {
  event.preventDefault();
  var selectedProductIds = [];
  $(".productCheckbox:checked").each(function () {
    var productId = $(this).data('id');
    selectedProductIds.push(productId);
    // console.log("Selected Product IDs:", selectedProductIds);
  });

  $.post("/marketplace/cart/remove", {
    IDs: selectedProductIds
  })
    .done(function (data) {
      var response = JSON.parse(data);
      console.log(data)
      if (response.success) {
        $(".productCheckbox:checked").each(function () {
          $(this).closest('.items').remove();
          iziToast.success({
            icon: 'fa fa-trash',
            timeout: 1500,
            title: 'Product Telah Dihapus',
            position: 'bottomRight',
            onClosed: function () {
              $(".spinnerout").hide();
              window.location.reload();
            }
          });
        });
      } else {
        $(".spinnerout").hide();
        iziToast.error({ title: 'Gagal Menghapus Product Yang dipilih:', message: response.message, position: 'bottomRight' });
      }
    })
    .fail(function () {
      $(".spinnerout").hide();
      iziToast.error({ title: 'Error', message: 'Terjadi Kesalahan', position: 'bottomRight' });
    });
});
$("#numberinput").on('input', function () {
  this.value = this.value.replace(/\D/g, '');
  if (this.value.length > 14) {
    this.value = this.value.slice(0, 14);
  }
});
$("#checkoutbtn").on('click', function (e) {
  e.preventDefault();
  TimeCheckout();
  callOrderID();
  var form = $("#checkout-form")[0];
  var selectedProductss = [];
  var numberInput = $("#numberinput").val();
  var regency = $('#fulldata .regency').text().trim();
  var customerName = $('#fulldata .customerName').text();
  var customerFullName = $('#fulldata .customerFullName').text();
  var customerEmail = $('#fulldata .customerEmail').text();
  var customerHandphone = $('#fulldata .customerHandphone').text();
  var customerAddress = $('#fulldata .customerAddress').text();
  var customerNotes = $('.form-group #message').val();
  var shippingCost = $('.list_2 #shippingProduct').text();
  var shippingCostNF = $('.list_2 #shippingNFProduct').text();
  var finalPrice = $('.list_2 #finalPriceProduct').text();
  var finalPriceNF = $('.list_2 #finalPriceNFProduct').text();
  var finalprice = $("#finalPriceProduct").text().trim();
  var selectordata = $("input[name='selectordata']:checked").length > 0;
  var selectorcost = $("input[name='selectorCost']:checked").length > 0;
  var terms = $("input[name='terms']:checked").length > 0;
  if (numberInput.length < 12 || numberInput.length > 14) {
    iziToast.warning({ position: "bottomRight", title: 'Caution', message: 'Isi nomor dengan benar!' });
    return;
  }
  if (!form.checkValidity()) {
    form.reportValidity();
  }
  if (regency === '') {
    iziToast.warning({ position: "bottomRight", title: 'Caution', message: 'Inputkan alamat dengan benar!' });
    return;
  }
  // if (!selectordata) {
  //   iziToast.warning({position: "bottomRight", title: 'Caution', message: 'Check data pengiriman jika data sudah benar!'});
  //   return;
  // }
  // if (!selectorcost) {
  //   iziToast.warning({position: "bottomRight", title: 'Caution', message: 'Pilih ongkir!'});
  //   return;
  // }
  // if (finalprice === '') {
  //   iziToast.warning({position: "bottomRight", title: 'Caution', message: 'Lengkapi data pengiriman!'});
  //   return;
  // }
  // if (!terms) {
  //   iziToast.warning({position: "bottomRight", title: 'Caution', message: 'Check terms & conditions!'});
  //   return;
  // }
  else {
    var paymentMethod = $("input[name='selectorpayment']:checked").val();
    if (paymentMethod === "manualtf") {
      var formData = new FormData();
      var fileInput = $('#transfer-image')[0].files[0];
      // console.log(formData)
      var paymentGate = $("input[name='selectorpaymentgate']:checked").val();
      var timeCheckout = $(".list_2").find('#time').text();
      var orderID = $(".list_2").find('#orderID').text();
      // console.log(timeCheckout)
      // console.log(orderID)
      // return false;
      for (const item of $(".listDataProduct")) {
        var productData = {
          ProductID: $(item).find('#productID').text(),
          ProductTitle: $(item).find('#productTitle').text(),
          ProductCartID: $(item).find('#productCartID').text(),
          ProductImage: $(item).find('#productImage').text(),
          ProductVariant: $(item).find('#productVariant').text(),
          ProductVariantID: $(item).find('#productVariantID').text(),
          ProductVariantWeight: $(item).find('#variantP').data('weight'),
          ProductPrice: $(item).find('#productPrice').text(),
          ProductQuantity: $(item).find('#productQuantity').text(),
          ProductTotalPrice: $(item).find('#productTotalPrice').text(),
          ProductSubTotalPrice: $(item).find('#productSubTotalPrice').text(),
          ProductSubTotalPriceNF: $(item).find('#productSubTotalPriceNF').text(),
          ProductCostShipping: shippingCost,
          ProductFinalPrice: finalPrice,
          ProductFinalPriceNF: finalPriceNF,
          CustomerName: customerName.replace('Nama: ', ''),
          CustomerFullName: customerFullName.replace('Nama lengkap: ', ''),
          CustomerEmail: customerEmail.replace('Email: ', ''),
          CustomerHandphone: customerHandphone.replace('Handphone: ', ''),
          CustomerAddress: customerAddress.replace('Alamat: ', ''),
          CustomerNotes: customerNotes,
          Bank: paymentGate,
          PaymentMethod: paymentMethod,
          TimeCheckout: timeCheckout,
          OrderID: orderID
        };
        selectedProductss.push(productData);
        // console.log(selectedProductss)
        formData.append('paymentDatas', JSON.stringify(selectedProductss));
      }
      if (fileInput) {
        formData.append('ProofImage', fileInput);
        $.ajax({
          url: '/marketplace/productcheckout/manualTF',
          type: 'POST',
          data: formData,
          processData: false,
          contentType: false,
          success: function (results) {
            iziToast.success({
              icon: 'fa fa-shipping-fast',
              timeout: 3500,
              title: 'Pesanan Telah Dibuat dan Akan dikirim Secepatnya',
              position: 'bottomRight',
              onClosed: function () {
                return false;
                window.location.href = "/marketplace/";
              }
            });
          },
          error: function (xhr, status, error) {
            iziToast.error({ title: 'Error', message: error, position: 'bottomRight' });
          }
        });
      } else {
        iziToast.warning({ position: "bottomRight", title: 'Caution', message: 'Inputkan Bukti Pembayaran!' });
      }
    } else if (paymentMethod === "duitku") {
      var formData = new FormData();
      var paymentGate = $("input[name='selectorpaymentgate']:checked").val();
      var timeCheckout = $(".list_2").find('#time').text();
      for (const item of $(".listDataProduct")) {
        var productData = {
          ProductID: $(item).find('#productID').text(),
          ProductTitle: $(item).find('#productTitle').text(),
          ProductCartID: $(item).find('#productCartID').text(),
          ProductImage: $(item).find('#productImage').text(),
          ProductVariant: $(item).find('#productVariant').text(),
          ProductVariantID: $(item).find('#productVariantID').text(),
          ProductVariantWeight: $(item).find('#variantP').data('weight'),
          ProductPrice: $(item).find('#productPrice').text(),
          ProductQuantity: $(item).find('#productQuantity').text(),
          ProductTotalPrice: $(item).find('#productTotalPrice').text(),
          ProductSubTotalPrice: $(item).find('#productSubTotalPrice').text(),
          ProductSubTotalPriceNF: $(item).find('#productSubTotalPriceNF').text(),
          ProductCostShipping: shippingCost,
          ProductFinalPrice: finalPrice,
          ProductFinalPriceNF: finalPriceNF,
          CustomerName: customerName.replace('Nama: ', ''),
          CustomerFullName: customerFullName.replace('Nama lengkap: ', ''),
          CustomerEmail: customerEmail.replace('Email: ', ''),
          CustomerHandphone: customerHandphone.replace('Handphone: ', ''),
          CustomerAddress: customerAddress.replace('Alamat: ', ''),
          CustomerNotes: customerNotes,
          Bank: paymentGate,
          PaymentMethod: paymentMethod,
          TimeCheckout: timeCheckout
        };
        selectedProductss.push(productData);
        formData.append('paymentDatas', JSON.stringify(selectedProductss));
      }
      $.ajax({
        url: "/marketplace/productcheckout/transaction",
        type: "POST",
        data: formData,
        contentType: false,
        processData: false,
        success: function (results) {
          try {
            var response = JSON.parse(results);
            if (response && response.paymentUrl) {
              iziToast.success({
                timeout: 2000,
                title: 'Tunggu Sebentar',
                message: 'Memproses Pembayaran',
                position: 'bottomRight',
                onClosed: function () {
                  window.location.href = response.paymentUrl;
                }
              });
            } else {
              iziToast.error({ title: 'Error', message: 'URL pembayaran tidak ditemukan dalam respons.', position: 'bottomRight' });
            }
          } catch (e) {
            iziToast.error({ title: 'Error' + e.message, position: 'bottomRight' });
          }
        },
        error: function () {
          iziToast.error({ title: 'Error', position: 'bottomRight' });
        }
      });
    } else {
      var formData = new FormData();
      var paymentGate = '';
      var timeCheckout = $(".list_2").find('#time').text();
      var orderID = $(".list_2").find('#orderID').text();
      for (const item of $(".listDataProduct")) {
        var productData = {
          ProductID: $(item).find('#productID').text(),
          ProductTitle: $(item).find('#productTitle').text(),
          ProductCartID: $(item).find('#productCartID').text(),
          ProductImage: $(item).find('#productImage').text(),
