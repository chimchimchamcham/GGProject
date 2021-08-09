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
<script>
<c:set var="id"  value="${sessionScope.loginId}" /> // 삭제와 수정을 하기 위함.
</script>
<body>
	<table id='comments_table'>
	<c:forEach items="${list}" var="comments">
		<tr id="${comments.pc_no }">
			<c:if test="${comments.u_newName eq 'default-profile.png' }">
				<td id='profile'><a href="./myPage?id=${comments.pc_id }"><img src="./img/default-profile.png" id='comments_img'><br/>${comments.u_nname } </a></td>
			</c:if>
			<c:if test="${comments.u_newName ne 'default-profile.png' }">
				<td id='profile'><a href="./myPage?id=${comments.pc_id }"><img src="/photo/${comments.u_newName }" id='comments_img'><br/>${comments.u_nname } </a></td>
			</c:if>
			<td id="content" >
				<p>${comments.pc_content }</p>
			</td>
			<td style="border-bottom: 0.5px solid lightgray;">
				<c:if test= "${comments.pc_id ne id }">
				
				<div style='margin-top: 1px'>${comments.pc_tm }<img src="./img/notify-icon.png" width="20px" height="20px" style="float:right" id="${comments.pc_id }" class="reporter"/></div>
				</c:if>
				<div id='nullPoint'>&nbsp;&nbsp;</div>
				<c:if test="${comments.pc_id eq id}">
					<div style='margin-top: 1px'>${comments.pc_tm }</div>
			 		<div style="text-align: center; font-weight: bold"><p class="update_comment" id="${comments.pc_no }" style="display: inline">수정하기</p>&nbsp;&nbsp;<p class="comm_del" id="${comments.pc_no }" style="display: inline">삭제하기</p></div>
			 	</c:if>
			 	<c:if test="${comments.pc_id ne id}">
			 		<div id='nullPoint'>&nbsp;&nbsp;</div>
			 	</c:if>
			 	<div id='nullPoint'>&nbsp;&nbsp;</div>
				<div><img src="./img/CommentArrow.png" width="20px" height="20px" id="${comments.pc_no }" class="re_Arrow"/></div>
			</td>
		</tr>
	
	</c:forEach>
	</table>
	<!-- 페이지를 몇부터 몇까지 보여줄건지 (이전/다음) -->
	<div class="pageArea">
		<c:if test="${currPage gt 1}">
		<span style='font-weight:bold' id='before'>[이전]</span>
		</c:if>
		<c:forEach var="i" begin="1" end="${totalPage }" step="1">
			<span class="page">
			<c:if test="${i ne currPage }"><span class='comment_nav' id="${i }">${i}</span></c:if>
			<c:if test="${i eq currPage }"><span id="${i }" style="font-weight:bold">${i}</span></c:if>
			</span>
		</c:forEach>
		<c:if test="${currPage lt totalPage }">
		<span style='font-weight:bold' id='after'>[다음]</span>
		</c:if>
	</div>
	<div class="board_t_b">
		<textarea class="board_text" style="resize: none;"></textarea>
		<button class="enter">enter</button>
		<div id="board_text_controll">(0 / 300)</div>
		
	</div>
	
</body>
</html>