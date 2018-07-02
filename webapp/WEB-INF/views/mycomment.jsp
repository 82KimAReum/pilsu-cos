<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
   String email = (String) session.getAttribute("email");
%>
<!DOCTYPE html>
<html>
<head>
<title>pcos | My Comment</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<link rel="icon" href="./resources/favicon.ico?v=2" type="image/x-icon">
<link rel="shortcut icon" href="./resources/favicon.ico?v=2" type="image/x-icon">
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
   var email = "<%= email %>";
   
   function Enter_Check() {
	     if(event.keyCode == 13) {
	        if($('#txtSearch').val() == "") {
	        	alert("검색어를 입력해주세요");
	        } else {
	        	location.href="/PCos/search/" + $('#txtSearch').val();
	        }
        }
    }
  
   function detailOne(idx){
	   window.open("/PCos/pages/onecomment.html?code="+idx, "pop", "width=800, height=600, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
   }
     $(function() {
        //나중에 자동적으로 email을 가져오는 ajax가 있어야 할 듯
        //그리고 회원만 이용 가능하므로 로그인 후 이용해야 함
      $.ajax({
         url:"/PCos/myQnA/" + email + ".", //나중에 이 뒤에다가 session으로 이메일 받아와야 함
         dataType : "json",
         method : "GET",
         success : function(data){
            if(data.code){
               var data=data.data;
               var str="<tr>";
               if(data.length==0) str+="<td></td><td>정보가 없습니다.</td><td></td>";
               else {for(var i=0; i<data.length;i++){
                     qna=data[i];
                     str+="<td>"+qna.regdate.substring(0,16)+"</td>";
                     str+="<td><a href=\"javascript:detailOne('" + qna.qnano + "');\" id='"+qna.qnano+"'>"+qna.title+"</a></td>";
                     if(qna.replstat=="Y") str+="<td><a class='qnano'>"+qna.replstat+"</a></td>";
                     else str+="<td>"+qna.replstat+"</td>";
                     str+="</tr>";
                     str+="<tr>";
                  }
               }
               str+="</tr>";
               $("#results").html(str);
            }
         }
      });      
        

		$("#enter").click(function() {
			if ($('#txtSearch').val() != "") {
				location.href = "/PCos/search/" + $('#txtSearch').val();
			} else {
				alert("검색어를 입력해주세요");
			}
		});
     });
  </script>
</head>
<body id="top">
<!-- Top Background Image Wrapper -->
<div class="bgded overlay" style="background-image:url('images/backgrounds/cosmetic02.jpg');"> 
  <div class="wrapper row1">
    <header id="header" class="hoc clear">
      
        <div id="header1" >  
            <input type="text" value="" id="txtSearch" placeholder="검색어를 입력해주세요." onkeypress="if(event.keyCode==13) {Enter_Check(); return false;}">&nbsp;
            <a href="" id="enter"><img src="images/small_images/search.png" class="smallIcon" id="searchIcon" title="검색"/></a>&nbsp;&nbsp;
            <a href="/PCos/cart"><img src="images/small_images/cart.png" class="smallIcon" id="cartIcon" title="내 장바구니"/></a>&nbsp;
            <a href="/PCos/mypage"><img src="images/small_images/mypage.png" class="smallIcon" id="mypageIcon" title="마이 페이지"/></a>&nbsp;
        </div>
      
        <div id="logo" class="fl_left">
          <a href="/PCos"><img src="images/small_images/cos.png" class="title" id=""/></a>
        </div>

      <nav id="mainav" class="fl_right">
        <ul class="clear">
          <li class="active"><a href="/PCos">HOME</a></li>
          <li><a class="drop" href="/PCos/pages/category.html">랭킹/쇼핑</a>
            <ul>
              <li><a href="/PCos/pages/category.html">카테고리별</a></li>
              <li><a href="/PCos/pages/brand.html">브랜드별</a></li>
              <li><a href="/PCos/pages/skintype.html">피부타입별</a></li>
              <li><a href="/PCos/pages/man.html">남성</a></li>
            </ul>
          </li>
          <li><a class="drop" href="/PCos/pages/board.html">코스 커뮤니티</a></li>
          <li><a class="drop" href="/PCos/pages/faq.html">Q&A</a>
            <ul>
              <li><a href="/PCos/pages/faq.html">FAQ</a></li>
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
      <li><a href="/PCos/pages/faq.html">Q&A</a></li>
      <li><a href="/PCos/qna">1:1</a></li>
    </ul>
  </div>
</div>
<!-- End Top Background Image Wrapper -->
<div class="wrapper row3">
  <main class="hoc container clear"> 
    <!-- main body -->
    <div class="sidebar one_quarter first"> 
      <h6>q & A</h6>
      <nav class="sdb_holder">
        <ul>
          <li><a href="/PCos/pages/faq.html">FAQ</a></li>
          <li><a href="/PCos/qna">1:1 문의</a>
            <ul>
              <li><a href="">내 문의 보기</a></li>
              <li><a href="/PCos/qna">문의하기</a></li>
            </ul>
          </li>
        </ul>
      </nav>
    </div>
    <div class="content three_quarter"> 
    <h1>Read your Question(s)</h1>
      <div class="scrollable">
        <table>
           <col width="70">
           <col width="200">
           <col width="20">
          <thead>
            <tr>
              <th>DATE</th>
              <th>TITLE</th>
              <th>REPLY</th>
            </tr>
          </thead>
          <tbody id="results">
            
          </tbody>
        </table>
      </div>
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
          <button type="button" value="submit">Submit</button>
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