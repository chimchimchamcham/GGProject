<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#myPoint, #myNname {
	display: inline;
}
h2 {
	text-align: center;
}
</style>
</head>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
var myPoint =0;
	$(document).ready(function() {
		
		$("#cancelBtn").click(function() {
			alert("포인트 인출이 취소되었습니다.");
			
			window.close();
		});

		console.log("야호");
		var loginId = "${sessionScope.loginId}";
		console.log("로그인 아이디 확인 ", loginId);
		var param = {};
		param.id = loginId;
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
<body>
	<h2>인출 팝업</h2>
		<table>
			<tr>
				<td>인출 금액 : <input type="text" name="outPoint" value=0 />P <input
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
					<button type='button'>인출</button> <input type="button"
					id="cancelBtn" value="취소" />
				</td>
			</tr>
		</table>
</body>
<script>
var param = {};
param.id = "${sessionScope.loginId}";
	$("input[name='outPoint']").keyup(function(e) {
		if (!(e.keyCode >= 37 && e.keyCode <= 40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi, ''));
		}
	});
	$("button[type='button']").click(
			function() {

				if ($("input[name='outPoint']").val() == ""
						|| $("input[name='outPoint']").val() == 0 || Number($("input[name='outPoint']").val()) >Number(myPoint)) {
					alert("정확한 금액을 입력해 주세요!");
					$("input[name='outPoint']").focus();
				}else {
					param.outPoint = $("input[name='outPoint']").val();
					console.log("인출할 포인트  :" , param.outPoint);
					$.ajax({
						type : "POST",
						url : "../outPoint",
						data : param,
						dataType : "JSON",
						success : function(data) {
							console.log(data.success);
							if (data.success) {
								alert("포인트 인출 성공 ");
								opener.parent.location.reload();
								window.close();
							} else {
								alert("인출에 실패하였습니다.");
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