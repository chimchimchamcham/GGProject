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
		<h2>"${param.insert}"검색결과 총 4개</h2>
		<p style="margin-left: 20px;"></p>
		<div id="searchButton">
			<button class="search_all">전체</button>
			<button class="user">사용자</button>
			<button class="post_title">제목</button>
			<button class="post_content">내용</button>
		</div>
		<div id="user_result">
			<p style="margin-top: 16px; color: #999999; font-size: 1.2rem">
				<b>사용자 검색결과</b>
			</p>
			<p>
			<hr>
			</p>
			<div id="userContent">
				<table class="hoverTr" onclick="location.href='#'" style="padding: 0 100px; width: 1140px; height: 100px">
					<tr>
						<td rowspan="3">
							<p style="text-align: center; padding: 0 50px">
								<img src="./test/default-profile.png" width="100">
							</p>
						</td>
						<th><p style="width: 500px; padding: 0 20px; text-align: left; /* overflow: hidden;  */ /* text-overflow: ellipsis; white-space: nowrap; */ font-size: 1.5rem">유저1</p></th>
					</tr>
					<tr>
						<td><p style="width: 500px; padding: 0 20px; text-align: left;">팔로워 30명 &nbsp;&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;&nbsp;총 게시글 100개</p></td>
					</tr>
					<tr>
						<td><p style="width: 500px; padding: 0 20px; text-align: left;">안녕하세요 유저1입니다.</p></td>
					</tr>
				</table>
				<p><hr style="width: 1140px"></p>

			</div>
		</div>
		<div id="post_title_result">
			<p style="margin-top: 16px; color: #999999; font-size: 1.2rem">
				<b>제목 검색결과</b>
			</p>
			<p><hr></p>
			<div id="post_titleContent">
				<table class="hoverTr" onclick="location.href='#'" style="padding: 0 100px; width: 1140px; height: 100px">
					<tr>
						<td rowspan="3">
							<p style="text-align: center; padding: 0 50px">
								<img src="./test/default-profile.png" width="100">
							</p>
						</td>
						<th><p style="width: 500px; padding: 0 20px; text-align: left; /* overflow: hidden;  */ /* text-overflow: ellipsis; white-space: nowrap; */ font-size: 1.5rem">유저1</p></th>
					</tr>
					<tr>
						<td><p style="width: 500px; padding: 0 20px; text-align: left;">팔로워 30명 &nbsp;&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;&nbsp;총 게시글 100개</p></td>
					</tr>
					<tr>
						<td><p style="width: 500px; padding: 0 20px; text-align: left;">안녕하세요 유저1입니다.</p></td>
					</tr>
				</table>
				<p><hr style="width: 1140px"></p>
			</div>
		</div>
		<div id="post_content_result">
			<p style="margin-top: 16px; color: #999999; font-size: 1.2rem">
				<b>내용 검색결과</b>
			</p>
			<p>
			<hr>
			</p>
			<div id="post_contentC">
				<table class="hoverTr" onclick="location.href='#'" style="padding: 0 100px; width: 1140px; height: 100px">
					<tr>
						<td rowspan="3">
							<p style="text-align: center; padding: 0 50px">
								<img src="./test/default-profile.png" width="100">
							</p>
						</td>
						<th><p style="width: 500px; padding: 0 20px; text-align: left; /* overflow: hidden;  */ /* text-overflow: ellipsis; white-space: nowrap; */ font-size: 1.5rem">유저1</p></th>
					</tr>
					<tr>
						<td><p style="width: 500px; padding: 0 20px; text-align: left;">팔로워 30명 &nbsp;&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;&nbsp;총 게시글 100개</p></td>
					</tr>
					<tr>
						<td><p style="width: 500px; padding: 0 20px; text-align: left;">안녕하세요 유저1입니다.</p></td>
					</tr>
				</table>
					<p><hr style="width: 1140px"></p>	
			</div>
		</div>
	</div>
	<!-- div main end -->
</body>
<script>
	//초기설정 
	$("#user_result").show();
	$("#post_title_result").show();
	$("#post_content_result").show();

	$(".search_all").click(function() {
		console.log("전체");
		$("#user_result").show();
		$("#post_title_result").show();
		$("#post_content_result").show();
	});

	$(".user").click(function() {
		console.log("사용자");
		$("#user_result").show();
		$("#post_title_result").hide();
		$("#post_content_result").hide();
	});

	$(".post_title").click(function() {
		console.log("제목");
		$("#user_result").hide();
		$("#post_title_result").show();
		$("#post_content_result").hide();
	});

	$(".post_content").click(function() {
		console.log("내용");
		$("#user_result").hide();
		$("#post_title_result").hide();
		$("#post_content_result").show();
	});
	

	
	
	
	console.log(f_ui.length);
	console.log(f_pc.length);
	console.log(f_pt.length);
	
	
</script>
</html>