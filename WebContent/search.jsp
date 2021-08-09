<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
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

h2 {
	text-align: center;
	padding-bottom: 30px;
}
/*tab 메뉴*/
#searchButton {
	width: 1140px;
	height: 50px;
	margin: 0px auto;
}

#searchButton button {
	/* display:inline-block; */
	width: 285px;
	height: 50px;
	float: left;
	background-color: #fff;
	border: 1px solid #D8D8D8;
	border-collapse: collapse;
}

#searchButton button:hover {
	background-color: #F2F2F2;
	cursor: pointer;
}

#Content {
	clear: both;
	padding: 10px 0;
}

#Content table {
	width: 1050px;
	margin: 0px auto;
	/* border-top: 1px solid gray; */
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
</head>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
		<br />
		<h2>"사과"검색결과 총 4개</h2>
		<p style="margin-left: 20px;"></p>
		<div id="searchButton">
			<button class="search_all">전체</button>
			<button class="user">사용자</button>
			<button class="post_title">제목</button>
			<button class="post_content">내용</button>
		</div>
		<div id="user">
				<table class="hoverTr" onclick="location.href='#'">
					<tr>
						<td rowspan="3"><img src="../test/default-profile.png" width="60"></td>
						<th><p style="width:310px;  padding:0 20px; text-align: left; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">안녕하세요? 이거 살려고하는데요^^하하하하하하하하</p></a></th>
						<td rowspan="2"><button class="delBtn">삭제</button></td>
				</tr>
				<tr>
					<td><p  style="width:310px; padding:0 20px; text-align: left;"><a href="#">보낸자</a> | 2021.08.06 13:45</p>
					</td>	
				</tr>
					<tr>
				<td style="border-bottom:1px solid black; padding-top:10px;" colspan="3"></td>
			</tr>
				</table>
			

		</div>
	</div>
	<!-- div main end -->
</body>
</html>