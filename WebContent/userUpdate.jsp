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

<style>
h2{
	text-align:center;
}
table {
	margin: auto;
}

th {
	text-align: left;
}

button {
	text-align: center;
}

td {
	padding: 5px;
}
#phone {
	width: 50px;
	text-align: center;
}

#id_check, #nname_check {
	color: red;
	padding: 0 0 0 15px;
}

#logobox {
	margin: auto;
	width: 500px;
	text-align: center;
}
</style>
<body>
<h2>${userUpdate.u_nname}님의 회원정보 수정</h2>
<form action="userUpdate" method="POST" enctype="multipart/form-data" id="userUpdate">
	<table>
		<tr>
				<th>닉네임</th>
			</tr>
			<tr>
				<td colspan="2">
					<input type="text" name="nname" value="${userUpdate.u_nname}" required/>
					<input type='button' id="nname_overlay" value='중복확인' />
				</td>
			</tr>
			<tr>
				<td id='nname_check'></td>
			</tr>
			<tr>
				<th>비밀 번호</th>
			</tr>
			<tr>
				<td colspan="2"><input type="password" name="pw" value="${userUpdate.u_pw}" required></td>
			</tr>
			<tr>
				<th>비밀 번호 확인</th>
			</tr>
			<tr>
				<td colspan="2"><input type="password" name="re_pw" value="${userUpdate.u_pw}" required></td>
			</tr>
		<tr>
			<th>이름</th>
			<td><input type="text" name="name" value="${userUpdate.u_name}" required></td>
		</tr>
		<tr>
			<th>자기소개 수정</th>
			<td><textarea name="intro"  id="intro" >${userUpdate.u_intro}</textarea></td>
			<td><div id="intro_cnt">(0 / 1000)</div></td>
		</tr>
		<tr>
			<th>프로필 사진</th>
			<td>
			<p><input type="file" name="photo" accept=".gif, .jpg, .png, .jpeg"/></p>
			
			<c:if test="${userUpdate.u_newName  eq 'default-profile.png'}">
				<img src="./img/default-profile.png" width="100px"/>
			</c:if>
			<c:if test="${userUpdate.u_newName  ne 'default-profile.png'}">
				<img src="/ProfilePhoto/${userUpdate.u_newName}" width="100px"/>
			</c:if>
			
			</td>
		</tr>
		<tr>
				<th>핸드폰 번호</th>
			</tr>
			<tr>
				<td colspan="2"><input type='text' name='phone1' maxlength='3' id='phone1' value="" required/>&nbsp;-
				<input type='text' name='phone2'id='phone2' maxlength='4' value="" required/>&nbsp;-
				<input type='text' name='phone3'id='phone3' maxlength='4' value="" required/>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
			</tr>
			<tr>
				<td><input type="text" name="email" value="" required>&nbsp;@ <select name="mail">
						<option value='naver.com'>naver.com</option>
						<option value='daum.net'>daum.net</option>
						<option value='google.com'>google.com</option>
				</select></td>
			</tr>
			<tr>
				<th>주소</th>
			</tr>
			<tr>
				<td><input type='text' name='addr' value="${userUpdate.u_addr}" required/>
				<input type='text' name='detailAddr' value="${userUpdate.u_detailAddr}" required/></td>
			</tr>
		<tr>
			<td colspan="2">
				<input type="button" onclick="location.href='myPage.jsp'" value="취소"/>
				<button type="button" id="updateBtn" >저장</button>
			</td>
		</tr>
	</table>
</form>
</body>
<script>

var msg = "${msg}";
if(msg != ""){
	alert(msg);
}

	/*세션아이디 가져오기*/
	var loginId = "${sessionScope.loginId}";

	
	/*전화번호 - 를 기준으로 자르기*/
	var phone = "${userUpdate.u_phone}";
	var arr = phone.split("-");
	console.log(arr);
	$('#phone1').attr('value',arr[0]);
	$('#phone2').attr('value',arr[1]);
	$('#phone3').attr('value',arr[2]);
	
	/*이메일 @기준으로 나누기*/
	var email = "${userUpdate.u_email}";
	var arr2 = email.split("@");
	console.log(arr2);
	$('input[name=email]').attr('value',arr2[0]);

	var overChk = false;
	
	$("#phone").keyup(function(e){
		if (!(e.keyCode >= 37 && e.keyCode <= 40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi, ''));
		}
	});

	$("#nname_overlay").click(function() {
		var nname = $("input[name='nname']").val();
		//overChk = false;
		console.log(nname);
		if (nname != "") {
			$.ajax({
				type : 'get',
				url : 'nname_overlay',
				data : {
					'nname' : nname,
				},
				dataType : 'JSON',
				success : function(data) {
					console.log(data);
					if (!data.success) {
						alert("처리 중 문제가 발생했습니다. 다시 시도해 주세요.");
					} else {
						if (data.overlay) {
							$("#nname_check").html("닉네임이 중복됩니다!");
							$("input[name='nname']").val("");
						} else {
							$("#nname_check").html("사용가능한 닉네임입니다!");
							overChk = true;
						}
					}
				},
				error : function(e) {
					console.log(e);
				}

			});
		}else {
			alert("중복 체크할 닉네임을 입력하세요!");
			$("input[name='nname']").focus();
		}
	});
	
	/*글자수 제한*/
	 $('#intro').on('keyup', function() {
	        $('#intro_cnt').html("("+$(this).val().length+" / 1000)");
	 
	        if($(this).val().length > 1000) {
	            $(this).val($(this).val().substring(0, 1000));
	            $('#intro_cnt').html("(1000 / 1000)");
	        }
	    });
	
	/*버튼 submit 제한*/
	var nname = "${userUpdate.u_nname}";
	
	 $("#updateBtn").click(function(){
		 if(nname == $("input[name='nname']").val()){
			 overChk=true;
		 }
		 
		 if(overChk==false){
	         alert("닉네임 중복체크를 해주세요");
	      }else{
	         $("#userUpdate").submit();
	      }
		
	   });
</script>
</html>