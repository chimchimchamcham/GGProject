<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알람</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
</style>
</head>
<style>
*{
	margin:0;
	padding:0;
}

h2 {
margin-top:20px;
	text-align: center;
}

#alarmWrap {
	width: 500px;
	/* text-align: center; */
	margin: 0px auto;
	/* background-color: blue; */

}

.tableWrap{
	text-align:center;
}

.tableWrap:hover{
background-color: #f7f7f7;
}

.content {
	/* background-color: yellow;  */
	/* 	text-align: center; */
	display: inline-block;
	margin-top: 30px;
	width: 460px;
	margin:10px 0 0 0;
	cursor: pointer;
}

.content td {
width: 500px;
text-align: left;
	/* display: inline-block; */
	/* border: 1px solid black; */
}

#buttonTwo {
	width: 500px;
	/* background-color: green; */
	text-align: center;
	display: inline-block;
	margin : 20px 0 30px 0;
}

#buttonTwo button {
	width: 70px;
	text-align: center;
	margin: 0px auto;
	display: inline-block;

}

/*읽었을때*/
.read{
	opacity: 0.3;
}

</style>
<body>
	<h2>알람</h2>
	<div id="alarmWrap">
		<div id="buttonTwo">
			<button id="allAL">전체알람</button>
			<button id="importAL">중요알람</button>
		</div>
		<div class="tableWrap">
		<table class="content">
		<c:if test="${dto eq null || dto eq ''}">
		<tr><td rowspan="2">알람이 존재하지 않습니다.</td></tr>
		</c:if>
			<tr>
				<td>${dto.a_content}</td>
			</tr>
			<tr>
				<td ><small>${dto.a_sendTm }</small></td>
			</tr>
			<tr>
				<td style="border-bottom:1px solid black; padding-top:10px;"></td>
			</tr>
		
		</table>
		</div>
	</div>
</body>
<script>
	
/*클릭시 거래페이지 팝업*/
$(".content").click(function(){
	console.log("알람보낸 페이지");
});

</script>
</html>