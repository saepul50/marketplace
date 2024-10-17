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
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
	<% base_tag %>
	<title>$SiteConfig.Title</title>
	<!-- Favicon-->
	<link rel="shortcut icon" href="$SiteConfig.Favicon.getURL()">
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	$MetaTags(false)

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
				<a href="/marketplace/venn/$Vendor.Pathname" class="text-muted">Riwayat Penjualan ></a>
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
				<div class="col-5 px-1">
					<h4 class="fw-bold">Pengunjung</h4>
					<div id="reportrange1" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 100%">
						<i class="fa fa-calendar"></i>&nbsp;
						<span id="daterange1"></span> <i class="fa fa-caret-down"></i>
						<input type="hidden" onchange="myFunction()" id="see">
					</div>
					<canvas id="myChart1"></canvas>
				</div>
				<div class="col-5 px-1">
					<h4 class="fw-bold">Penjualan</h4>
					<div id="reportrange" style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc; width: 100%">
						<i class="fa fa-calendar"></i>&nbsp;
						<span id="daterange"></span> <i class="fa fa-caret-down"></i>
						<input type="hidden" onchange="myFunction()" id="see">
					</div>
					<canvas id="myChart"></canvas>
				</div>
				<div class="col-2 px-1">
					<h4 class="fw-bold">Produk Kategori</h4>
					<canvas id="CategoryChart"></canvas>
				</div>
				
			</div>
		</div>

	</div>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			
			var transactionsctx = document.getElementById('myChart').getContext('2d');
			var categoriesctx = document.getElementById('CategoryChart').getContext('2d');
			var transactions = {$Transactions.Raw}; // Transactions from backend
			var transactionsCancel = {$TransactionsCancel.Raw}; // Cancellations from backend
			var labelstransactions = {$Labels.raw}; // Labels from backend
			var labelcategories = {$LabelsCategory.raw}; // Categories from backend
			
			var myLineChart = new Chart(transactionsctx, {
				data: {
					datasets: [{
						type: 'line',
						label: 'Grafik Pemesanan',
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
								text: 'Tanggal'
							}
						},
						y: {
							display: true,
							title: {
								display: true,
								text: 'Transaksi'
							}
						}
					}
				}
			});
		
			// Code for category chart
			var CategoryChart = new Chart(categoriesctx, {
				type: 'doughnut',
				data: {
					labels: Object.keys(labelcategories),
					datasets: [{
						data: Object.values(labelcategories),
						backgroundColor: ['rgb(54, 162, 235)', 'rgba(153, 102, 255)', 'rgba(255, 159, 64)'],
						hoverOffset: 4
					}]
				}
			});
		
				
				$(function() {
					let storedRange = localStorage.getItem('selectedRange');
					let start = moment().subtract(29, 'days'); 
					let end = moment(); 
				
					if(storedRange) {
						let dates = storedRange.split(' - ');
						start = moment(dates[0]);
						end = moment(dates[1]);
					}
					function cb(start, end) {
						$('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
						$('#see').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
						var datelabels = [];
						var currentdate = start.clone();
						
						while (currentdate.isSameOrBefore(end)) {
							datelabels.push(currentdate.format('DD/MM/YYYY'));
							currentdate.add(1, 'days');
						}
			
						var length = datelabels.length;
						

						$.post("/marketplace/admin/status/dashboard", { length: length }, function(data, status) {
							console.log("Length posted: " + length);
							
						});
					}
			
					$('#reportrange').daterangepicker({
						startDate: start,
						endDate: end,
						showCustomRangeLabel : false,
						ranges: {
							'Today': [moment(), moment()],
							'Last 7 Days': [moment().subtract(6, 'days'), moment()],
							'Last 30 Days': [moment().subtract(29, 'days'), moment()],
						}
					}, cb);
					$('#reportrange').on('apply.daterangepicker', function(ev, picker) {
						let selectedRange = picker.startDate.format('YYYY-MM-DD') + ' - ' + picker.endDate.format('YYYY-MM-DD');
						localStorage.setItem('selectedRange', selectedRange);
				
						$('#see').val(selectedRange);
						setTimeout(function() {
							location.reload();
						}, 500);
					});
					cb(start, end);
					
					
				});


				//pengunjung
				var transactionsctx = document.getElementById('myChart1').getContext('2d');
				var dataview = {$DataView.Raw}; // View from backend
				var labelview = {$LabelView.raw}; // Labels from backend
				
				var myLineChart = new Chart(transactionsctx, {
					data: {
						datasets: [{
							type: 'line',
							label: 'Grafik Pengunjung',
							data: dataview,
							fill: false,
							borderColor: 'rgb(75, 192, 192)',
							tension: 0.1
						}],
						labels: labelview,
					},
					options: {
						responsive: true,
						scales: {
							x: {
								display: true,
								title: {
									display: true,
									text: 'Tanggal'
								}
							},
							y: {
								display: true,
								title: {
									display: true,
									text: 'Pengunjung'
								}
							}
						}
					}
				});

				let storedRange = localStorage.getItem('selectedRange1');
				let start = moment().subtract(29, 'days'); 
				let end = moment(); 
			
				if(storedRange) {
					let dates = storedRange.split(' - ');
					start = moment(dates[0]);
					end = moment(dates[1]);
				}
				$(function() {

					function cb(start, end) {
						$('#reportrange1 span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
						$('#see').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
						var datelabels = [];
						var currentdate = start.clone();
						
						while (currentdate.isSameOrBefore(end)) {
							datelabels.push(currentdate.format('DD/MM/YYYY'));
							currentdate.add(1, 'days');
						}
			
						var length = datelabels.length;
						

						$.post("/marketplace/admin/status/dashboard", { lengthview: length }, function(data, status) {
							console.log("Length posted: " + length);
							
						});
					}
			
					$('#reportrange1').daterangepicker({
						startDate: start,
						endDate: end,
						showCustomRangeLabel : false,
						ranges: {
							'Today': [moment(), moment()],
							'Last 7 Days': [moment().subtract(6, 'days'), moment()],
							'Last 30 Days': [moment().subtract(29, 'days'), moment()],
						}
					}, cb);
					$('#reportrange1').on('apply.daterangepicker', function(ev, picker) {
						   let selectedRange = picker.startDate.format('YYYY-MM-DD') + ' - ' + picker.endDate.format('YYYY-MM-DD');
						   localStorage.setItem('selectedRange1', selectedRange);
				   
						   $('#see').val(selectedRange);
						   setTimeout(function() {
							   location.reload();
						   }, 500); 
					});
					cb(start, end);
				});
			});
			
			
			
			
			function myFunction() {
				console.log("Date range changed!");
				setTimeout(function() {
					location.reload();
				}, 1500);  
			}

	</script>

	
	<%-- <script src="$ThemeDir/js/script.js" defer></script> --%>
</body>

