<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
#mainHeader{
	z-index: 1000;
}
#main {
	width:1200px;
	height:auto;
	position: absolute;
	top:150px;
	z-index: -1;
	magin:0 auto;
	text-align:center;
}
</style>
<body>
<div id="mainHeader"><jsp:include page="header.jsp" /></div>
<div id="main">
<h3>커뮤니티</h3><label for="test">테스트</label><input type='checkbox' id="test">
<input type = "button" class ="category" value=" like('%')"/>
<input type = "button" class ="category" value="'C001'"/>구매대행
<input type = "button" class ="category" value="''C002"/>동네이야기
<input type = "button" class ="category" value="'C003'"/>같이해요
<input type = "button" class ="category" value="'C004'"/>자랑해요
<input type = "button" class ="category" value="'C005'"/>공유해요
<input type = "button" class ="category" value="'C006'"/>잡담해요
<input type = "button" class ="category" value="'C007'"/>홍보해요
	<c:forEach items="${list }" var="item">
		<div>
			<span>${item.c_name}</span>&nbsp;&nbsp;&nbsp;&nbsp;
			<span>${item.u_id}</span>&nbsp;&nbsp;&nbsp;&nbsp;
			<span>${item.u_nname}</span>&nbsp;&nbsp;&nbsp;&nbsp;
			<span>${item.p_title}</span>&nbsp;&nbsp;&nbsp;&nbsp;
			<span>${item.p_tm}</span>&nbsp;&nbsp;&nbsp;&nbsp;
			<span>${item.p_view}</span>&nbsp;&nbsp;&nbsp;&nbsp;
		</div>
	</c:forEach>
</div>
</body>
</html>