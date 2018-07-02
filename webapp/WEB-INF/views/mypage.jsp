<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*, java.text.*"  %>
<c:set var="ageYear" value="${ageYear}"/>
<%
	String path = (String)session.getAttribute("path");
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy");
    String today = formatter.format(new java.util.Date());
    String email = (String)session.getAttribute("email");
    int realAge = 0;

   if(session.getAttribute("email") != null && session.getAttribute("name") != null) {
   	String name = (String)session.getAttribute("name");
   	String skinType = (String)session.getAttribute("skinType");
   	int ageYear = (Integer)pageContext.getAttribute("ageYear");
   	realAge=Integer.valueOf(today)-ageYear+1;
   }
%>

<!DOCTYPE html>
<html>
<head>
<title>pcos | MyPage</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="./layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<link rel="stylesheet" href="./layout/styles/mypage.css"> 
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue-grey.css">
<link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
<link rel="icon" href="../resources/favicon.ico?v=2" type="image/x-icon">
<link rel="shortcut icon" href="../resources/favicon.ico?v=2" type="image/x-icon">
  <script src="//cdnjs.cloudflare.com/ajax/libs/numeral.js/2.0.6/numeral.min.js"></script>
  <script src="<c:url value='/js/jquery-1.12.4.js'/>"></script>
  <script>

	function Enter_Check() {
		if (event.keyCode == 13) {
			if ($('#txtSearch').val() != "") {
				location.href = "/PCos/search/" + $('#txtSearch').val();
			} else {
				alert("검색어를 입력해주세요");
			}
		}
	}
	
     function detailOne(idx) {
        window.open("/PCos/pages/onecomment.html?code=" + idx, "pop", "width=800, height=600, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
     }
     
     function detailBoard(idx) {
        window.open("/PCos/pages/oneBoard.html?code=" + idx, "pop", "width=800, height=600, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );  
     }
     
     function myFunction(loc) {
     	location.href=loc;
     }
  
     $(function() {
        var email = "<%= email %>";
        
        if(email == "null") {
           location.href = "/PCos/login";
          <%
            session.setAttribute("path", "mypage");
          %>
         //이메일이 널이 아니면서 가입한 회원이 아니면
         //personalInfo 페이지로 리다이렉트
         
        } else if(email != "null") {
        	$.ajax({
        		url			: "/PCos/memberRegStat/" + email + ".",
        		dataType 	: "json",
        		method		: "POST",
    			contentType	: "application/json; charset=utf-8",
        		success		: function(data) {
        			if(data.code) {
        				$.ajax({
        	                url 	 : "/PCos/myOrder/" + email + ".",
        	                dataType : "json",
        	                method 	 : "GET",
        	                success  : function(data){
        	                   if(data.code){
        	                      var data = data.data;
        	                      var str = "<tr>";
        	                      if(data.length==0) str+="<td></td><td>정보가 없습니다.</td><td></td><td></td>";
        	                      else {
        	                         for(var i=0; i < data.length; i++) {
        	                            order = data[i];
        	                            date = order.orderDate.substring(0,16);
        	                            
        	                            if(i > 0) {
        	                               if(date==data[i-1].orderDate.substring(0,16)) date="";
        	                            }
        	                            
        	                              str+="<td>" + date + "</td>";
        	                              str+="<td>" + order.productName + "(" + order.amount + ")</td>";
        	                              str+="<td>₩" +numeral( order.amount*order.price).format('0,0') + "</td>";
        	                              str+="<td>" + order.orderStat + "</td>";
        	                              str+="</tr>";
        	                              str+="<tr>";
        	                         }
        	                      }
        	                      str += "</tr>";
        	                      $("#orderResults").html(str);
        	                   }
        	                }
        	            });
        	            
        	            $.ajax({
        	               url:"/PCos/myBoard/" + email + ".",
        	               dataType : "json",
        	               method : "GET",
        	               success : function(data){
        	                  if(data.code){
        	                     var data=data.data;
        	                     var str="<tr>";
        	                     if(data.length==0) str+="<td></td><td>정보가 없습니다.</td><td></td><td></td>";
        	                     else {for(var i=0; i<data.length;i++){
        	                           board=data[i];
        	                           str+="<td>"+board.regDate.substring(0,16)+"</td>";
        	                           str+="<td><a style='color:#C96D9F;' href=\"javascript:detailBoard('" + board.boardNo + "');\" id='"+board.boardNo+"'>"+board.title+"</a></td>";
        	                           str+="<td>"+board.readCount+"</td>";
        	                           str+="<td>"+board.likeCount+"</td>";
        	                           str+="<td>"+board.dislikeCount+"</td>";
        	                           str+="</tr>";
        	                           str+="<tr>";
        	                        }
        	                     }
        	                        str+="</tr>";
        	                        $("#boardResults").html(str);
        	                  }
        	               }
        	            });
        	            
        	            $.ajax({
        	               url:"/PCos/myQnA/" + email + ".",
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
        	                         str+="<td><a style='color:#C96D9F;' href=\"javascript:detailOne('" + qna.qnano + "');\" id='"+qna.qnano+"'>"+qna.title+"</a></td>";
        	                         if(qna.replstat=="Y") str+="<td><a style='color:#C96D9F;' class='qnano'>"+qna.replstat+"</a></td>";
        	                         else str+="<td>"+qna.replstat+"</td>";
        	                         str+="</tr>";
        	                         str+="<tr>";
        	                      }
        	                   }
        	                      str+="</tr>";
        	                      $("#qnaResults").html(str);
        	                }
        	             }
        	            });
        	            
        	            $.ajax({
        	                  url:"/PCos/myGrade/" + email + ".",
        	               dataType : "json",
        	               method : "GET",
        	               success : function(data){
        	                  if(data.code){
        	                     var data=data.data;
        	                     var str="<tr>";
        	                     if(data.length==0) str+="<td></td><td>정보가 없습니다.</td><td></td><td></td>";
        	                     else {for(var i=0; i<data.length;i++){
        	                           grade=data[i];
        	                           str+="<td>"+grade.regDate.substring(0,16)+"</td>";
        	                           str+="<td>"+grade.productName+"</td>";
        	                           str+="<td>"+grade.grade+" 점</td>";
        	                           str+="<td>"+grade.comments+"</td>";
        	                           str+="</tr>";
        	                           str+="<tr>";
        	                        }
        	                     }
        	                        str+="</tr>";
        	                        $("#gradeResults").html(str);
        	                  }
        	               }
        	            });
        				
        			} else {
        				location.href = "/PCos/myInfo";
       		            <%
       		            	session.setAttribute("path", "mypage");
       		            %>
        			}
        		}
        	});
        }
        
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
<div class="bgded overlay" style="background-image:url('./images/backgrounds/cosmetic02.jpg');"> 
  <div class="wrapper row1">
    <header id="header" class="hoc clear">
        <div id="header1" >  
            <input type="text" value="" id="txtSearch" placeholder="검색어를 입력해주세요." onkeypress="if(event.keyCode==13) {Enter_Check(); return false;}">&nbsp;
            <a href="" id="enter"><img src="./images/small_images/search.png" class="smallIcon" id="searchIcon" title="검색"/></a>&nbsp;&nbsp;
            <a href="/PCos/cart"><img src="./images/small_images/cart.png" class="smallIcon" id="cartIcon" title="내 장바구니"/></a>&nbsp;
            <a href="/PCos/mypage"><img src="./images/small_images/mypage.png" class="smallIcon" id="mypageIcon" title="마이 페이지"/></a>&nbsp;
        </div>

        <div id="logo" class="fl_left">
          <a href="/PCos"><img src="/PCos/images/small_images/cos.png" class="title" id=""/></a>
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
      <li><a href="/PCos/mypage">My Page</a></li>
    </ul>
  </div>
</div>
<!-- End Top Background Image Wrapper -->

<div class="wrapper row3">
  <main class="hoc container clear"> 
    <!-- main body -->

<div>
<!-- Page Container -->
<div class="w3-container w3-content" style="max-width:1400px">    
  <!-- The Grid -->
  <div class="w3-row">
    <!-- Left Column -->
    <div class="w3-col m3">

      <!-- 사진/이름/피부타입/나이 -->
      <div class="w3-card w3-round w3-white">
        <div class="w3-container">
         <h4 class="w3-center">My Profile</h4>
         <p class="w3-center"><img src="./images/small_images/profile.png" class="w3-circle" style="height:106px;width:106px" alt="Avatar"></p>
         <hr>
         <p><img src="./images/small_images/cream.png"> 이름: ${name}</p>
         <p><img src="./images/small_images/cream.png"> 피부타입: ${skinType}</p>
         <p><img src="./images/small_images/cream.png"> 나이: <%=realAge %></p>
         
        </div>
      </div>
      <br>
      
      <!-- 프로필 밑 파란 칸 -->
      <div class="w3-card w3-round">
        <div class="w3-white">
          <button onclick="location.href='/PCos/myInfo'" class="w3-button w3-block w3-theme-l1 w3-left-align"> 개인정보 수정</button>
          <div id="Demo1" class="w3-hide w3-container">
            <p>Some text..</p>
          </div>

          <button onclick="myFunction('/PCos/mydetail/CartAll')" class="w3-button w3-block w3-theme-l1 w3-left-align"> 내 장바구니</button>
          <div id="Demo2" class="w3-hide w3-container">
          </div>

          <button onclick="myFunction('/PCos/mydetail/OrderAll')" class="w3-button w3-block w3-theme-l1 w3-left-align"> 내 주문내역</button>
          <div id="Demo3" class="w3-hide w3-container">
          </div>

          <button onclick="myFunction('/PCos/mydetail/BoardAll')" class="w3-button w3-block w3-theme-l1 w3-left-align"> 내가 작성한 글</button>
          <div id="Demo4" class="w3-hide w3-container">
          </div>

          <button onclick="myFunction('/PCos/mydetail/GradeAll')" class="w3-button w3-block w3-theme-l1 w3-left-align"> 나의 후기</button>
          <div id="Demo5" class="w3-hide w3-container">
          </div>

          <button onclick="myFunction('/PCos/mydetail/QnaAll')" class="w3-button w3-block w3-theme-l1 w3-left-align"> 나의 1:1 문의</button>
          <div id="Demo6" class="w3-hide w3-container">
          </div>
          <button onclick="if(confirm('정말 로그아웃 하시겠습니까?')) location.href = '/PCos/logout'" class="w3-button w3-block w3-theme-l1 w3-left-align"> 로그아웃</button>
          <div id="Demo6" class="w3-hide w3-container">
          </div>

        </div>      
      </div>
      <br>
    <!-- End Left Column -->
    </div>
<!-- Middle Column -->
    <div class="w3-col m7">
    
      <div class="w3-row-padding">
        <div class="w3-col m12">
          <div class="w3-card w3-round w3-white">
            <div class="w3-container w3-padding">
             <span class="w3-right w3-opacity"><a href="/PCos/mydetail/OrderAll">전체 보기</a></span>
              <h4>최근 주문내역(상위 3)</h4><br>
            <hr class="w3-clear">
        <div class="scrollable">
        <table>
           <col width="100">
           <col width="200">
           <col width="15">
           <col width="15">
          <thead>
            <tr>
              <th>DATE</th>
              <th>ORDERLIST</th>
              <th>PRICE</th>
              <th>STATE</th>
            </tr>
          </thead>
          <tbody id="orderResults">
            
          </tbody>
        </table>
      </div>
            </div>
          </div>
        </div>
      </div>
      
      <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
        <span class="w3-right w3-opacity"><a href="/PCos/mydetail/BoardAll">전체 보기</a></span>
        <h4>내가 작성한 글(상위 3)</h4><br>
        <hr class="w3-clear">
        <div class="scrollable">
        <table>
           <col width="100">
           <col width="200">
           <col width="15">
           <col width="15">
           <col width="15">
          <thead>
            <tr>
              <th>DATE</th>
              <th>TITLE</th>
              <th>READ</th>
              <th>LIKE</th>
              <th>DIS</th>
            </tr>
          </thead>
          <tbody id="boardResults">
            
          </tbody>
        </table>
      </div>
      </div> 
      
      <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
        <span class="w3-right w3-opacity"><a href="/PCos/mydetail/GradeAll">전체 보기</a></span>
        <h4>내 후기 글(상위 3)</h4><br>
        <hr class="w3-clear">
      <div class="scrollable">
        <table>
          <thead>
            <tr>
              <th>DATE</th>
              <th>PRODUCTNAME</th>
              <th>GRADE</th>
              <th>COMMENTS</th>
            </tr>
          </thead>
          <tbody id="gradeResults">
            
          </tbody>
        </table>
      </div>
      </div> 
      
      <div class="w3-container w3-card w3-white w3-round w3-margin"><br>
        <span class="w3-right w3-opacity"><a href="/PCos/mydetail/QnaAll">전체 보기</a></span>
        <h4>내 1:1 문의보기(상위 3)</h4><br>
        <hr class="w3-clear">
        <div class="scrollable">
        <table>
           <col width="100">
           <col width="200">
           <col width="20">
          <thead>
            <tr>
              <th>DATE</th>
              <th>TITLE</th>
              <th>REPLY</th>
            </tr>
          </thead>
          <tbody id="qnaResults">
            
          </tbody>
        </table>
      </div>
      </div>
    <!-- End Middle Column -->
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