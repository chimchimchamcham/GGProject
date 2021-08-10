<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>충전 팝업</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
</style>
</head>
<style>
h2 {
	text-align: center;
	padding: 5px 0 5px 0;
}

#wrap{
	width:892px;
	height: 592px;
	float:left;
}

#detailTb{
	width:750px;
	height: 440px;
	margin:0px auto;
	
}

#detailTb, #detailTb td{
	border:1px solid gray;
	 border-collapse : collapse;
}

#detailTb td{
	padding-left:20px;
}

#button{
	width:750px;
	margin:0px auto;
/* 	border:1px solid black; */
	clear:both;
}

#button button{
	float:right;
	margin:10px 5px;
}

</style>
<body>
<div id="wrap">
	<h2>신고 상세내용</h2>
	<table id="detailTb">
			<tr>
				<td>신고번호</td>
				<td>1</td>
			</tr>
			<tr>
				<td>신고받은 아이디</td>
				<td><b>${notifyDet.n_receiveId}</b></td>
			</tr>
			<tr>
				<td>신고한 아이디</td>
				<td>${notifyDet.n_sendId}</td>
			</tr>
			<tr>
				<td>날짜</td>
				<td>${notifyDet.n_tm}</td>
			</tr>
			<tr>
				<td>신고분류</td>
				<td>${notifyDet.n1_name} &gt; ${notifyDet.n2_name}</td>
			</tr>
			<tr>
				<td>관리자 아이디</td>
				<td>${notifyDet.hn_adminid}</td>
			</tr>
			<tr>
				<td>처리상태</td>
				<td><select><option value="hn_001">${notifyDet.n_receiveId}</option></select></td>
			</tr>
			<tr>
				<td>신고내용</td>
				<td>${notifyDet.n_content}</td>
			</tr>
	</table>
	<div id="button"><button>저장</button><button>블랙리스트 처리</button></div>
	</div>
</body>
<script>

</script>
</html>