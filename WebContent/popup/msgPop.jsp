<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래톡</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
</style>
</head>
<style>
* {
	margin: 0;
	padding: 0;
}

h2 {
	margin-top: 20px;
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
	margin: 10px 0 0 0;
}

.content img:hover {
	opacity: 0.9;
}

.tableWrap {
	text-align: center;
}

#threeButton {
	width: 500px;
	/* background-color: green; */
	text-align: center;
	display: inline-block;
}


#threeButton button {
	width: 90px;
	text-align: center;
	margin: 0px auto;
	display: inline-block;
}

a {
	text-decoration: none;
	color: black;
}
/*읽었을때*/
.read {
	opacity: 0.3;
}
#threeButton button{
	margin:10px 10px;
}

</style>
<body>
	<h2>쪽지</h2>
	<div id="msgWrap">
		<div class="tableWrap">
				<div id="threeButton">
					<button onclick="./msgList">전체보기</button>
					<button onclick="./msgList?rOPs=s">보낸쪽지</button>
					<button onclick="./msgList?rOPs=r">받은쪽지</button>
				</div>
			<table class="content">
				<c:foreach>
					<tr>
						<td rowspan="2"><a href="#"><img src="../test/default-profile.png" width="60"></a></td>
						<th><a href="#"><p style="width: 280px; padding: 0 20px; text-align: left; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">안녕하세요?이거 살려고하는데요^^하하하하하하하하</p></a></th>
						<td rowspan="2"><button style="padding:3px" class="delBtn">삭제</button></td>
					</tr>
					<tr>
						<td>
							<p style="width: 280px; padding: 0 20px; text-align: left;"><a href="#">날짜</a> | 2021.08.06 13:45</p>
						</td>
					</tr>
					<tr>
						<td style="border-bottom: 1px solid black; padding-top: 10px;" colspan="3"></td>
					</tr>
				</c:foreach>
			</table>
		</div>
	</div>
</body>
<script>
	/*쪽지 삭제*/
	$(".delBtn").click(function() {
		
	});
	$("#receiveBtn").click(function(){
		
	});
	$("#sendBtn").click(function(){
		
	});
</script>
</html>