<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리페이지</title>
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
}

#manageButton {
	width: 1140px;
	text-align: center;
	margin: 10px;
}

#manageButton button {
	display: inline-block;
	width: 280px;
	height: 50px;
	float: left;
	background-color: #fff;
	border: 1px solid #D8D8D8;
	border-collapse: collapse;
}

#manageButton button:hover {
	background-color: #D8D8D8;
}

#userInfo {
	width: 1140px;
	height: auto;
	border: 0.7px solid #eaeaea;
	margin:0px auto;
	
}

#userContent{
	clear: both;
	padding-top: 10px;
}

#userContent table{
	width: 1050px;
	margin: 0px auto;
	border-top: 1px solid gray;
}

#userContent table th {
	/* border: 1px solid black; */
	padding: 10px 0;
}

#userContent table td {
	/* border: 1px solid black; */
	padding: 8px 0;
	text-align: center;
}

#userContent table td a {
	text-decoration: none;
	color: #000;
}

#userContent table td a:hover {
	text-decoration: underline;
}

.hoverTr:hover{
	background-color: #D8D8D8;
	cursor: pointer;
}

h2 {
	text-align: center;
	padding-bottom: 30px;
}

h3 {
	text-align: center;
	padding:100px 0 30px 0 ;
}

 /*검색창*/
 #searchBox{
	width: 1050px;
	margin: 0px auto;
 }
 
#searchBox img {
	width: 20px;
	cursor: pointer;
	transition: 0.5s;
	float:left;
	padding-left: 5px;
}

#searchBox input {
	display: block;
	width: 280px;
	height: 25px;
	outline: none;
	border: 1px solid gray;
	border-radius: 3px;
	float:left;
}

</style>
</head>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
		<h2>관리페이지</h2>
		<p style="margin-left: 20px;">관리자1님</p>
		<div id="manageButton">
			<button>회원목록</button>
			<button>신고</button>
			<button>블랙리스트</button>
			<button>마이페이지</button>
		</div>

		<div class="userInfo">
		<h3>회원목록</h3>
		
		<div id="searchBox">
			<input type="text" name="search" placeholder="검색">
			<img src="img/search-icon.png" alt="search-icon">
		</div>
		<div id="userContent">
			<table>
				<tr>
					<th>아이디</th>
					<th>닉네임</th>
					<th>이름</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>가입날짜</th>
				</tr>
				<tr>
					<td colspan="6" style="padding: 0; border-bottom: 1px solid gray"></td>
				</tr>
					<tr class="hoverTr">
						<td>1234</td>
						<td>애플</td>
						<td>정슬기</td>
						<td>1234@email.com</td>
						<td>010-****-8206</td>
						<td>2021-08-08</td>
					</tr>
					<tr>
						<td colspan="6" style="padding: 0; border-bottom: 0.7px solid #e8e8e8"></td>
					</tr>
			</table>
			</div>
		</div>


	</div> <!-- main end -->
</body>
<script type="text/javascript">
	
</script>
</html>