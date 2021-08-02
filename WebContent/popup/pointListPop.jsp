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
<body>
	<h2>포인트 내역</h2>
	<hr />
	<table>
		<thead>
			<tr>
				<td>포인트 내역</td>
				<td>포인트</td>
				<td>사진</td>
				<td>글 제목</td>
				<td>거래 날짜</td>
			</tr>
		</thead>
		<tbody>
		</tbody>
		<tfoot>
		<tr>
			<td colspan="3"><b id='myPoint'></b></td>
			<td><button>
					<b>충전</b>
					<!-- 충전 팝업 실행-->
				</button></td>
			<!-- 포인트 인출 팝업 -->
			<td><input type='button' value='인출' id='pointPop' /></td>
		</tr>
		</tfoot>
	</table>
</body>
<script>
	var loginId = "${sessionScope.loginId}";
	console.log("로그인 아이디 확인 ", loginId);
	var param = {};
	param.id = loginId;
	function chargePopup() { window.open("./chargePopup.jsp", "charge", "width=600, height=500, left=600, top=200"); }
	listCall();
	$("button").click(function(){
		console.log("충전 버튼 클릭");
		chargePopup();
	});

	function listCall() {
	
		$.ajax({
			type : "POST",
			url : "../pointList",
			data : param,
			dataType : "JSON",
			success : function(data) {
				//console.log(data.list);
				console.log("마이 포인트 : " ,data.myPoint);
				drawList(data.list);
				myPoint(data.myPoint);
				
			},
			error : function(e) {
				console.log("에러");
				console.log(e);
			}

		});

	};
	function myPoint(myPoint){
		console.log("나의 최종 포인트 확인.");
		console.log(myPoint);
		$("#myPoint").empty();
		$("#myPoint").append("총 보유 포인트 : "+myPoint);
		
	};	
	
	function drawList(list) {
		console.log("드로우 리스트");
		console.log(list);
		var content = "";
		var pnt_code ="";
		var i_newName = "";
		console.log("forEach문")
		list.forEach(function(item, idx) {
			console.log(idx, item);
			if(item.Pntcode =="PNT001"){
				pnt_code = "충전";
			}else if(item.Pntcode =="PNT002"){
				pnt_code = "인출";
			}else if(item.Pntcode =="PNT003"){
				pnt_code = "구매";
			}else if(item.Pntcode =="PNT004"){
				pnt_code = "판매";
			}else if(item.Pntcode =="PNT005"){
				pnt_code = "거래취소";
			}else if(item.Pntcode =="PNT006"){
				pnt_code = "입찰금";
			}else if(item.Pntcode =="PNT007"){
				pnt_code = "입찰금반환";
			}else if(item.Pntcode =="PNT008"){
				pnt_code = "승인거부";
			}else if(item.Pntcode =="PNT009"){
				pnt_code = "미입금패널티";
			}else if(item.Pntcode =="PNT010"){
				pnt_code = "경매위자료";
			}
			console.log("글 번호 확인",item.p_no);
			
			content += "<tr><td>"+pnt_code+"</td>";
			content += "<td>" + item.pnt_point + "</td>";
			content += "<td id=''><a href='details?p_no="+item.p_no+ "'><img src='C:/photo/"+item.i_newName +"'/></td>";
			content += "<td><a href='details?p_no="+item.p_no+ "'>" + item.p_title + "</a></td>";
			content += "<td>" + item.pnt_tm + "</td></tr>";
		});
		$("tbody").empty();
		$("tbody").append(content);
		
	}
</script>
</html>