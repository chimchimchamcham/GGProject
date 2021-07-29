<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>충전 팝업</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<script type="text/javascript">
	$(document).ready(function() {

		$("#cancelBtn").click(function() {
			alert("포인트 충전이 취소되었습니다.");
			window.close();
		});

	});
</script>
<style>
h2 {
	text-align: center;
}
</style>
<body>
	<h2>포인트 충전</h2>
	<form action="./charge" method="POST">
		<table>
			<tr>
				<td>충전금액 : <input type="number" name="chargePoint" />P
				</td>
			</tr>
			<tr>
				<td>유저님의 현재 포인트 : 15000p</td>
			</tr>
		<tr>
		<td>
		<button>충전</button>
		<input type="button" id="cancelBtn" value="취소"/></td>
		</tr>
		</table>
	</form>
</body>
</html>