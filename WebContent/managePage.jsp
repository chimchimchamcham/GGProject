<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리페이지</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
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

h2 {
	text-align: center;
	padding-bottom: 30px;
}

h3 {
	text-align: center;
	padding: 30px 0 30px 0;
}

/*검색창*/
#searchBox {
	width: 500px;
	/* margin: 0px auto; */
}

#searchBox img {
	width: 20px;
	cursor: pointer;
	transition: 0.5s;
	float: left;
	padding-left: 5px;
}

#searchBox input {
	display: block;
	width: 280px;
	height: 25px;
	outline: none;
	border: 1px solid gray;
	border-radius: 3px;
	float: left;
}

/*검색, select있는bar*/
#headerBar {
	width: 1050px;
	margin: 0px auto;
}

#headerBar {
	width: 1050px;
	margin: 0px auto;
}

#headerBar select {
	width: 90px;
}

#headerBar td {
	/* border:1px solid black; */
	
}
</style>
</head>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
		<h2>관리페이지</h2>
		<p style="margin-left: 20px;">관리자1님</p>
		<div id="manageButton">
			<button class="userBtn">회원목록</button>
			<button class="notifyBtn">신고</button>
			<button class="blackBtn">블랙리스트</button>
			<button class="myBtn">마이페이지</button>
		</div>

		<!-- ===========회원목록============= -->
		<div id="userInfo">
			<h3>회원목록</h3>
			<table id="headerBar">
				<tr>
					<td>
						<div id="searchBox">
							<input type="text" name="search" placeholder="검색"> <img
								src="img/search-icon.png" alt="search-icon">
						</div>
					</td>
				</tr>
			</table>
			<div id="Content">
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
						<td colspan="6"
							style="padding: 0; border-bottom: 0.7px solid #e8e8e8"></td>
					</tr>
				</table>
			</div>
		</div>


		<!-- ===========신고============= -->
		<div id="notifyInfo">
			<h3>신고</h3>

			<table id="headerBar">
				<tr>
					<td>
						<div id="searchBox">
							<input type="text" name="search" placeholder="검색"> <img
								src="img/search-icon.png" alt="search-icon">
						</div>
					</td>
					<td style="text-align: right;"><select>
							<option value="게시글">게시글</option>
					</select> <select>
							<option value="처리중">처리중</option>
					</select></td>
				</tr>
			</table>
			<div id="Content">
				<table>
					<tr>
						<th>신고번호</th>
						<th>신고받은 아이디</th>
						<th>신고한 아이디</th>
						<th>대분류명</th>
						<th>신고날짜</th>
						<th>처리상태</th>
						<th>담당자</th>
					</tr>
					<tr>
						<td colspan="7" style="padding: 0; border-bottom: 1px solid gray"></td>
					</tr>
					<tr class="hoverTr">
						<td>1</td>
						<td>1234</td>
						<td>emily1770</td>
						<td>게시글</td>
						<td>2021-08-08</td>
						<td>처리중</td>
						<td>관리자1</td>
					</tr>
					<tr>
						<td colspan="7"
							style="padding: 0; border-bottom: 0.7px solid #e8e8e8"></td>
					</tr>
				</table>
			</div>
		</div>


		<!-- ===========블랙리스트============= -->
		<div id="blackInfo">
			<h3>블랙리스트</h3>

			<table id="headerBar">
				<tr>
					<td>
						<div id="searchBox">
							<input type="text" name="search" placeholder="검색">
							<img src="img/search-icon.png" alt="search-icon">
						</div>
					</td>
					<td style="text-align: right;"><select>
							<option value="댓글금지">댓글금지</option>
					</select></td>
				</tr>
			</table>
			<div id="Content">
				<table>
					<tr>
						<th>아이디</th>
						<th>분류</th>
						<th>등록 날짜</th>
						<th>등록 종료 날짜</th>
						<th>담당자</th>
					</tr>
					<tr>
						<td colspan="5" style="padding: 0; border-bottom: 1px solid gray"></td>
					</tr>
					<tr class="hoverTr">
						<td>1234</td>
						<td>댓글금지</td>
						<td>2021-08-06</td>
						<td>2021-08-09</td>
						<td>관리자1</td>
					</tr>
					<tr>
						<td colspan="5"
							style="padding: 0; border-bottom: 0.7px solid #e8e8e8"></td>
					</tr>
				</table>
			</div>
		</div>


		<!-- ===========마이페이지============= -->
		<div id="myInfo">
			<h3>마이페이지</h3>
			<div id="Content">
				<table>
						<tr>
							<th rowspan="2">프사</th>
							<th>관리자1</th>
						</tr>
						<tr>
							<td>admin1</td>
						</tr>
				</table>
			</div>
		</div>


	</div>
	<!-- main end -->
</body>
<script type="text/javascript">
	//초기 화면 설정
	$(".userBtn").css({
		"background-color" : "#D8D8D8"
	});
	$("#userInfo").show();
	$("#notifyInfo, #blackInfo, #myInfo").hide();

	//회원목록 버튼 클릭 했을 때
	$(".userBtn").click(function() {
		$(".userBtn").css({
			"background-color" : "#D8D8D8"
		});
		$(".notifyBtn, .blackBtn, .myBtn").css({
			"background-color" : "#fff"
		});
		$("#userInfo").show();
		$("#notifyInfo, #blackInfo, #myInfo").hide();
	});

	//신고 버튼 클릭 했을 때
	$(".notifyBtn").click(function() {
		$(".notifyBtn").css({
			"background-color" : "#D8D8D8"
		});
		$(".userBtn, .blackBtn, .myBtn").css({
			"background-color" : "#fff"
		});
		$("#notifyInfo").show();
		$("#userInfo, #blackInfo, #myInfo").hide();
	});

	//블랙리스트 버튼 클릭 했을 때
	$(".blackBtn").click(function() {
		$(".blackBtn").css({
			"background-color" : "#D8D8D8"
		});
		$(".userBtn, .notifyBtn, .myBtn").css({
			"background-color" : "#fff"
		});
		$("#blackInfo").show();
		$("#notifyInfo, #userInfo, #myInfo").hide();
	});

	//마이페이지 버튼 클릭 했을 때
	$(".myBtn").click(function() {
		$(".myBtn").css({
			"background-color" : "#D8D8D8"
		});
		$(".userBtn, .blackBtn, .notifyBtn").css({
			"background-color" : "#fff"
		});
		$("#myInfo").show();
		$("#notifyInfo, #blackInfo, #userInfo").hide();
	});
</script>
</html>