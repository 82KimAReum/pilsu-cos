<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String email = (String)session.getAttribute("email");
%>

<!DOCTYPE html>
<html>
<head>
<title>pcos | Cart</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="./layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<link rel="icon" href="./resources/favicon.ico?v=2" type="image/x-icon">
<link rel="shortcut icon" href="./resources/favicon.ico?v=2" type="image/x-icon">
<script src="//cdnjs.cloudflare.com/ajax/libs/numeral.js/2.0.6/numeral.min.js"></script>
<script src="<c:url value='/js/jquery-1.12.4.js'/>"></script>

<script>
	var cart     = null;
	var cartSize = -1;
	//var totalPrice_All = 0;
	
	//로그인 한 회원 아이디
	var email = "<%= email %>";
	
  	function Enter_Check(){
    	if(event.keyCode == 13){
	    	if($('#txtSearch').val()!="") {
	    		location.href = "/PCos/search/" + $('#txtSearch').val();
	    	} else {
	    		alert("검색어를 입력해주세요");
	    	}
    	}
	}
   		
  	$(function() {
		
		if(email == "null") {
			location.href =  "/PCos/login";
			<%
				session.setAttribute("path", "cart");
			%>
		} else {   //로그인 한 회원이라면,
			$('#email').val(email);
		
        	$.ajax({
        		url			: "/PCos/memberRegStat/" + email + ".",
        		dataType 	: "json",
        		method		: "POST",
    			contentType	: "application/json; charset=utf-8",
        		success		: function(data) {
        			if(data.code) {

        				// 화면 로드시 최초 실행 _ 장바구니 목록을 불러온다.
        				init();
        				priceCalc();
        			} else {
        				location.href = "/PCos/cart";
       		            <%
       		            	session.setAttribute("path", "cart");
       		            %>
        			}
        		}
        		
        	});
		
		}
		
		
		//장바구니 체크박스 전체 목록 선택/해제
		$('input[name=_selected_all_]').on('change', function() {
			$('input[name=_selected_]').prop('checked', this.checked);
			checkbox_event();
		});
		
		$('input[name=amount]').on('change', function() {
			checkbox_event();
		});
		
		$("#enter").click(function(){
	    	if($('#txtSearch').val() != "") {
	    		location.href="/PCos/search/"+$('#txtSearch').val();
	    	} else {
	    		alert("검색어를 입력해주세요");
	    	}
		});
		
		//주문하기 버튼 클릭 시
		$('input#btnOrder').on('click', function() {
			if($('#checked_CartList').val() == "" ||
				$('#checked_CartList').val() == '{"checked_CartList" : []}') {

				alert('주문할 상품을 선택해 주세요.');
			} else {
				var form = document.getElementById('order');
			
				form.method = "POST";
				form.action= "/PCos/order";
				form.submit();
			}
		});
		
	});

	function priceCalc() {
		for(var j = 0; j < cartSize; j++) {
			//각 항목 수량 증감하면 각 항목별 수량 * 금액 값 넣기
			$('input#amount_' + j).on('click', function() {
				var amount = $(this).val();
				
				var price = $(this).parent().parent().next().find("span").text();
				price = price.replace(/[^\d]+/g, ''); //천단위 제거
         
				var priceTot = amount * price;

				$(this).parent().parent().next().next().find("strong > span").text(numeral(priceTot).format('0,0') + "원");
				
				//각 항목 체크하면 총합에 계산된 값 넣기
				totalPrice = 0;
				for(var k = 0; k < cartSize; k++) {
					var price = $('span#priceTot_' + k).text();
					price = price.replace(/[^\d]+/g, '');
					price = parseInt(price);

					$('#priceTots_' + k).val(price);
					totalPrice = totalPrice + price;
				}
				
				$('#total').text(numeral(totalPrice).format('0,0'));
				$('#totalPrice').val(totalPrice);
			});
		}
	}
	
	//장바구니에서 삭제 누르면 확인 후 삭제
	function deleteFromCart() {
		if(cartSize != 0) {
			if($('#checked_CartList').val() == "" ||
					$('#checked_CartList').val() == '{"checked_CartList" : []}') {

					alert('삭제할 상품을 선택해 주세요.');
			} else {
				
				if(confirm('해당 상품을 정말 삭제하시겠습니까?')) { 
					var checked_length = 0;
					for(var n = 0; n < cartSize; n++) {
						if($("#_checked_" + n).is(":checked")) {
							checked_length += 1;
							var cartNo = $('#cartNo_' + n).val();
							
							$.ajax({
								url : "/PCos/deleteFromCart",
								method : "POST",
								dataType : "json",
								data : {
									"email" : email,
									"cartNo" : cartNo
								},
								success : function(data) {
									if(data.code) {
										//alert("선택하신 상품에 장바구니에서 제거되었습니다.");
										init();
									}
								}
							});
						}
					}
					
					if(checked_length == 0) {
						alert("삭제할 상품을 선택해 주세요.");
					}
				}
			}
			
		} else {
			alert("장바구니에 삭제할 상품이 존재하지 않습니다.");
		}
	}
	
	function checkbox_event() {
		
		var checked_CartList = new Array();
		//var priceTots = 0;
		for(var n = 0; n < cartSize; n++) {
			var str = "";

			if($("#_checked_" + n).is(":checked")) {
				//priceTots += parseInt($("#prices_" + n).val());
				checked_CartList.push({
					cartNo : $("#cartNo_" + n).val(),
					image : $("#image_" + n).val(),
					productName : $("#productName_" + n).val(),
					productCode : $("#productCode_" + n).val(),
					amount : $("#amount_" + n).val(),	
					price : $("#prices_" + n).val(),
					priceTot : $("#priceTots_" + n).val()
				});
				
				//console.log("checked priceTots = " + priceTots);
				//$('#total').text(numeral(priceTots).format('0,0'));
			}
			
			/* if($("#_checked_" + n).attr("checked", false)) {
				console.log("unchecked priceTots = " + totalPrice_All);
				$('#total').text(0);
				$('#total').text(numeral(totalPrice_All).format('0,0'));
			} */
			
		}
		
		$("#checked_CartList").val("{\"checked_CartList\" : " + JSON.stringify(checked_CartList) + "}");
		
	}
	
	function init() {
		$.ajax({
			url			: "/PCos/cartList",
			method		: "POST",
			async		: false,
			dataType	: "json",
			contentType	: "application/json; charset=utf-8",
			data		: JSON.stringify({
				"email" : email
			}),
			success : function(data) {
				//회원 카트 전체 목록 읽어오기
				cart = data.data;
				cartSize = data.data.length;
				totalPrice_All = 0;
				var str = "";
				
				if(cartSize == 0) {
					str += "<tr><td></td><td>정보가 없습니다.</td><td></td><td></td><td></td><td></td></tr>";
				} else {
					for(var i = 0; i < cartSize; i++) {
						str += "<tr class='cake-top' id='cart_" + i + "'>";
						str += "	<td>";
						str += "		<input type='checkbox' name='_selected_' value='ROW_" + i + "' id='_checked_" + i + "'>";
						str += "	</td>";

						str += "	<input type='hidden' name='cartNo' id='cartNo_" + i + "' value='" + cart[i].cartNo + "'/>";
						
						str += "	<td class='cakes'>";
						str += "		<div class='product-img'>";
						str += "			<img src='" + cart[i].image + "' width='10px' height='10px'/>";
						str += "			<input type='hidden' name='images' id='image_" + i + "'  value='" + cart[i].image + "'/>";
						str += "		</div>";
						str += "	</td>";
						
						str += "	<td class='cake-text'>";
						str += "		<div class='product-text'>";
						str += "			<h3>" + cart[i].productName + "</h3>";
						str += "			<input type='hidden' name='productNames' id='productName_" + i + "' value='" + cart[i].productName + "'/>";
						str += "			<input type='hidden' name='productCodes' id='productCode_" + i + "' value='" + cart[i].productCode + "'/>";
						str += "		</div>";
						str += "	</td>";
						
						str += "	<td class='quantity'>";
						str += "		<div class='product-right'>";
						str += "			<input min='1' type='number' id='amount_" + i + "' name='amount' value='" + cart[i].amount + "' style='width: 50px'/>";
						str += "		</div>";
						str += "	</td>";
						
						str += "	<td class='price'>";
						str += "		<span id='price_" + i + "'>" + numeral(cart[i].price).format('0,0') + "원</span>";
						str += "		<input type='hidden' name='prices' id='prices_" + i + "' value='" + cart[i].price + "'/>";
						str += "	</td>";

						str += "	<td class='top-remove'>";
						str += "		<strong>";
						str += "			<span id='priceTot_" + i + "'>" + numeral(cart[i].amount * cart[i].price).format('0,0') + "원</span>";
						str += "		</strong>";
						str += "		<input type='hidden' name='priceTots' id='priceTots_" + i + "' value='" + (cart[i].amount * cart[i].price) + "'/>";
						str += "	</td>";
						str += "</tr>";
					}
				}
				
				$('#cartList').html(str);
				
				var totalPrice = 0;
				
				// 금액 계산
				for(var k = 0; k < cartSize; k++) {
					var price = $('span#priceTot_' + k).text();
					price = price.replace(/[^\d]+/g, '');
					price = parseInt(price);

					totalPrice = totalPrice + price;
				}
				
				$('#total').text(numeral(totalPrice).format('0,0'));
				$('#totalPrice').val(totalPrice);
				totalPrice_All = $('#totalPrice').val();
				
				//체크 박스 이벤트 (선택한 값만 저장)
				$( "input[type=checkbox]" ).on( "change", checkbox_event );
			}
		});
	}
</script>

</head>
<body id="top">
<!-- Top Background Image Wrapper -->
<div class="bgded overlay" style="background-image:url('./images/backgrounds/cosmetic02.jpg');"> 
  <div class="wrapper row1">
    <header id="header" class="hoc clear">
      
        <div id="header1" >  
            <input type="text" value="" id="txtSearch" placeholder="검색어를 입력해주세요.">&nbsp;
            <a href="" id="enter"><img src="./images/small_images/search.png" class="smallIcon" id="searchIcon"/></a>&nbsp;&nbsp;
            <a href="/PCos/cart"><img src="./images/small_images/cart.png" class="smallIcon" id="cartIcon"/></a>&nbsp;
            <a href="/PCos/mypage"><img src="./images/small_images/mypage.png" class="smallIcon" id="mypageIcon"/></a>&nbsp;
        </div>
      
        <div id="logo" class="fl_left">
          <a href="/PCos"><img src="./images/small_images/cos.png" class="title" id=""/></a>
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
            </ul>
          </li>
          <li><a class="drop" href="./pages/board.html">코스 커뮤니티</a></li>
          <li><a class="drop" href="./pages/faq.html">Q&A</a>
            <ul>
              <li><a href="./pages/faq.html">FAQ</a></li>
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
      <li><a href="/PCos/cart">cart</a></li>
    </ul>
  </div>
</div>
<!-- End Top Background Image Wrapper -->

<div class="wrapper row3">
  <main class="hoc container clear"> 
    <!-- main body -->

	<a href="javascript:;" onclick="deleteFromCart();">선택 상품 장바구니에서 삭제</a>
   <form id='order'>
   <!-- <form method="POST" action="/PCos/order"> -->
      <input type="hidden" id="email" name="email"/>
      
      <div class="cart">
      
         <div class="cart-bottom">
             <div class="table">
                <table style="text-align: center">
                   <thead>
                      <tr class="main-heading">
                          <th style="width: 3%"><input type="checkbox" name="_selected_all_" onchange='checkbox_event()'></th>
                      <th style="width: 20%">Images</th>
                      <th style="width: 30%">Product Name</th>
                      <th style="width: 3%">Amount</th>
                      <th style="width: 15%">Price</th>
                      <th style="width: 15%">Total</th>
                       </tr>
                   </thead>
                   <tbody id="cartList">
                   </tbody>
                </table>
             </div>
             <div class="vocher">
                <div class="dis-total">
                   <!-- <h1>총합<span id="total"></span>원</h1> -->
                   <input type='hidden' id='totalPrice' name="totalPrice"/>
                   <div class="tot-btn">
                      <input type='button' id='btnOrder' value="주문하기"/>
                   </div>
                </div>
                <div class="clear"> </div>
                
                <input type='hidden' name='results' id='results'/>
             </div>
         </div>
      </div>
     
     <input type="hidden" name="checked_CartList" id="checked_CartList"/>
      
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