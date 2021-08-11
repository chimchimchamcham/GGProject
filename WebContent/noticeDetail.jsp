<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세보기</title>
<style type="text/css">
#mainHeader {
	z-index: 1000;
}

#main {
	/* background-color: gray; */
	width: 1140px;
	height: auto;
	position: absolute;
	top: 150px;
	z-index: -1;
	margin: 0px auto;
	padding: 30px;
	border: 0.7px solid #eaeaea;
}

#noticeDetailtable {
	width: 1100px;
	margin: 0px auto;
	text-align: left;
}

#noticeDetailtable td, th {
	/* border: 1px solid black; */
}

#infoTable {
	width:260px;
	margin-left:20px;
}

#infoTable td, th {
	/* border: 1px solid black; */
}

.content {
	width: 1100px;
	margin: 0px auto;
}

.content p {
	padding: 10px 0;
}

h2 {
	text-align: center;
}
</style>
</head>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
		<h2>공지사항</h2>
		<table id="noticeDetailtable">
			<tr>
				<td style="text-align: right" colspan="3">
				<input type=button value="목록" onclick="location.href='./noticeList'">
				<input type=button value="삭제"  class="updatebutton" onclick="location.href='./postDel?p_no=${dto.p_no}'"></td>
			</tr>
			<tr>
				<th colspan="3"><h3>${dto.p_title}</h3></th>
			</tr>
	
		</table>
		<table id="infoTable">
			<tr>
				<td rowspan="2"><img src="test/default-profile.png" width="50"></td>
				<td colspan="2">${dto.u_nname}</td>
			</tr>
			<tr>
				<td>${dto.p_tm}</td>
				<td>조회수 ${dto.p_view}</td>
			</tr>
		</table>
		<hr>
		<div class="content">
			<p>${dto.p_content}</p>
			<p style="text-align: center;">
				<img src="/photo/${dto.i_newName}" width="400">
			</p>
		</div>
	</div>
</body>
<script type="text/javascript">
	var loginId = "${sessionScope.loginId}";

	if (loginId != "${dto.u_id}" || loginId == null) {


		$(".updatebutton").css("visibility", "hidden");

	}
</script>
</html>