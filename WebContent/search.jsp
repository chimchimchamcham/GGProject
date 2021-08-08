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
#mainHeader{
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

</style>
</head>
<body>
<div id="mainHeader"><jsp:include page="header.jsp" /></div>
<div id="main">
<br/>
<h2>"사과"검색결과 총 4개</h2>
<p style="margin-left: 20px;"></p>
<div id="searchButton">
			<button class="search_all">전체</button>
			<button class="user">사용자</button>
			<button class="post_title">제목</button>
			<button class="post_content">내용</button>
</div>
<div id="user">
	<table>
		<tr>
			<td>
				<a href="#">
				<img src="img/default-profile.png"id="preview-image" width="100px" height="100px" style="border: solid 1px gray" />
				</a>
			</td>
			<td>
				<a href="#">
				<img src="img/default-profile.png"id="preview-image" width="100px" height="100px" style="border: solid 1px gray" />
				</a>
			</td>
			<td>
				<a href="#">
				<img src="img/default-profile.png"id="preview-image" width="100px" height="100px" style="border: solid 1px gray" />
				</a>
			</td>
			<td>
				<a href="#">
				<img src="img/default-profile.png"id="preview-image" width="100px" height="100px" style="border: solid 1px gray" />
				</a>
			</td>
	</table>
</div>

</div><!-- div main end -->
</body>
</html>