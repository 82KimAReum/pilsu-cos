<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import="java.net.URLEncoder" %>

<!DOCTYPE html>
<html>
<head>
<title>pcos | Login</title>
<meta charset="utf-8">
<link href="./layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<link rel="icon" href="./resources/favicon.ico?v=2" type="image/x-icon">
<link rel="shortcut icon" href="./resources/favicon.ico?v=2" type="image/x-icon">
<link href="./layout/styles/bootstrap-social.css" rel="stylesheet">
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>
<script src="<c:url value='/js/jquery-1.12.4.js'/>"></script>
<script type="text/javascript">
	var _gaq = _gaq || [];
	_gaq.push([ '_setAccount', 'UA-42119746-1' ]);
	_gaq.push([ '_trackPageview' ]);

	(function() {
		var ga = document.createElement('script');
		ga.type = 'text/javascript';
		ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl': 'http://www') + '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0];
		s.parentNode.insertBefore(ga, s);
	})();
</script>

<script>
	function Enter_Check() {
	  	if(event.keyCode == 13) {
	    	if($('#txtSearch').val() != "") {
	    		location.href = "/PCos/search/" + $('#txtSearch').val();
	    	} else {
	    		alert("검색어를 입력해주세요");
	    	}
	  	}
	}
	
	$(function() {
		$("#enter").click(function() {
			if ($('#txtSearch').val() != "") {
				location.href = "/PCos/search/" + $('#txtSearch').val();
			} else {
				alert("검색어를 입력해주세요");
			}
		});
	});
</script>
<script>
	var email = '';
	var name = '';

	$(function() {
		googleLogin();
		naverLogin();
	});

	// Called when Google Javascript API Javascript is loaded
	function HandleGoogleApiLibrary() {
		// Load "client" & "auth2" libraries
		gapi.load('client:auth2', { callback : function() {
				// Initialize client & auth libraries
			gapi.client.init({
					apiKey : 'AIzaSyDx9QHjUr9Cy2S1D9YTZvndrkfWNXV_Lz0',
					clientId : '510826025827-lt845o2ft5b7klr4s2ehb0911scjfhog.apps.googleusercontent.com',
					scope : 'https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/plus.me'
				}).then(function(success) {
					// Libraries are initialized successfully
					// You can now make API calls
				}, function(error) {
					console.log(error);
				});
			},
			onerror : function() {
				// Failed to load libraries
			}
		});
	}

	//구글 로그인 연동
	function googleLogin() {
		$("#google-login-button").on('click', function() {
			gapi.auth2.getAuthInstance().signIn().then(function(data) {
				var profile = data.getBasicProfile();

				email = profile.getEmail();
				name = profile.getName();

				$('#email').val(email);
				$('#name').val(name);

				goToLogin();
				
			}, function(error) {
				console.log(error);
			});
		});
	}

<%!
	private String getState() {
		SecureRandom sr = new SecureRandom();
		BigInteger bi = new BigInteger(128, sr);
		return bi.toString();
	}
%>
	//네이버 로그인 연동
	function naverLogin() {
		$("#naver-login-button").on('click', function() {
			<%
				String clientId = "lIeESu0jf8vwL6PkjnoI";
		    	String redirectURI = URLEncoder.encode("http://www.pcos.com/PCos/naverLogin", "UTF-8");
				String state = getState();
			    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
			    apiURL += "&client_id=" + clientId;
			    apiURL += "&redirect_uri=" + redirectURI;
			    apiURL += "&state=" + state;
			    session.setAttribute("state", state);
			%>
			
			location.href = "<%= apiURL %>";
		});
	}

	function goToLogin() {
		var form = document.getElementById('goToLogin');

		form.method = "POST";
		form.action = "/PCos/loginComplete";
		form.submit();
	}
</script>

</head>

<body id="top">
	<!-- Top Background Image Wrapper -->
	<div class="bgded overlay"
		style="background-image: url('./images/backgrounds/cosmetic01.jpg');">
		<div class="wrapper row1">
			<header id="header" class="hoc clear">
				<div id="header1">
					<input type="text" value="" id="txtSearch" placeholder="검색어를 입력해주세요." onkeypress="if(event.keyCode==13) {Enter_Check(); return false;}"/>&nbsp;
					<a href="" id="enter"><img src="./images/small_images/search.png" class="smallIcon" id="searchIcon" title="검색" /></a>&nbsp;&nbsp;
					<a href="/PCos/cart"><img src="./images/small_images/cart.png" class="smallIcon" id="cartIcon" title="내 장바구니" /></a>&nbsp;
					<a href="/PCos/mypage"><img src="./images/small_images/mypage.png" class="smallIcon" id="mypageIcon" title="마이 페이지" /></a>&nbsp;
				</div>

				<div id="logo" class="fl_left">
					<a href="/PCos"><img src="./images/small_images/cos.png" class="title" id="" /></a>
				</div>

				<nav id="mainav" class="fl_right">
					<ul class="clear">
						<li class="active"><a href="/PCos">HOME</a></li>
						<li><a class="drop" href="./pages/category.html">랭킹/쇼핑</a>
							<ul>
								<li><a href="./pages/category.html">카테고리별</a></li>
								<li><a href="./pages/brand.html">브랜드별</a></li>
								<li><a href="./pages/skintype.html">피부타입별</a></li>
								<li><a href="./pages/man.html">남성</a></li>
							</ul></li>
						<li><a class="drop" href="./pages/board.html">코스 커뮤니티</a></li>
						<li><a class="drop" href="./pages/faq.html">Q&A</a>
						<ul>
							<li><a href="./pages/faq.html">FAQ</a></li>
							<li><a href="/PCos/qna">1:1 문의</a></li>
						</ul></li>
					</ul>
				</nav>
			</header>
		</div>
		<div id="breadcrumb" class="hoc clear">
			<ul>
				<li><a href="/PCos">Home</a></li>
				<li><a href="/PCos/login">Login</a></li>
			</ul>
		</div>
	</div>
	<!-- End Top Background Image Wrapper -->

	<div class="wrapper row3">
		<main class="hoc container clear"> <!-- main body -->
		<div class="content" style="text-align: center">

			<form id='goToLogin' onsubmit="goToLogin()">

				<input type='hidden' id='email' name='email' />
				<input type='hidden' id='name' name='name' />

				<div class="col-sm-4">
					<!-- <div class="social-sizes" id="google-login-button">
						<a class="btn btn-block btn-social btn-lg btn-google" style="width: 260px;">
						<span class="fa fa-google"></span>
							Sign in with Google </a>
					</div> -->
					
					<img src="./images/gallery/google_login.png"
						style="height: 68px; width: 290px; cursor: pointer;"
						id="google-login-button"/>
						
					<br />
					<br />
					<div id="naverIdLogin">
						<a id="naverIdLogin_loginButton" href="#" role="button">
						<img src="./images/gallery/naver_login.PNG"
							id="naver-login-button" style="height: 60px; width: 280px;"/></a>
					</div>

				</div>

				<script async defer src="https://apis.google.com/js/api.js"
					onload="this.onload=function(){};HandleGoogleApiLibrary()"
					onreadystatechange="if (this.readyState === 'complete') this.onload()">
				</script>
			</form>
		</div>

		<!-- / main body --> </main>
	</div>

	<div class="wrapper row4">
		<footer id="footer" class="hoc clear">
			<div class="one_third first">
				<h6 class="heading">GET IN TOUCH</h6>
				<ul class="nospace btmspace-30 linklist contact">
					<li><i class="fa fa-map-marker"></i>
						<address>종로 서울YMCA빌딩 &amp; 69, 종로구, 03164</address></li>
					<li><i class="fa fa-phone"></i> +82 (02) 123 4567</li>
					<li><i class="fa fa-envelope-o"></i> info@domain.com</li>
				</ul>
				<ul class="faico clear">
					<li><a class="faicon-facebook" href="#"><i class="fa fa-facebook"></i></a></li>
					<li><a class="faicon-twitter" href="#"><i class="fa fa-twitter"></i></a></li>
					<li><a class="faicon-dribble" href="#"><i class="fa fa-dribbble"></i></a></li>
					<li><a class="faicon-linkedin" href="#"><i class="fa fa-linkedin"></i></a></li>
					<li><a class="faicon-google-plus" href="#"><i class="fa fa-google-plus"></i></a></li>
					<li><a class="faicon-vk" href="#"><i class="fa fa-vk"></i></a></li>
				</ul>
			</div>
			<div class="one_third">
				<h6 class="heading">Awarded by</h6>
				<ul class="nospace linklist">
					<li>
						<article>
							<h2 class="nospace font-x1">
								<a>Beauty Industry Awards 2018</a>
							</h2>
							<time class="font-xs block btmspace-10" datetime="2045-04-06">
								Friday, 6<sup>th</sup> April 2018
							</time>
							<p class="nospace">2018 신흥 밴처기업 부문에서 입상, 첨단의 신기술과 아이디어를 개발하여
								사업에 도전하는 창조적인 중소기업으로 선발</p>
						</article>
					</li>
					<li>
						<article>
							<h2 class="nospace font-x1">
								<a>The COSMETICS Awards</a>
							</h2>
							<time class="font-xs block btmspace-10" datetime="2045-04-05">
								Thursday, 5<sup>th</sup> April 2016
							</time>
							<p class="nospace">소비자 컨펌을 기반으로한 운영 방식에서 전세대 광고 형식을 탈피, 업계 선의
								경쟁을 주도하는 기업으로 선정</p>
						</article>
					</li>
				</ul>
			</div>
			<div class="one_third">
				<h6 class="heading">SIGN UP FOR PROMOTIONS</h6>
				<p class="nospace btmspace-30">필수코스의 쿠폰 및 향후 제품, 이벤트에 대한 소식을
					받아보세요.</p>
				<form method="post" action="#">
					<fieldset>
						<legend>Newsletter:</legend>
						<input class="btmspace-15" type="text" value="" placeholder="Name">
						<input class="btmspace-15" type="text" value="" placeholder="Email">
						<button type="button" value="submit">Submit</button>
					</fieldset>
				</form>
			</div>
		</footer>
	</div>
	<div class="wrapper row5">
		<div id="copyright" class="hoc clear">
			<p class="fl_left">
				Copyright &copy; 2018 <a href="#"> Pilsu Cosmetics .Inc </a>
			</p>
		</div>
	</div>
	<a id="backtotop" href="#top"><i class="fa fa-chevron-up"></i></a>
</body>
</html>