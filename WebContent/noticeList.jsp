<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
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

#noticeTable {
	width: 1100px;
	margin: 0px auto;
	border-top: 1px solid gray;
}

#noticeTable th {
	/* border: 1px solid black; */
	padding: 10px 0;
}

#noticeTable td {
	/* border: 1px solid black; */
	padding: 8px 0;
	text-align: center;
}

#noticeTable td a{
	text-decoration: none;
	color:#000;
}

#noticeTable td a:hover{
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
		<h2>공지사항</h2>
		<p style="margin-left:20px;">총 ${noticeListSize} 개의 게시글</p>
		<table id="noticeTable">
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<c:if test="${noticeList eq null || noticeList eq ''}">
				<tr>
					<td>공지사항 글이 없습니다.</td>
				</tr>
			</c:if>
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
		
		<div class="pageArea">
		<a href="noticeList?currPageNum=${noticeList[0].currPageNum-1 }">이전</a>
		<c:forEach var="i" begin="${noticeList[0].currPageStart }" end="${noticeList[0].currPageEnd }" step="1">
		<span class="page">
			<c:if test="${i ne noticeList[0].currPage}"><a href="noticeList?paging=${i}&currPageNum=${noticeList[0].currPageNum }">${i}</a></c:if>
			<c:if test="${i eq noticeList[0].currPage}"><b>${i}</b></c:if>
		</span>	
		</c:forEach>
		<a href="noticeList?currPageNum=${noticeList[0].currPageNum+1 }">다음</a>
	</div>
	</div>
</body>
<script type="text/javascript">
console.log(${noticeList[0].currPageNum});
console.log(${noticeList[0].currPageStart});
console.log(${noticeList[0].currPageEnd});
</script>
</html>