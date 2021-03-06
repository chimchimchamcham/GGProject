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
button{
	width:100px;
	height:50px;
	position:absolute;
	left:700px;
	top:550px;
	border-radius:5px/5px;
	font-size:17px;
}
</style>
<script>
$(document).ready(function(){
	//등록한 관리자 아이디 세션값에서 가져오기
	var userId = "${sessionScope.loginId}";
	document.getElementById("b_adminId").value=userId;
});
</script>
</head>
<body>
<div id="wrap">
<div id="header"><h2>블랙리스트 등록</h2></div>
<div id="content">
<form action="../blackLstPr" method="post" id="blackLstFrm">
<table id="blackLstT">
<tr><th >아이디</th><td><input type="text" name="b_Id" style="width:300px;  text-align:center; font-size:18px" value="${param.n_receiveid}"></td></tr>
<tr><th>등록 종료 날짜</th><td><input type="date" id="b_endtm" name="b_endtm"/></td></tr>
<tr><th>관리자 아이디</th><td ><span id="b_adminId"><input type="hidden" name="b_adminId" value="${sessionScope.loginId}"/>${sessionScope.loginId}</span></td></tr>
<tr><th>등록 사유</th><td><textarea  id="b_content"  placeholder="등록사유를 입력하세요" name="b_content"></textarea></td></tr>
</table>
<button type="button">등록</button>
</form>
</div>
</div>
</body>
<script>

	/* //등록한 관리자 아이디 세션값에서 가져오기
	var userId = "${sessionScope.loginId}";
	console.log(userId);
	document.getElementById('b_adminId').innerHTML=userId; */
	
	 //현재 날짜+1
    var setting = new Date();
    setting.setDate(setting.getDate()+2);
    console.log("내일",setting);
	
	// 블랙리스트 등록날짜 오늘날짜로 초기 설정

    document.getElementById('b_endtm').min = setting.toISOString().substring(0,10);
	
    //버튼 클릭시 항목이 구성되지 않으면 튕기는 기능
	$("button").click(function(){
		console.log("click!");
		 if($("textarea[name=b_content]").val() ==""){
    		alert("블랙리스트 등록 상세 사유를 입력하세요");
    		$("textarea[name=b_content]").focus();
    		return false;
    	}else{
			$("#blackLstFrm").submit();
		}
		
	})
	
	var msg = "${msg}";
	if("${success}" == true){
  		alert(msg);
	}
	
</script>
</html>