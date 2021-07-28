<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	*{margin:0;padding:0;border-width:0;list-style-type:none;}
    body{width:100%;}
	div{
		background-color:gray;
	}
	#wrap{
		position:absolute;
		top:50%;
		left:50%;
		transform:translate(-50%, -50%);
		text-align:left;
		width:500px;
		height:400px;
	}
	#idarea,#pwarea{
		background-color:aqua;
	}
	table{
		text-align:left;
		width:500px;
		padding:10px;
	}
	tr,th,td{
		padding:10px;
	}
</style>
</head>
<body>
	<div>
		<a href="index.jsp" id=logo><img src="/img/logo2.png"/></a>
	</div>
	<div id=wrap>
	<button id="findId">아이디찾기</button>
	<button id="rewritePw">비밀번호 재설정</button>
		<div id="idarea">
			<form action="idsearch" method="POST">
				<table>
					<tr>
						<th>이름</th>
					</tr>
					<tr>
						<td><input type="text" name = "name"/></td>
					</tr>
					<tr>
						<th>이메일</th>
					</tr>
					<tr>
						<td>
							<input type="text" name="email">&nbsp;@ 
							<select name="mail">
								<option value='naver.com'>naver.com</option>
								<option value='daum.net'>daum.net</option>
								<option value='google.com'>google.com</option>
							</select>
						</td>
					</tr>
					<tr>
						<td align="right">
							<button id="findId">아이디찾기</button>
						</td>
					</tr>
					<tr>
						<td class="findedId">귀하의 아이디는 입니다.</td>
					</tr>
					
					<tr>
						<td align="right"><input type="button" value="로그인 하러가기" onclick="location.href='login.jsp'"></td>
					</tr>
				</table>
			</form>
		</div>
		<div id = "pwarea">비밀번호 재설정
		</div>
	</div>
</body>
<script>
	$("#pwarea").hide();
	$("#findId").click(function(){
		$("#pwarea").hide();
		$("#idarea").show();
	})
	$("#rewritePw").click(function(){
		$("#idarea").hide();
		$("#pwarea").show();
	})
</script>
</html>