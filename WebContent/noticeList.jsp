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
	width: 260px;
	margin-left: 20px;
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
		
	</div>
</body>
<script type="text/javascript">

</script>
</html>