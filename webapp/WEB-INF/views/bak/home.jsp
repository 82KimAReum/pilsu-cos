<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<table border="1">
	<thead>
		<th>이메일</th>
		<th>이름</th>
		<th>나이</th>
		<th>성별</th>
		<th>피부 타입</th>
		<th>전화번호</th>
		<th>우편번호</th>
		<th>기본 주소</th>
		<th>상세 주소</th>
		<th>가입 여부</th>
	</thead>
	<tbody>
		<c:forEach items="${memberlist}" var="member">
			<tr>
				<td><a href="view/${member.email}">${member.email}</a></td>
				<td>${member.name}</td>
				<td>${member.age}</td>
				<td>${member.gender}</td>
				<td>${member.skintype}</td>
				<td>${member.phone}</td>
				<td>${member.zipcode}</td>
				<td>${member.address1}</td>
				<td>${member.address2}</td>
				<td>${member.regstat}</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

</body>
</html>
