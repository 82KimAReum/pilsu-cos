<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="email" value="${email}" />
<%
	String path = (String)session.getAttribute("path");
%>

<!DOCTYPE html>
<html>
<head>
<title>pcos | MyPage | Personal Information</title>
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
<!-- 참고 API : http://postcode.map.daum.net/guide -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="<c:url value='/js/jquery-1.12.4.js'/>"></script>
<script>
	function searchZipcode() {
		new daum.Postcode({
			oncomplete : function(data) {
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
				if (data.userSelectedType === 'R') {
					//법정동명이 있을 경우 추가한다.
					if (data.bname !== '') {
						extraAddr += data.bname;
					}
					// 건물명이 있을 경우 추가한다.
					if (data.buildingName !== '') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
					fullAddr += (extraAddr !== '' ? ' (' + extraAddr
							+ ')' : '');
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
	var email = "${email}";
	var path = "<%= path %>";

	function Enter_Check() {
		if (event.keyCode == 13) {
			if ($('#txtSearch').val() != "") {
				location.href = "/PCos/search/" + $('#txtSearch').val();
			} else {
				alert("검색어를 입력해주세요");
			}
		}
	}

	function changeYear(year) {
		var currentYear = parseInt(year);//선택한 해당연도
		var intNum = 2; //해당 연도에서 +,- 개수
		var selName = document.getElementById("ageYear"); //option추가할 select명
		
		var inHtml = "";
		//option 제거
		for (var j = selName.length - 1; j >= 0; j--) {
			selName.options[j] = null;
		}
		var j = 0;//options 값 세팅초기값

		// select에 options 넣기 IE6에서 제대로 작동
		for (var i = currentYear - intNum; i <= currentYear + intNum; i++) {
			selName.options[j] = new Option(i, i);
			if (currentYear == i) {
				selName.options[j].selected = true;
			}
			j++;
		}
	}

	$(function() {
		//마이 페이지 경로를 직접 들어왔을 때 path가 없음
		if(path == "null") {
			location.href = "/PCos/logout";
		}
		
		$("#email").val(email);
		$.ajax({
			url : "/PCos/myInfo/" + email + ".",
			dataType : "json",
			method : "GET",
			success : function(data) {
				if(data.code) {
					var member = data.data;
					$("#name").val(member.name);
					$("#phone1").val(member.phone.substring(0, 3));
					$("#phone2").val(member.phone.substring(3, 7));
					$("#phone3").val(member.phone.substring(7));
					$("#ageYear").val(member.ageYear);
					$('input:radio[name=gender]:input[value=' + member.gender + ']').attr("checked", true);
					$('input:radio[name=skintype]:input[value=' + member.skintype + ']').attr("checked", true);
					$("#zipcode").val(member.zipcode);
					$("#address1").val(member.address1);
					$("#address2").val(member.address2);
				}
			}
		});

		var thisDate = new Date();
		var currentYear = thisDate.getFullYear(); //현재년도
		var selName = document.getElementById("ageYear"); //option추가할 select명

		//option 태그를 생성해서 select에 넣기
		for (var i = currentYear; i >= 1930; i--) {
			var opt = document.createElement("option"); //option 태그 생성
			opt.value = i;
			if (i == currentYear) {
				opt.selected = "selected";
			}
			opt.appendChild(document.createTextNode(i)); //option 태그에 텍스트 추가
			selName.appendChild(opt); // select 태그에 추가
		}

		$("#submit").click(function() {
			$.ajax({
				url : "/PCos/personalInfo",
				method : "POST",
				dataType : "json",
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify({
					"email" : email,
					"name" : $("#name").val(),
					"phone" : $("#phone1").val() + $("#phone2").val() + $("#phone3").val(),
					"ageYear" : $("#ageYear").val(),
					"gender" : $("input[name='gender']:checked").val(),
					"skintype" : $("input[name='skintype']:checked").val(),
					"zipcode" : $("#zipcode").val(),
					"address1" : $("#address1").val(),
					"address2" : $("#address2").val()
				}),
				success : function(data) {
					if (data.code == "insert") {
						alert("환영합니다! " + $("#name").val() + "님 :-)");
						location.href = "/PCos/logout";
					} else {
						alert("수정 완료되었습니다. 다시 로그인 해주세요");
						location.href = "/PCos/logout";
					}
				}
			});
		});

		$('input#zipcode').on('click', searchZipcode);
		$('input#address1').on('click', searchZipcode);

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
	<div class="bgded overlay" style="background-image: url('./images/backgrounds/cosmetic10.jpg');">
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
				<li><a href="/PCos/mypage">My Page</a></li>
				<li><a href="/PCos/personalInfo">Personal Information</a></li>
			</ul>
		</div>
	</div>
	<!-- End Top Background Image Wrapper -->

	<div class="wrapper row3">
		<main class="hoc container clear"> <!-- main body -->
		<div class="content">
			<h1>개인정보 수정</h1>

			<form method="GET" action="">
				<table>
					<tr>
						<th>이메일</th>
						<td><input type='text' id='email' readonly /></td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input type='text' id='name' /></td>
					</tr>
					<tr>
						<th>휴대폰</th>
						<td class='formtd'>
							<input type='tel' id="phone1" maxlength="3" size="2" value='010' readonly/>-
							<input type='tel' id="phone2" maxlength="4" size="3" />-
							<input type='tel' id="phone3" maxlength="4" size="3" />
						</td>
					</tr>
					<tr>
						<th>나이</th>
						<td class='formtd'>
							<select id="ageYear"></select>년생
						</td>
					</tr>
					<tr>
						<th>성별</th>
						<td class='formtd'>
							<div class="btn-group btn-group-toggle form-control"
								data-toggle="buttons">
								<label class="btn btn-success" role="button" aria-pressed="false">
									<input type="radio" name="gender" value="M">남성
								</label>
								<label class="btn btn-secondary" role="button" aria-pressed="false">
									<input type="radio" name="gender" value="F">여성
								</label>
							</div>
						</td>
					</tr>
					<tr>
						<th>피부타입</th>
						<td class='formtd'>
							<div class="btn-group btn-group-toggle form-control"
								data-toggle="buttons">
								<label class="btn btn-success" role="button" aria-pressed="false">
									<input type="radio" name="skintype" value="지성">지성
								</label> <label class="btn btn-secondary" role="button" aria-pressed="false">
									<input type="radio" name="skintype" value="건성">건성
								</label> <label class="btn btn-secondary" role="button" aria-pressed="false">
									<input type="radio" name="skintype" value="복합성">복합성
								</label>
							</div>

						</td>
					</tr>
					<tr>
						<th>배송지</th>
						<td>
							<table id='detailAddress'>
								<tr>
									<td class='formtd' rowspan="2"><input type='button'
										value='주소검색' onclick="searchZipcode();" />&nbsp; <input
										type='text' id='zipcode' readonly /><br /></td>
								</tr>
								<tr>
									<td><input type='text' id='address1' readonly /> <input
										type='text' id='address2' placeholder="상세 주소를 입력해주세요." /></td>
							</table>
						</td>
					</tr>
				</table>
				<div class="group btmspace-10 demo">
					<div class="one_half first" id="reset">다시 쓰기</div>
					<div class="one_half" id="submit">제출하기</div>
				</div>
			</form>
		</div>

		<!-- / main body --> </main>
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
							<p class="nospace">소비자 컨펌을 기반으로 한 운영 방식에서 전세대 광고 형식을 탈피, 업계
								선의 경쟁을 주도하는 기업으로 선정</p>
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