<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
#drop *{
	list-style: none;
}
</style>
</head>
<body>
	<div id="mainheader">신고하기</div>
	<select name="drop">
	    <option value = "boardCate">게시글 신고</option>
	    <option value = "commertCate">댓글 신고</option>
	    <option value = "userCate">사용자 신고</option>
	</select>
	<form  action = "#" method = "get" name = "boardNoti">
		<table id = "postTable">
			<tr>
				<td><input type="hidden" name="N1_code" value="post" checked></td>
			</tr>
			<tr>
				<td>게시글 신고<input type="radio" name="xxx" value="yyy" checked></td>
			</tr>
			<tr>
				<td><button>신고하기</button></td>
			</tr>
		</table>
	</form>
	<form  action = "#" method = "get" name = "commentNoti">
		<table id = "boardTable" style="visibility:hidden">
			<tr>
				<td><input type="hidden" name="N1_code" value="board" checked></td>
			</tr>
			<tr>
				<td>댓글 신고<input type="radio" name="xxx" value="yyy" checked></td>
			</tr>
			<tr>
				<td><button>신고하기</button></td>
			</tr>
		</table>
	</form>
	<form  action = "#" method = "get" name = "userNoti">
		<table id = "userTable" style="visibility:hidden">
			<tr>
				<td><input type="hidden" name="N1_code" value="user" checked></td>
			</tr>
			<tr>
				<td>유저 신고<input type="radio" name="xxx" value="yyy" checked></td>
			</tr>
			<tr>
				<td><button>신고하기</button></td>
			</tr>
		</table>
	</form>
</body>
<script type="text/javascript">
function drop(drop){
	switch (drop) {
	case boardCate:
		$("#postTable").show();
		$("#commentTable").hide();
		$("#userTable").hide();
		break;
	case	commertCate:
		$("#postTable").hide();
		$("#commentTable").show();
		$("#userTable").hide();
		break;
	case	userCate:
		$("#postTable").hide();
		$("#commentTable").hide();
		$("#userTable").show();
		break;
	}
}
	$("select[name=drop]").onchange(drop($("drop option:selected").val()));
	console.log($("drop option:selected").val());
</script>
</html>