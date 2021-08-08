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
	<table id='comments_table'>
	<c:forEach items="${list}" var="comments">
		<tr>
			<c:if test="${comments.u_newName eq 'default-profile.png' }">
				<td id='profile'><a href="./myPage?id=${comments.pc_id }"><img src="./img/default-profile.png" id='comments_img'><br/>${comments.u_nname } </a></td>
			</c:if>
			<c:if test="${comments.u_newName ne 'default-profile.png' }">
				<td id='profile'><a href="./myPage?id=${comments.pc_id }"><img src="/photo/${comments.u_newName }" id='comments_img'><br/>${comments.u_nname } </a></td>
			</c:if>
			<td id="content" >
				<p>${comments.pc_content }</p>
			</td>
			<td>
				<div style='margin-top: 1px'>${comments.pc_tm }<img src="./img/notify-icon.png" width="20px" height="20px" style="float:right"/></div>
				<div id='nullPoint'>&nbsp;&nbsp;</div>
			 	<div >수정하기      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      삭제하기</div>
				<div style=" text-align:center"><img src="./img/CommentArrow.png" width="20px" height="20px"/></div>
			</td>
		</tr>
	
	</c:forEach>
	</table>
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
	<div class="board_t_b">
		<textarea class="board_text" style="resize: none;"></textarea>
		<button class="enter">enter</button>
		<div id="board_text_controll">(0 / 300)</div>
		
	</div>
	
</body>
</html>