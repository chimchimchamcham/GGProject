<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
*{margin:0;padding:0;border-width:0;list-style-type:none;}
    body{width:100%;}
div,input{
	margin:10px;
}
div#outLine{
	background-color : gray;
	position:absolute;
	top:60%;
	left:50%;
	transform:translate(-50%, -50%);
	overflow:visible;
	width:270px;
}
div#head{
	background-color : gray;
	position:absolute;
	top:45%;
	left:50%;
	transform:translate(-50%, -50%);
	font-family : TmonMonsori, "GodoB", "굴림";
	font-size : 30px;
}
div#logo{
	background-color : gray;
	width:100px;
	height:100px;
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
	<div id="logo"><a href="index.jsp"><img src="img/logo2.png" width="100"></a></div>
	<div id ="head">로그인 페이지</div>
	<div id = "outLine">
		<form action ="/login" method ="post">
			<input id="idbox" type="text" name = "loginId" placeholder = "아이디"/>
			<input id="pwbox"  type="password" name = "loginPw" placeholder  = "비밀번호"/>
			<button style="margin:10px">로그인</button>
			<input type="button" onclick="location.href='joinForm.jsp'" value="회원가입"/>
			<a href="#" style = " font-size:12px;">아이디/비밀번호 찾기</a>
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