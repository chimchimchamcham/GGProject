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
	height:auto;
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
		<a href = "myPage?id=123">123프로필로 연결</a>
		<a href = "#" onclick= notifyPop()>신고하기</a>
<<<<<<< HEAD
		<a href = "commUpdateForm?P_no=61">커뮤니티 글 수정</a>
=======
		<a href = "commDetail?P_no=6";>커뮤니티 글 상세보기</a>
>>>>>>> 06463c6c58249df91eb31947ce1a14f3b74f7625
	</div><!-- div main end -->
</body>
<script>
	function notifyPop() { window.open("./popup/notifyPopup.jsp", "notify", "width=500, height=700, left=600, top=200"); }
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
		msg = "";
	};
</script>
</html>