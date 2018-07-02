<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="com.pcos.vo.ProductVO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="prod" value="${data}" />
<%
   String email = (String) session.getAttribute("email");
   String skinType = (String)session.getAttribute("skinType");

   ProductVO product = (ProductVO) pageContext.getRequest().getAttribute("data");
   String productCode = (String) product.getProductCode();
%>
<!DOCTYPE html>
<html>
<head>
<title>pcos | Product | Detail</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="../layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<link rel="icon" href="/PCos/resources/favicon.ico?v=2" type="image/x-icon">
<link rel="shortcut icon" href="/PCos/resources/favicon.ico?v=2" type="image/x-icon">
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
	var count = 10;
	
    var email = "<%=email%>";
    var skintype = "<%=skinType%>";

    function Enter_Check() {
	     if(event.keyCode == 13) {
	        if($('#txtSearch').val() == "") {
	        	alert("검색어를 입력해주세요");
	        } else {
	        	location.href="/PCos/search/" + $('#txtSearch').val();
	        }
       }
   }
    
   function goToDirectOrder() {
      var form = document.getElementById('directOrder');

      //$('#price').val($('#priceValue').text());
      //$('#priceTotal').val($('#amount').val() * $('#priceValue').text());

      form.method = "POST";
      form.action = "/PCos/order";
      form.submit();
   }

   $(function() {
	  if(email != "null") {
		  $('#email').val(email);
		  $('#mail').val(email);
	  }
			 
      //product 하나 뿌려주기
      $("#productCode").val("${prod.productCode}");
      $("#image").attr("src", "${prod.image}");
      $("#brandName").text("${prod.brandName}");
      $("#productName").text("${prod.productName}");
      $("#capacity").text("${prod.capacity}");
      $("#avgGrade").text("${prod.avgGrade}");
      $("#priceValue").text(numeral("${prod.price}").format('0,0'));

      
      ajax();
      
      
      //장바구니 버튼 클릭하면
      $('button#cart').click(function() {
         if (email == "null") {
            location.href = "/PCos/login";
            <%
               session.setAttribute("path", "detail/" + productCode);
            %>
         } else {

         	$.ajax({
         		url			: "/PCos/memberRegStat/" + email + ".",
         		dataType 	: "json",
         		method		: "POST",
     			contentType	: "application/json; charset=utf-8",
         		success		: function(data) {
         			if(data.code) {

         	            $.ajax({
         	               url : "/PCos/inputCart",
         	               method : "POST",
         	               dataType : "json",
         	               contentType : "application/json; charset=utf-8",
         	               data : JSON.stringify({
         	                  "productCode" : "${prod.productCode}",
         	                  "email" : email,
         	                  "amount" : $('#amount').val()
         	               }),
         	               success : function(data) {
         	                  if (data.code) {
         	                     location.href = "/PCos/cart";
         	                  }
         	               }
         	            });
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
      });
      
      	$("#reset").click(function() {
			$("#comment").val("");
		});

		//검색 버튼을 클릭하면
		$("#enter").click(function() {
			if ($('#txtSearch').val() != "") {
				location.href = "/PCos/search/" + $('#txtSearch').val();
			} else {
				alert("검색어를 입력해주세요");
			}
		});
      
      //바로 구매 버튼 클릭하면
      $('button#order').click(function() {
         if (email == "null") {
            location.href = "/PCos/login";
            <%
               session.setAttribute("path", "detail/" + productCode);
            %>
         } else {

          	$.ajax({
          		url			: "/PCos/memberRegStat/" + email + ".",
          		dataType 	: "json",
          		method		: "POST",
      			contentType	: "application/json; charset=utf-8",
          		success		: function(data) {
          			if(data.code) {
          				
          	            goToDirectOrder();
          	            
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
      });

      function ajax(){
          $.ajax({
             url : "/PCos/comments/${prod.productCode}",
             dataType : "json",
             method : "GET",
             success : function(data) {
                if (data.code) {
                   var data = data.data;
                   var str = "";
                   if (data.length < count){
                      count = data.length;
                      //$("#increasecount").attr("style","visibility:hidden");
                   }
                   for (var i = 0; i < count; i++) {
                      var comment = data[i];
                      str += "<li>";
                      str += "<article>";
                      str += "<header>";
                      str += "<address>";
                      switch (comment.gender) {
                      case "F":
                         comment.gender = "여성";
                         break;
                      default:
                         comment.gender = "남성";
                         break;
                      };
                      
                      var now = new Date();
                      comment.age = now.getFullYear() - parseInt(comment.ageYear) + 1;
                      str += "By <a href='#' style='color:black;'>"
                            + comment.email.substring(0, 3) + "**<span>　["
                            + comment.grade
                            + " 점]</span></a> <span id='spanright'>"
                            + comment.age + "세/" + comment.gender + "/"
                            + comment.skintype + "</span>";
                      str += "</address>";
                      str += "<time datetime='2045-04-06T08:15+00:00'>"
                            + comment.regDate.substring(0, 16) + "</time>";
                      str += "</header>";
                      str += "<div class='comcont'>";
                      comment.comments = comment.comments.replace(/\n/g, "<br />");
                      str += "<p>" + comment.comments + "</p>";
                      str += "</div>";
                      str += "</article>";
                      str += "</li>";
                   }
                   if (data.length != 0)
                      $("#others").html(str);
                }
             }
          });
       }
       
       $("#increasecount").click(function() {
          count = count + 10;
          ajax();
       });

      $("#submit").click(function() {
         if (email == "null") {
            alert("로그인이 필요한 기능입니다");
            location.href = "/PCos/login";
            <%
               session.setAttribute("path", "detail/" + productCode);
            %>
         } else {
            if (!$("#comment").val()) {
               alert("후기를 작성해주세요");
            } else {
               $.ajax({
                  url : "/PCos/inputGrade",
                  method : "POST",
                  dataType : "json",
                  contentType : "application/json;charset=utf-8",
                  data : JSON.stringify({
                     "productCode" : "${prod.productCode}",
                     "email" : $("#mail").val(),
                     "comments" : $("#comment").val(),
                     "grade" : $("span.result").text(),
                     "skintype":skintype
                  }),
                  success : function(data) {
                     if (data.code) {
                        alert("후기 작성 감사합니다~!");
                        location.href = "${prod.productCode}";
                     }
                  }
               });
            }
         }
      });

      $("#slider").on("change", function() {
         $("span.result").text($(this).val() / 20);
      });

      $("#reset").click(function() {
         $("#slider").val(50);
         $("span.result").text("2.5");
         $("#comment").val("");
      });

   });
</script>
</head>
<body id="top">
   <!-- Top Background Image Wrapper -->
   <div class="bgded overlay"
      style="background-image: url('/PCos/images/backgrounds/cosmetic14.jpg');">
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
                  <li><a class="drop" href="/PCos/pages/category.html">랭킹/쇼핑</a>
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
            <li><a href="/PCos/pages/category.html">Product</a></li>
            <li><a href="">Detail</a></li>
         </ul>
      </div>
   </div>
   <!-- End Top Background Image Wrapper -->
   <div class="wrapper row3">
      <main class="hoc container clear"> <!-- main body -->
      <div class="content">
         <h1>Product Detail</h1>
         <form id="directOrder" onsubmit="goToDirectOrder();">
            <input type="hidden" id="cartNo" name="cartNo" />
            <input type="hidden" id="email" name="email" />
            <input type='hidden' id='productCode' name='productCode' />
            <input type='hidden' id='price' name='price' />
            <input type='hidden' id='priceTotal' name='priceTotal' />
            <img id="image"   src="../images/backgrounds/cosmetic01.jpg" width="800px" height="500px"><br>

            <table>
               <tr>
                  <th>브랜드명</th>
                  <td><span id="brandName"></span></td>
               </tr>
               <tr>
                  <th>상품명</th>
                  <td><span id="productName"></span></td>
               </tr>
               <tr>
                  <th class="thcenter">평점</th>
                  <td><span id="avgGrade"></span>점 / 5.0점 만점</td>
               </tr>
               <tr>
                  <th class="thcenter">용량</th>
                  <td><span id="capacity"></span></td>
               </tr>
               <tr>
                  <th class="thcenter">가격</th>
                  <td>￦<span id="priceValue"></span></td>
               </tr>
               <tr>
                  <th class="thcenter">수량</th>
                  <td><input type="number" min="1" max="9" value="1" id="amount" name="amount"></td>
               </tr>
            </table>
         </form>
         <div class="group btmspace-30 demo">
            <button class="one_half first" id="cart">장바구니</button>
            <button class="one_half" id="order">바로 구매</button>
         </div>
         <div id="result">
            <div id="comments">
               <h2>Write Your Comment to this product</h2>
               <form action='#' method='post'>
                  <div class='one_third first'>
                     <label for='name'>Mail </label> <input type="email" name='email'
                        id='mail' value="" size='35' required readonly="readonly">
                  </div>
                  <div class='one_third'></div>
                  <div class='one_third'>
                     <label for='url'>평점 <span class='result'>2.5</span>점 / 5.0점 만점
                     </label> <input type='range' list='tickmarks' step='10' id='slider'>
                     <datalist id='tickmarks'>
                        <option value='10'>
                        <option value='20'>
                        <option value='30'>
                        <option value='40'>
                        <option value='50'>
                        <option value='60'>
                        <option value='70'>
                        <option value='80'>
                        <option value='90'>
                        <option value='100'>
                     </datalist>
                  </div>
                  <div class='block clear'>
                     <label for='comment'>Your Comment</label>
                     <textarea name='comment' id='comment' cols='25' rows='10'></textarea>
                  </div>
                  <div class="group btmspace-10 demo">
                     <div class="one_half first" id="reset">Reset Form</div>
                     <div class="one_half" id="submit">Submit Form</div>
                  </div>
               </form>
               <h2>Comments from others</h2>
               <ul id="others">
                  <li>
                     <article>
                        <header>
                           <address>아직 후기가 없습니다</address>
                        </header>
                        <div class="comcont">
                           <p>최초의 후기를 작성해주세요!</p>
                        </div>
                     </article>
                  </li>
               </ul>
            </div>
         </div>
      </div>
      <button id="increasecount">후기 10글 더 보기</button>
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