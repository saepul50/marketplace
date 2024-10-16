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
        .table.table-borderless tr, 
        .table.table-borderless th,
         {
            border: none;
        }
	</style>
</head>
<body>
	<div class="cms-content fill-height flexbox-area-grow cms-tabset center BlogAdmin ModelAdmin LeftAndMain" data-layout-type="border" data-pjax-fragment="Content" id="ModelAdmin">
		<div class="cms-content-header north">
			<div class="cms-content-header-info vertical-align-items flexbox-area-grow">
				<div class="breadcrumbs-wrapper">
					<span class="cms-panel-link crumb last">
						Log View
					</span>
				</div>
			</div>
		</div>
        <div class="d-flex justify-content-around text-center mt-3">
            <h1 class="">Total Pengunjung</h1>
            <h1 class="">$LogView.Count</h1>
        </div>
        <div class="container-fluid">
            <table class="table table-borderless text-center ">
                <thead>
                  <tr class="">
                    <th scope="col">User</th> 
                    <th scope="col">Since</th>
                  </tr>
                </thead>
                <tbody>
                    <% loop $LogView %>
                        <% if $MemberID != -1 %> 
                            <tr>
                                <td>$Member.Title</td> 
                                <td data-date="$Created" class="since"></td>
                            </tr>
                        <% else %> 
                            <tr>
                                <td>Anon</td> 
                                <td data-date="$Created" class="since"></td>
                            </tr>
                        <% end_if %>
                    <% end_loop %>
                    
                </tbody>
            </table>
        </div>
    </div>
    <% with  $LogView %>
        <nav class="blog-pagination justify-content-center d-flex " style="left: 50%;padding: 0 !important;">
            <% if $MoreThanOnePage %>
                <div class="pagination">
                <% if $NotFirstPage %>
                    <a href="$PrevLink" class="prev-arrow"><i class="fa fa-long-arrow-left" aria-hidden="true"></i></a>
                <% end_if %>
                <% loop $PaginationSummary(10) %>
                    <% if $Link %>
                        <a href="$Link" class="page-link">$PageNum</a>
                    <% else %>
                    <span class="bg-secondary ">...</span>
                <% end_if %>
                <% end_loop %>
                <% if $NotLastPage %>
                    <a href="$NextLink" class="next-arrow"><i class="fa fa-long-arrow-right" aria-hidden="true"></i></a>
                <% end_if %>
            </div>
            <% end_if %>
        </nav>
    <% end_with %>
	<%-- <script src="$ThemeDir/js/script.js" defer></script> --%>
</body>
<script>
    document.addEventListener("DOMContentLoaded", function() {
    function timeSince(date) {
        const now = new Date();
        const seconds = Math.floor((now - date) / 1000);
        const intervals = {
            tahun: 31536000,
            bulan: 2592000,
            hari: 86400,
            jam: 3600,
            menit: 60,
        };

        for (const [unit, value] of Object.entries(intervals)) {
            const timePassed = Math.floor(seconds / value);
            if (timePassed >= 1) {
                return `${timePassed} ${unit} lalu`;
            }
        }
        return "Just Now";
    }

    function updateTimeSince() {
        const elements = document.querySelectorAll('.since');
        elements.forEach((element) => {
            const dateString = element.dataset.date;
            const inputDate = new Date(dateString);
            if (isNaN(inputDate.getTime())) {
                element.textContent = "Invalid date";
                return;
            }
            const timePassed = timeSince(inputDate);
            element.textContent = timePassed;
        });
    }
    updateTimeSince();
    function handlePaginationLinks() {
        document.querySelectorAll('.blog-pagination a.page-link, .blog-pagination .prev-arrow, .blog-pagination .next-arrow').forEach(el => {
            el.addEventListener('click', function(event) {
                event.preventDefault(); 

                const link = this.getAttribute('href');
                fetch(link)
                    .then(response => {
                        if (!response.ok) {
                            throw new Error('Network response was not ok');
                        }
                        return response.text();
                    })
                    .then(html => {
                        const parser = new DOMParser();
                        const doc = parser.parseFromString(html, 'text/html');
                        const newContent = doc.querySelector('.cms-content'); 

                        if (newContent) {
                            const contentElement = document.querySelector('.cms-content');
                            contentElement.innerHTML = newContent.innerHTML; 
                            updateTimeSince(); 
                            handlePaginationLinks(); 
                        } else {
                            console.error("New content not found in response");
                        }
                    })
                    .catch(error => console.error('Error fetching new content:', error));
            });
        });
    }
    handlePaginationLinks();
});

</script>


