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
	<h2>옥션 리스트입니다.</h2>
	
	<table>
	<c:forEach items="${list}" var="comments">
		<tr>
			<td>${comments.p_no }</td>
		</tr>
	
	</c:forEach>
	</table>
	<div class="board_t_b">
		<textarea class="board_text" style="resize: none;"></textarea>
		<div id="board_text_controll">(0 / 300)</div>
		<button class="enter">enter</button>
	</div>
</body>
<script>




/*글자수 제한*/
$(".board_text,").on('keyup', function() {
	$('#board_text_controll').html("(" + $(this).val().length + " / 300)");
	console.log(page);
	if ($(this).val().length > 300) {
		$(this).val($(this).val().substring(0, 300));
		$('#board_text_controll, update_text_controll').html("(300 / 300)");
	}
});
</script>
</html>