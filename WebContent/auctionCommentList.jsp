<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
	<table>
	<c:forEach items="${list}" var="comments">
		<tr>
			<td>${comments.p_no }</td>
		</tr>
	
	</c:forEach>
	</table>
	<div class="board_t_b">
		<textarea class="board_text" style="resize: none;"></textarea>
		<button class="enter">enter</button>
		<div id="board_text_controll">(0 / 300)</div>
		
	</div>
	<!-- 페이지를 몇부터 몇까지 보여줄건지 (이전/다음) -->
	<div class="pageArea">
		<a href="./?page=${currPage-1 }"><</a>
		<c:forEach var="i" begin="1" end="${totalPage }" step="1">
			<span class="page">
			<c:if test="${i ne currPage }"><a href="./?page=${i }">${i}</a></c:if>
			<c:if test="${i eq currPage }"><b>${i}</b></c:if>
			</span>
		</c:forEach>
		<a href="./?page=${currPage +1 }">></a>
	</div>
</body>
</html>