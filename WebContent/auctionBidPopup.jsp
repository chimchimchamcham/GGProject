<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	*{margin:0;padding:0;border-width:0;list-style-type:none;}
    body{width:100%;background-color:white;}
	#wrap{width:400px;height:200px;background-color:white;position:relative;}
	#wrap>div:nth-of-type(1){position:absolute;top:10px;left:20px;}
	#wrap>div:nth-of-type(1)>p{font-size:1.5rem;}
	
	#wrap>div:nth-of-type(2){position:absolute;top:60px;left:20px;line-height:50px;}
	#wrap>div:nth-of-type(2)>input{width:240px;height:50px;text-align:center;padding-right:30px;font-weight:700;font-size:2.5rem;border:1px solid gray;border-radius:5px/5px;}
	#wrap>div:nth-of-type(2)>span{font-weight:700;font-size:2.5rem;}
	#wrap>div:nth-of-type(2)>button{display:inline-block;margin-left:10px;width:90px;height:40px;color:white;background-color:#6E6E6E;font-size:1.1rem;border-radius:5px/5px;}
	
	#wrap>div:nth-of-type(3){position:absolute;top:140px;left:20px;}
	#wrap>div:nth-of-type(3)>div{display:inline-block;width:270px;height:40px;background-color:#BDBDBD;border-radius:5px/5px;text-align:center;font-weight:500;font-size:1.1em;line-height:40px;}
	#wrap>div:nth-of-type(3)>button{display:inline-block;margin-left:10px;width:90px;height:40px;color:white;background-color:#6E6E6E;border-radius:5px/5px;font-size:1.1rem;}
	
	#wrap>span{top:60px;left:260px;font-weight:700;font-size:2.5rem;position:absolute;}
	
	
	
	
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="wrap">
		<div><p>아이패드 파우치에 <b>입찰하기</b></p></div>
		<div><input type="text" name="point"><button>입찰</button></div>
		<div><div>둘리님의 잔여 포인트 5000P</div><button>포인트충전</button></div>
		<span>P</span>
	</div>
</body>
<script></script>
</html>