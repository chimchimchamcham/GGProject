<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알람</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
</style>
</head>
<style>
h2 {
	text-align: center;
}

#alarmWrap {
	width: 380px;
	/* text-align: center; */
	margin: 0px auto;
	/* background-color: blue; */
}

.content {
	/* background-color: yellow; */
	/* 	text-align: center; */
	display: inline-block;
	margin-top: 30px;
	
}

.content td {
	width: 380px;
	display: inline-block;
	/* border: 1px solid black; */
}

#buttonTwo {
	width: 380px;
	/* background-color: green; */
	text-align: center;
	display: inline-block;
}

#buttonTwo button {
	width: 70px;
	text-align: center;
	margin: 0px auto;
	display: inline-block;
}

/*읽었을때*/
.read{
	opacity: 0.3;
}

</style>
<body>
	<h2>알람</h2>
	<div id="alarmWrap">
		<div id="buttonTwo">
			<button id="allAL">전체알람</button>
			<button id="importAL">중요알람</button>
		</div>
		<table class="content">
			<tr>
				<td>닉네임님이 댓글을 달았습니다.</td>
			</tr>
			<tr>
				<td ><small>2021.08.06 13:43</small></td>
			</tr>
			<tr>
				<td style="border-bottom:1px solid black;"></td>
			</tr>
		</table>
	</div>
</body>
<script>
	
</script>
</html>