<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="data" value="${data }" />
<!DOCTYPE html>
<html>
<head>
<title>pcos | Search</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="/PCos/layout/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<link rel="icon" href="/PCos/resources/favicon.ico?v=2" type="image/x-icon">
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
  <script src="../js/jquery-1.12.4.js" ></script>
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
	
	
  	/* $(function(){
		var num=1;
		var categoryCode=1;
		var order=1;
	function ajax(){
  		$.ajax({
			url : "/PCos/category/"+categoryCode+"/"+order,
			dataType : "json",
			method : "GET",
			success : function(data){
				var data = data.data;
				var totalCount = data.length;
				var range=12;
				//페이징을 위해서 총 건 수를 한 페이지(12)에 맞게 나눠주기
				if(totalCount%range==0){
					var realSize=totalCount/range;
				} else{
					var realSize=parseInt(totalCount/range) +1;
					page(num);
				}
				var size=10;
				
				// 최대 페이지 만큼 뿌려주기(10개씩)
				function numbers(){
					var pageStr="";
					pageStr="<li id='first'><a>&laquo; 10Pages</a></li>";
					pageStr+="<li id='previous'><a>&lsaquo; Previous</a></li>";
					if(realSize>10 && size==10){
						var start=1;
						var end=size;
					} else if(size%10==0){
						var start=size-9;
						var end=size;
					} else{
						var start=1;
						var end=size;
					}
					
					pageStr+="<li id='"+start+"' class='current'><a>"+start+"</a></li>";
					for(var idx=start+1;idx<=end;idx++){
						if(idx>realSize) break;
						pageStr+="<li id='no"+idx+"'><a>"+idx+"</a></li>";
					}
					pageStr+="<li id='next'><a>Next &rsaquo;</a></li>";
					pageStr+="<li id='end'><a>10Pages &raquo;</a></li>";
					
					$("#numbers").html(pageStr);
				}
				
				//페이지 이동하기
				function page(num){
					var str = "";
					if(num == 0) {
						
					}else if(num > 0){
						var start=(num-1)*range;
						if(num*range>totalCount) var end=totalCount;
						else var end=num*range;
						for(var i =  start; i < end ; i++){
							if(i%4==0){
								var prod = data[i];
								str += "<li class='one_quarter first'><a href='../detail/"+prod.productCode+"'><img src='"+prod.image+"' alt=''>";
			                    str+="<span>"+prod.productName+"</span><br><span>￦"+numeral( prod.price ).format( '0,0' )+"</span></a></li>";
							} else{
							var prod = data[i];
							str += "<li class='one_quarter'><a href='../detail/"+prod.productCode+"'><img src='"+prod.image+"' alt=''>";
		                    str+="<span>"+prod.productName+"</span><br><span>￦"+numeral( prod.price ).format( '0,0' )+"</span></a></li>";
							}
						}
					}
					$("#results").html(str);
				}
				
				//최초 로딩시 1페이지와 페이지 순서 보여주기
				page(num);
				numbers();
				//
				$(".pagination ul li").click(function(){
					//10Pages 전으로!!!! 10페이지 전이면 1로 움직이기
					if($(this).attr("id")=="first"){
						$(".current").removeAttr("class");
						if(num<=10){
							num=1;
						} else{
							size=size-10;
							if(size>0)	numbers();
						}
						page(num);
						$("#no1").attr("class","current");
						
						//하나 전!!!
					} else if($(this).attr("id")=="previous"){
						$(".current").removeAttr("class");
						if(num==1){
							alert("이 페이지가 처음입니다."); 
						} else{
							num=num-1;
							if(num%10==0 && num!=0){
								size=size-10;
								if(size>0)	numbers();
							}
						}
						page(num);
						$("#no"+num).attr("class","current");
						
						//하나 후!!!
					} else if($(this).attr("id")=="next"){
						$(".current").removeAttr("class");
						num=num+1;
						if(num%10==1){
							size=size+10;
							numbers();
						}
						page(num);
						$("#no"+num).attr("class","current");
						
						//10Pages 후로!!!!!! 10페이지 전까지 있으면 가장 마지막 페이지 
					} else if($(this).attr("id")=="end"){
						if(realSize<=10){
							if(totalCount%range==0){
								$(".current").removeAttr("class");
								num=totalCount/range;
								page(num);
								$("#no"+num).attr("class","current");
							} else{
								if(realSize<=10){
									$(".current").removeAttr("class");
									num=parseInt(totalCount/range) +1;
									page(num);
									$("#no"+num).attr("class","current");
								}else{
									$(".current").removeAttr("class");
									num=parseInt((num+10)/10);
									page(num);
									$("#no"+num).attr("class","current");
								}
							}
						}else{
							$(".current").removeAttr("class");
							size=size+10;
							numbers();
							num=parseInt((num+10)/10)*10+1;
							page(num);
							$("#no"+num).attr("class","current");
						}
						
						//페이지를 직접적으로 눌렀을때
					}else{
						$(".current").removeAttr("class");
			  			num=parseInt($(this).attr("id").substring(2));
			  			page(num);
						$("#no"+num).attr("class","current");
					}
		  		})
			}
		}); 
		}
	
		ajax();
		
		$("div>div>div").click(function(){
			categoryCode=parseInt($(this).attr("id"));
			order=1;
			ajax();
		});
		//로딩시 바로 데이터 받아오기
		
		$(".order").click(function(){
			switch($(this).attr("id")){
				case "name": order=1; break;
				case "lowPrice": order=2; break;
				case "highPrice": order=3; break;
				case "grade": order=4; break;
			}
			ajax();
		});
		
		
  		
  		
  	}); */
  </script>
</head>
<body id="top">
<!-- Top Background Image Wrapper -->
<div class="bgded overlay" style="background-image:url('../images/backgrounds/cosmetic1.jpg');"> 
  <div class="wrapper row1">
    <header id="header" class="hoc clear">
      
        <div id="header1" >  
			<input type="text" value="" id="txtSearch" placeholder="검색어를 입력해주세요." onkeypress="if(event.keyCode==13) {Enter_Check(); return false;}"/>&nbsp;
			<a href="" id="enter"><img src="/PCos/images/small_images/search.png" class="smallIcon" id="searchIcon" title="검색" /></a>&nbsp;&nbsp;
			<a href="/PCos/cart"><img src="/PCos/images/small_images/cart.png" class="smallIcon" id="cartIcon" title="내 장바구니" /></a>&nbsp;
			<a href="/PCos/mypage"><img src="/PCos/images/small_images/mypage.png" class="smallIcon" id="mypageIcon" title="마이 페이지" /></a>&nbsp;
        </div>

        <div id="logo" class="fl_left">
          <a href="/PCos"><img src="../images/small_images/cos.png" class="title" id=""/></a>
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
      <li><a>Search</a></li>
    </ul>
  </div>
</div>
<!-- End Top Background Image Wrapper -->
<div class="wrapper row3">
  <main class="hoc container clear"> 
    <!-- main body -->
    <div id="gallery">
        <figure>
          <header class="heading">Results For Searching</header>
          <ul class="nospace clear" id="results">
           	<c:forEach items="${data }" var="prod">
           	<li class='one_half'>
           	<a href="../detail/${prod.productCode}"><img src="${prod.image}" alt=''><br>
           	<span>${prod.productName}</span><br><span>￦<fmt:formatNumber value="${prod.price}" pattern="#,###" /></span></a></li>

           	</c:forEach>
          </ul>
        </figure>
      </div>
      <nav class="pagination">
        <ul id="numbers">
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