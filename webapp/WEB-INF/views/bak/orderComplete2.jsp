<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>pcos | Ranking / Shopping | Product Payment</title>
<meta charset="utf-8">
<link href="/layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<style type="text/css">
  .container .demo{text-align:center;}
  .container .demo div{padding:8px 0;}
  .container .demo div:nth-child(odd){color:#FFFFFF; background:#CCCCCC;}
  .container .demo div:nth-child(even){color:#FFFFFF; background:#979797;}
  @media screen and (max-width:900px){.container .demo div{margin-bottom:0;}}
</style>
</head>
<script src="<c:url value='/js/jquery-1.12.4.js'/>"></script>
<script>
	$(function() {
		$('input#btnCancel').on('click', function() {
			//주문내역 마이페이지로 이동
		});
		
		$('input#btnOrder').on('click', function() {
			location.href = "../static/index.html";
		});
	})
</script>

<body id="top">
<!-- Top Background Image Wrapper -->
<div class="bgded overlay" style="background-image:url('../images/backgrounds/cosmetic01.jpg');"> 
  <div class="wrapper row1">
    <header id="header" class="hoc clear">
        <div id="header1" >  
            <h7><input type="text" value="" id="txtSearch" placeholder="검색어를 입력해주세요.">&nbsp;
            <a href="#"><img src="/images/small_images/search.png" class="smallIcon" id="searchIcon"/></a>&nbsp;&nbsp;
            <a href="#"><img src="/images/small_images/cart.png" class="smallIcon" id="cartIcon"/></a>&nbsp;
            <a href="/pages/personalInfo.html"><img src="/images/small_images/mypage.png" class="smallIcon" id="mypageIcon"/></a>&nbsp;</h7>
        </div>
        <div id="logo" class="fl_left">
          <a href="/PCos"><img src="../images/small_images/cos.png" class="title" id=""/></a>
        </div>

      <nav id="mainav" class="fl_right">
        <ul class="clear">
          <li class="active"><a href="/PCos">HOME</a></li>
          <li><a class="drop" href="">랭킹/쇼핑</a>
            <ul>
              <li><a href="../pages/category.html">카테고리별</a></li>
              <li><a href="../pages/brand.html">브랜드별</a></li>
              <li><a href="../pages/skintype.html">피부타입별</a></li>
              <li><a href="../pages/age.html">연령대별</a></li>
              <li><a href="../pages/man.html">남성</a></li>
            </ul>
          </li>
          <li><a class="drop" href="#">코스 커뮤니티</a></li>
          <li><a class="drop" href="#">Q&A</a>
            <ul>
              <li><a href="#">FAQ</a></li>
              <li><a href="#">1:1 문의</a></li>
            </ul>
          </li>
        </ul>
      </nav>
    </header>
  </div>
  <div id="breadcrumb" class="hoc clear"> 
    <ul>
      <li><a href="/PCos">Home</a></li>
      <li><a href="#">Cart</a></li>
      <li><a href="#">Order</a></li>
      <li><a href="#">OrderComplete</a></li>
    </ul>
  </div>
</div>
<!-- End Top Background Image Wrapper -->

<div class="wrapper row3">
  <main class="hoc container clear"> 
    <!-- main body -->
    <div class="content"> 
      <h1>상품 주문이 완료되었습니다.</h1>

      <br />
      <br />
	  <div id='btn'>
	       <input type='button' id='btnCancel' value="주문내역 확인하기"/>
	       <input type='button' id='btnOrder' value="메인 페이지로"/>
	  </div>
    </div>

    <!-- / main body -->
  </main>
</div>

<div class="wrapper row4">
  <footer id="footer" class="hoc clear"> 
    <div class="one_third first">
      <h6 class="heading">GET IN TOUCH</h6>
      <ul class="nospace btmspace-30 linklist contact">
        <li><i class="fa fa-map-marker"></i>
          <address>
          종로 서울YMCA빌딩 &amp; 69, 종로구, 03164
          </address>
        </li>
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
            <h2 class="nospace font-x1"><a>Beauty Industry Awards 2018</a></h2>
            <time class="font-xs block btmspace-10" datetime="2045-04-06">Friday, 6<sup>th</sup> April 2018</time>
            <p class="nospace">2018 신흥 밴처기업 부문에서 입상, 첨단의 신기술과 아이디어를 개발하여 사업에 도전하는 창조적인 중소기업으로 선발</p>
          </article>
        </li>
        <li>
          <article>
            <h2 class="nospace font-x1"><a >The COSMETICS Awards</a></h2>
            <time class="font-xs block btmspace-10" datetime="2045-04-05">Thursday, 5<sup>th</sup> April 2016</time>
            <p class="nospace">소비자 컨펌을 기반으로한 운영 방식에서 전세대 광고 형식을 탈피, 업계 선의 경쟁을 주도하는 기업으로 선정</p>
          </article>
        </li>
      </ul>
    </div>
    <div class="one_third">
      <h6 class="heading">SIGN UP FOR PROMOTIONS</h6>
      <p class="nospace btmspace-30">필수코스의 쿠폰 및 향후 제품, 이벤트에 대한 소식을 받아보세요.</p>
      <form method="post" action="#">
        <fieldset>
          <legend>Newsletter:</legend>
          <input class="btmspace-15" type="text" value="" placeholder="Name">
          <input class="btmspace-15" type="text" value="" placeholder="Email">
          <button type="submit" value="submit">Submit</button>
        </fieldset>
      </form>
    </div>
  </footer>
</div>
<div class="wrapper row5">
  <div id="copyright" class="hoc clear"> 
    <p class="fl_left">Copyright &copy; 2018 <a href="#"> Pilsu Cosmetics .Inc </a></p>
  </div>
</div>
<a id="backtotop" href="#top"><i class="fa fa-chevron-up"></i></a>
</body>
</html>