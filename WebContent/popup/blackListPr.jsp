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
#blackLstEnd{
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
<div id="header"><h2>블랙리스트 등록</h2></div>
<div id="content">
<table id="blackLstT">
<tr><th >아이디</th><td><input type="text" name="blackLstId" style="width:300px;  text-align:center; font-size:18px" required></td></tr>
<tr>
	<th>분류코드</th>
	<td>
		<select style="text-align:center">
		<option value="B001">댓글금지</option>
		<option value="B002" >글작성금지</option>
		<option value="B003">판매금지</option>
		<option value="B004">활동금지</option></select>
	</td>
</tr>
<tr><th>등록 종료 날짜</th><td><input type="date" id="blackLstEnd"/></td></tr>
<tr><th>관리자 아이디</th><td id="blackLstMId"></td></tr>
<tr><th>등록 사유</th><td><textarea  id="blackLstC"  placeholder="등록사유를 입력하세요" required></textarea></td></tr>
</table>
<button>등록</button>
</div>
</div>
</body>
<script>

	//등록한 관리자 아이디 세션값에서 가져오기
	var userId = "${sessionScope.loginId}";
	document.getElementById('blackLstMId').value=userId;
	
	var currDate = new Date().toISOString().substring(0,10);
	console.log("오늘 날짜 : ",currDate);
	
	// 블랙리스트 등록날짜 오늘날짜로 초기 설정
	document.getElementById('blackLstEnd').value = currDate;
    document.getElementById('blackLstEnd').min = currDate;
    
    //사유 선택시 기본 내용 전체 선택
    function SelectTextArea(textarea)
	{
	  document.getElementById("blackLstC").select();
	}


    
</script>
</html>