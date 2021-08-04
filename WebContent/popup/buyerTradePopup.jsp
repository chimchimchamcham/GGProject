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
#trade_cancel{display:inline-block; width:80px;height:35px; position:absolute; top:10px; left:10px; font-size:0.8rem; border-radius:5px/5px;background-color:#919999;color:white;}
#report{display:inline-block; width:80px;height:35px; position:absolute; top:10px; left:100px; font-size:0.8rem; border-radius:5px/5px;}

#condition{position:relative; left: 250px; top:15px; color:#C1C6C6}
#send,#approval,#shipping,#receive{display:inline-block; position:absolute;} 
#approval{left:100px}
#shipping{left:200px}
#receive{left:300px}

#imgDiv{left:130px; top:100px; position:relative; background-color:pink; width:200px; height:200px}
.img{display:block; width:180px; height:180px; position:absoulte;}
#img_condition{position:relative; left:10px}
#s_a_code{display:inline-block;background-color:#C1C6C6;border-radius:5px/5px;text-align:center;font-size:0.8rem; width:60px}

#subject{display:inline-block; font-size:0.8rem;}
#content{position:absolute; left:380px; top:100px;width:300px;height:200px;background-color:green;}

#send_price{display:inline-block; position:relative; top:10px;left:30px;width:190px;height:50px;text-align:center;font-weight:500;font-size:2.5rem;border:1px solid gray;border-radius:5px/5px;padding-left:10px;padding-right:40px;}
.p{font-size:2.5rem; position:absolute; top:30px;left:230px }
#remainPoint{position:relative;top:25px;background-color:#C1C6C6;border-radius:5px/5px;text-align:center;}
#sendTwoBtn{position:relative; top:50px;background-color:blue; width:200px; left:55px}
#sendTwoBtn>button{width:60px; height:35px; border-radius:5px/5px;font-size:0.7rem;}

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
		<div id="img_condition">
			<div id="s_a_code">판매중</div>
			<p id="subject">아이패드 파우치</p>
		</div>
	</div>
	
	<div id="content">
		<div id="top_content"><span>애플</span>님에게 <span>승인요청</span>중..</div>
		<div id="writePoint"><input type="text" name="send_price" id="send_price" value="5500"></div>
		<span class="p"><b>P</b></span>
		<div id="remainPoint"><span>둘리</span>님의 잔여 포인트 : <span>25000</span>P</div>
		<div id="sendTwoBtn">
			<button id="sendY">송금</button>
			<button id="receiveY">수취확인</button>
			<button id="chargeBtn">포인트 충전</button>
		</div>
	</div>
	
	
</div>

</body>
</html>