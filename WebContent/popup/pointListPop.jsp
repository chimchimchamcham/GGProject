<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트 내역</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
#myPoint {
	display: inline;
}
h2 {
	text-align: center;
}

table {
	width: 734.2px;
	margin: auto;
	text-align: center;
}

td {
	margin: 20px;
}

td {
	border-bottom: 2px solid gray;
}

button {
	width: 120px;
	height: 30px;
	border-radius: 5px;
	background-color: lightblue;
}

#pointPop {
	width: 120px;
	height: 30px;
	border-radius: 5px;
	background-color: lightgray;
	font-weight: bold;
}
</style>
</head>
<script type="text/javascript">
	$(document).ready(function() {
		var loginId = "${sessionScope.loginId}";
		console.log("로그인 아이디 확인 ", loginId);
		var param = {};
		param.id = loginId;
		
		$.ajax({
			type : "POST",
			url : "../pointList",
			data : param,
			dataType : "JSON",
			success : function(data) {
				console.log("야호");
			},
			error : function(e) {
				console.log("에러");
				console.log(e);
			}

		});

	});
</script>
<body>
	<h2>포인트 내역</h2>
	<hr />
	<table>
		<tr>
			<td>포인트 내역</td>
			<td>포인트</td>
			<td>사진</td>
			<td>글 제목</td>
			<td>작성일</td>
		</tr>
		<c:if test="${list eq null || list eq '' }">
			<tr>
				<td colspan="5">해당 데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach items="${list}" var="bbs">
			<tr>
				<td>포인트사용내역</td>
				<td>사용한 포인트</td>
				<td><a href="#"><img src="#"/>aa</a></td>
				<td><a href="#">제목</a></td>
				<td>거래 완료일</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan="3"><b>총 보유 포인트 : </b></td>
			<td><button>
					<b>충전</b> <!-- 충전 팝업 실행-->
				</button></td>
				<!-- 포인트 인출 팝업 -->
			<td><input type='button' value='인출' id='pointPop' /></td>
			
		</tr>
	</table>


</body>
<script>
	
</script>
</html>