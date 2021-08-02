<%@ page import="com.gg.dto.GGDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
    
	#mainHeader{
	z-index: 1000;
	}
	#main {
	/* background-color: gray; */
	width:1200px;
	height:auto;
	position: absolute;
	top:150px;
	z-index: -1;
	}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

</script>
</head>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
    <div id="wrap">
    	<h3>커뮤니티</h3>
    	<input type = text value = ${dto.u_nname }>유저 닉네임
    	<input type = text value = ${dto.u_newName }>유저 사진 이름
    	<input type = text value = ${dto.p_no }>글 번호
    	<input type = text value = ${dto.p_title }>글 제목
    	<input type = text value = ${dto.p_content }>글 내용
    	<input type = text value = ${dto.p_tm }>작성 시간
    	<input type = text value = ${dto.p_view }>조회수
    	<input type = text value = ${dto.i_newName }>글 사진 이름
    </div>
    </div>
</body>
<script>

</script>
</html>