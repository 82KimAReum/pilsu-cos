<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.pcos.vo.MemberVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="member" value="${data}" />

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
</script>
<%
	MemberVO member = (MemberVO)pageContext.getRequest().getAttribute("data");

	String path = "";

	if(member != null) {
		session.setAttribute("email", member.getEmail());
		session.setAttribute("name", member.getName());
		session.setAttribute("skinType", member.getSkintype());
		session.setAttribute("ageYear", member.getAgeYear());
	}

	path = (String)session.getAttribute("path");
/* 	if(path != null) {
		path = (String)session.getAttribute("path");
	} else {
		path = "";
	} */
%>

<script>
	location.href = "/PCos/" + "<%= path %>";
</script>