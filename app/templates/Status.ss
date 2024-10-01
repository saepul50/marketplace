
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
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<% base_tag %>
	<title>$SiteConfig.Title</title>
	<!-- Favicon-->
	<link rel="shortcut icon" href="$SiteConfig.Favicon.getURL()">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	$MetaTags(false)
	<link rel="stylesheet" href="$ThemeDir/css/linearicons.css" />
	<link rel="stylesheet" href="$ThemeDir/css/magnific-popup.css" />
	<link rel="stylesheet" href="$ThemeDir/css/main.css" />
	<link rel="stylesheet" href="$ThemeDir/css/font-awesome.min.css" />
	<link rel="stylesheet" href="$ThemeDir/css/themify-icons.css" />
	<link rel="stylesheet" href="$ThemeDir/css/bootstrap.css" />
	<link rel="stylesheet" href="$ThemeDir/css/owl.carousel.css" />
	<link rel="stylesheet" href="$ThemeDir/css/nice-select.css" />
	<link rel="stylesheet" href="$ThemeDir/css/nouislider.min.css" />
	<link rel="stylesheet" href="$ThemeDir/css/ion.rangeSlider.css" />
	<link rel="stylesheet" href="$ThemeDir/css/ion.rangeSlider.skinFlat.css" />
	<style>
		.fw-bold{
			font-weight: bold;
		}
	</style>
</head>
<body>
	
	<div class="cms-content fill-height flexbox-area-grow cms-tabset center BlogAdmin ModelAdmin LeftAndMain" data-layout-type="border" data-pjax-fragment="Content" id="ModelAdmin">

		<div class="cms-content-header north">
			<div class="cms-content-header-info vertical-align-items flexbox-area-grow">
				<div class="breadcrumbs-wrapper">
					<span class="cms-panel-link crumb last">
						Status
					</span>
				</div>
			</div>
		</div>

		<div class=" ml-5 mt-3 mr-5 Semua" id="semua">
			<div class="d-flex justify-content-between">
			<h2 class="fw-bold" style="margin-top: .04rem;">Status Pesanan</h2>
				<a href="/marketplace/venn/" class="text-muted">Riwayat Penjualan ></a>
			</div>
			<div class="mt-2 row text-center">
				<div class="p-4 col">
					<p>$Dikemas</p>
					<p>Dikemas $Data.OrderID</p>
				</div>
				<div class="p-4 col">
					<p>$Dikirim</p>
					<p>Dikirim</p>
				</div>
				<div class="p-4 col">
					<p>$Selesai</p>
					<p>Selesai</p>
				</div>
				<div class="p-4 col">
					<p>$Dibatalkan</p>
					<p>Dibatalkan</p>
				</div>
			</div>
		</div>
		<div class=" ml-5 mt-3 mr-5 Semua" id="Performa">
			<div class="d-flex justify-content-between">
				<h2 class="fw-bold">Performa Toko</h2>
			</div>
			<p class="" id="days">$Days</p>
			<div class="mt-2 d-flex" style="height: 350px;">
				<div class="col-8 p-0">
					<h4 class="fw-bold">Penjualan</h4>
					<canvas id="myChart"></canvas>
				</div>
				<div class="col-4 p-0">
					<h4 class="fw-bold">Product Category</h4>
					<canvas id="CategoryChart"></canvas>
				</div>
			</div>
		</div>
	</div>
	<script>
	document.addEventListener("DOMContentLoaded", function() {
		var transactionsctx = document.getElementById('myChart').getContext('2d');
		var categoriesctx = document.getElementById('CategoryChart').getContext('2d');
		var transactions = {$Transactions.Raw};
		var transactionsCancel = {$TransactionsCancel.Raw};
        var labelstransactions = {$Labels.raw}; 
		
		var myLineChart = new Chart(transactionsctx, {
			data: {
				datasets: [{
					type: 'line',
					label: 'Grafik Penjualan',
					data: transactions,
					fill: false,
					borderColor: 'rgb(75, 192, 192)',
					tension: 0.1
				}, {
					type: 'line',
					label: 'Pembatalan Pesanan',
					data: transactionsCancel,
					fill: false,
					borderColor: 'rgb(239, 83, 80)',
					tension: 0.1
				}],
				labels: labelstransactions,
			},
			options: {
				responsive: true,
				scales: {
					x: {
						display: true,
						title: {
							display: true,
							text: 'Date'
						}
					},
					y: {
						display: true,
						title: {
							display: true,
							text: 'Transaction'
						}
					}
				}
			}
		});
		var CategoryChart = new Chart(categoriesctx, {
			type: 'doughnut',
			data: {
				labels: [
					'Red',
					'Blue',
					'Yellow'
				],
				datasets: [{
					label: 'My First Dataset',
					data: [300, 50, 100],
					backgroundColor: [
					'rgb(255, 99, 132)',
					'rgb(54, 162, 235)',
					'rgb(255, 205, 86)'
					],
					hoverOffset: 4
				}]
			}
		});
	});
	</script>

	
	<script src="$ThemeDir/js/script.js" defer></script>
</body>

