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

.alaramBox {
	width: 370px;
	background-color: yellow;
}

#buttonTwo{
	width: 370px;
	margin: 0px auto;
	background-color: green;
}


</style>
<body>
	<h2>알람</h2>
	<div id="alarmList">
		<div id="buttonTwo">
			<button id="allAL">전체알람</button>
			<button id="importAL">중요알람</button>
		</div>
		<table class="alaramBox">
			<tr>
				<td>내용</td>
				<td>시간</td>
			</tr>
		</table>

	</div>
</body>
<script>
	
</script>
</html>