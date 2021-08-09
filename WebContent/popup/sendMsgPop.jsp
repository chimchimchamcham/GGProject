<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
*{
	margin:0;
	padding:0;
}
h2 {
margin-top:20px;
	text-align: center;
}
#tradeWrap {
	width: 500px;
	margin: 0px auto;
}
.content {
	display: inline-block;
	width: 420px;
	margin:30px;
}
.content img:hover{
	opacity:0.9;
}
.tableWrap{
	text-align:center;
}
a{
	text-decoration: none;
	color: black;
}
/*읽었을때*/
.read {
	opacity: 0.3;
}
textarea{
	overflow:hidden;
	width:380px;
	height:230px;
	resize:none;
	padding:20px;
}
</style>
<body>
	<h2>쪽지보내기</h2>
	<div id="msgWrap">
		<div class="tableWrap">
		<form action="sendMsg" method="GET">
			<table class="content">
				<tr>
					<td style="text-align:left"><a href="#"><img src="../test/default-profile.png" width="60"><b id="receiveId" style="font-size:25px;">&nbsp;&nbsp;To : &nbsp;</b></a></td>
				</tr>
				<tr>
					<td><textarea id="m_content" maxlength="1000" placeholder="내용을 입력해 주세요♥"></textarea></td>
				</tr>
				<tr>
					<td style="text-align:right; margin-top:30px;"><button style="padding:3px 10px;">보내기</button></td>
				</tr>
			</table>
		</form>
		</div>
	</div>
</body>
<script>
	
</script>
</html>