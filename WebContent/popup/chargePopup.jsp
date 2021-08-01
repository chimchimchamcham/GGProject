<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>충전 팝업</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
#myPoint {
	display: inline;
}
</style>
</head>
<script type="text/javascript">
	$(document).ready(function() {

		$("#cancelBtn").click(function() {
			alert("포인트 충전이 취소되었습니다.");
			window.close();
		});

		console.log("야호");
		var loginId = "${sessionScope.loginId}";
		console.log("로그인 아이디 확인 ", loginId);
		var param = {};
		param.id = loginId;
		var myPoint = 110;
		$.ajax({
			type : "POST",
			url : "../pointPop",
			data : param,
			dataType : "JSON",
			success : function(data) {
				console.log(data.success);
				console.log(data.myPoint);
				if (data.success) {
					myPoint = data.myPoint;
					console.log("내포인트 : ", myPoint);
					$("#myPoint").text(myPoint);
				} else {
					alert("페이지 로딩 중 오류가 발생하였습니다.");
				}

			},
			error : function(e) {
				console.log(e);
			}

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
	<form action="../charge" method="POST" id="charge">
		<table>

			<tr>
				<td>충전금액 : <input type="text" name="chargePoint" value=0 />P <input
					type='text' name='id' value=${loginId } hidden='hidden' />
				</td>
			</tr>
			<tr>
				<td>${loginId }님의 현재 포인트 :
					<p id="myPoint"></p>P
				</td>
			</tr>
			<tr>
				<td>
					<button type='button'>충전</button> <input type="button"
					id="cancelBtn" value="취소" />
				</td>
			</tr>
		</table>
	</form>
</body>
<script>
	$("input[name='chargePoint']").keyup(function(e) {
		if (!(e.keyCode >= 37 && e.keyCode <= 40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi, ''));
		}
	});
	$("button[type='button']").click(
			function() {

				if ($("input[name='chargePoint']").val() == ""
						|| $("input[name='chargePoint']").val() == 0) {
					alert("금액을 입력해 주세요!");
					$("input[name='chargePoint']").focus();
				} else {
					$("#charge").submit();
				}

			});
	var msg = "${sesssionScope.chargeSuccess}";
	if(msg != ""){
		alert(msg);
	}
</script>
</html>