<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>충전 팝업</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
#myPoint{
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
		var loginId = "${sessionScope.loginId}";
		console.log("로그인 아이디 확인 " , loginId);
		var param= {};
		param.id = loginId;
		var myPoint = 110;
		$.ajax({
			type : "POST",
			url : "../pointPop",
			data: param,
			dataType : "JSON",
			success :function(data){
				console.log("잘 놀다갑니다.");
				console.log(data.success);
				console.log(data.myPoint);
				if(data.success){
					myPoint = data.myPoint;
					console.log("내포인트 : " ,myPoint);
					$("#myPoint").text(myPoint);
				}else{
					alert("페이지 로딩 중 오류가 발생하였습니다.");
				}
				
			},
			error : function(e){
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
	<form action="../charge" method="POST">
		<table>
			<tr>
				<td>충전금액 : <input type="number" name="chargePoint" value=0 />P
				</td>
			</tr>
			<tr>
				<td>${loginId }님 의 현재 포인트 : <p id="myPoint"></p>P</td>
			</tr>
			<tr>
				<td>
					<button type='button'>충전</button> <input type="button" id="cancelBtn" value="취소" />
				</td>
			</tr>
		</table>
	</form>
</body>
<script>
	$("button[type='button']").click(function(){
		
		if($("input[name='chargePoint']").val() == ""){
			alert("금액을 입력해 주세요!");
			location.href='./chargePopup.jsp';
		}
		
		
	});

</script>
</html>