<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
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
}

/*tab 메뉴*/
#manageButton {
	width: 1140px;
	height: 50px;
	margin: 0px auto;
}

#manageButton button {
	/* display:inline-block; */
	width: 285px;
	height: 50px;
	float: left;
	background-color: #fff;
	border: 1px solid #D8D8D8;
	border-collapse: collapse;
}

#manageButton button:hover {
	background-color: #F2F2F2;
	cursor: pointer;
}

#userInfo, #notifyInfo, #blackInfo {
	width: 1140px;
	height: auto;
	border: 0.7px solid #eaeaea;
	margin: 0px auto;
}

#Content {
	clear: both;
	padding: 10px 0;
}

#Content table {
	width: 1050px;
	margin: 0px auto;
	border-top: 1px solid gray;
}

#Content table th {
	/* border: 1px solid black; */
	padding: 10px 0;
}

#Content table td {
	/* border: 1px solid black; */
	padding: 8px 0;
	text-align: center;
}

#Content table td a {
	text-decoration: none;
	color: #000;
}

#Content table td a:hover {
	text-decoration: underline;
}

.hoverTr:hover {
	background-color: #D8D8D8;
	cursor: pointer;
}
</style>
<body>
<div id="notifyInfo">


			<div id="Content">
				<table>
					<tr>
						<th>신고한아이디</th>
						<th>신고 대분류</th>
						<th>신고 내용</th>
						<th>담당자</th>
						<th>신고날짜</th>
						<th>처리상태</th>
					</tr>
					<tr>
						<td colspan="6" style="padding: 0; border-bottom: 1px solid gray"></td>
					</tr>

					<tr class="content-zoon_report">

					</tr>
				</table>
			</div>
		</div>

</body>




</html>