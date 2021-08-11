<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">

div,input{
	margin:10px;
}
div#outLine{
	position:absolute;
	top:60%;
	left:50%;
	transform:translate(-50%, -50%);
	overflow:visible;
	width:350px;
	text-align:center;
}
div#head{
	position:absolute;
	top:45%;
	left:50%;
	transform:translate(-50%, -50%);
	font-size : 30px;
}
div#logo{
	width:250px;
	position:absolute;
	top:20%;
	left:50%;
	transform:translate(-50%, -50%);
}
#idbox,#pwbox{
	width:250px;
	height: 20px;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div id="logo"><a href="index.jsp"><img width="250" src="img/logo2.png" width="100"></a></div>
	<div id ="head"><b>로그인 페이지</b></div>
	<div id = "outLine">
		<form action ="login" method ="post">
			<input id="idbox" type="text" name = "loginId" placeholder = "아이디"/>
			<input id="pwbox"  type="password" name = "loginPw" placeholder  = "비밀번호"/>
			<button style="margin:10px">로그인</button>
			<input type="button" onclick="location.href='joinForm.jsp'" value="회원가입"/>
			<a href="idsearch.jsp" style = " font-size:12px;">아이디/비밀번호 찾기</a>
		</form>
	</div>
</body>
<script>
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
</script>
</html>