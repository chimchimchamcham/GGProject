<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    body{width:100%;}
	div{
		border:1px solid black;
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
		border:1px solid black;
	}
	tr,th,td{
		padding:10px;
		border:1px solid black;
	}
	#pwarea *{
		padding:3px;
		font-size:10px;
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
						<input type="button" id="searchId" value="아이디찾기"/>
					</td>
				</tr>
				<tr>
					<td id ="resultprint"></td>
				</tr>
				<tr>
					<td align="right"><input type="button" value="로그인 하러가기" onclick="location.href='login.jsp'"></td>
				</tr>
			</table>
		</div>
		<!-- --여기서 부터는 비밀번호 재설정 창-- -->
			<div id = "pwarea">
			<table id = "pwar">
				<tr>
					<th>아이디</th>
				</tr>
				<tr>
					<td><input type="text" id="chkid"/></td>
				</tr>
				<tr>
					<th>이름</th>
				</tr>
				<tr>
					<td><input type="text" id="chkname"/></td>
				</tr>
				<tr>
					<th>이메일</th>
				</tr>
				<tr>
					<td>
						<input type="text" id="chkemail"/>@
						<select name="mail">
							<option value='naver.com'>naver.com</option>
							<option value='daum.net'>daum.net</option>
							<option value='google.com'>google.com</option>
						</select>
					</td>
				</tr>
				<tr>
					<td align="right">	
						<input type="button" value="개인정보 확인" id="chkinfo"/>
					</td>
				</tr>
			</table>
			<div id="resetpw">
				<span style="font-weight:bold">비밀번호 재설정</span>
				<table>
					<tr>
						<td>새 비밀번호</td>
					</tr>
					<tr>
						<td><input type="text" id="pwchk1"/></td>
					</tr>
					<tr>
						<td>새 비밀번호 확인</td>
					</tr>
					<tr>
						<td><input type="text" id="pwchk2"/>&nbsp<span id ="alert" style="color:red">* 비밀번호가 일치하지 않습니다.</span></td>
					</tr>
					<tr>
						<td align="right"><input type="button" value="비밀번호 확인" id="chkpw"/><input type="button" value="비밀번호 변경하기"/></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
<script>
	var chkpw = false;
	$("#pwarea").hide();
	$("#resetpw").hide();
	$("#alert").hide();
	
	$("#findId").click(function(){
		$("#pwarea").hide();
		$("#idarea").show();
	})
	
	$("#rewritePw").click(function(){
		$("#idarea").hide();
		$("#pwarea").show();
	})
	
	$("#searchId").click(function(){
	$.ajax({
		type:'post',
		url:'idsearch',
		data:{
			'name':$("input[name='name']").val(),
			'email':$("input[name='email']").val(),
			'mail':$("select[name='mail']").val()
		},
		dataType:"JSON",
		success:function(data){
			console.log(data.id);
			if(data.id == null){
				$("#resultprint").html("일치하는 아이디가 없습니다.");
			}else{
				var stn = "고객님의 ID는 "+data.id+"입니다.";
				$("#resultprint").html(stn);
			}
		},
		error:function(e){
			console.log(e);
		}
	});	
	})
	
	$("#chkinfo").click(function(){
		var email = $("#chkemail").val()+"@"+$("select[name=mail]").val();
		$.ajax({
			type:"post",
			url:"chkpw",
			data:{
				"id":$("#chkid").val(),
				"name":$("#chkname").val(),
				"email":email
			},
			dataType:"JSON",
			success:function(data){
				if(data.success){
					$("#resetpw").show();
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	})
	
	$("#chkpw").click(function(){
		if($("#pwchk1").val() != "" && $("#pwchk1").val() == $("#pwchk2").val()){	
			chkpw=true;
			$("#alert").hide();
		}else{
			$("#alert").show();
		}
	})
	
	$("#chkpw").click(function(){
		if(chkpw=true){
			location.href("/changePw");
		}
	});
</script>
</html>