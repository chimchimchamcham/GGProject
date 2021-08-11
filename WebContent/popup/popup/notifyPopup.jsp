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
/* table,tr,td{
	border:1px solid black;
} */
#postTable *,#commentTable *,#userTable *{
	font-size : 10px;	
}
#postTable,#commentTable,#userTable{
	width:100%;
}
#postTable textarea,#commentTable textarea,#userTable textarea{
	width:98%;
	height:200px;
	resize:none;
}
#notifyBody{
	margin:0;
	padding:0;
	width:100%;
}
#mainheader{
	background-color:gray;
}
</style>
</head>
<body id="notifyBody">
	<div id="mainheader">신고하기</div>
	<select name="drop" onchange="drop()">
	    <option value = "postCate">게시글 신고</option>
	    <option value = "commentCate">댓글 신고</option>
	    <option value = "userCate">사용자 신고</option>
	</select>
	<form  action = "../notify" method = "get" name = "postNoti">
		<table id = "postTable">
			<tr style="display:none">
				<td><input type="text" name="N_receiveId" value=${param.N_receiveId }></td>
			</tr>
			<tr>
				<td><input type="hidden" name="N1_code" value="post" checked></td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="post_01" checked/>허위상품,과대상품거래</td>
				<td><input type="radio" name="N2_code" value="post_02"/>물건에 무관한 게시글</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="post_03"/>판매금지 품목이예요</td>
				<td><input type="radio" name="N2_code" value="post_04"/>사기글이예요</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="post_05"/>중복게시글</td>
				<td><input type="radio" name="N2_code" value="post_06"/>사용할수없는상품</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="post_07"/>되팔이 상품</td>
				<td><input type="radio" name="N2_code" value="post_08"/>기타(상세 정보 입력 가능)</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="" style="visibility:hidden"/></td>		
				<td><input type="radio" name="N2_code" value="" style="visibility:hidden"/></td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="" style="visibility:hidden"/></td>
				<td><input type="radio" name="N2_code" value="" style="visibility:hidden"/></td>
			</tr>
			<tr>
				<td colspan = "2"><textarea name ="N_content" maxlength="1000"></textarea></td>
			</tr>
			<tr style="text-align:right">
				<td colspan ="2"><button>신고하기</button></td>
			</tr>
		</table>
	</form>
	<form  action = "../notify" method = "get" name = "commentNoti">
		<table id = "commentTable" style="display:none">
			<tr style="display:none">
				<td><input type="text" name="N_receiveId" value=${param.N_receiveId }></td>
			</tr>
			<tr>
				<td><input type="hidden" name="N1_code" value="comment" checked></td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="comment_01" checked/>욕설,비방성 댓글</td>
				<td><input type="radio" name="N2_code" value="comment_02"/>광고/홍보성댓글</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="comment_03"/>음란성댓글</td>
				<td><input type="radio" name="N2_code" value="comment_04"/>댓글도배</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="comment_05"/>다른채팅앱으로 유도하는 댓글</td>
				<td><input type="radio" name="N2_code" value="comment_06"/>연애대상을 구하는 댓글</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="comment_07"/>개인정보를 요구하는 댓글</td>
				<td><input type="radio" name="N2_code" value="comment_08"/>금전,물품,후원요구댓글</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="comment_09"/>기타(상세 정보 입력 가능)</td>
				<td><input type="radio" name="N2_code" value="" style="visibility:hidden"/></td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="" style="visibility:hidden"/></td>
				<td><input type="radio" name="N2_code" value="" style="visibility:hidden"/></td>
			</tr>
			<tr>
				<td colspan = "2"><textarea name ="N_content" maxlength="1000"></textarea></td>
			</tr>
			<tr style="text-align:right">
				<td colspan ="2"><button>신고하기</button></td>
			</tr>
		</table>
	</form>
	<form  action = "../notify" method = "get" name = "userNoti">
		<table id = "userTable" style="display:none">
			<tr style="display:none">
				<td><input type="text" name="N_receiveId" value=${param.N_receiveId }></td>
			</tr>
			<tr>
				<td><input type="hidden" name="N1_code" value="user" checked></td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="user_01" checked/>거래와 상관 없는 쪽지와 댓글을 보내는 경우</td>
				<td><input type="radio" name="N2_code" value="user_02"/>불법상품 거래</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="user_03"/>비매너 사용자예요</td>
				<td><input type="radio" name="N2_code" value="user_04"/>욕설을 해요</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="user_05"/>성희롱을 해요</td>
				<td><input type="radio" name="N2_code" value="user_06"/>사기 사용자예요</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="user_07"/>거래 분쟁 신고(상세 정보 입력가능)</td>
				<td><input type="radio" name="N2_code" value="user_08"/>프로필사진신고</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="user_09"/>무리한 요구를 해요</td>
				<td><input type="radio" name="N2_code" value="user_10"/>불건전 닉네임신고</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="user_11"/>기타(상세 정보 입력 가능)</td>
				<td><input type="radio" name="N2_code" value="" style="visibility:hidden"/></td>
			</tr>
			<tr>
				<td colspan = "2"><textarea name ="N_content" maxlength="1000"></textarea></td>
			</tr>
			<tr style="text-align:right">
				<td colspan ="2"><button>신고하기</button></td>
			</tr>
		</table>
	</form>
</body>
<script type="text/javascript">
console.log("${loginId}");
if("${loginId}" == ""){
	alert("로그인이 필요한 서비스 입니다.");
	window.close();
}

if("${msg}" != ""){
	alert("${msg}");
	window.close();
}

function drop(){
	var drop = $("select[name=drop]").val();
	console.log(drop);
	switch (drop) {
	case "postCate":
		$("#postTable").css("display","");
		$("#commentTable").css("display","none");
		$("#userTable").css("display","none");
		console.log("게시판");
		break;
	case	"commentCate":
		$("#postTable").css("display","none");
		$("#commentTable").css("display","");
		$("#userTable").css("display","none");
		console.log("댓글");
		break;
	case	"userCate":
		$("#postTable").css("display","none");
		$("#commentTable").css("display","none");
		$("#userTable").css("display","");
		console.log("유저");
		break;
	}
}

$("select[name=drop]").onchange(drop($("select[name=drop]").val()));


</script>
</html>