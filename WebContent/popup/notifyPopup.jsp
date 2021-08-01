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
table,tr,td{
	border:1px solid black;
}
#postTable *,#commentTable *,#userTable *{
	font-size : 10px;	
}
#postTable,#commentTable,#userTable{
	width:380px;
}
#postTable textarea,#commentTable textarea,#userTable textarea{
	width:370px;
}
#mainheader{
	magin:0px;
	padding:0px;
	background-color:gray;
}
</style>
</head>
<div id="mainheader">신고하기</div>
<body>
	<select name="drop" onchange="drop()">
	    <option value = "postCate">게시글 신고</option>
	    <option value = "commentCate">댓글 신고</option>
	    <option value = "userCate">사용자 신고</option>
	</select>
	<form  action = "#" method = "get" name = "postNoti">
		<table id = "postTable">
			<tr>
				<td><input type="hidden" name="N1_code" value="post" checked></td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="허위상품,과대상품거래"/>허위상품,과대상품거래</td>
				<td><input type="radio" name="N2_code" value="물건에 무관한 게시글"/>물건에 무관한 게시글</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="판매금지 품목이예요"/>판매금지 품목이예요</td>
				<td><input type="radio" name="N2_code" value="사기글이예요"/>사기글이예요</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="중복게시글"/>중복게시글</td>
				<td><input type="radio" name="N2_code" value="사용할수없는상품"/>사용할수없는상품</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="되팔이 상품"/>되팔이 상품</td>
				<td><input type="radio" name="N2_code" value="기타(상세 정보 입력 가능)"/>기타(상세 정보 입력 가능)</td>
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
				<td colspan = "2"><textarea></textarea></td>
			</tr>
			<tr style="text-align:right">
				<td colspan ="2"><button>신고하기</button></td>
			</tr>
		</table>
	</form>
	<form  action = "#" method = "get" name = "commentNoti">
		<table id = "commentTable" style="display:none">
			<tr>
				<td><input type="hidden" name="N1_code" value="post" checked></td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="욕설,비방성 댓글"/>욕설,비방성 댓글</td>
				<td><input type="radio" name="N2_code" value="광고/홍보성댓글"/>광고/홍보성댓글</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="음란성댓글"/>음란성댓글</td>
				<td><input type="radio" name="N2_code" value="댓글도배"/>댓글도배</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="다른채팅앱으로 유도하는 댓글"/>다른채팅앱으로 유도하는 댓글</td>
				<td><input type="radio" name="N2_code" value="연애대상을 구하는 댓글"/>연애대상을 구하는 댓글</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="개인정보를 요구하는 댓글"/>개인정보를 요구하는 댓글</td>
				<td><input type="radio" name="N2_code" value="금전,물품,후원요구댓글"/>금전,물품,후원요구댓글</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="기타(상세 정보 입력 가능)"/>기타(상세 정보 입력 가능)</td>
				<td><input type="radio" name="N2_code" value="" style="visibility:hidden"/></td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="" style="visibility:hidden"/></td>
				<td><input type="radio" name="N2_code" value="" style="visibility:hidden"/></td>
			</tr>
				<tr>
				<td colspan = "2"><textarea></textarea></td>
			</tr>
			<tr style="text-align:right">
				<td colspan ="2"><button>신고하기</button></td>
			</tr>
		</table>
	</form>
	<form  action = "#" method = "get" name = "userNoti">
		<table id = "userTable" style="display:none">
			<tr>
				<td><input type="hidden" name="N1_code" value="post" checked></td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="거래와 상관 없는 쪽지와 댓글을 보내는 경우"/>거래와 상관 없는 쪽지와 댓글을 보내는 경우</td>
				<td><input type="radio" name="N2_code" value="불법상품 거래"/>불법상품 거래</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="비매너 사용자예요"/>비매너 사용자예요</td>
				<td><input type="radio" name="N2_code" value="욕설을 해요"/>욕설을 해요</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="성희롱을 해요"/>성희롱을 해요</td>
				<td><input type="radio" name="N2_code" value="사기 사용자예요"/>사기 사용자예요</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="거래 분쟁 신고(상세 정보 입력가능)"/>거래 분쟁 신고(상세 정보 입력가능)</td>
				<td><input type="radio" name="N2_code" value="프로필사진신고"/>프로필사진신고</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="무리한 요구를 해요"/>무리한 요구를 해요</td>
				<td><input type="radio" name="N2_code" value="불건전 닉네임신고"/>불건전 닉네임신고</td>
			</tr>
			<tr>
				<td><input type="radio" name="N2_code" value="기타(상세 정보 입력 가능)"/>기타(상세 정보 입력 가능)</td>
				<td><input type="radio" name="N2_code" value="" style="visibility:hidden"/></td>
			</tr>
			<tr>
				<td colspan = "2"><textarea></textarea></td>
			</tr>
			<tr style="text-align:right">
				<td colspan ="2"><button>신고하기</button></td>
			</tr>
		</table>
	</form>
</body>
<script type="text/javascript">
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