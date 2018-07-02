<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cart" value="${data}" />

<!DOCTYPE html>
<html>
<head>
<title>pcos | Ranking / Shopping | Product Payment</title>
<meta charset="utf-8">
<link href="../layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<style type="text/css">
  .container .demo{text-align:center;}
  .container .demo div{padding:8px 0;}
  .container .demo div:nth-child(odd){color:#FFFFFF; background:#CCCCCC;}
  .container .demo div:nth-child(even){color:#FFFFFF; background:#979797;}
  @media screen and (max-width:900px){.container .demo div{margin-bottom:0;}}
</style>
</head>

	<!-- 참고 API : http://postcode.map.daum.net/guide -->
<!-- <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function searchZipcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('address1').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('address2').focus();
            }
        }).open();
    }
</script>
 -->
<script src="//cdnjs.cloudflare.com/ajax/libs/numeral.js/2.0.6/numeral.min.js"></script>
<script src="<c:url value='/js/jquery-1.12.4.js'/>"></script>
<script>
	$(function() {
		//장바구니 전체 목록 선택/해제
/* 		$('input[name=_selected_all_]').on('change', function() {
			$('input[name=_selected_]').prop('checked', this.checked);
		}); */
		
		console.log("${cart.cartNo}");
		console.log("${cart.email}");
		

	});
</script>

<!-- 
<body id="top">
Top Background Image Wrapper
<div class="bgded overlay" style="background-image:url('../images/backgrounds/cosmetic01.jpg');"> 
  <div class="wrapper row1">
    <header id="header" class="hoc clear">
        <div id="header1" >  
            <h7><input type="text" value="" id="txtSearch" placeholder="검색어를 입력해주세요.">&nbsp;
            <a href="#"><img src="../images/small_images/search.png" class="smallIcon" id="searchIcon"/></a>&nbsp;&nbsp;
            <a href="#"><img src="../images/small_images/cart.png" class="smallIcon" id="cartIcon"/></a>&nbsp;
            <a href="personalInfo.html"><img src="../images/small_images/mypage.png" class="smallIcon" id="mypageIcon"/></a>&nbsp;</h7>
        </div>
        <div id="logo" class="fl_left">
          <a href="/PCos"><img src="../images/small_images/cos.png" class="title" id=""/></a>
        </div>

      <nav id="mainav" class="fl_right">
        <ul class="clear">
          <li class="active"><a href="/PCos">HOME</a></li>
          <li><a class="drop" href="">랭킹/쇼핑</a>
            <ul>
              <li><a href="category.html">카테고리별</a></li>
              <li><a href="brand.html">브랜드별</a></li>
              <li><a href="skintype.html">피부타입별</a></li>
              <li><a href="age.html">연령대별</a></li>
              <li><a href="man.html">남성</a></li>
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
      <li><a href="category.html">Ranking / Shopping</a></li>
      <li><a href="order.html">Product Payment</a></li>
    </ul>
  </div>
</div>
End Top Background Image Wrapper

<div class="wrapper row3">
  <main class="hoc container clear"> 
    main body
    <div class="content"> 
      <h1><strong>주문/결제 화면</strong></h1>

		<div class="cart">

   <div class="cart-bottom">
   	 <div class="table">
   	 	<table>
   	 		<thead>
	   	 		<tr class="main-heading">
	   	 	    	<th><input type="checkbox" name="_selected_all_"></th>
			 		<th>Images</th>
			 		<th>Product Description</th>
			 		<th>Quantity</th>
			 		<th>Price</th>
			 		<th>Total</th>
	   	 	    </tr>
   	 		</thead>
   	 		<tbody id="cartList"></tbody>
   	 	</table>
   	 </div>
   	 <div class="vocher">
   	 	<div class="dis-total">
   	 		<h1>총합 <span id="total"></span>원</h1>
   	 		<div class="tot-btn">
   	 			<input type='button' id='btnOrder' value="주문하기"/>
   	 		</div>
   	 	</div>
   	   <div class="clear"> </div>
   	 </div>
   </div>
</div>




      <form method="POST">
        <h3>주문자 정보</h3>
        <table>
            <tr>
                <th><label for='orderName'>주문자명</label></th>
                <td><input type="text" id='orderName' required/></td>
            </tr>
            <tr>
              <th>휴대폰</th>
              <td class='formtd'><input type='text' size="2" id='phone11'/>-<input type='text' size="3" id='phone12'/>-<input type='text' size="3"  id='phone13'/></td>
            </tr>
            <tr>
              <th>이메일</th>
              <td><input type='text' id='email'/></td>
            </tr>
        </table>
        <br />
        <br />
        
        <h3>배송지 정보</h3>
        <div class='formtd'>
            <input type='checkbox' id='deliveryAddr'/>&nbsp;
            <label for='deliveryAddr'>주문자 정보와 동일</label>
        </div>
        <table>
            <tr>
              <th><label for='recipient'>받는 분</label></th>
              <td><input type='text' id='recipient'/></td>
            </tr>
            <tr>
              <th>휴대폰</th>
              <td class='formtd'><input type='text' size="2" id='phone21'/>-<input type='text' size="3" id='phone22'/>-<input type='text' size="3" id='phone23'/></td>
            </tr>
            <tr>
              <th>배송지</th>
              <td>
                <table id='detailAddress'>
                  <tr>
                    <td class='formtd' rowspan="2">
                      <input type='text' id='zipcode' placeholder="우편번호" readonly/><br/>
                      <input type='button' onclick='searchZipcode()' value='우편번호 찾기'/>&nbsp;
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <input type='text' id='address1' placeholder="주소" readonly/>
                      <input type='text' id='address2' placeholder="상세 주소를 입력해주세요."/>
                    </td>
                </table>
              </td>
            </tr>
        </table>
        
        <div class='formtd'>
            <input type='checkbox' id='defaultDeliveryAddr'/>&nbsp;
            <label for='defaultDeliveryAddr'>기본 배송지로 저장</label>
        </div>
        <br />
        <br />

        <div class='formtd'>
          <label for='comments'>배송 요청사항</label>&nbsp;&nbsp;
          <input type='text' id='comments'></label>
        </div>

        <hr />
        <br />
        <br />
        <div class='formtd'>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <label for='comments'>총 결제금액</label>&nbsp;&nbsp;
          <span id='total'></span>원
        </div>
        <hr />
        <br />
        <br />

        <div class='formtd'>
          <label for='paymentMethod'>결제 수단</label>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type='radio' id='paymentMethod' checked/>카드 결제
        </div>
        <br />
        <br />
		<div id='btn'>
	        <input type='button' id='btnCancel' value="취소하기" onclick="javascript:history.go(-1);"/>
	        <input type='button' id='btnOrder' value="주문하기"/>
		</div>
    </form>
  </div>

    / main body
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
</html> -->