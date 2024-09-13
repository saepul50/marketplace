
$(document).ready(function () {
  "use strict";

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
        items:1,
        autoplay:true,
        autoplayTimeout: 3000,
        loop:true,
        nav:true,
        navText:[
          "<img src='_resources/themes/simple/images/banner/prev.png'>",
          "<img src='_resources/themes/simple/images/banner/next.png'>"
        ],
        dots:false
    });

    /*=================================
    Javascript for product area carousel
    ==================================*/
    $(".active-product-area").owlCarousel({
        items:1,
        autoplay:false,
        autoplayTimeout: 5000,
        loop:true,
        nav:true,
        navText:[
          "<img src='_resources/themes/simple/images/banner/prev.png'>",
          "<img src='_resources/themes/simple/images/banner/next.png'>"
        ],
        dots:false
    });

    /*=================================
    Javascript for single product area carousel
    ==================================*/
    $(".s_Product_carousel").owlCarousel({
      items:1,
      autoplay:false,
      autoplayTimeout: 5000,
      loop:true,
      nav:false,
      dots:true
    });
    
    /*=================================
    Javascript for exclusive area carousel
    ==================================*/
    $(".active-exclusive-product-slider").owlCarousel({
        items:1,
        autoplay:false,
        autoplayTimeout: 5000,
        loop:true,
        nav:true,
        dots:false
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
      $("#loginn").on('click', function (event) {
        event.preventDefault();
        $.post("/marketplace/login/proseslogin",
        {
            Email: $("#emaillogin").val(),
            Password:  $("#passwordlogin").val()
        })
        .done(function (data) {
          var response = JSON.parse(data);
          if (response.success) {
            alert("sukses");
            window.location.href = "";
          } else {
            alert("gagal login")
          }
        })
        .fail(function () {
          alert("gaiso1")
        });
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
              window.location.href = "/marketplace/login";
            } else {
              alert("error");
            }
            
          }).fail(function () {
            alert("errorfail");
          });
      });
      $("#addCart").on('click', function(e){
        e.preventDefault();
        var formData = new FormData();
        var ProductItem = [];
        var activeSubvariant = $('.variantItem.active');
        $.post("/marketplace/cart/addcart", {
          ProductID: $("#productId").text(),
          ProductTitle: $("#productTitle").text(),
          ProductImage: $("#productImage").attr("src"),
          ProductCategoryID: $("#productCategoriID").text(),
          ProductVariant: activeSubvariant.find('#variantName').text(),
          ProductVariantID: activeSubvariant.data('id'),
          ProductPrice: $(".ppprice").text(),
          ProductQuantity: $("#sst").val(),
        })
        .done(function (data) {
          var response = JSON.parse(data);
          console.log(response)
          if (response.success) {
            alert("sukses");
          }else{
            alert("gagal");
          }
        })
        .fail(function() {
          alert("gaiso");
        });
      });
      $("#proceedCheckout").on('click', function(e){
        e.preventDefault();
          var selectedProducts = [];
          $(".productCheckbox:checked").each(function() {
              var productData = {
                  CartID: $(this).data("id"),
                  ProductID: $(this).closest('.cartProduct').find('#productCheckoutID').text(),
                  ProductTitle: $(this).closest('.cartProduct').find('#productCheckoutTitle').text(),
                  ProductImage: $(this).closest('.cartProduct').find('#productCheckoutImage').attr("src"),
                  VariantName: $(this).closest('.cartProduct').find('#productCheckoutVariant').text(),
                  VariantID: $(this).closest('.cartProduct').find('#productCheckoutVariant').data('id'),
                  Price: $(this).closest('.cartProduct').find('#itemPrice').text(),
                  TotalPrice: $(this).closest('.cartProduct').find('#totalPriceCheckout').text(),
                  TotalPriceNF: $(this).closest('.cartProduct').find('#totalPriceNFCheckout').text(),
                  Quantity: $(this).closest('.cartProduct').find('#quantityInput').val()
              };
              selectedProducts.push(productData);
              console.log(selectedProducts)
          });
      });
      $("#Comment").on('click', function(e){
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
              alert("success");
            },
          error: function () {
            alert("fail");
          }
        });
      });
      $('.variantItem').on('click', function(e){
        e.preventDefault();
        $('.variantItem').removeClass('active');
        $(this).addClass('active')
        var variantPrice = $(this).data('price');
        var variantDiscountedPrice = $(this).data('discount');
        var variantStock = $(this).data('stock');
        if(variantStock<1){
          alert("stock kosong");
          $('.variantItem').removeClass('active');
          return;
        }
        $('.ppprice').text(variantDiscountedPrice);
        $('.nnprice').text(variantPrice);
      });
      $('.navbar-nav .nav-item').click(function(){
        $('.navbar-nav .nav-item.active').removeClass('active');
        $(this).addClass('active');
      });
      $('.payment_box .list li').click(function(){
        $('.payment_box .list li').removeClass('active');
        $(this).addClass('active');
      });
      $('.nav-linked').on('click', function (e) {
        e.preventDefault();

        $('.nav-linked').removeClass('active');
        $('.tab-pane').removeClass('show active');

        $(this).addClass('active');

        var targetId = $(this).attr('href');
        $('.tab-pane').each(function() {
            if ($(this).attr('id') === targetId) {
                $(this).addClass('show active');
            }
        });
      });
      $("#masterCheckbox, #bottomMasterCheckbox").on('change', function() {
        var isChecked = $(this).is(':checked');
        $(".productCheckbox").prop('checked', isChecked);
      });
      document.querySelectorAll('.cartProduct').forEach(itemCart => {
        const priceElement = itemCart.querySelector('#totalPriceNFCheckout');
      
        if (priceElement) {
          let priceText = priceElement.textContent;
          console.log(priceText);
        }
      });
      function FinalPrice() {
        let priceElements = [];
    
      

        // let totalPrice = 0;
        // priceElements.forEach(element => {
        //     const price = parseInt(element);

        //     if (!isNaN(price)) {
        //         totalPrice += price;
        //     }
        // });

        // return totalPrice;
      }
      FinalPrice();

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
        totalPriceElement.textContent = `Rp. ${formatNumber(totalPrice)}`;
        totalPriceElementNF.textContent = totalPrice;
        // console.log(totalPriceElement.textContent)
      }
      document.querySelectorAll('.cartProduct').forEach(item => {
        const decrementButton = item.querySelector('#decrementButton');
        const incrementButton = item.querySelector('#incrementButton');
        const quantityInput = item.querySelector('#quantityInput');
        const priceElement = item.querySelector('#itemPrice');
        const totalPriceElement = item.querySelector('#totalPriceCheckout');
        const totalPriceElementNF = item.querySelector('#totalPriceNFCheckout');
        decrementButton.addEventListener('click', function() {
          if (quantityInput.value > 1) {
            quantityInput.value = parseInt(quantityInput.value, 10) - 1;
            updateTotalPrice(quantityInput, priceElement, totalPriceElement, totalPriceElementNF);
          }
      });

      incrementButton.addEventListener('click', function() {
          quantityInput.value = parseInt(quantityInput.value, 10) + 1;
          updateTotalPrice(quantityInput, priceElement, totalPriceElement, totalPriceElementNF);
      });

      quantityInput.addEventListener('input', function() {
        quantityInput.value = quantityInput.value.replace(/[^0-9]/g, '');
        if (!quantityInput.value || quantityInput.value<1) {
          quantityInput.value = 1;
          // console.log(quantityInput.value)
        }
        updateTotalPrice(quantityInput, priceElement, totalPriceElement, totalPriceElementNF);
      });
        updateTotalPrice(quantityInput, priceElement, totalPriceElement, totalPriceElementNF);
    });
});

