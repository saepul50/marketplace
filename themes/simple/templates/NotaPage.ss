<!DOCTYPE html>
<!--
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
Simple. by Sara (saratusar.com, @saratusar) for Innovatif - an awesome Slovenia-based digital agency (innovatif.com/en)
Change it, enhance it and most importantly enjoy it!
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-->

<!--[if !IE]><!-->
<html lang="$ContentLocale">
<!--<![endif]-->
<!--[if IE 6 ]><html lang="$ContentLocale" class="ie ie6"><![endif]-->
<!--[if IE 7 ]><html lang="$ContentLocale" class="ie ie7"><![endif]-->

<!--[if IE 8 ]><html lang="$ContentLocale" class="ie ie8"><![endif]-->
<head>
	


<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js" integrity="sha512-DUC8yqWf7ez3JD1jszxCWSVB0DMP78eOyBpMa5aJki1bIRARykviOuImIczkxlj1KhVSyS16w2FSQetkD4UU2w==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<link href="https://cdn.jsdelivr.net/npm/izitoast@1.4.0/dist/css/iziToast.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.0/dist/sweetalert2.all.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.0/dist/sweetalert2.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/owl.carousel@2.3.4/dist/owl.carousel.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/owl.carousel@2.3.4/dist/assets/owl.carousel.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>

	<% base_tag %>
	<title>$SiteConfig.Title</title>
	<!-- Favicon-->
	<link rel="shortcut icon" href="$SiteConfig.Favicon.getURL()">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	$MetaTags(false)
	<!--[if lt IE 9]>
	<script src="//html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<% require themedCSS("linearicons") %>
	<% require themedCSS('magnific-popup') %>
	<% require themedCSS('main') %>
	<% require themedCSS('font-awesome.min') %>
	<% require themedCSS('themify-icons') %>
	<% require themedCSS('bootstrap') %>
	<% require themedCSS('owl.carousel') %>
	<% require themedCSS('nice-select') %>
	<% require themedCSS('nouislider.min') %>
	<% require themedCSS('ion.rangeSlider') %>
	<% require themedCSS('ion.rangeSlider.skinFlat') %>
	<% require themedCSS('main') %>
	<% require themedCSS('linearicons') %>
	<% require themedCSS('font-awesome.min') %>
	<% require themedCSS('themify-icons') %>
	<% require themedCSS('bootstrap') %>
	<% require themedCSS('owl.carousel') %>
	<% require themedCSS('nice-select') %>
	<% require themedCSS('nouislider.min') %>
	<% require themedCSS('ion.rangeSlider.skinFlat') %>
	<% require themedCSS('magnific-popup') %>
      

<div class="Struk " id="struk" style="max-width: 600px; margin: 40px auto; background-color: #f7f7f7; border: 1px solid #e0e0e0; border-radius: 12px; padding: 25px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
    <% with $Header %>
        <p>No.Pesanan : $OrderID</p> 
            <div class="d-flex justify-content-between">
                <div>
                    <p>Total Pembayaran </p>
                    <p >$FinalPrice</p>
                </div>
                <div>
                    <p>Waktu Pembayaran</p>
                    <p>$TimeCheckout</p>
                </div>
                
            </div>
            <hr>
            <div class="d-flex justify-content-between">
                <div>
                    <p>Rincian Pengiriman </p>
                    <div class="">
                    <span>$CustomerName</span><br>
                    <span>$CustomerAddress</span><br>
                    <span>$CustomerHandphone</span>
                    </div>
                </div>
                <div>
                    <p>Metode Pembayaran</p>
                    <p>$PaymentMethod</p>
                </div>
            </div>
            <hr>
            <p>Rincian Pesanan</p>  
            <% loop $items %>
            <div class="d-flex justify-content-between items">
                    <div>
                        <p>$ProductTitle</P>
                        <p>$ProductVariant</p> 
                    </div>
                    <div>
                        <p id="quantity">x$ProductQuantity</p>
                        <p id="harga">$ProductPrice</p>
                    </div>
                    
                </div>
            <% end_loop %>
            <hr>
            <div class="d-flex justify-content-between">
                <div>
                    <p>Subtotal untuk produk</p>
                    <p class="text-muted">Fee Pengiriman</p>
                    <p class="text-muted">Diskon</p>
                    <p style="font-weight:bold;">Total</p>
                </div>
                <div>
                    <p id="SubTotal"></p>
                    <p  class="text-muted">$ProductCostShipping</p>
                    <p  class="text-muted"><% if $Diskon %>$Diskon%<% else %>0 %<% end_if %></p>
                    <p style="font-weight:bold;">$FinalPrice</p>
                </div>
                
            </div>
        <input class="d-none" id="order" value="$OrderID">
        <% end_with %>
</div>  
<div class="text-center mt-2">
<button class="genric-btn primary-border">Cetak Pdf</button>
</div>









<% require themedJavascript('jquery.ajaxchimp.min') %>
<% require themedJavascript('jquery.nice-select.min') %>
<% require themedJavascript('jquery.sticky') %>
<% require themedJavascript('nouislider.min') %>
<% require themedJavascript('countdown') %>
<% require themedJavascript('jquery.magnific-popup.min') %>
<% require themedJavascript('owl.carousel.min') %>
<% require themedJavascript('gmaps.min') %>
<% require themedJavascript('main') %>


<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.12.4/dist/sweetalert2.all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/izitoast@1.4.0/dist/js/iziToast.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/dayjs@1/dayjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.2/html2pdf.bundle.min.js" integrity="sha512-MpDFIChbcXl2QgipQrt1VcPHMldRILetapBl5MPCA9Y8r7qvlwx1/Mc9hNTzY+kS5kX6PdoDq41ws1HiVNLdZA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<%-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script> --%>


    <script>
        $(document).ready(function() {
            $('.primary-border').on('click', function(event) {
                event.preventDefault();
                var orderid = document.getElementById('order').value;
                var element = document.getElementById('struk');
                console.log(element.width);
                var pageWidth = element.offsetWidth;
                var pageHeight = element.OffsetHeight;

                console.log("Width: " + pageWidth + ", Height: " + pageHeight);
                var opt = {
                    margin: 1,
                    filename: orderid + '_' + Date.now() + '.pdf',
                    image: { type: 'jpeg', quality: 0.98 },
                    html2canvas: { scale: 2 },
                    jsPDF: { unit: 'in', format:'letter', orientation: 'portrait' } 
                };
                html2pdf().set(opt).from(element).save();
              
            });


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

            let subhistorytotal = 0;
            document.querySelectorAll('.items').forEach(item => {
                const quantityElement = item.querySelector('#quantity');
                const priceElement = item.querySelector('#harga');
                var quantityAmount = parseInt(quantityElement.textContent.replace("x", "").trim(), 10);
                var price = priceElement.textContent.replace('Rp. ', '').replace('.', '').replace('.', '').replace('.', '').replace('.', '').replace('.', '').replace('.', '');
                var totalpriceproduct = price * quantityAmount;
                subhistorytotal += totalpriceproduct;
            });

            document.querySelector('#SubTotal').textContent = `Rp. ${formatNumber(subhistorytotal)}`;


        });
    </script>
