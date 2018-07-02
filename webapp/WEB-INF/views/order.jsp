<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List"%>
<%@ page import="com.pcos.vo.ProductVO"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<c:set var="member" value="${data}" />
<c:set var="product" value="${product}" />
<%
	ProductVO product = (ProductVO) pageContext.getRequest().getAttribute("product");
	int orderAmount = 0;

	//int orderAmount = (Integer)pageContext.getRequest().getAttribute("amount");
	if (product != null) {
		orderAmount = product.getOrderAmount();
	}

	String email = (String) session.getAttribute("email");

	String[] cartNos = null;
	String[] images = null;
	String[] productNames = null;
	String[] productCodes = null;
	String[] amounts = null;
	String[] prices = null;
	String[] priceTots = null;

	//String totalPrice = request.getParameter("totalPrice");

	int cartListSize = 0;

	String checked_CartList = request.getParameter("checked_CartList");

	if (checked_CartList != null) { //장바구니에서 넘어왔을 때
		try {
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObj = (JSONObject) jsonParser.parse(checked_CartList);
			JSONArray cartArray = (JSONArray) jsonObj.get("checked_CartList");

			cartListSize = cartArray.size();

			cartNos = new String[cartListSize];
			images = new String[cartListSize];
			productNames = new String[cartListSize];
			productCodes = new String[cartListSize];
			amounts = new String[cartListSize];
			prices = new String[cartListSize];
			priceTots = new String[cartListSize];

			for (int i = 0; i < cartArray.size(); i++) {
				JSONObject cartObj = (JSONObject) cartArray.get(i);

				cartNos[i] = cartObj.get("cartNo").toString();
				images[i] = cartObj.get("image").toString();
				productNames[i] = cartObj.get("productName").toString();
				productCodes[i] = cartObj.get("productCode").toString();
				amounts[i] = cartObj.get("amount").toString();
				prices[i] = String.format("%,d", Integer.parseInt(cartObj.get("price").toString()));
				priceTots[i] = String.format("%,d", Integer.parseInt(cartObj.get("priceTot").toString()));
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
	} else { //제품 상세보기(detail.jsp)에서 바로 구매로 왔을 때
		cartListSize = 1;

		cartNos = new String[1];
		images = new String[1];
		productNames = new String[1];
		productCodes = new String[1];
		amounts = new String[1];
		prices = new String[1];
		priceTots = new String[1];

		cartNos[0] = product.getCartNo();
		images[0] = product.getImage();
		productNames[0] = product.getProductName();
		productCodes[0] = product.getProductCode();
		amounts[0] = String.valueOf(orderAmount);
		prices[0] = String.format("%,d", product.getPrice());
		priceTots[0] = String.format("%,d", orderAmount * product.getPrice());
	}
%>

<!DOCTYPE html>
<html>
<head>
<head>
<title>pcos | Order | Payment</title>
<meta charset="utf-8">
<link href="./layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<link rel="icon" href="./resources/favicon.ico?v=2" type="image/x-icon">
<link rel="shortcut icon" href="./resources/favicon.ico?v=2" type="image/x-icon">
<style type="text/css">
.container .demo { text-align: center; }
.container .demo div { padding: 8px 0; }
.container .demo div:nth-child(odd) { color: #FFFFFF; background: #CCCCCC; }
.container .demo div:nth-child(even) { color: #FFFFFF; background: #979797; }
@media screen and (max-width:900px) { .container .demo div { margin-bottom: 0; } }
</style>
<script src="//cdnjs.cloudflare.com/ajax/libs/numeral.js/2.0.6/numeral.min.js"></script>
<script src="<c:url value='/js/jquery-1.12.4.js'/>"></script>
<!-- 참고 API : http://postcode.map.daum.net/guide -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
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
	var email = "<%=email%>";
	var cartSize = "<%=cartListSize%>";

	$(function() {
		init();
		
		//주문자 정보와 동일 체크박스 눌렀을 때	
		$('input#deliveryAddr').on("change", addr_same);
		
		//기본 배송지로 저장 체크박스 눌렀을 때
		$('input#defaultDeliveryAddr').on("change", default_AddrSet);

		$('input[name=amount]').on('click', function() {
			priceCalc();
		});
		
		$('input#zipcode').on('click', searchZipcode);
		$('input#address1').on('click', searchZipcode);
		
		$('input#btnOrder').on('click', goToOrderCompl);
	})
	
	function goToOrderCompl() {
		if($('input#recipient').val() == "") {
			alert('받는 분 성함을 입력해주세요');
			$('input#recipient').focus();
		} else if($('input#phone21').val() == "" || $('input#phone22').val() == "" || $('input#phone23').val() == "") {
			alert('전화번호를 정확히 입력해주세요');
			$('input#phone22').focus();
		} else if($('input#zipcode').val() == "") {
			alert('배송지 주소를 입력해주세요');
			$('input#zipcode').focus();
		} else {
			var form = document.getElementById('orderCompl');
			
			form.method = "POST";
			form.action= "/PCos/orderComplete";
			form.submit();
		}
	}
	
	
	//화면 최초 로드 시
	function init() {
		$('#email').val(email);
		$('#orderName').val("${member.name}");
		
		var phone = "${member.phone}";
		$('#phone11').val(phone.substring(0,3));
		$('#phone12').val(phone.substring(3,7));
		$('#phone13').val(phone.substring(7,11));
		
		priceCalcInit();
	}
	
	function priceCalcInit() {
		var totalPrice = 0;
		
		// 금액 계산
		for(var k = 0; k < cartSize; k++) {
			var price = $('span#priceTot_' + k).text();
			price = price.replace(/[^\d]+/g, '');
			price = parseInt(price);

			totalPrice = totalPrice + price;
		}
		
		$('#total').text(numeral(totalPrice).format('0,0'));
	}
	
 	function priceCalc() {
		var totalPrice = 0;
		for(var j = 0; j < cartSize; j++) {
			//각 항목 수량 증감하면 각 항목별 수량 * 금액 값 넣기
			$('input#amount_' + j).on('click', function() {
				var amount = $(this).val();
				
				var price = $(this).parent().next().find("span").text();
				price = price.replace(/[^\d]+/g, ''); //천단위 제거
         
				var priceTot = amount * price;
				$(this).parent().next().next().find("strong > span").text(numeral(priceTot).format('0,0') + "원");
				
				//각 항목 체크하면 총합에 계산된 값 넣기
				for(var k = 0; k < cartSize; k++) {
					var price = $('span#priceTot_' + k).text();
					price = price.replace(/[^\d]+/g, '');
					price = parseInt(price);

					$('#priceTots_' + k).val(price);
					totalPrice = totalPrice + price;
				}
				$('#total').text(numeral(totalPrice).format('0,0'));
			});
		}
	}
	
	//주문자 정보와 동일 체크박스 눌렀을 때
	function addr_same() {
 		if($("input#deliveryAddr").is(":checked")) {
			$('input#recipient').val($('#orderName').val());
			$('input#phone21').val($('#phone11').val());
			$('input#phone22').val($('#phone12').val());
			$('input#phone23').val($('#phone13').val());
			$('input#zipcode').val('${member.zipcode}');
			$('input#address1').val('${member.address1}');
			$('input#address2').val('${member.address2}');

			$('input#recipient').prop('readonly', true);
			$('input#phone22').prop('readonly', true);
			$('input#phone23').prop('readonly', true);
			$('input#zipcode').prop('readonly', true);
			$('input#address1').prop('readonly', true);
			
			$('#deliveryAddrVal').val("true");
		} else {
			$('input#recipient').val('');
			$('input#phone21').val('010');
			$('input#phone22').val('');
			$('input#phone23').val('');
			$('input#zipcode').val('');
			$('input#address1').val('');
			$('input#address2').val('');

			$('input#recipient').prop('readonly', false);
			$('input#phone22').prop('readonly', false);
			$('input#phone23').prop('readonly', false);
			$('input#zipcode').prop('readonly', false);
			$('input#address1').prop('readonly', false);
			
			$('#deliveryAddrVal').val("false");
		}
	}
	
	//기본 배송지로 저장 체크박스 선택 시
	function default_AddrSet() {
		//주문하기 버튼 누를 때 처리
 		if($("input#defaultDeliveryAddr").is(":checked")) {
			$('#defaultDeliveryAddrVal').val("true");
		} else {
			$('#defaultDeliveryAddrVal').val("false");
		}
	}

</script>
</head>

</head>
<body id="top">
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
				<li><a href="">Order</a></li>
				<li><a href="">Payment</a></li>
			</ul>
		</div>
	</div>

	<div class="wrapper row3">
		<main class="hoc container clear">
		<div class="content">
			<h1>
				<strong>주문/결제 화면</strong>
			</h1>

			<!-- <form method="POST" action="/PCos/orderComplete"> -->
			<form id="orderCompl">
				<div class="cart">

					<div class="cart-bottom">
						<div class="table">
							<table style="text-align: center">
								<thead>
									<tr class="main-heading">
										<th style="width: 20%">Images</th>
										<th style="width: 30%">Product Name</th>
										<th style="width: 10%">Amount</th>
										<th style="width: 15%">Price</th>
										<th style="width: 15%">Total</th>
									</tr>
								</thead>
								<tbody id="cartList">
									<%
										for (int i = 0; i < cartListSize; i++) {
									%>

									<tr>
										<td>
											<input type='hidden' name="cartNo" value='<%= cartNos[i] %>' />
											<img src='<%= images[i] %>' />
										</td>
										<td>
											<span><%= productNames[i] %></span>
											<input type='hidden' name="productCode" value='<%= productCodes[i]%>' />
										</td>
										<td>
											<input min="1" type="number" id="amount_<%= i %>" name="amount" value="<%= amounts[i] %>" style='width: 50px'>
										</td>
										<td>
											<span><%= prices[i] %>원</span>
											<input type='hidden' name='price' value='<%= prices[i].replace(",", "")%>' />
										</td>
										<td>
											<strong><span id="priceTot_<%= i %>"><%= priceTots[i] %>원</span></strong>
											<input type='hidden' name='priceTot' value='<%= priceTots[i] %>' />
										</td>
									</tr>

									<%
										}
									%>

								</tbody>
							</table>
						</div>
					</div>
				</div>


				<h3>주문자 정보</h3>
				<table>
					<tr>
						<th><label for='orderName'>주문자명</label></th>
						<td><input type="text" id='orderName' name="orderName" required readonly/></td>
					</tr>
					<tr>
						<th>휴대폰</th>
						<td class='formtd'>
							<input type='tel' size="2" id='phone11' name="phone11" value='010' maxlength="3" readonly/>-
							<input type='tel' size="3" id='phone12' name="phone12" maxlength="4" readonly/>-
							<input type='tel' size="3" id='phone13' name="phone13" maxlength="4" readonly/>
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td><input type='text' id='email' name="email" readonly/></td>
					</tr>
				</table>
				<br /> <br />

				<h3>배송지 정보</h3>
				<div class='formtd'>
					<input type='checkbox' id='deliveryAddr' name="deliveryAddr" />&nbsp;
					<label for='deliveryAddr'>주문자 정보와 동일</label>
					<input type="hidden" id="deliveryAddrVal" name="deliveryAddrVal" />
				</div>
				<table>
					<tr>
						<th><label for='recipient'>받는 분</label></th>
						<td><input type='text' id='recipient' name="recipient" /></td>
					</tr>
					<tr>
						<th>휴대폰</th>
						<td class='formtd'>
							<input type='tel' size="2" id='phone21' name="phone21" value='010' maxlength="3" readonly/>-
							<input type='tel' size="3" id='phone22' name="phone22" maxlength="4" />-
							<input type='tel' size="3" id='phone23' name="phone23" maxlength="4" />
						</td>
					</tr>
					<tr>
						<th>배송지</th>
						<td>
							<table id='detailAddress'>
								<tr>
									<td class='formtd' rowspan="2"><input type='text' id='zipcode' name="zipcode" placeholder="우편번호" readonly /><br />
										<input type='button' onclick='searchZipcode()' value='우편번호 찾기' />&nbsp;
									</td>
								</tr>
								<tr>
									<td>
										<input type='text' id='address1' name="address1" placeholder="주소" readonly />
										<input type='text' id='address2' name="address2" placeholder="상세 주소를 입력해주세요." />
									</td>
							</table>
						</td>
					</tr>
				</table>

				<div class='formtd'>
					<input type='checkbox' id='defaultDeliveryAddr' />&nbsp;
					<label for='defaultDeliveryAddr'>기본 배송지로 저장</label>
					<input type="hidden" id="defaultDeliveryAddrVal" name="defaultDeliveryAddrVal" />
				</div>
				<br /> <br />

				<div class='formtd'>
					<label for='comments'>배송 요청사항</label>&nbsp;&nbsp;
					<input type='text' id='comments' name="comments">
				</div>

				<hr />
				<br /> <br />
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
				<br /> <br />

				<div class='formtd'>
					<label for='paymentMethod'>결제 수단</label>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type='radio' id='paymentMethod' checked />카드 결제
				</div>
				<br /> <br />

				<div id='btn'>
					<input type='button' id='btnCancel' value="취소하기" onclick="javascript:history.go(-1);" />
					<input type='button' id='btnOrder' value="주문하기" />
				</div>
			</form>
		</div>
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