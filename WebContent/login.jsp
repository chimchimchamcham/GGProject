<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
*{margin:0;padding:0;border-width:0;list-style-type:none;}
    body{width:100%;}
div,input{margin:10px;
}
span{
	position:relative;
	float:left;
}
div#outLine{
	background-color : gray;
	position:absolute;
	top:60%;
	left:50%;
	transform:translate(-50%, -50%);
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

#loginbox{
	width:270px;
	height:70px;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div id="logo"></div>
	<div id ="head">로그인 페이지</div>
	<div id = "outLine">
		<form action ="/login" method ="post" id="loginbox">
			<input id="idbox" type="text" name = "loginId" placeholder = "아이디"/><span>아이디를 입력하세요</span>
			<input id="pwbox"  type="password" name = "loginPw" placeholder  = "비밀번호"/><span>비밀번호를 입력하세요</span>
		</form>
	</div>
</body>
</html>