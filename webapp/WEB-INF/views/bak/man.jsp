<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="./resources/favicon.ico?v=2" type="image/x-icon">
<link rel="shortcut icon" href="./resources/favicon.ico?v=2" type="image/x-icon">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>pcos | Ranking / Shopping | Man</title>
<script type="text/javascript">
var page =window.location.href.split("?")[1];
if (page==null)page="";
if (page.indexOf('page') != -1) {
  //alert("Find!"+page.indexOf('page'));
  
}
else {
  
  location.href="/PCos/pages/man.html?page=1";
}
</script>
<script src="<c:url value='/js/jquery-1.12.4.js'/>"></script>
<script>
	$(function(){
		$("#skin").click(function(){
			self.location="/PCos/pages/man/skin?page=1";
		});
		$("#lotion").click(function(){
			self.location="/PCos/pages/man/lotion?page=1";
		});
		$("#essence").click(function(){
			self.location="/PCos/pages/man/essence?page=1";
		});
		$("#cream").click(function(){
			self.location="/PCos/pages/man/cream?page=1";
		});
		$("#oil").click(function(){
			self.location="/PCos/pages/man/oil?page=1";
		});
		$("#shaving").click(function(){
			self.location="/PCos/pages/man/oil?page=1";
		});
		$("#cleansing").click(function(){
			self.location="/PCos/pages/man/cleansing?page=1";
		});$("#mask").click(function(){
			self.location="/PCos/pages/man/mask?page=1";
		});
	});
	
	
</script>

<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="<c:url value='/layout/styles/layout.css'/>" rel="stylesheet" type="text/css" media="all">

<style type="text/css">
  /* DEMO ONLY */
  .container .demo{text-align:center;}
  .container .demo div{padding:8px 0;}
  .container .demo div:nth-child(odd){color:#FFFFFF; background:#CCCCCC;}
  .container .demo div:nth-child(even){color:#FFFFFF; background:#979797;}
  @media screen and (max-width:900px){.container .demo div{margin-bottom:0;}}
  /* DEMO ONLY */
</style>
</head>
<body id="top">
<!-- Top Background Image Wrapper -->
<div class="bgded overlay" style="background-image:url('<c:url value='/images/backgrounds/cosmetic12.jpg'/>');"> 
  <div class="wrapper row1">
    <header id="header" class="hoc clear">
      
        <div id="header1" >  
            <input type="text" value="" id="txtSearch" placeholder="검색어를 입력해주세요.">&nbsp;
            <a id="enter"><img src="<c:url value='/images/small_images/search.png'/>" class="smallIcon" id="searchIcon"/></a>&nbsp;&nbsp;
            <a href="/PCos/cart"><img src="<c:url value='/images/small_images/cart.png'/>" class="smallIcon" id="cartIcon"/></a>&nbsp;
            <a href="/PCos/mypage"><img src="<c:url value='/images/small_images/mypage.png'/>" class="smallIcon" id="mypageIcon"/></a>&nbsp;
        </div>

        <div id="logo" class="fl_left">
          <a href="/PCos"><img src="<c:url value='/images/small_images/cos.png'/>" class="title" id=""/></a>
        </div>

      <nav id="mainav" class="fl_right">
        <ul class="clear">
          <li class="active"><a href="/PCos">HOME</a></li>
          <li><a class="/PCos/drop" href="/PCos/category.html">랭킹/쇼핑</a>
            <ul>
              <li><a href="/PCos/category.html">카테고리별</a></li>
              <li><a href="/PCos/brand.html">브랜드별</a></li>
              <li><a href="/PCos/skintype.html">피부타입별</a></li>
              <li><a href="/PCos/man.html">남성</a></li>
            </ul>
          </li>
          <li><a class="drop" href="/PCos/board.html">코스 커뮤니티</a></li>
          <li><a class="drop" href="/PCos/faq.html">Q&A</a>
            <ul>
              <li><a href="/PCos/faq.html">FAQ</a></li>
              <li><a href="/PCos/qna">1:1 문의</a></li>
            </ul>
          </li>
        </ul>
      </nav>
    </header>
  </div>
  <div id="breadcrumb" class="hoc clear"> 
    <ul>
      <li><a href="/PCos">Home</a></li>
      <li><a href="">Shopping</a></li>
      <li><a href="">man</a></li>
    </ul>
  </div>
</div>
<!-- End Top Background Image Wrapper -->

<div class="wrapper row3">
  <main class="hoc container clear"> 
    <!-- main body -->
    <div class="content"> 
      <h2>MEN's Category</h2> 
      <div class="group btmspace-10 demo">
        <div class="one_quarter first " id="skin">스킨</div>
        <div class="one_quarter " id="lotion">로션</div>
        <div class="one_quarter " id="essence">에센스</div>
        <div class="one_quarter " id="cream">크림/젤</div>
      </div>
      <div class="group btmspace-50 demo">
        <div class="one_quarter first " id="oil">오일</div>
        <div class="one_quarter " id="shaving">쉐이빙</div>
        <div class="one_quarter " id="cleansing">클렌징</div>
        <div class="one_quarter " id="mask">마스크팩</div>
      </div>
    </div><hr>
    
    <div>
      <span id="spanright_none"><a href="#">Name</a>  |  
      <a href="#">LowPrice</a>  |  
      <a href="#">HighPrice</a>  |  
      <a href="#">Grade</a></span>
    </div><br>
    <div id="gallery">
        <figure>
          <header class="heading">Gallery Title Goes Here</header>
          <ul class="nospace clear">
          <c:forEach items="${ data}" varStatus="sta" var="p">
          	<c:choose>
	          	<c:when test="${sta.index %4 ==0 }">
	          		<li class="one_quarter first"><a href="/PCos/detail/${p.productCode }"><img src="${p.image }" alt="">
	          		<span>${p.productName}</span><br><span></span>${p.price }</span></a></li>
	          	</c:when>
          		<c:otherwise>
          			<li class="one_quarter "><a href="/PCos/detail/${p.productCode }"><img src="${p.image }" alt="">
	          		<span>${p.productName}</span><br><span></span>${p.price }</span></a></li>
          		</c:otherwise>
          	</c:choose>
          </c:forEach>
          
           
           </ul>
        </figure>
      </div>
      
     
    <%--  pagepre:${page.pre }<br>
     page:${page.page } --%>
      <nav class="pagination">
	      <ul>
	      	<c:if test="${page.prepre}">
	      		<li><a href='/PCos/pages/man.html?page=${page.pageStart-10}'>&laquo; 10Pages</a></li>
	      	</c:if>
	      	<c:if test="${page.pre }">
	      		<li><a href="/PCos/pages/man.html?page=${ page.page-1}">&laquo; Previous</a></li>
	      	</c:if>
	      	
	      <c:forEach begin="${page.pageStart }" end="${page.pageEnd }" varStatus="sta" >
	      	<li <c:out value="${sta.index==page.page ?'class=current':''}"/> ><a href='/PCos/pages/man.html?page=${sta.index }'>${sta.index }</a></li>
	      </c:forEach>
	      
	      	<c:if test="${page.next}">
	      		<li><a href='/PCos/pages/man.html?page=${page.page+1}'>Next &raquo;</a></li>
	      	</c:if>
	      	<c:if test="${page.nextnext }">
	      		<li><a href="/PCos/pages/man.html?page=${ page.pageStart+10}">10Pages &raquo;</a></li>
	      	</c:if>
	      
	      </ul>
      </nav>
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