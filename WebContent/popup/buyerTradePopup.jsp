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
#wrap{width:900px;height:600px;background-color:white;position:relative;}
#twoButton{position:relative; width:200px;}
#trade_cancel{display:inline-block; width:80px;height:35px; position:absolute; top:10px; left:10px; font-size:0.8rem; border-radius:5px/5px;}
#report{display:inline-block; width:80px;height:35px; position:absolute; top:10px; left:100px; font-size:0.8rem; border-radius:5px/5px;}

#condition{position:relative; left: 250px; top:15px; color:#C1C6C6}
#send,#approval,#shipping,#receive{display:inline-block; position:absolute;} 
#approval{left:100px}
#shipping{left:200px}
#receive{left:300px}
#imgDiv{left:130px; top:100px; position:relative}

.img{display:block; width:150px; height:150px; position:absoulte}
#s_a_code{display:inline-block;background-color:#C1C6C6;border-radius:5px/5px;text-align:center;}

#subject{display:inline-block;}
#content{position:absolute; left:380px; top:100px}

</style>
</head>
<body>
<div id="wrap">
	<div id="twoButton">
		<input type="button" id="trade_cancel" value="거래취소"/>
		<input type="button" id="report" value="신고하기"/>
	</div>

	<div id="condition">
		<div id="send"><b>송금 &nbsp;&nbsp;&nbsp;&nbsp;→</b></div>
		<div id="approval"><b>승인&nbsp;&nbsp;&nbsp;&nbsp;→</b></div>
		<div id="shipping"><b>배송&nbsp;&nbsp;&nbsp;&nbsp;→</b></div>
		<div id="receive"><b>수취확인</b></div>
	</div>
	
	<div id="imgDiv">
		<img class="img" src="../img/notebook.PNG"/>
		<div id="s_a_code">판매중</div>
		<p id="subject">아이패드 파우치</p>
	</div>
	
	<div id="content">
		<span>애플</span>님에게 <span>승인요청</span>중..
	</div>
</div>

</body>
</html>