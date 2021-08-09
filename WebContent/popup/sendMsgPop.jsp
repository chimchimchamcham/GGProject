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
	/* text-align: center; */
	margin: 0px auto;
	/* background-color: blue; */
}

.content {
	/* background-color: yellow; */
	/* 	text-align: center; */
	display: inline-block;
	/* background-color: yellow; */
	width: 460px;
	cursor: pointer;
	margin:10px 0 0 0;
}

.content img:hover{
opacity:0.9;
}

.tableWrap{
	text-align:center;
}
.tableWrap:hover{
background-color: #f7f7f7;
}

.content td{
	/* border: 1px solid black;  */
}

#buttonTwo {
	width: 500px;
	/* background-color: green; */
	text-align: center;
	display: inline-block;
	margin : 20px 0 30px 0;
}

#buttonTwo button {
	width: 90px;
	text-align: center;
	margin: 0px auto;
	display: inline-block;
}

a{
	text-decoration: none;
	color: black;
}
/*읽었을때*/
.read {
	opacity: 0.3;
}
</style>
<body>
	<h2>쪽지보내기</h2>
	<div id="msgWrap">
		<div id="buttonTwo">
			<button id="receiveBtn">받은 쪽지(20)</button>
			<button id="sendBtn">보낸 쪽지</button>
		</div>
		<div class="tableWrap">
		<table class="content">
				<tr>
					<td rowspan="2"><a href="#"><img src="../test/default-profile.png" width="60"></a></td>
					<th ><a href="#"><p style="width:310px;  padding:0 20px; text-align: left; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">안녕하세요? 이거 살려고하는데요^^하하하하하하하하</p></a></th>
					<td rowspan="2"><button class="delBtn">삭제</button></td>
				</tr>
				<tr>
					<td><p  style="width:310px; padding:0 20px; text-align: left;"><a href="#">보낸자</a> | 2021.08.06 13:45</p>
					</td>	
				</tr>
					<tr>
				<td style="border-bottom:1px solid black; padding-top:10px;" colspan="3"></td>
			</tr>
		</table>
		</div>
	</div>
</body>
<script>
	
	/*쪽지 삭제*/
	$(".delBtn").click(function(){
		console.log("쪽지 삭제");
	});
	
	
</script>
</html>