<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>충전 팝업</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
#myPoint, #myNname {
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
					nickname = data.nickname;
					console.log("내포인트 : ", myPoint);
					$("#myPoint").text(myPoint);
					$("#myNname").text(nickname);
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
		<table>
			<tr>
				<td>충전금액 : <input type="text" name="chargePoint" value=0 />P <input
					type='text' name='id' value=${loginId } hidden='hidden' />
				</td>
			</tr>
			<tr>
				<td><p id="myNname"></p>님의 현재 포인트 :
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
</body>
<script>
var param = {};
param.id = "${sessionScope.loginId}";

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
					param.chargePoint = $("input[name='chargePoint']").val();
					console.log("충전할 포인트  :" , param.chargePoint);
					$.ajax({
						type : "POST",
						url : "../charge",
						data : param,
						dataType : "JSON",
						success : function(data) {
							console.log(data.success);
							if (data.success) {
								alert("포인트 충전 여부 "+data.success);
								opener.parent.location.reload();
								window.close();
							} else {
								alert("충전에 실패하였습니다.");
							}
						},
						error : function(e) {
							console.log(e);
						}

					});
				}

			});
</script>
</html>