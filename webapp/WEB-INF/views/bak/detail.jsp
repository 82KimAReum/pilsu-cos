<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="prod" value="${data}" />

<!DOCTYPE html>
<html>
<head>
<title>pcos | Pages | Gallery</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="../layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<style type="text/css">
  /* DEMO ONLY */
  .container .demo{text-align:center;}
  .container .demo div{padding:8px 0;}
  .container .demo div:nth-child(odd){color:#FFFFFF; background:#CCCCCC;}
  .container .demo div:nth-child(even){color:#FFFFFF; background:#979797;}
  @media screen and (max-width:900px){.container .demo div{margin-bottom:0;}}
  /* DEMO ONLY */
  </style>
  <script src="//cdnjs.cloudflare.com/ajax/libs/numeral.js/2.0.6/numeral.min.js"></script>
  <script src="<c:url value='/js/jquery-1.12.4.js'/>"></script>
  <script>
    $(function(){
    	$("#image").attr("src","${prod.image}");
    	$("#brandName").text("${prod.brandName}");
    	$("#avgGrade").text("${prod.avgGrade}");
    	$("#productName").text("${prod.productName}");
    	$("#capacity").text("${prod.capacity}");
    	$("#price").text(numeral( "${prod.price}" ).format( '0,0' ));
       
      $("#writecomment").click(function(){
        var str="<div id='comments'>"+
          "<div class='one_quarter first' style='visibility: hidden;'></div>"+
          "<div class='one_quarter style='visibility: hidden;'></div>"+
          "<div class='one_quarter style='visibility: hidden;'></div>"+
          "<div class='one_quarter'><a href='detail.html'><< 후기 다시보기</a></div>"+
          "<h2>Write A Comment</h2>"+
        "<form action='#' method='post'>"+
          "<div class='one_third first'>"+
            "<label for='name'>Name <span>*</span></label>"+
            "<input type='text' name='name' id='name' value='' size='22' required>"+
          "</div>"+
          "<div class='one_third'>"+
          "</div>"+
          "<div class='one_third'>"+
            "<label for='url'>평점 <span id='grade'></span>점 <span>*</span></label>"+
            "<input type='range' list='tickmarks' step='10'>"+
        "<datalist id='tickmarks'>"+
          "<option value='10'>"+
          "<option value='20'>"+
          "<option value='30'>"+
          "<option value='40'>"+
          "<option value='50'>"+
          "<option value='60'>"+
          "<option value='70'>"+
          "<option value='80'>"+
          "<option value='90'>"+
          "<option value='100'>"+
        "</datalist>"+
          "</div>"+
          "<div class='block clear'>"+
            "<label for='comment'>Your Comment</label>"+
            "<textarea name='comment' id='comment' cols='25' rows='10'></textarea>"+
          "</div>"+
          "<div>"+
            "<input type='reset' name='submit' value='취소'>"+
            "&nbsp;&nbsp;&nbsp;"+
            "<input type='submit' name='reset' value='후기 작성'>"+
          "</div>"+
        "</form>"+
        "</div>";
      $("#result").html(str);
      });
    });
  </script>
</head>
<body id="top">
<!-- Top Background Image Wrapper -->
<div class="bgded overlay" style="background-image:url('../images/backgrounds/cosmetic12.jpg');"> 
  <div class="wrapper row1">
    <header id="header" class="hoc clear">
      
        <div id="header1" >  
            <h7><input type="text" value="" id="txtSearch" placeholder="검색어를 입력해주세요.">&nbsp;
            <a href="#"><img src="../images/small_images/search.png" class="smallIcon" id="searchIcon"/></a>&nbsp;&nbsp;
            <a href="#"><img src="../images/small_images/cart.png" class="smallIcon" id="cartIcon"/></a>&nbsp;
            <a href="#"><img src="../images/small_images/mypage.png" class="smallIcon" id="mypageIcon"/></a>&nbsp;</h7>
        </div>
      

        <div id="logo" class="fl_left">
          <a href="/PCos"><img src="../images/small_images/cos.png" class="title" id=""/></a>
        </div>

      <nav id="mainav" class="fl_right">
        <ul class="clear">
          <li class="active"><a href="../index.html">HOME</a></li>
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
      <li><a href="#">Home</a></li>
      <li><a href="#">Lorem</a></li>
      <li><a href="#">Ipsum</a></li>
      <li><a href="#">Dolor</a></li>
    </ul>
  </div>
</div>
<!-- End Top Background Image Wrapper -->
<div class="wrapper row3">
  <main class="hoc container clear"> 
    <!-- main body -->
    <div class="content"> 
      <h1>Product Detail</h1> 
      <img id="image" src="../images/backgrounds/cosmetic01.jpg" width="800px" height="500px"><br>
      <div>
        <table>
          <tr><th>브랜드명</th><td><span id="brandName"></span></td></tr>
          <tr><th>상품명</th><td><span id="productName"></span></td></tr>
          <tr><th class="thcenter">평점</th><td><span id="avgGrade"></span>점 / 5.0점</td></tr>
          <tr><th class="thcenter">용량</th><td><span id="capacity"></span></td></tr>
          <tr><th class="thcenter">가격</th><td>￦<span id="price"></span></td></tr>
          <tr><th class="thcenter">수량</th><td><input type="number" min="1" max="9" value="1"></td></tr>
        </table>
        <div class="group btmspace-30 demo">
          <button class="one_half first">장바구니</button>
          <button class="one_half"><a href="../pages/order.html">바로 구매</a></button>
        </div>
        <div class="group btmspace-50 demo">
          <div class="one_quarter first" style="visibility: hidden;"></div>
          <button class="one_half" id="writecomment">후기 작성하기</button>
        </div>
      <div id="result">
        <div id="comments">
            <h2>Comments</h2>
            <ul>
              <li>
                <article>
                  <header>
                    <address>
                    By <a href="#">작성자 이름<span>　[3.5 점]</span></a> <span id="spanright">24세/여/건성</span>
                    </address>
                    <time datetime="2045-04-06T08:15+00:00">Friday, 6<sup>th</sup> April 2045 @08:15:00</time>
                  </header>
                  <div class="comcont">
                    <p>This is an example of a comment made on a post. You can either edit the comment, delete the comment or reply to the comment. Use this as a place to respond to the post or to share what you are thinking.</p>
                  </div>
                </article>
              </li>
              <li>
                <article>
                  <header>
                    <address>
                    By <a href="#">A Name</a>
                    </address>
                    <time datetime="2045-04-06T08:15+00:00">Friday, 6<sup>th</sup> April 2045 @08:15:00</time>
                  </header>
                  <div class="comcont">
                    <p>This is an example of a comment made on a post. You can either edit the comment, delete the comment or reply to the comment. Use this as a place to respond to the post or to share what you are thinking.</p>
                  </div>
                </article>
              </li>
              <li>
                <article>
                  <header>
                    <address>
                    By <a href="#">A Name</a>
                    </address>
                    <time datetime="2045-04-06T08:15+00:00">Friday, 6<sup>th</sup> April 2045 @08:15:00</time>
                  </header>
                  <div class="comcont">
                    <p>This is an example of a comment made on a post. You can either edit the comment, delete the comment or reply to the comment. Use this as a place to respond to the post or to share what you are thinking.</p>
                  </div>
                </article>
              </li>
            </ul>

     </div>
      <nav class="pagination">
        <ul>
          <li><a href="#">&laquo; Previous</a></li>
          <li><a href="#">1</a></li>
          <li><a href="#">2</a></li>
          <li><strong>&hellip;</strong></li>
          <li><a href="#">6</a></li>
          <li class="current"><strong>7</strong></li>
          <li><a href="#">8</a></li>
          <li><a href="#">9</a></li>
          <li><strong>&hellip;</strong></li>
          <li><a href="#">14</a></li>
          <li><a href="#">15</a></li>
          <li><a href="#">Next &raquo;</a></li>
        </ul>
      </nav>
    </div>
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