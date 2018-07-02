<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="boardno" value="${board.boardNo}"/>
<c:set var="readCount" value="${board.readCount}"/>
<%
	String email = (String) session.getAttribute("email");
	String boardno = (String) pageContext.getAttribute("boardno");
	String bo = (String) session.getAttribute(boardno);
	
	int r = (Integer) pageContext.getAttribute("readCount");
	
	if (bo != null) {
		r = r + 1;
	} else {
		session.setAttribute(boardno, boardno);
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>pcos | Cos Community | Read</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="../layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<link rel="icon" href="/PCos/resources/favicon.ico?v=2" type="image/x-icon">
<link rel="shortcut icon" href="/PCos/resources/favicon.ico?v=2" type="image/x-icon">
<style type="text/css">
.container .demo { text-align: center; }
.container .demo div { padding: 8px 0; }
.container .demo div:nth-child(odd) { color: #FFFFFF; background: #CCCCCC; }
.container .demo div:nth-child(even) { color: #FFFFFF; background: #979797; }
@media screen and (max-width:900px) { .container .demo div { margin-bottom: 0; } }
</style>
<script src="//cdnjs.cloudflare.com/ajax/libs/numeral.js/2.0.6/numeral.min.js"></script>
<script src="<c:url value='/js/jquery-1.12.4.js'/>"></script>
<script>
	function Enter_Check() {
		if(event.keyCode == 13) {
		   if($('#txtSearch').val()!="") {
			   location.href="/PCos/search/"+$('#txtSearch').val();
		   } else {
			   alert("검색어를 입력해주세요");
		   }
		}
	}

  	var flag = 0;
	var boardno = "${board.boardNo}";
	var email = "<%= email %>";
	var r = "<%= r %>";
	
	function Enter_Check() {
		if(event.keyCode == 13) {
	       location.href="/PCos/search/"+$('#txtSearch').val();
	  	}
	}
  
  	function update(idx) {
		if(idx != 0) {
			if(email == "null") {
				alert("로그인이 필요한 기능입니다");   
		  		location.href =  "/PCos/login";
		        <%
		        	session.setAttribute("path", "board/" + boardno);
	         	%>
			} else {

	          	$.ajax({
	          		url			: "/PCos/memberRegStat/" + email + ".",
	          		dataType 	: "json",
	          		method		: "POST",
	      			contentType	: "application/json; charset=utf-8",
	          		success		: function(data) {
	          			if(data.code) {
	        				updateajax(idx);
	          			} else {
	        				alert('회원 필수 정보를 입력해 주세요');
	        				location.href = "/PCos/myInfo";
	       		            <%
	       		            	session.setAttribute("path", "mypage");
	       		            %>
	        			}
	          		}
	          	});
				
			}
		}
  	}
  
   	function updateajax(idx) {
		$.ajax({
			url : "/PCos/updateBoard/" + boardno + "/" + idx,
			method : "PUT",
			dataType : "json",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify({
				"title" : $("#title").val(),
				"contents" : $("#contents").val() ,
				"email" : email
			}),
			success : function(data){
				if(data.code){
					ajax();
				}
			}
		});
  	} 
  
 	function ajax() {
		$.ajax({
   			url : "/PCos/oneBoard/"+boardno,
   			dataType : "json",
			method : "GET",
			success : function(data) {
				if(data.code) {
					var data=data.data;
					$("#title").val(data.title);
					$("#date").val("${board.regDate}".substring(0,16));
					$("#count").text(data.readCount+"  |  " + data.likeCount+"  |  " + data.dislikeCount);
					data.contents = data.contents.replace(/<br\/>/g,"\n");
					$("#contents").text(data.contents);
					if(data.email == email) {
						$("#update").attr("style", "");
					}
				}
			}
		});
	} 

 	$(document).ready(function() {
		if (r == "${board.readCount}") {
			updateajax(0);
		} else {
			ajax();
		}
		
		$("#enter").click(function() {
			if ($('#txtSearch').val() != "") {
				location.href = "/PCos/search/" + $('#txtSearch').val();
			} else {
				alert("검색어를 입력해주세요");
			}
		});

		$("#confirm").click(function() {
			if (flag == 1) {
				update(3);
			}
			location.href = "/PCos/pages/board.html";
		});

		$("#update").click(function() {
			if (flag == 0) {
				$("#title").removeAttr("readonly");
				$("#contents").removeAttr("readonly");
				flag = 1;
				$("#contents").focus();
				$("#update").text("삭제하기");
				$("#update").attr("title", "삭제를 원하시면 재클릭해주세요");
			} else {
				if (confirm("정말 삭제하시겠습니까?")) {
					$.ajax({
						url : "/PCos/deleteBoard/" + boardno,
						method : "DELETE",
						dataType : "json",
						success : function(data) {
							alert("삭제완료되었습니다");
							location.href = "/PCos/pages/board.html";
						}
					});
				}
			}
		});
	});
</script>
</head>
<body id="top">
	<!-- Top Background Image Wrapper -->
	<div class="bgded overlay"
		style="background-image: url('/PCos/images/backgrounds/cosmetic1.jpg');">
		<div class="wrapper row1">
			<header id="header" class="hoc clear">
				<div id="header1">
					<input type="text" value="" id="txtSearch" placeholder="검색어를 입력해주세요." onkeypress="if(event.keyCode==13) {Enter_Check(); return false;}"/>&nbsp;
					<a href="" id="enter"><img src="/PCos/images/small_images/search.png" class="smallIcon" id="searchIcon" title="검색" /></a>&nbsp;&nbsp;
					<a href="/PCos/cart"><img src="/PCos/images/small_images/cart.png" class="smallIcon" id="cartIcon" title="내 장바구니" /></a>&nbsp;
					<a href="/PCos/mypage"><img src="/PCos/images/small_images/mypage.png" class="smallIcon" id="mypageIcon" title="마이 페이지" /></a>&nbsp;
				</div>

				<div id="logo" class="fl_left">
					<a href="/PCos"><img src="/PCos/images/small_images/cos.png" class="title" id="" /></a>
				</div>

				<nav id="mainav" class="fl_right">
					<ul class="clear">
						<li class="active"><a href="/PCos">HOME</a></li>
						<li><a class="drop" href="./pages/category.html">랭킹/쇼핑</a>
							<ul>
								<li><a href="/PCos/pages/category.html">카테고리별</a></li>
								<li><a href="/PCos/pages/brand.html">브랜드별</a></li>
								<li><a href="/PCos/pages/skintype.html">피부타입별</a></li>
								<li><a href="/PCos/pages/man.html">남성</a></li>
							</ul></li>
						<li><a class="drop" href="/PCos/pages/board.html">코스 커뮤니티</a></li>
						<li><a class="drop" href="/PCos/pages/faq.html">Q&A</a>
						<ul>
							<li><a href="/PCos/pages/faq.html">FAQ</a></li>
							<li><a href="/PCos/qna">1:1 문의</a></li>
						</ul></li>
					</ul>
				</nav>
			</header>
		</div>
		<div id="breadcrumb" class="hoc clear">
			<ul>
				<li><a href="/PCos">Home</a></li>
				<li><a href="/Pages/pages/board.html">Cos Community</a></li>
				<li><a href="">board</a></li>
			</ul>
		</div>
	</div>
	<!-- End Top Background Image Wrapper -->
	<div class="wrapper row3">
		<main class="hoc container clear"> <!-- main body -->
		<h1 style="text-align: center">Cos Community</h1>
		<form action="#" method="post">
			<div class="one_third first">
				<label for="title">Title</label> <input type="text" name="title" id="title" value="" readonly="readonly">
			</div>
			<div class="one_third">
				<label for="date">Date</label> <input type="text" name="date" id="date" value="" readonly="readonly">
			</div>
			<div class="one_third" style="text-align: right">
				<label for="count">Count(read | <a href="javascript:update(1);">
				<img src="../images/small_images/like.png"></a> | <a href="javascript:update(2);">
				<img src="../images/small_images/dislike.png"></a>)
				</label><span id="count"></span>
			</div>
			<br> <br> <br>
			<hr>

			<div class="block clear">
				<label for="contents">Your Writing</label>
				<textarea name="contents" id="contents" cols="120" rows="15"
					readonly="readonly"></textarea>
				<br>
			</div>
			<div class="group btmspace-10 demo">
				<div class="one_half first" id="update" style="visibility: hidden"
					title="제목과 본문을 수정할 수 있습니다">수정하기(삭제를 원하시면 두 번 클릭해주세요)</div>
				<div class="one_half" id="confirm">확인</div>
			</div>
		</form>
		<!-- / main body -->
		<div class="clear"></div>
		</main>
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