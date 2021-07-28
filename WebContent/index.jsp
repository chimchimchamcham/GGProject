<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
<style type="text/css">
#mainHeader{
	z-index: 1000;
}
#main {
	background-color: gray;
	width:1200px;
	height:2000px;
	position: absolute;
	top:150px;
	z-index: -1;
}

</style>
</head>
<body>
<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
		<h2>메인페이지</h2>
		<a href="salesDetail.jsp?P_no=10">타인 판매 상세보기</a>
		<a href="salesDetailSalerPosition.jsp">내 판매글 상세보기</a>
	</div>
</body>
</html>