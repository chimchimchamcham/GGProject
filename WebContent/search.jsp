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
		<h2>"${param.insert}"검색결과 총 ${list_size}개</h2>
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
			<c:if test="${f_ui eq null || f_ui eq ''}">
				<h3>사용자가 존재하지 않습니다.</h3>
			</c:if>
			<c:forEach items="${f_ui }" var ="dto">
				<table class="hoverTr" onclick="location.href='myPage?id=${dto.u_id}'" style="padding: 0 100px; width: 1140px; height: 100px">
					<tr>
						<td rowspan="3">
							<p style="text-align: center; padding: 0 50px">
								<img src="/photo/${dto.u_newName }" width="100">
							</p>
						</td>
						<th><p style="width: 500px; padding: 0 20px; text-align: left; /* overflow: hidden;  */ /* text-overflow: ellipsis; white-space: nowrap; */ font-size: 1.5rem">${dto.u_id }</p></th>
					</tr>
					<tr>
						<td><p style="width: 500px; padding: 0 20px; text-align: left;">팔로워 ${dto.flow_count}명 &nbsp;&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;&nbsp;총 게시글 ${dto.p_registCnt}개</p></td>
					</tr>
					<tr>
						<td><p style="width: 500px; padding: 0 20px; text-align: left;">${dto.p_content }</p></td>
					</tr>
				</table>
				
				<p><hr style="width: 1140px"></p>
			</c:forEach>
			</div>
		</div>
		<div id="post_title_result">
			<p style="margin-top: 16px; color: #999999; font-size: 1.2rem">
				<b>제목 검색결과</b>
			</p>
			<p><hr></p>
			<div id="post_titleContent">
			<c:if test="${f_pc eq null || f_pc eq ''}"><h3>해당 제목을 가진 게시글이 존재하지 않습니다.</h3></c:if>
			<c:forEach items="${f_pc }" var ="dto">
			<p style="display:hidden"><c:if test="${dto.p_code eq 'P001' }">./auctionDetail?p_no=${dto.p_no }</c:if></p>
			<p style="display:hidden"><c:if test="${dto.p_code eq 'P002' }">./salesDetail?p_no=${dto.p_no }</c:if></p>
			<p style="display:hidden"><c:if test="${dto.p_code eq 'P003' }">./noticeDetail?p_no=${dto.p_no }</c:if></p>
			<p style="display:hidden"><c:if test="${dto.p_code eq 'P004' }">./commDetail?p_no=${dto.p_no }</c:if></p>
				<table class="hoverTr" onclick="location.href=''" style="padding: 0 100px; width: 1140px; height: 100px">
					<tr>
						<td rowspan="3">
							<p style="text-align: center; padding: 0 50px">
								<img src="/photo/${dto.i_newName }" width="100">
							</p>
						</td>
						<th><p style="width: 500px; padding: 0 20px; text-align: left; /* overflow: hidden;  */ /* text-overflow: ellipsis; white-space: nowrap; */ font-size: 1.5rem">${dto.p_title }</p></th>
					</tr>
					<tr>
						<td><p style="width: 500px; padding: 0 20px; text-align: left;">좋아요 ${dto.p_likeCount}명 &nbsp;&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;&nbsp;조회수 ${dto.p_view }</p></td>
					</tr>
					<tr>
						<td><p style="width: 500px; padding: 0 20px; text-align: left;">${dto.p_content }</p></td>
					</tr>
				</table>
				<p><hr style="width: 1140px"></p>
				</c:forEach>
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
			<c:if test="${f_pt eq null || f_pt eq ''}"><h3>해당 내용을 가진 게시글이 존재하지 않습니다.</h3></c:if>
			<c:forEach items="${f_pt }" var ="dto">
				<table class="hoverTr" onclick="location.href='#'" style="padding: 0 100px; width: 1140px; height: 100px">
					<tr>
						<td rowspan="3">
							<p style="text-align: center; padding: 0 50px">
								<img src="/photo/${dto.i_newName }" width="100">
							</p>
						</td>
						<th><p style="width: 500px; padding: 0 20px; text-align: left; /* overflow: hidden;  */ /* text-overflow: ellipsis; white-space: nowrap; */ font-size: 1.5rem">${dto.p_title }</p></th>
					</tr>
					<tr>
						<td><p style="width: 500px; padding: 0 20px; text-align: left;">좋아요 ${dto.p_likeCount}명 &nbsp;&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;&nbsp;조회수 ${dto.p_view }</p></td>
					</tr>
					<tr>
						<td><p style="width: 500px; padding: 0 20px; text-align: left;">${dto.p_content }</p></td>
					</tr>
				</table>
					<p><hr style="width: 1140px"></p>	
				</c:forEach>
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

	
	
</script>
</html>