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
	<% base_tag %>
	<title>MarketPlace</title>
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
	<link rel="shortcut icon" href="$resourceURL('themes/simple/images/favicon.ico')" />

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
</head>
<body class="$ClassName.ShortName<% if not $Menu(2) %> no-sidebar<% end_if %>" <% if $i18nScriptDirection %>dir="$i18nScriptDirection"<% end_if %>>
<% include Header %>
<div class="main" role="main">
	<div class="inner typography line">
		$Layout
	</div>
</div>
<% include Footer %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
<% require themedJavascript('jquery.ajaxchimp.min') %>
<% require themedJavascript('jquery.nice-select.min') %>
<% require themedJavascript('jquery.sticky') %>
<% require themedJavascript('nouislider.min') %>
<% require themedJavascript('countdown') %>
<% require themedJavascript('jquery.magnific-popup.min') %>
<% require themedJavascript('owl.carousel.min') %>
<% require themedJavascript('gmaps.min') %>
<% require themedJavascript('main') %>
<% require themedJavascript('bootstrap.min') %>
<% require themedJavascript('jquery-2.2.4.min') %>
<!--gmaps Js-->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCjCGmQ0Uq4exrzdcL6rvxywDDOvfAu6eE"></script>
</body>
</html>
