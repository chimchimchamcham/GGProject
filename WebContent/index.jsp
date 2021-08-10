<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
<style type="text/css">
body{
display: flex;
flex-direction: column;
}
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
	display: none;
}
#main a{
z-index: 2;
}
.auc-con{
	margin-top:30vh;
}
</style>
</head>
<body>
<div id="mainHeader"><jsp:include page="header.jsp" /></div>
<div id="main">
	<h2>메인페이지</h2>
	<a href="salesDetail?p_no=10">타인 판매 상세보기</a>
	<a href="salesDetailSalerPosition.jsp">내 판매글 상세보기</a>
	<a href = "myPage?id=123">123프로필로 연결</a>
	<a href = "#" onclick= notifyPop()>신고하기</a>
	<a href = "commUpdateForm?P_no=65">커뮤니티 글 수정</a>
	<a href = "commDetail?P_no=64">커뮤니티 글 상세보기</a>
</div><!-- div main end -->
    <div class="content">
    <c:if test="${mainlist eq null}">
    	<jsp:include page="mainpage.jsp"></jsp:include>
    </c:if>
    <c:if test="${mainlist eq 0}">
		<jsp:include page="sale_main_list.jsp"></jsp:include>
	</c:if>
    <c:if test="${mainlist eq 1}">
		<jsp:include page="auction_main_list.jsp"></jsp:include>
	</c:if>
	</div>
</body>
<script>


	function notifyPop() { window.open("popup/notifyPopup.jsp?N_receiveId=123", "notify", "width=500, height=700, left=600, top=200"); }
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
		msg = "";
	};
</script>
</html>