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
*{margin:0;padding:0;border-width:0;list-style-type:none;}
body{width:100%;background-color:gray;}
#wrap{width:900px;height:650px;background-color:white;position:relative;}
#header{/* background-color:blue */ text-align:center;  width:900px; height:50px; position:absolute; top:15px} 

#blackLstT, #blackLstT th, #blackLstT td{
	text-align:center;
	padding:10px;
	border:1px solid black;
	border-collapse:collapse;
	font-size:17px;
}
#blackLstT{
	width: 700px;
	height:450px;
	left:100px;
	top:70px;
	position:absolute;
}
#blackLstT select {
	text-align-last:center;
	text-align: center;
	font-size:17px
}
#b_endtm{
	text-align:center;
	font-size:17px
}
textarea{
	width:450px;
	height:150px;
	resize:none;
	font-size:17px
}

</style>
</head>
<body>
<div id="wrap">
<div id="header"><h2>블랙리스트 상세보기</h2></div>
<div id="content">
<table id="blackLstT">
<tr><th >아이디</th><td style="width:450px; text-align:center; font-size:17px">${dto.b_id }</td></tr>
<tr><th>등록 날짜</th><td>${dto.b_starthr }</td></tr>
<tr><th>등록 종료 날짜</th><td>${dto.b_endhr }</td></tr>
<tr><th>관리자 아이디</th><td>${dto.b_adminId }</td></tr>
<tr><th>등록 사유</th><td>${dto.b_content }</td></tr>
</table>
</div>
</div>
</body>
<script>
var msg = "${msg}";
if(msg!=""){
	alert(msg);
}


</script>
</html>