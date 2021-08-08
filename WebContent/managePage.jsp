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

#userInfoBox {
	width: 1100px;
	margin: 0px auto;
	border-top: 1px solid gray;
}

#userInfoBox th {
	/* border: 1px solid black; */
	padding: 10px 0;
}

#userInfoBox td {
	/* border: 1px solid black; */
	padding: 8px 0;
	text-align: center;
}

#userInfoBox td a{
	text-decoration: none;
	color:#000;
}

#userInfoBox td a:hover{
	text-decoration: underline;
}

h2 {
	text-align: center;
	padding-bottom: 30px;
}


</style>
</head>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
		<h2>관리페이지</h2>
		<p style="margin-left:20px;">관리자1 님</p>
		<button>회원목록</button>
		<button>신고</button>
		<button>블랙리스트</button>
		<button>마이페이지</button>
		
		<div class="userInfo">
		<table id="userInfoBox">
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>

			<tr>
				<td colspan="5" style="padding:0; border-bottom:1px solid gray"></td>
			</tr>
			<c:forEach items="${noticeList}" var="noticeList">
				<tr>
					<td>${noticeList.p_no}</td>
					<td style="text-align: left;"><a href="noticeDetail?p_no=${noticeList.p_no}">${noticeList.p_title}</a></td>
					<td>${noticeList.u_nname}</td>
					<td>${noticeList.p_tm}</td>
					<td>${noticeList.p_view}</td>
				</tr>
				<tr>
				<td colspan="5" style="padding:0; border-bottom:0.7px solid #e8e8e8"></td>
			</tr>
			</c:forEach>
		</table>
		</div>
		
		
		<div class="pageArea">
		currPage : ${noticeList[0].currPage} / totalPage : ${noticeList[0].totalPage}
		<span onclick="before();">이전</span>
		<c:forEach var="i" begin="1" end="${noticeList[0].totalPage}" step="1">
		<span class="page">
			<c:if test="${i ne noticeList[0].currPage}"><a href="noticeList?paging=${i}">${i}</a></c:if>
			<c:if test="${i eq noticeList[0].currPage}"><b>${i}</b></c:if>
		</span>	
		</c:forEach>
		<span onclick="after();">다음</span>
	</div>
	</div>
</body>
<script type="text/javascript">

</script>
</html>