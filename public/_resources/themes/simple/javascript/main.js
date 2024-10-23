
$(document).ready(function () {
  "use strict";
  $("#filtera").change(function (event) {
    event.preventDefault();
    var selected = $("#filtera").val();

    if (selected == '') {
      return;
    }
    localStorage.setItem("filteraValue", selected);
    $.post("/marketplace/shopcategory/filter", {
      select: $("#filtera").val(),
    })
      .done(function (data) {
        var response = JSON.parse(data);
        if (response.success) {
          
          setInterval(href, 1000);

          function href() {
            location.reload();
          }
        } else {
        
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

  $("#emailform").submit(function (event) {
    event.preventDefault();
    $.ajax({
        url: "/marketplace/contact/mail",
        type: "POST",
        data: {
            name: $("#name").val(),
            email: $("#email").val(),
            subject: $("#subject").val(),
            message: $("#message").val()
        },
        success: function (response) {
            Swal.fire({
                title: "Succes",
                text: "Your Message Sending",
                icon: "success",
                showConfirmButton: false,
                timer: 1500
            });
        },
        error: function (xhr, status, error) {
            alert("Failed to send message: " + error); // Add error message
        }
    });
    return false;
});
  var currentParams = new URLSearchParams(window.location.search);
  var selectedBrand = currentParams.get('filter');
  var selectedSubCategory = currentParams.get('subcategory');
  var selectedSort = currentParams.get('sort');

  var message = currentParams.get('m');
  
  if(message){
    var slicedMessage = message.split('l');
    var receiverChat = slicedMessage[1].trim();
    var thisReceiver = document.querySelector(`.sidechat[data-receiver="${receiverChat}"]`);
    if (thisReceiver) {
      thisReceiver.classList.add('chatActive');
    }
  }
  if (selectedBrand) {
    $('#navProduct').click();
    $('#filterForm input[name="brand"]').each(function () {
      if ($(this).val() === selectedBrand) {
        $(this).prop('checked', true);
      }
    });
  }

  if (selectedSubCategory) {
    $('#navProduct').click();
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
  $("input[name='selectorcancelled']").on('change', function () {
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
      if (!additionalReason) {
        iziToast.warning({ position: "bottomRight", title: 'Caution', message: 'Isi alasan pembatalan' });
      }
    }
    $.post("/marketplace/history/service", {
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
  $('#receivedBtn').on('click', function (e) {
    e.preventDefault();
    var orderid = $(this).data('orderid');
    var request = 'diterima';
    iziToast.show({
      color: 'dark',
      icon: 'bx bxs-archive-in',
      timeout: 5000,
      title: 'Apakah pesanan telah sampai dan sesuai',
      position: 'bottomRight',
      progressBarColor: 'rgb(0, 255, 184)',
      buttons: [
        [
          '<button>Pesanan Diterima</button>',
          function (instance, toast) {
            $(this).prop('disabled', true);
            $.post("/marketplace/history/service", {
              Request: request,
              OrderID: orderid
            })
            .done(function (data) {
              try {
                var response = JSON.parse(data);
                if (response.success) {
                  $('#cancelbtn').modal('hide');
                  iziToast.success({
                    icon: 'fa fa-check',
                    timeout: 2000,
                    title: 'Sukses',
                    message: 'Pesanan telah diterima',
                    position: 'bottomRight',
                    onClosed: function () {
                      window.location.href = '/marketplace/confirm/';
                    }
                  });
                } else {
                  iziToast.warning({ position: "bottomRight", title: 'Caution', message: response.message || 'Failed' });
                }
              } catch (e) {
                iziToast.error({ position: "bottomRight", title: 'Error', message: 'Invalid response from server' });
              }
            }).fail(function (xhr) {
              iziToast.error({ position: "bottomRight", title: 'Error', message: xhr.responseText || 'An error occurred' });
            }).always(function() {
              $(this).prop('disabled', false); // Re-enable button after processing
            });
          }
        ],
        [
          '<button>Close</button>',
          function (instance, toast) {
              instance.hide({
                  transitionOut: 'fadeOutUp'
              }, toast);
          }
        ]
      ]
    });
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
    dateElement.innerHTML = `${date} ${icon}`;

  });
  const sidebar = document.querySelectorAll('.time-sidebar');
  sidebar.forEach(event => {
    const date = dayjs(event.dataset.date).format('D MMM YYYY');
    const dateElement = event.querySelector('.date-sidebar');
    dateElement.innerHTML = `${date}`;

  });


  const myForm = $("#myForm");
  $(".submit").click(function () {

    myForm.submit();

  });

  
  $("#Couponform").submit(function (event) {
    event.preventDefault(); 
    $.post("/marketplace/productcheckout/coupon", {
      Coupon: $("#Couponin").val(),

    })
      .done(function (data) {
        var response = JSON.parse(data);
        // console.log(response);
        if (response.success) {
          Swal.fire({
            title: "SUCCESS",
            text: response.message,
            icon: "success",
            timer: 1700
          })
          setInterval(href, 1800);

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
            message: 'Wait for Second, OTP will Expired for 5 Minutes!',
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

  otpInputs.on('input', function () {
    $(this).val($(this).val().toUpperCase());

    if ($(this).val().length > 0) {
      $(this).next('.otp-input').focus();
    }
  });

  otpInputs.on('keydown', function (e) {
    if (e.key === 'Backspace' && $(this).val().length === 0) {
      $(this).prev('.otp-input').focus();
    }
  });

  $('#sentotp').on('click', function (e) {
    e.preventDefault();
    let otpCode = '';
    otpInputs.each(function () {
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
        if (response.success) {
          iziToast.success({
            icon: 'fa fa-check',
            timeout: 3500,
            title: 'Sukses',
            message: 'Registrasi vendor berhasil!',
            position: 'bottomRight',
             onClosed: function () {
              window.location.href = "/marketplace/venn/" + vendorName;
             }
          });
        } else {
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

  $("#forgetpass").on("submit", function(event) {
    event.preventDefault(); 

    var email = $("#inputEmail4").val(); 

    $.post("/marketplace/login/sendlink", { 
        Email: email 
    })
    .done(function (data) {
      var response = JSON.parse(data);
      console.log(response);
      if (response.success) {
        iziToast.success({
          title: 'Link Sudah Diberikan Ke Alamat Email Anda',
          position: 'bottomRight',
        });
      } else {
        iziToast.error({ title: 'Gagal Mengirim', message: response.message, position: 'bottomRight' });
      }
    }).fail(function () {
      iziToast.error({ title: 'Error', message: 'Terjadi Kesalahan', position: 'bottomRight' });
    });
  });


  $("#forgetpassword").submit(function(event) {
    event.preventDefault();

    var Password = $("#inputPassword4").val(); 
    var Password2 = $("#inputPassword5").val(); 
    var uniqe = $("#uniqe").val();  
    if(Password === Password2){
      $.post("/marketplace/forgetpassword/changepass", { 
          Pw : Password,
          Pw2 : Password2,
          ID: uniqe
      })
      .done(function (data) {
        var response = JSON.parse(data);
        console.log(response);
        if (response.success) {
          iziToast.success({
            title: 'Password Anda Berhasil Diganti Silahkan Kembali Ke hal.Login',
            position: 'bottomRight',
          });
          setInterval(href, 2000);
          
          function href() {
            window.location.href = "/marketplace/login"
          }
          
        } else {
          iziToast.error({ title: 'Gagal Mengirim', message: response.message, position: 'bottomRight' });
        }
      }).fail(function () {
        iziToast.error({ title: 'Error', message: 'Terjadi Kesalahan', position: 'bottomRight' });
      });
    } else {
      iziToast.error({ title: 'Error', message: 'Password Dan Confirm Password Harus Sama', position: 'bottomRight' });
    }
  });

  $("#replycomment").submit(function (event) {
    event.preventDefault();
    console.log('kdkaskd');
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
  $('#Nilai').on('click', function(event) {
    event.preventDefault();
    var button = $(this); 
    var title = button.data('title');
    var image = button.data('image');
    var variant = button.data('variant');
    var get = button.data('get');
    var id = button.data('id');
    var button = $('.showModalButton').data('id');
    var Filter =  $("#ID").val();
    $('#ProductID').val(id);
    $('#title').html(title);
    $('#variants').html(variant);
    $('#image').attr('src', image);
    $('#OrderID').val(get);
    $('#exampleModalCenter').modal('show');
    });
  
    $("#reviewform").submit(function (event) {
      event.preventDefault();
      const rating = document.getElementById("ratingValue");
      // console.log(button);
      let angka = rating.getAttribute('value');
      // console.log(angka);
      if(parseInt(angka) === 0 ){
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
                ID: $("#ProductID").val(),
              })
              .done(function (data) {
                var response = JSON.parse(data);
                var Filter =  $("#ID").val();
                var OrderID =  $("#OrderID").val();
                
                if (response.success) {
                  $('.showModalButton[data-get="' + OrderID + '"][data-id="' + Filter+'"]').prop('disabled', true).text('Submitted'); 
                  localStorage.setItem('reviewsubmit' + OrderID + Filter, true);
                  Swal.fire({
                        title: "SUCCESS",
                        text: "Review submitted successfully!",
                        icon: "success",
                        timer: 1000,
                      });
                      $('#exampleModalCenter').removeClass('show').attr("aria-hidden", "true");
                      $('.modal-backdrop').removeClass('show');
                      document.getElementById('reviewmsg').value=null;
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

  $("#productcommentreply").submit(function (event) {
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
      // console.log("No active tab found.");
    }

    const contenttab = document.querySelector('div.tab-pane.active');
    if (contenttab) {
      var sam = contenttab.getAttribute('id');
      localStorage.setItem('SelectedContent', sam);
    } else {
      // console.log("No active tab found.");
    }
  });

  // Search Toggle
  $("#search_input_box").hide();
  $("#search_history").hide();
  $("#search").on("click", function () {
    $("#search_input_box").slideToggle();
    $("#search_history").slideToggle();
    $("#search_input").focus();
  });
  $("#close_search").on("click", function () {
    $('#search_input_box').slideUp(500);
    $('#search_history').slideUp(100);
  });
  function fetchProductName() {
    return $.ajax({
        url: '/marketplace/home/ProductListSearch',
        method: 'GET',
        dataType: 'json'
    }).fail(function () {
        console.error('Failed to fetch product names');
    });
}
let selectedIndex = -1;
function updateProductList(filteredNames) {
    var searchList = $('#history_list');
    searchList.empty();
    selectedIndex = -1;
    if (filteredNames.length > 0) {
        $('#search_input').attr('placeholder', filteredNames[0]);
        filteredNames.slice(0, 5).forEach(function (name) {
          searchList.append('<li class="py-2" style="color: #707070; border-bottom: 1px solid #f5f5f5; font-weight: 500;">' + name + '</li>');
        });
    } else {
        $('#search_input').attr('placeholder', '');
        searchList.append('<li class="py-2" style="color: #707070; border-bottom: 1px solid #f5f5f5; font-weight: 500;">No products found</li>');
    }
}

let jeda;
$('#search_input').on('input', function () {
    var searchTerm = $(this).val().toLowerCase();

    clearTimeout(jeda);
    jeda = setTimeout(function () {
        fetchProductName().done(function (productNames) {
            var filteredNames = productNames.filter(function (name) {
                return name.toLowerCase().includes(searchTerm);
            });
            updateProductList(filteredNames);
        });
    }, 300);
});
$('#search_input').on('keydown', function (e) {
  const list = $('#history_list li');
  if (e.key === 'ArrowDown') {
      selectedIndex = Math.min(selectedIndex + 1, list.length - 1);
  } else if (e.key === 'ArrowUp') {
      selectedIndex = Math.max(selectedIndex - 1, -1);
  }

  list.removeClass('selected');
  if (selectedIndex >= 0) {
      list.eq(selectedIndex).addClass('selected');
      $(this).attr('placeholder', list.eq(selectedIndex).text());
  } else {
      $(this).attr('placeholder', '');
  }
});
$('#search_input').on('keydown', function (e) {
  if (e.key === 'Tab') {
    const placeholder = $(this).attr('placeholder');
      if (placeholder) {
          e.preventDefault();
          $(this).val(placeholder);
          selectedIndex = -1;
      }
  }
});
$('#searchForm').submit(function(e) {
  e.preventDefault();
  var searchkey = $('#search_input').val();
  var searchph = $('#search_input').attr('placeholder');
  var currentParams = new URLSearchParams(window.location.search);
  if (searchph){
    if (searchph === 'SearchHere'){
      return;
    } else{
      currentParams.set('keywords', searchph);
      window.location.href = '/marketplace/shopresult' + '?' + currentParams.toString();
    }
  } else{
    currentParams.set('keywords', searchkey);
    window.location.href = '/marketplace/shopresult' + '?' + currentParams.toString();
  }
  
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
                                                                  ');

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

  /*----------------------------------------------------*/
  /*  Google map js
    /*----------------------------------------------------*/

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
    var stock = activeSubvariant.data('stock');
    var buy = $("#quantityInputDetails").val();
    var vendorID =  $("#VendorID").text();
    // console.log(vendorID);
    // return false;
    var categoryId = document.querySelector('#productCategoriID').textContent;
    if(stock >= buy){
      // alert("in");
      // return false;
      if (categoryId == 2) {
        $.post("/marketplace/cart/addcart", {
          ProductID: $("#productId").text(),
          ProductTitle: $("#productTitle").text(),
          ProductImage: $("#productImage").attr("src"),
          ProductCategoryID: $("#productCategoriID").text(),
          ProductPrice: $(".ppprice").text(),
          ProductVariant: activeSubvariant.find('#variantName').text(),
          ProductVariantID: activeSubvariant.data('id'),
          ProductQuantity: $("#quantityInputDetails").val(),
          ProductVariantWeight: activeSubvariant.data('weight'),
          VendorID: $("#VendorID").text(),
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
          ProductQuantity: $("#quantityInputDetails").val(),
          VendorID: $("#VendorID").text(),
        })
          .done(function (data) {
            var response = JSON.parse(data);
            // console.log(response.message)
            if (response.success) {
              iziToast.success({
                timeout: 2000,
                title: 'Product berhasil dimasukkan ke keranjang',
                position: 'bottomRight',
              });
            } else if (response.message = 'Login terlebih dahulu') {
              iziToast.show({
                color: 'dark',
                icon: 'fa fa-user',
                title: 'Login terlebih dahulu',
                position: 'bottomRight',
                progressBarColor: 'rgb(0, 255, 184)',
                buttons: [
                  [
                    '<button>Login</button>',
                    function (instance, toast) {
                      window.location.href = '/marketplace/login'
                    }
                  ],
                  [
                    '<button>Close</button>',
                    function (instance, toast) {
                        instance.hide({
                            transitionOut: 'fadeOutUp'
                        }, toast);
                    }
                  ]
                ]
              });
              // iziToast.warning({ position: "bottomRight", title: 'Caution', message: response.message });
            } else {
              iziToast.warning({ position: "bottomRight", title: 'Caution', message: response.message });
            }
          })
          .fail(function () {
            iziToast.error({ title: 'Error', position: 'bottomRight' });
          });
      } else {
        iziToast.warning({ title: 'Choose Variant!', position: 'bottomRight' });
        return;
      }
    } else{
      // alert("out");
      // return false;
      iziToast.warning({ title: 'Stok produk kurang dari pesanan!', position: 'bottomRight' });
      return;
    }
  });

  
  document.querySelectorAll('#variantChoose').forEach(item => {
    item.addEventListener('click', function () {
      // alert('sd');
      var productid = $(this).data('id');
      var productvariantid = $(this).data('variant');
      var cartid = $(this).data('cart');
      // console.log(productvariantid);
      
      $.post("/marketplace/cart/variantShow", {
          ProductID: productid
      })
      .done(function (data) {
          var response = JSON.parse(data);
          // return false;
          if (response.success) {
              var modalHeader = `
                  <div class="modal-header">
                      <div class="col-3 p-0 position-relative">
                          <img src="${response.productImage}" class="img-fluid img-productcart" style="aspect-ratio: 1/1; object-fit: contain; cursor: pointer;">
                          <i class='bx bx-expand-horizontal p-1' data-toggle="modal" data-target="#imageVariantModal" style="position: absolute; right: 0; color: #fff; background-color: #9e9e9e; border-radius: 50%; transform: rotate(-45deg);  cursor: pointer;"></i>
                      </div>
                      <div class="col-9 pl-3 p-0 d-flex flex-column">
                          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                          </button>
                          <div class="pt-4">
                              <h6 class="m-0" style="font-size: 18px; color: darkorange"></h6>
                              <p class="m-0" style="font-size: 15px; color: #707070; font-weight: 400;">Stok: </p>
                          </div>
                      </div>
                  </div>`;

                  var modalBody = `<div class="modal-body">
                            <div class="d-flex flex-wrap cardVariant" style="gap: 1rem;">`;

              response.variants.forEach(function(variant) {
                  modalBody += `
                              <div class="py-1 px-2 variantItem" data-variant-id="${variant.ID}">
                                  <p class="m-0">${variant.VariantName}</p>
                              </div>`;
              });

              modalBody += `</div>
                        </div>`;

              var modalFooter = `
                  <div class="modal-footer">
                      <button id="variantChange" class="genric-btn primary-border" style="width: 100%;">Konfirmasi</button>
                  </div>
              `;
              var modalImagePreview = `
                  <div class="modal fade" id="imageVariantModal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
                      <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                          <div class="modal-content" style="background: none; border: none;">
                              <div class="modal-header" style="border-bottom: none;">
                                  <button type="button" class="close"
                                      <span>&times;</span>
                                  </button>
                              </div>
                              <div class="modal-body" style="background: none;">
                                  <img id="modal-image" src="${response.productImage}" class="img-fluid" style="width: 100%; height: auto;"/>
                              </div>
                          </div>
                      </div>
                  </div>`;

              $('#VariantShow .modal-content').empty().append(modalHeader + modalBody + modalFooter);
              $('#VariantShow').append(modalImagePreview);

              $('#VariantShow').modal('show');
              $('#imageVariantModal').find('.close').on('click', function () {
                $('#imageVariantModal').modal('hide');
              });

              var defaultVariant = $(`.variantItem[data-variant-id="${productvariantid}"]`);
              if (defaultVariant.length) {
                  defaultVariant.addClass('active');
                  
                  var selectedVariant = response.variants.find(v => v.ID == productvariantid);
                  if (selectedVariant) {
                      $('.modal-header h6').text(`Rp. ${formatNumber(selectedVariant.Price)}`);
                      $('.modal-header p').text(`Stok: ${selectedVariant.Stock}`);
                  }
              }

              $('.variantItem').on('click', function() {
                var variantID = $(this).data('variant-id');
                $('.variantItem').removeClass('active');
                  $(this).addClass('active')

                  var selectedVariant = response.variants.find(v => v.ID == variantID);
                  // console.log(selectedVariant)
                  if (selectedVariant) {
                      $('.modal-header h6').text(`Rp. ${formatNumber(selectedVariant.Price)}`);
                      $('.modal-header p').text(`Stok: ${selectedVariant.Stock}`);
                  }
              });
              
              $('#variantChange').on('click', function() {
                var variantChangeID = $('.variantItem.active').data('variant-id');
                $.post("/marketplace/cart/variantChange", {
                  ProductVariantID: variantChangeID,
                  CartID : cartid
                })
                  .done(function (data) {
                    var response = JSON.parse(data);
                    // console.log(data)
                    if (response.success) {
                      location.reload();
                    } else {
                      iziToast.error({ title: 'Gagal Menghapus Product Yang dipilih:', message: response.message, position: 'bottomRight' });
                    }
                  })
                  .fail(function () {
                    iziToast.error({ title: 'Error', message: 'Terjadi Kesalahan', position: 'bottomRight' });
                  });
              });
          } else {
              alert('Gagal memuat varian.');
          }
      }).fail(function () {
          alert('Terjadi kesalahan.');
      });
    });
  }); 

   
 
  $("#proceedCheckout").on('click', function (e) {
    // console.log("ha");
    e.preventDefault();
    var selectedProducts = [];
    var formData = new FormData();
    $(".productCheckbox:checked").each(function () {
      var productData = {
        ProductCartID: $(this).data("id"),
        ProductID: $(this).closest('.cartProduct').find('#productCheckoutID').text(),
        productCheckoutVendorID: $(this).closest('.cartProduct').find('#productCheckoutVendorID').text(),
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
        // console.log(data)
        if (response.success) {
          $(".productCheckbox:checked").each(function () {
            $(this).closest('.items').remove();
            iziToast.success({
              icon: 'fa fa-trash',
              timeout: 1500,
              title: 'Product Telah Dihapus',
              position: 'bottomRight',
              onClosed: function () {
                window.location.reload();
              }
            });
          });
        } else {
          iziToast.error({ title: 'Gagal Menghapus Product Yang dipilih:', message: response.message, position: 'bottomRight' });
        }
      })
      .fail(function () {
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
    var selectedVendors = [];
    var numberInput = $("#numberinput").val();
    var regency = $('#fulldata .regency').text().trim();
    var customerName = $('#fulldata .customerName').text();
    var customerFullName = $('#fulldata .customerFullName').text();
    var customerEmail = $('#fulldata .customerEmail').text();
    var customerHandphone = $('#fulldata .customerHandphone').text();
    var customerAddress = $('#fulldata .customerAddress').text();
    var customerNotes = $('.form-group #message').val();
    console.log(customerNotes);
    var shippingCost = $('.list_2 #shippingProduct').text();
    var shippingCostNF = $('.list_2 #shippingNFProduct').text();
    var finalPrice = $('.list_2 #finalPriceProduct').text();
    var Diskon = $('.list_2 #Diskon').text();
    // console.log(Diskon);
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
        // console.log(formData)
        var paymentGate = $("input[name='selectorpaymentgate']:checked").val();
        var timeCheckout = $(".list_2").find('#time').text();
        var paymentMethod = "Manual Transfer";
        // var orderID = $(".list_2").find('#orderID').text();
        // console.log(timeCheckout)
        // console.log(orderID)
        // return false;
        $(".singlecheckoutpervendor").each(function(index, vendor) {
          var vendorID = $(vendor).find(".vendorIDProductCheckout").data('vendor');
          var vendorData = {
            VendorID: vendorID,
            VendorName: $(vendor).find(".vendorIDProductCheckout").text(),
            ProductShippingPrice: $(vendor).find('.TotalShippingPerVendor').text(),
            ProductTotalPrice: $(vendor).find('.TotalPerVendor').text(),
            CustomerNotes: $(vendor).find('.NotesMessage').text(),
            CustomerName: customerName.replace('Nama: ', ''),
            CustomerFullName: customerFullName.replace('Nama lengkap: ', ''),
            CustomerEmail: customerEmail.replace('Email: ', ''),
            CustomerHandphone: customerHandphone.replace('Handphone: ', ''),
            CustomerAddress: customerAddress.replace('Alamat: ', ''),
            Bank: paymentGate,
            PaymentMethod: paymentMethod,
            TimeCheckout: timeCheckout,
            Products: []
          };
          
          $(vendor).find(".listDataProduct").each(function(index, product) {
              var productVendorID = $(product).find('#vendorID').text();
              if (productVendorID === vendorID.toString()) {
                  var productData = {
                      ProductID: $(product).find('#productID').text(),
                      ProductTitle: $(product).find('#productTitle').text(),
                      ProductCartID: $(product).find('#productCartID').text(),
                      ProductImage: $(product).find('#productImage').text(),
                      ProductVariant: $(product).find('#productVariant').text(),
                      ProductVariantID: $(product).find('#productVariantID').text(),
                      ProductVariantWeight: $(product).find('.variantP').data('weight'),
                      ProductPrice: $(product).find('#productPrice').text(),
                      ProductQuantity: $(product).find('#productQuantity').text(),
                      VendorID: productVendorID,
                  };
                  vendorData.Products.push(productData);
              }
          });
          selectedVendors.push(vendorData);
        });
        // console.log(selectedVendors);
        formData.append('paymentDatas', JSON.stringify(selectedVendors));
        $.ajax({
          url: '/marketplace/productcheckout/manualTF',
          type: 'POST',
          data: formData,
          processData: false,
          contentType: false,
          success: function (results) {
            // return false;
            iziToast.success({
              icon: 'fas fa-shipping-fast',
              timeout: 3500,
              title: 'Pembayaran, ',
              message: 'Segera lakukan pembayaran pesanan',
              position: 'bottomRight',
              // onClosed: function () {
              //   window.location.href = "/marketplace/history";
              // }
              // onClosed: function () {
              //   window.location.href = "/marketplace/productcheckout/manualpayment/" + orderID + '?invoice=true';
              // }
            });
          },
          error: function (xhr, status, error) {
            iziToast.error({ title: 'Error', message: error, position: 'bottomRight' });
          }
        });
      } else if (paymentMethod === "duitku") {
        var formData = new FormData();
        var paymentMethod = "Duitku";
        var paymentGate = $("input[name='selectorpaymentgate']:checked").val();
        var timeCheckout = $(".list_2").find('#time').text();
        $(".singlecheckoutpervendor").each(function(index, vendor) {
          var vendorID = $(vendor).find(".vendorIDProductCheckout").data('vendor');
          var vendorData = {
            VendorID: vendorID,
            VendorName: $(vendor).find(".vendorIDProductCheckout").text(),
            ProductShippingPrice: $(vendor).find('.TotalShippingPerVendor').text(),
            ProductTotalPrice: $(vendor).find('.TotalPerVendor').text(),
            CustomerNotes: customerNotes,
            CustomerName: customerName.replace('Nama: ', ''),
            CustomerFullName: customerFullName.replace('Nama lengkap: ', ''),
            CustomerEmail: customerEmail.replace('Email: ', ''),
            CustomerHandphone: customerHandphone.replace('Handphone: ', ''),
            CustomerAddress: customerAddress.replace('Alamat: ', ''),
            Bank: paymentGate,
            PaymentMethod: paymentMethod,
            TimeCheckout: timeCheckout,
            Products: []
          };
          
          $(vendor).find(".listDataProduct").each(function(index, product) {
              var productVendorID = $(product).find('#vendorID').text();
              if (productVendorID === vendorID.toString()) {
                  var productData = {
                      ProductID: $(product).find('#productID').text(),
                      ProductTitle: $(product).find('#productTitle').text(),
                      ProductCartID: $(product).find('#productCartID').text(),
                      ProductImage: $(product).find('#productImage').text(),
                      ProductVariant: $(product).find('#productVariant').text(),
                      ProductVariantID: $(product).find('#productVariantID').text(),
                      ProductVariantWeight: $(product).find('.variantP').data('weight'),
                      ProductPrice: $(product).find('#productPrice').text(),
                      ProductQuantity: $(product).find('#productQuantity').text(),
                      VendorID: productVendorID,
                  };
                  vendorData.Products.push(productData);
              }
          });
          selectedVendors.push(vendorData);
        });
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
        var paymentMethod = "Cash On Delivery";
        var paymentGate = '';
        var timeCheckout = $(".list_2").find('#time').text();
        // var orderID = $(".list_2").find('#orderID').text();
        $(".singlecheckoutpervendor").each(function(index, vendor) {
          var vendorID = $(vendor).find(".vendorIDProductCheckout").data('vendor');
          var vendorData = {
            VendorID: vendorID,
            VendorName: $(vendor).find(".vendorIDProductCheckout").text(),
            ProductShippingPrice: $(vendor).find('.TotalShippingPerVendor').text(),
            ProductTotalPrice: $(vendor).find('.TotalPerVendor').text(),
            CustomerNotes: customerNotes,
            CustomerName: customerName.replace('Nama: ', ''),
            CustomerFullName: customerFullName.replace('Nama lengkap: ', ''),
            CustomerEmail: customerEmail.replace('Email: ', ''),
            CustomerHandphone: customerHandphone.replace('Handphone: ', ''),
            CustomerAddress: customerAddress.replace('Alamat: ', ''),
            Bank: paymentGate,
            PaymentMethod: paymentMethod,
            TimeCheckout: timeCheckout,
            Products: []
          };
          
          $(vendor).find(".listDataProduct").each(function(index, product) {
              var productVendorID = $(product).find('#vendorID').text();
              if (productVendorID === vendorID.toString()) {
                  var productData = {
                      ProductID: $(product).find('#productID').text(),
                      ProductTitle: $(product).find('#productTitle').text(),
                      ProductCartID: $(product).find('#productCartID').text(),
                      ProductImage: $(product).find('#productImage').text(),
                      ProductVariant: $(product).find('#productVariant').text(),
                      ProductVariantID: $(product).find('#productVariantID').text(),
                      ProductVariantWeight: $(product).find('.variantP').data('weight'),
                      ProductPrice: $(product).find('#productPrice').text(),
                      ProductQuantity: $(product).find('#productQuantity').text(),
                      VendorID: productVendorID,
                  };
                  vendorData.Products.push(productData);
              }
          });
          selectedVendors.push(vendorData);
        });
        $.ajax({
          url: '/marketplace/productcheckout/cash',
          type: 'POST',
          data: formData,
          processData: false,
          contentType: false,
          success: function (results) {
            iziToast.success({
              icon: 'fas fa-shipping-fast',
              timeout: 3500,
              title: 'Pesanan Telah Dibuat',
              message: 'Pesananmu Akan dikirim Secepatnya',
              position: 'bottomRight',
              onClosed: function () {
                window.location.href = "/marketplace/history";
              }
            });
          },
          error: function (xhr, status, error) {
            iziToast.error({ title: 'Error', message: error, position: 'bottomRight' });
          }
        });
      }
    }
  });
  $('.bx-copy').click(function() {
    var textToCopy = $(this).siblings('h6').text();
    
    var tempInput = $('<input>');
    $('body').append(tempInput);
    tempInput.val(textToCopy).select();
    document.execCommand('copy');
    tempInput.remove();
    iziToast.success({ timeout: 1500, icon: 'bx bx-copy', position: "bottomRight", message: 'OK' });
  });
  $('#manualtfpaymentbtn').on('click', function (e) {
    e.preventDefault();
    var formData = new FormData();
    var fileInput = $('#transfer-image')[0].files[0];
    var orderId = $(this).data('id');
    
    if(orderId) {
        formData.append('ID', orderId);
    }
    // console.log(fileInput);
    // return false;
    if(fileInput){
      formData.append('ProofImageManual', fileInput);
      $.ajax({
        url: '/marketplace/productcheckout/manualpayment',
        type: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function (results) {
          // console.log(results)
          var response = JSON.parse(results);
          if (response.success) {
            iziToast.success({
              icon: 'fas fa-shipping-fast',
              timeout: 3500,
              title: 'Pesanan Telah Dibuat dan Akan dikirim Secepatnya',
              position: 'bottomRight',
              onClosed: function () {
                // return false;
                window.location.href = "/marketplace/history";
              }
            });
          }else{
            iziToast.error({ title: 'Error', message: response.message, position: 'bottomRight' });
          }
        },
        error: function (xhr, status, error) {
          iziToast.error({ title: 'Error', message: 'error', position: 'bottomRight' });
        }
      });
    } else {
      iziToast.warning({ position: "bottomRight", title: 'Caution', message: 'Inputkan Bukti Pembayaran!' });
    }
  });
  $('.province_select').on('click', function () {
    $.ajax({
      url: '/marketplace/productcheckout/rajoProvince',
      method: 'GET',
      dataType: 'json',
      success: function (data) {
        $('#province_select').empty();
        var dataProvince = data.rajaongkir.results;
        // console.log()
        var options = '';
        dataProvince.forEach(element => {
          options += `<li data-value="${element.province_id}" class="option selected focus">${element.province}</li>`;
        });
        $('.province_select .list').append(options);
        // console.log($('.province_select .').html());
        // console.log('jQuery version:', $.fn.jquery);

      },
      error: function (jqXHR, textStatus, errorThrown) {
        console.error('Error fetching provinces:', textStatus, errorThrown);
      }
    });
  });
  $('.province_select .list').on('click', 'li', function () {
    changeProvince(this);
  });
  function changeProvince(e) {
    // alert("fs");
    // return false;
    var idProvinsi = $(e).data('value');
    // var Provinsi = $(this).text();
    // console.log(idProvinsi)
    // console.log(Provinsi)
    // return false; 
    if (idProvinsi > 0) {
      $('.regency_select .list').empty();
      $('.regency_select .current').text("Choose regency");
      $.ajax({
        url: '/marketplace/productcheckout/rajoRegency',
        type: 'POST',
        data: { ProvinceID: idProvinsi },
        dataType: 'json',
        success: function (data) {
          var options = '';
          var dataRegency = data.rajaongkir.results;
          // console.log(regency)
          dataRegency.forEach(element => {
            // console.log(element)
            // return false;
            options += `<li data-value="${element.city_id}" data-province="${element.province}" data-type="${element.type}" data-postal="${element.postal_code}" class="option selected focus">${element.city_name}</li>`;
          });
          $('.regency_select .list').append(options);
        },
        error: function (jqXHR, textStatus, errorThrown) {
          console.error('Error fetching provinces:', textStatus, errorThrown);
        }
      });
    } else {
      iziToast.warning({ position: "bottomRight", title: 'Caution', message: 'Pilih Provinsi' });
      return;
    }
  }
  $('.regency_select .list').on('click', 'li', function () {
    // alert("fs");
    var idCity = $(this).data('value');
    var City = $(this).text();
    var Provinsi = $(this).data('province');
    var Type = $(this).data('type');
    var Postal = $(this).data('postal');
    // console.log(Postal)
    $('.postalcode').val(Postal);
  });
  // $.ajax({
  //   url: '/marketplace/productcheckout/rajoProvince',
  //   method: 'GET',
  //   dataType: 'json',
  //   success: function(data) {
  //     $('#province_select').empty();
  //     var dataProvince = data.rajaongkir.results;
  //     var options = '';
  //     // console.log(data)
  //     // return false;
  //     dataProvince.forEach(element => {
  //         options += `<li data-value="${element.province_id}" class="option selected focus">${element.province}</li>`;
  //     });
  //     $('.province_select .list').append(options);
  //     // console.log($('.province_select .').html());
  //     // console.log('jQuery version:', $.fn.jquery);
  //   },
  //   error: function(jqXHR, textStatus, errorThrown) {
  //       console.error('Error fetching provinces:', textStatus, errorThrown);
  //     }
  //   });
  $('#saveData').on('click', function (e) {
    e.preventDefault();
    var firstName = $('#first').val();
    var lastName = $('#last').val();
    var numberInput = $("#numberinput").val();
    var address = $('.regency_select .list .selected').html() + ', ' + $('.province_select .list .selected').html();
    var province = parseInt($('.province_select .list .selected').data('value'));
    var regency = parseInt($('.regency_select .list .selected').data('value'));
    var street = $('#add1').val();
    var postal =  $('#zip').val();
    var notes = $('#message').val();
    // console.log(address)
    // console.log(regency)
    if (numberInput.length < 12 || numberInput.length > 14) {
      iziToast.warning({ position: "bottomRight", title: 'Caution', message: 'Nomor harus antara 12 hingga 14 digit.' });
      return;
    }
    if (!firstName || !lastName || !province || !regency || !street || !postal) {
      iziToast.warning({ position: "bottomRight", title: 'Caution', message: 'Lengkapi data pengiriman.' });
      return;
    }
    $.post("/marketplace/productcheckout/address", {
      Number: numberInput,
      FName: firstName,
      LName: lastName,
      Address: address,
      AddressDetail: street,
      Province: province,
      Regency: regency,
      Postal: postal,
      Notes : notes
    })
      .done(function (data) {
        var response = JSON.parse(data);
        // console.log(response)
        // return false;
        window.location.reload();
      })
      .fail(function () {
        iziToast.warning({ position: "bottomRight", title: 'Caution', message: 'Gagal menyimpan data pengiriman' });
      });
  });
  SelectorPayment();
  $("input[name='selectorpayment']").on('change', function () {
    SelectorPayment();
  });
  function SelectorPayment() {
    var selectedPayment = $("input[name='selectorpayment']:checked").val();
    var options = '';
    $(".optiondisplay").hide();
    $(".nooption").show();

    if (selectedPayment === "manualtf") {
      options += `<div class="payment_item active">
                        <div class="radion_btn">
                            <input type="radio" id="f-option12" value="BCA" name="selectorpaymentgate">
                            <label for="f-option12">BCA </label>
                            <img src="https://imgur.com/5pLj8C1.jpg" alt="" class="col-2">
                            <div class="check"></div>
                        </div>
                    </div>
                    <div class="payment_item">
                        <div class="radion_btn">
                            <input type="radio" id="f-option13" value="BRI" name="selectorpaymentgate">
                            <label for="f-option13">BRI </label>
                            <img src="https://imgur.com/5ssXSBr.jpg" alt="" class="col-2">
                            <div class="check"></div>
                        </div>
                    </div>
                    <div class="payment_item">
                        <div class="radion_btn">
                            <input type="radio" id="f-option14" value="Mandiri" name="selectorpaymentgate">
                            <label for="f-option14">Mandiri </label>
                            <img src="https://imgur.com/r8FVNV6.jpg" alt="" class="col-2">
                            <div class="check"></div>
                        </div>
                    </div>`;
      $(".nooptionmanualtf").hide();
      $(".optiondisplaymanualtf").show();
      $('.paymentOptionDisplayManual').html(options);
      $('.paymentOptionDisplayManual input[type="radio"]').first().prop('checked', true);
    } else if (selectedPayment === "duitku") {
      $.ajax({
        url: "/marketplace/productcheckout/paymentmethod",
        type: "POST",
        success: function (results) {
          var data = JSON.parse(results).Data;
          var collapseDuitku = $('.paymentOptionDisplayDuitku');
          collapseDuitku.empty();

          data.forEach(function (payment) {
            var paymentOption = `
                    <div class="payment_item">
                        <div class="radion_btn">
                            <input type="radio" id="${payment.paymentMethod}" value="${payment.paymentMethod}" data-method="${payment.paymentName}" name="selectorpaymentgate">
                            <label for="${payment.paymentMethod}">${payment.paymentName}</label>
                            <img src="${payment.paymentImage}" alt="${payment.paymentName}" class="col-2" style="left: 170px;">
                            <div class="check"></div>
                        </div>
                    </div>
                `;
            collapseDuitku.append(paymentOption);
          });
          $('.paymentOptionDisplayDuitku input[type="radio"]').first().prop('checked', true);
        },
        error: function () {
          $(".spinnerout").hide();
          iziToast.error({ title: 'Error', message: 'Saat Memuat Data', position: 'bottomRight' });
        }
      });
      var formData = new FormData();
      $(".nooptionduitku").hide();
      $(".optiondisplayduitku").show();
    }
  }
  $(document).on('change', 'input[name="transferImage"]', function (event) {
    previewImage(event);
  });
  var selectedImage;
  function previewImage(event) {
    var reader = new FileReader();
    var img = document.getElementById('image-preview');
    // console.log(img)
    reader.onload = function () {
      img.src = reader.result;
      img.style.display = 'block';
      var modalImg = document.getElementById('modal-image');
      modalImg.src = reader.result;
    }

    if (event.target.files[0]) {
      selectedImage = event.target.files[0];
      // console.log(selectedImage)
      reader.readAsDataURL(event.target.files[0]);
    }
  }
  function generateOrderID() {
    const timestamp = Date.now().toString(36);
    console.log(timestamp);
    const randomStr = Math.random().toString(36).substring(2, 10);
    console.log(randomStr);
    return `SHOESTORE${timestamp}${randomStr}`;
  }

  function callOrderID() {
    const orderID = generateOrderID();

    $('.list_2').each(function () {
      $(this).find('#orderID').text(orderID);
    });
  }
  function TimeCheckout() {
    var now = new Date();
    var day = now.getDate().toString().padStart(2, '0');
    var month = (now.getMonth() + 1).toString().padStart(2, '0');
    var year = now.getFullYear();
    var hours = now.getHours().toString().padStart(2, '0');
    var minutes = now.getMinutes().toString().padStart(2, '0');
    var seconds = now.getSeconds().toString().padStart(2, '0');

    var formattedTime = `${day}/${month}/${year}   ${hours}:${minutes}:${seconds}`;

    $('.list_2').each(function () {
      $(this).find('#time').text(formattedTime);
    });
  }
  $("#Comment").on('click', function (e) {
    e.preventDefault();
    var formData = new FormData();
    var comment = $("#commentMessage").val();
    formData.append('Comments', comment);
    $.ajax({
      url: "productdetails/comment",
      type: "POST",
      data: formData,
      contentType: false,
      processData: false,
      success: function (results) {
        iziToast.success({
          timeout: 2000,
          title: 'Sukses',
          position: 'bottomRight'
        });
      },
      error: function () {
        iziToast.error({ title: 'Error', message: 'Fail', position: 'bottomRight' });
      }
    });
  });
  const quantityInputDetails = $('#quantityInputDetails');
  quantityInputDetails.val(1);
  $('.variantItem').on('click', function (e) {
    e.preventDefault();
    $('.variantItem').removeClass('active');
    $(this).addClass('active')
    var variantPrice = $(this).data('price');
    var variantDiscountedPrice = $(this).data('discount');
    var variantStock = $(this).data('stock');
    if (variantStock < 1) {
      iziToast.warning({ position: "bottomRight", title: 'Caution', message: 'Stok kosong' });
      $('.variantItem').removeClass('active');
      return;
    }
    $('.ppprice').text(variantDiscountedPrice);
    $('.nnprice').text(variantPrice);
    
    const decrementButtonDetails = $('#decrementButtonDetails');
    const incrementButtonDetails = $('#incrementButtonDetails');
    const variantSelect = $('.variantItem.active');
    let maxStok = parseInt(variantSelect.data('stock'), 10);
    let currentQuantity = parseInt(quantityInputDetails.val(), 10);
    if(currentQuantity > maxStok){
      quantityInputDetails.val(maxStok);
    }
    decrementButtonDetails.off('click');
    incrementButtonDetails.off('click');
    quantityInputDetails.off('input');

    $('#monostok').text(maxStok);
    decrementButtonDetails.on('click', function() {
      let currentQuantity = parseInt(quantityInputDetails.val(), 10);
      if (currentQuantity > 1) {
        quantityInputDetails.val(currentQuantity - 1);
      }
    });
    
    incrementButtonDetails.on('click', function() {
      let currentQuantity = parseInt(quantityInputDetails.val(), 10);
      console.log(maxStok)
      if (currentQuantity < maxStok) {
        quantityInputDetails.val(currentQuantity + 1);
      }
    });

    quantityInputDetails.on('input', function() {
      quantityInputDetails.val(quantityInputDetails.val().replace(/[^0-9]/g, ''));
      let currentQuantity = parseInt(quantityInputDetails.val(), 10);
      if (!currentQuantity || currentQuantity < 1) {
        quantityInputDetails.val(1);
      } else if (currentQuantity > maxStok) {
        quantityInputDetails.val(maxStok);
      }
    });
  });
  $('.navbar-nav .nav-item').click(function () {
    $('.navbar-nav .nav-item.active').removeClass('active');
    $(this).addClass('active');
  });
  $('.payment_box .list li').click(function () {
    $('.payment_box .list li').removeClass('active');
    $(this).addClass('active');
  });
  
  $('.nav-linked').on('click', function (e) {
    e.preventDefault();

    $('.nav-linked').removeClass('active');
    $('.tab-pane').removeClass('show active');

    $(this).addClass('active');

    var targetId = $(this).attr('href');
    $('.tab-pane').each(function () {
      if ($(this).attr('id') === targetId) {
        $(this).addClass('show active');
      }
    });
  });
  $("#masterCheckbox, #bottomMasterCheckbox").on('change', function () {
    var isChecked = $(this).is(':checked');
    $(".productCheckbox").prop('checked', isChecked);
    updateSubtotal();
  });
  $('.productCheckbox').on('change', function () {
    updateSubtotal();
  });
  function showSection(sectionId, navItem) {
    $('.Semua, .Pending, .Proses, .Selesai, .Canceled, .Awal, .Akhir').hide();
    $(sectionId).show();
    $('.navi-item').removeClass('active');
    $(navItem).addClass('active');
  }
  $('#navSemua').click(function () {
    showSection('#semua', '#navSemua');
    toggleOrderDetail(false);
  });
  $('#navPending').click(function () {
    showSection('#pending', '#navPending');
    toggleOrderDetail(false);
  });
  $('#navProses').click(function () {
    showSection('#proses', '#navProses');
    toggleOrderDetail(false);
  });
  $('#navSelesai').click(function () {
    showSection('#selesai', '#navSelesai');
    toggleOrderDetail(false);
  });
  $('#navCanceled').click(function () {
    showSection('#canceled', '#navCanceled');
    toggleOrderDetail(false);
  });
  $('#navUtama').click(function () {
    showSection('#awal', '#navUtama');
    toggleOrderDetail(false);
  });
  $('#navProduct').click(function () {
    showSection('#akhir', '#navProduct');
    toggleOrderDetail(false);
  });
  $('#refreshfilter').click(function () {
    var id = $(this).data('id');
    window.location.href = '/marketplace/venn/' + id + '?filter=all';
  });
  $('#chaticons').on('click', function (e) {
    e.preventDefault();
    $.post("/marketplace/chat/clearSession", {})
    window.location.href = '/marketplace/chat/';
  });
  $('#logoutBtn').on('click', function (e) {
    e.preventDefault();
    $.post("/marketplace/profile/logout", {})
    .done(function (data) {
      var response = JSON.parse(data);
      if (response.success) {
        window.location.href = '/marketplace/';
      } else {
        alert('Fail');
      }

    }).fail(function () {
      alert('error');
    });
  });
  $('#closeProductChat').on('click', function (e) {
    e.preventDefault();
    $.post("/marketplace/chat/clearSession", {})
    window.location.reload();
  });
  $('#ChatBtn').on('click', function (e) {
    e.preventDefault();
    var ownerID = $(this).data('owner');
    var userID = $(this).data('user');
    var productID = $(this).data('product');
    $.post("/marketplace/chat/session", {
      OwnerID: ownerID,
      ProductID: productID
    })
    .done(function (data) {
      var response = JSON.parse(data);
      if (response.success) {
        window.location.href = '/marketplace/chat/?m=' + userID + 'l' + ownerID;
      } else {
        alert('Fail');
      }

    }).fail(function () {
      alert('error');
    });
  });
  $('#SendChat').submit(function (e) {
    e.preventDefault();
    
    var message = $('textarea[name="MessageChat"]').val();
    var senderID = $(this).data('sender');
    var receiverID = $(this).data('receiver');
    var productID = $('.reqProduct').find('.thisReqProduct').attr('id');
    // console.log(productID)
    // return false
    if(!message || !receiverID ){
      return;
    }
    var unichat =  '?m=' + senderID + 'l' + receiverID;
    $.post("/marketplace/chat/sendMessage", {
      Message: message,
      ReceiverID: receiverID,
      ProductID: productID
    })
    .done(function (data) {
      // return false;
      var response = JSON.parse(data);
      // return false;
      if (response.success) {
        $.post("/marketplace/chat/clearSession", {})
        window.location.href = '/marketplace/chat/' + unichat;
      } else {
        alert('Fail');
      }

    }).fail(function () {
      alert('error');
    });
  });
  $('.sidechat').on('click', function() {
    $('.sidechat').removeClass('selected');
    
    $(this).addClass('selected');
    var receiver = $(this).data('receiver');
    var sender = $(this).data('sender');
    window.location.href = '/marketplace/chat/?m=' + sender + 'l' + receiver;
  });
  $('#profilechange').submit(function(e) {
    e.preventDefault();
    var firstname = $(this).find('#firstname').val();
    var lastname = $(this).find('#lastname').val();
    var userid = $(this).find('#userid').val();
    var changeprofile = $('#transfer-image')[0].files[0];
    var form = new FormData();

    var datachange = {
      FirstName: firstname,
      LastName: lastname,
      UserID: userid
    };
    form.append('dataChange', JSON.stringify(datachange));
    form.append('profileChange', changeprofile);
    $.ajax({
      url: '/marketplace/profile/ChangeData',
      type: 'POST',
      data: form,
      processData: false,
      contentType: false,
      success: function (results) {
        var response = JSON.parse(results);
        if (response.success) {
          var changedFields = response.changedFields.join(', ');
          iziToast.success({
            icon: 'fa fa-check',
            timeout: 4000,
            title: 'Sukses',
            message: 'Data '+ changedFields + ' Telah Diperbarui',
            position: 'bottomRight',
            onClosed: function () {
              return false;
              // window.location.href = "/marketplace/";
            }
          });
        } else {
          iziToast.error({
            title: 'Failed ',
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
  var email = $('#profilechange').find('#email-label').text();
  var hashedEmail = hashEmail(email);
  $('#email-label').text(hashedEmail);
  $('#reqChangePass').on('click', function() {
    var form = new FormData();
    var otpCode = generateOTP();
    var changePass = {
      CodeOTP: otpCode,
      EmailChange: email
    };
    form.append('ChangePass', JSON.stringify(changePass));
    iziToast.success({
      icon: 'fa fa-check',
      timeout: 5000,
      title: 'Sukses',
      message: 'Tunggu sebentar...',
      position: 'bottomRight',
      onClosed: function () {
        $('#OTPCodeChangePass').modal('show');
      }
    });
    $.ajax({
      url: '/marketplace/profile/SentOTP',
      type: 'POST',
      data: form,
      processData: false,
      contentType: false,
      success: function (results) {
        iziToast.success({
          icon: 'fa fa-check',
          timeout: 3500,
          title: 'Sukses',
          message: 'OTP berhasil dikirim, OTP akan expired setelah 3 menit!',
          position: 'bottomRight',
          onClosed: function () {
            $('#OTPCodeChangePass').modal('show');
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
    })
  });
  $('#sentOTPChangePass').submit(function (e) {
    e.preventDefault();
    let otpCode = '';
    otpInputs.each(function () {
      otpCode += $(this).val();
    });
    // console.log(otpCode)
    $.post("/marketplace/profile/CheckOTP", {
      OTPCode: otpCode
    })
    .done(function (data) {
      // return false;
      var response = JSON.parse(data);
      if (response.success) {
        $('#ChangePass').modal('show');
      } else {
        alert('Fail');
      }

    }).fail(function () {
      alert('error');
    });
  });
  $('#ChangePass').submit(function (e) {
    e.preventDefault();

    var password = $(this).find('#newpass').val();
    var confirmpassword = $(this).find('#confpass').val();
    if(password != confirmpassword){
      iziToast.warning({ position: "bottomRight", title: 'Caution', message: 'Password Tidak Sama' });
    }
    $.post("/marketplace/profile/ChangePass", {
      NewPassword: password
    })
    .done(function (data) {
      var response = JSON.parse(data);
      // console.log(response)
      if (response.success) {
        iziToast.success({
          icon: 'fa fa-check',
          timeout: 3500,
          title: 'Sukses',
          message: 'Password Berhasil Diperbarui',
          position: 'bottomRight',
          onClosed: function () {
            window.location.reload();
          }
        });
      } else {
        iziToast.error({
          title: 'Failed ',
          message: response.message,
          position: 'bottomRight'
        });
      }

    }).fail(function () {
      iziToast.error({
        title: 'Error ',
        position: 'bottomRight'
      });
    });
  });
  const urlParams = new URLSearchParams(window.location.search);
  const urlPath = window.location.pathname.split('/');
  const urlOrder = urlPath[3];
  // console.log(urlParams);
  // console.log(urlPath);
  // console.log(urlOrder);
  if(urlOrder == 'order'){
    const urlHistory = urlPath[4]
    if(urlHistory){
      $.post("/marketplace/notification/NotificationRead", {
        OrderID: urlHistory
      })
    }
  }

  if (urlParams.has('detailOrder')) {
    toggleOrderDetail(true);
  } else {
    if (selectedBrand || selectedSubCategory || selectedSort) {
      $('#navSemua').click();
      $('#navProduct').click();
    } else {
      $('#navSemua').click();
      $('#navUtama').click();
    }

  }
  function toggleOrderDetail(showDetail) {
    if (showDetail) {
      $('#myOrder').hide();
      $('#detailOrder').show();
    } else {
      $('#myOrder').show();
      $('#detailOrder').hide();
    }
  }
  if(urlParams.has('account')){
    toggleSwitchProfile(true);
  } else {
    toggleSwitchProfile(false);
  }
  function toggleSwitchProfile(stts) {
    if (stts) {
      $('#ProfileMainpage').hide();
      $('#ProfileAccountSec').show();
    } else {
      $('#ProfileMainpage').show();
      $('#ProfileAccountSec').hide();
    }
  }
  if(urlParams.has('invoice')){
    manualPayment(true);
  } else {
    manualPayment(false);
  }
  function manualPayment(showPayment) {
    if (showPayment) {
      $('#checkout_area').hide();
      $('#invoice_payment').show();
    } else {
      $('#checkout_area').show();
      $('#invoice_payment').hide();
    }
  }

  function hashEmail(email) {
    var emailParts = email.split('@');
    var namePart = emailParts[0];
    
    if (namePart.length > 1) {
        var hashedName = namePart[0] + '****';
        return hashedName + '@' + emailParts[1];
    }
    return email;
  }
  const textareachat = document.querySelector('textarea[name="MessageChat"]');
  if(textareachat){
    textareachat.addEventListener('input', function () {
        this.style.height = 'auto';
        this.style.height = (this.scrollHeight) + 'px';
    });
  }
  $(document).on('submit', '.note-form', function(event) {
    event.preventDefault();
    
    var vendorID = $(this).data('vendor-id');
    var noteContent = $("#Notes-product-" + vendorID).val();
    $("#Notes-message-" + vendorID).text(noteContent);
    $("#Notes-" + vendorID).modal('hide');
});
$('#loading').show();
if($('#loading').show()){
    document.body.style.overflow = 'hidden';
}
let ajaxPromises = [];

document.querySelectorAll('.singlecheckoutpervendor').forEach(vendor => {
    let vendorID = vendor.querySelector('.vendorIDProductCheckout').getAttribute('data-vendor');
    
    function updateTotals(vendorID) {
        let subtotalproduct = 0;

        vendor.querySelectorAll(`.variantP-${vendorID}`).forEach(product => {
            let productPrice = parseInt(product.getAttribute('data-price').replace('Rp. ', '').replace(/\./g, ''), 10);
            subtotalproduct += productPrice;
        });

        let shippingCost = parseFloat($(`.TotalShippingPerVendor-${vendorID}`).text().replace('Rp. ', '').replace(/\./g, ''));
        let totalWithShipping = subtotalproduct + (isNaN(shippingCost) ? 0 : shippingCost);

        $(`.TotalPerVendor-${vendorID}`).text(`Rp. ${formatNumber(totalWithShipping)}`);
    }

    updateTotals(vendorID);

    $(document).on('change', `input[name='selectorCost-${vendorID}']`, function () {
        fetchcost(vendorID);
        updateTotals(vendorID);
        updateFinalPrice(vendorID);
    });
    
    function fetchcost(vendorID) {
        var cost = $(`input[name='selectorCost-${vendorID}']:checked`).next('label').data('opt');
        $(`.TotalShippingPerVendor-${vendorID}`).text(`Rp. ${formatNumber(cost)}`);
        
        updateTotals(vendorID);
    }

    $(`input[name='selectorcourir-${vendorID}']`).on('change', function () {
        fetchcourir(vendorID);
        updateFinalPrice(vendorID);
    });
    ajaxPromises.push(fetchcourir(vendorID));

    function fetchcourir(vendorID) {
        return new Promise((resolve, reject) => {
            var courir = $(`input[name='selectorcourir-${vendorID}']:checked`).next('label').data('opt');
            let totalWeight = 0;
            vendor.querySelectorAll(`.variantP-${vendorID}`).forEach(item => {
                const weight = parseFloat(item.getAttribute('data-weight'));
                if (!isNaN(weight)) {
                    totalWeight += weight;
                }
            });
            var idRegency = $('#fulldata .regency').text();
            var regencyID = vendor.querySelector('.vendorIDProductCheckout').getAttribute('data-origin');

            $.ajax({
                url: '/marketplace/productcheckout/rajoCost',
                type: 'POST',
                data: {
                    Courir: courir,
                    RegencyID: idRegency,
                    Weight: totalWeight,
                    Origin: regencyID
                },
                dataType: 'json',
                success: function (data) {
                    var options = '';
                    var dataCost = data.rajaongkir.results[0].costs;
                    var courirName = $(`input[name='selectorcourir-${vendorID}']:checked`).next('label').text();
                    var OpsiCourir = null;
                    dataCost.forEach((element, index) => {
                        let formattedCost = formatNumber(element.cost[0].value);
                        options += `<div class="payment_item active">
                                        <div class="radion_btn">
                                            <input type="radio" id="${element.service}-${vendorID}" name="selectorCost-${vendorID}" ${index === 0 ? 'checked' : ''}>
                                            <label class="rajoCostOptionLabel" data-opt="${element.cost[0].value}" for="${element.service}-${vendorID}">${element.description} (${formattedCost})</label>
                                            <div class="check"></div>
                                        </div>
                                    </div>`;
                    });
                    $(`.rajoCostOption-${vendorID}`).html(options);
                    OpsiCourir = courirName;
                    $(`#OpsiSelect-${vendorID}`).text(OpsiCourir);
                    
                    fetchcost(vendorID);
                    updateFinalPrice();
                    resolve();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    reject(errorThrown);
                }
            });
        });
    }

    function formatNumber(number) {
        let parts = number.toString().split('.');
        let integerPart = parts[0];
        let decimalPart = parts.length > 1 ? '.' + parts[1] : '';
        let formattedIntegerPart = '';
        while (integerPart.length > 0) {
            formattedIntegerPart = '.' + integerPart.slice(-3) + formattedIntegerPart;
            integerPart = integerPart.slice(0, -3);
        }
        return formattedIntegerPart.slice(1) + decimalPart;
    }

});

  Promise.all(ajaxPromises).then(() => {
      $('#loading').hide();
      if($('#loading').hide()){
        document.body.style.overflow = 'auto';
      }
  }).catch((error) => {
      console.error("Error in one of the AJAX requests:", error);
      $('#loading').hide(); 
  });

  updateFinalPrice();
  function updateFinalPrice() {
    let totalFinalPrice = 0;
    document.querySelectorAll('.TotalPerVendor').forEach(totalElement => {
        const subTotalElement = totalElement.textContent.trim();
        const subTotalInt = parseInt(subTotalElement.replace('Rp. ', '').replace(/\./g, ''), 10);
        if (!isNaN(subTotalInt)) {
            totalFinalPrice += subTotalInt;
        }
    });
    const finalElement = $('#finalPriceProduct');
    finalElement.text(`Rp. ${formatNumber(totalFinalPrice)}`);
    
    let totalShippingPrice = 0;
    document.querySelectorAll('.TotalShippingPerVendor').forEach(totalElement => {
      const subTotalElement = totalElement.textContent.trim();
      const subTotalInt = parseInt(subTotalElement.replace('Rp. ', '').replace(/\./g, ''), 10);
      if (!isNaN(subTotalInt)) {
        totalShippingPrice += subTotalInt;
      }
    });
    const finalShippingElement = $('#shippingProduct');
    finalShippingElement.text(`Rp. ${formatNumber(totalShippingPrice)}`);
    
    const finalElementMinus = $('#finalPriceProduct').text();
    const finalShippingElementMinus = $('#shippingProduct').text();
    const subTotalProduct = $('#subTotalPriceProduct');
    let subTotalPriceProduct = parseInt(finalElementMinus.replace('Rp. ', '').replace(/\./g, ''), 10) - parseInt(finalShippingElementMinus.replace('Rp. ', '').replace(/\./g, ''), 10);
    // console.log(subTotalPriceProduct)
    subTotalProduct.text(`Rp. ${formatNumber(subTotalPriceProduct)}`);
  }
  let subtotal = 0;
  $('#subTotalPriceProduct').text(`Rp. ${subtotal.toLocaleString('id-ID')}`);


  function formatNumber(number) {
    let parts = number.toString().split('.');
    let integerPart = parts[0];
    let decimalPart = parts.length > 1 ? '.' + parts[1] : '';

    let formattedIntegerPart = '';
    while (integerPart.length > 0) {
      formattedIntegerPart = '.' + integerPart.slice(-3) + formattedIntegerPart;
      integerPart = integerPart.slice(0, -3);
    }

    return formattedIntegerPart.slice(1) + decimalPart;
  }
  function updateTotalPrice(quantityInput, priceElement, totalPriceElement, totalPriceElementNF) {
    let priceText = priceElement.textContent.replace('Rp. ', '').replace('.', '').replace('.', '');
    let priceNumber = parseInt(priceText);
    const quantity = parseInt(quantityInput.value, 10);

    if (isNaN(priceNumber)) priceNumber = 0;
    if (isNaN(quantity) || quantity < 1) quantity = 1;

    const totalPrice = (priceNumber * quantity).toFixed(0);
    priceElement.textContent = `Rp. ${formatNumber(priceNumber)}`;
    totalPriceElement.textContent = `Rp. ${formatNumber(totalPrice)}`;
    totalPriceElementNF.textContent = totalPrice;
  }

  function updateSubtotal() {
    let subtotal = 0;
    document.querySelectorAll('.cartProduct').forEach(item => {
      if (item.querySelector('.productCheckbox:checked')) {
        const totalPriceElementNF = item.querySelector('#totalPriceNFCheckout');
        const totalPrice = parseInt(totalPriceElementNF.textContent);
        // console.log(totalPrice)
        if (!isNaN(totalPrice)) {
          subtotal += totalPrice;
        }
      }
    });

    const subtotalElement = document.querySelector('#subTotalPriceCheckout');
    const subtotalElementNF = document.querySelector('#subTotalPriceNFCheckout');
    if(subtotalElement || subtotalElementNF){
      subtotalElement.textContent = `Rp. ${formatNumber(subtotal.toString())}`;
      subtotalElementNF.textContent = subtotal;
    }
  }
  document.querySelectorAll('.cartProduct').forEach(item => {
    const decrementButton = item.querySelector('#decrementButton');
    
    const incrementButton = item.querySelector('#incrementButton');
    const quantityInput = item.querySelector('#quantityInput');
    const quantitymax = item.querySelector('#quantityInput').getAttribute('data-stock');
    // console.log(quantitymax);
    const priceElement = item.querySelector('#itemPrice');
    const totalPriceElement = item.querySelector('#totalPriceCheckout');
    const totalPriceElementNF = item.querySelector('#totalPriceNFCheckout');
    const checkboxhCheck = item.querySelector('.productCheckbox');
    const stockWarning = item.querySelector('#stockWarning');

    function StockWarning(quantity) {
      const maxQuantity = parseInt(quantitymax, 10);
      const currentQuantity = parseInt(quantity, 10);
      // console.log(quantity)
      if (currentQuantity >= maxQuantity) {
          stockWarning.style.display = 'flex';
      } else {
          stockWarning.style.display = 'none';
      }
    }

    decrementButton.addEventListener('click', function () {
      if (quantityInput.value > 1) {
        quantityInput.value = parseInt(quantityInput.value, 10) - 1;
        updateTotalPrice(quantityInput, priceElement, totalPriceElement, totalPriceElementNF);
        updateSubtotal();
        StockWarning(quantityInput.value);
      }
    });

    incrementButton.addEventListener('click', function () {
      let currentQuantity = parseInt(quantityInput.value, 10);

      if (currentQuantity < quantitymax) {
        console.log(quantitymax);
        quantityInput.value = currentQuantity + 1;
        updateTotalPrice(quantityInput, priceElement, totalPriceElement, totalPriceElementNF);
        updateSubtotal();
      }
      StockWarning(quantityInput.value);
    });

    quantityInput.addEventListener('input', function () {
      quantityInput.value = quantityInput.value.replace(/[^0-9]/g, '');
      let currentQuantity = parseInt(quantityInput.value, 10);
      if (!currentQuantity || currentQuantity < 1) {
        quantityInput.value = 1;
      } else if (currentQuantity > quantitymax) {
        quantityInput.value = quantitymax;
      }
      updateTotalPrice(quantityInput, priceElement, totalPriceElement, totalPriceElementNF);
      updateSubtotal();
      StockWarning(quantityInput.value);
    });
    updateTotalPrice(quantityInput, priceElement, totalPriceElement, totalPriceElementNF);
  });
  updateSubtotal();
});
  const events = document.querySelector('.event');
function saveSelectionAndSubmit() {
  const ratingFilter = document.getElementById('rating-filter');
  localStorage.setItem('selectedSort', ratingFilter.value);

  ratingFilter.form.submit();
}
