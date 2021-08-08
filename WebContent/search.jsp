<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
#mainHeader{
	position: relative;
	z-index: 1
}
#main {
	background-color: gray;
	width:1140px;
	height:auto;
	position: relative;
	top:150px;
	z-index: 0;
}
h2 {
	text-align: center;
	padding-bottom: 30px;
}
</style>
</head>
<body>
<div id="mainHeader"><jsp:include page="header.jsp" /></div>
<div id="main">
<h2>검색결과</h2>

</div><!-- div main end -->
</body>
</html>