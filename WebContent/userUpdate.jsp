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
#mainHeader {
	z-index: 1000;
}

#main {
	/* background-color: gray; */
	width: 1140px;
	height: auto;
	position: absolute;
	top: 150px;
	z-index: -1;
	margin: 0px auto;
	padding: 30px;
}

#phone1, #phone2, #phone3{
	width : 45px;
}

h2 {
	text-align: center;
}

table {
	margin: auto;
}

th {
	text-align: left;
	border:1px solid black;
}

button {
	text-align: center;
}

td {
	padding: 5px;
/* 	border:1px solid black; */
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

/*프로필 사진*/
.box {
    width: 130px;
    height: 130px; 
    border-radius: 50%;
    overflow: hidden;
    margin:0px auto;
}

.profile {
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
	<h2>회원정보 수정</h2>
	<form action="userUpdate" method="POST" enctype="multipart/form-data"
		id="userUpdate">
		<table>
			<tr>
				<th>닉네임</th>
			</tr>
			<tr>
				<td colspan="2"><input type="text" name="nname"
					value="${userUpdate.u_nname}" id="nname" placeholder="닉네임" />
					<input type='button' id="nname_overlay" value='중복확인' /></td>
			</tr>
			<tr>
				<td id='nname_check'></td>
			</tr>
			<tr>
				<th>비밀 번호</th>
			</tr>
			<tr>
				<td colspan="2"><input type="password" name="pw"
					value="${userUpdate.u_pw}" placeholder="비밀번호"/></td>
			</tr>
			<tr>
				<th>비밀 번호 확인</th>
			</tr>
			<tr>
				<td colspan="2"><input type="password" name="re_pw"
					value="${userUpdate.u_pw}" placeholder="비밀번호 확인" /></td>
			</tr>
			<tr>
				<th>이름</th>
				<td><input type="text" name="name" value="${userUpdate.u_name}" placeholder="이름" /></td>
			</tr>
			<tr>
				<th>자기소개 수정</th>
				<td><textarea name="intro" id="intro" style="resize: none; width:500px; height:150px;" placeholder="자기소개를 입력해 주세요">${userUpdate.u_intro}</textarea></td>
				<td><div id="intro_cnt">(0 / 1000)</div></td>
			</tr>
			<tr>
				<th>프로필 사진</th>
				<td>
					<p>
						<input type="file" name="photo" accept=".gif, .jpg, .png, .jpeg" id="test"/>
					</p> <c:if test="${userUpdate.u_newName  eq 'default-profile.png'}">
					<div class="box" >
    					<img class="profile" src="./img/default-profile.png" id="preview-image" >
					</div>
					</c:if> <c:if test="${userUpdate.u_newName  ne 'default-profile.png'}">
					<div class="box" >
    					<img class="profile" src="/photo/${userUpdate.u_newName}" id="preview-image" >
					</div>
					</c:if>
					<!-- <button type="button" id="default-image">기본 이미지</button> -->
				</td>
			</tr>
			<tr>
				<th>핸드폰 번호</th>
			</tr>
			<tr>
			<td colspan="2">
				<input type='text' name='phone1' maxlength='3' id='phone1' value=""  />&nbsp;-
				<input type='text' name='phone2' id='phone2' maxlength='4' value="" />&nbsp;-
				<input type='text' name='phone3' id='phone3' maxlength='4' value="" />
			</td>
			</tr>
			<tr>
				<th>이메일</th>
			</tr>
			<tr>
				<td><input type="text" name="email" value="" placeholder="이메일" maxlength="20">&nbsp;@ <select
					name="mail">
						<option value='naver.com'>naver.com</option>
						<option value='daum.net'>daum.net</option>
						<option value='google.com'>google.com</option>
				</select></td>
			</tr>
			<tr>
				<th>주소</th>
			</tr>
			<tr>
				<td><input type='text' name='addr' value="${userUpdate.u_addr}" placeholder="주소"  
					required /> <input type='text' name='detailAddr' placeholder="(상세주소)"
					value="${userUpdate.u_detailAddr}" required /></td>
			</tr>
			<tr>
				<td colspan="2"><input type="button"
					onclick="location.href='myPage.jsp'" value="취소" />
					<button type="button" id="updateBtn">저장</button></td>
			</tr>
		</table>
	</form>
	</div>
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
							document.getElementById('nname').readOnly = true;
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
	
	/*빈칸 확인, 닉네임 중복체크 확인 여부*/
		var chk_pw = $("input[name='pw']");//비번
		var chk_re_pw = $("input[name='re_pw']");//비밀번호 확인칸
		var chk_nname = $("input[name = 'nname']");
		var chk_name = $("input[name='name']");//이름
		var chk_phone1 = $("input[name='phone1']");// 전화번호1
		var chk_phone2 = $("input[name='phone2']");// 전화번호2
		var chk_phone3 = $("input[name='phone3']");// 전화번호3
		var chk_email = $("input[name='email']");//이메일아이디
		var chk_mail = $('select'); // 이메일주소
		var chk_addr = $("input[name='addr']"); //주소
		var chk_detailAddr = $("input[name='detailAddr']"); // 상세주소
		
		var user_nname = "${userUpdate.u_nname}";
		
		/*저장 버튼 클릭 시 확인*/
	 $("#updateBtn").click(function(){
				console.log("수정사항 체크");
				
				/*닉네임 중복체크 확인*/
				 if(user_nname == chk_nname.val()){
					 overChk=true;
				 }
				 
				 if (chk_pw.val() == "") {
					alert("비밀번호를 입력해 주세요!!");
					chk_pw.focus();
				} else if (chk_re_pw.val() == "") {
					alert("비밀번호 확인칸을 입력해 주세요!");
					chk_re_pw.focus();
				} else if (chk_pw.val() != chk_re_pw.val()) {
					alert("비밀번호가 일치하지 않습니다!")
					chk_re_pw.focus();
				} else if (chk_nname.val() == "") {
					alert("닉네임을 입력해 주세요!");
					chk_nname.focus();
				} else if (chk_name.val() == "") {
					alert("이름 입력해 주세요!!");
					chk_name.focus();
				}else if(chk_phone1.val() =="") {
					alert("핸드폰 번호를 입력해 주세요!!");
					chk_phone1.focus();
				}else if(chk_phone2.val() =="") {
					alert("핸드폰 번호를 입력해 주세요!!");
					chk_phone2.focus();
				}else if(chk_phone3.val() =="") {
					alert("핸드폰 번호를 입력해 주세요!!");
					chk_phone3.focus();
				}else if (chk_email.val() == "") {
					alert("이메일을 입력해 주세요!!");
					chk_email.focus();
				} else if (chk_addr.val() == "") {
					alert("주소를 입력해 주세요!!");
					chk_addr.focus();
				} else if (chk_detailAddr.val() == "") {
					alert("상세 주소를 입력해 주세요!!");
					chk_detailAddr.focus();
				}else if(overChk==false){
				         alert("닉네임 중복체크를 해주세요!!!");
				}else{ //모든 조건이 맞을 경우
					$("#userUpdate").submit();
				}
	   });
		
		/*사진 미리보기*/
		function readImage(input) {
		    // 인풋 태그에 파일이 있는 경우
		    if(input.files && input.files[0]) {
		        // 이미지 파일인지 검사 (생략)
		        // FileReader 인스턴스 생성
		        const reader = new FileReader()
		        // 이미지가 로드가 된 경우
		        reader.onload = e => {
		            const previewImage = document.getElementById("preview-image");
		            previewImage.src = e.target.result;
		        }
		        // reader가 이미지 읽도록 하기
		        reader.readAsDataURL(input.files[0])
		    }
		};
		// input file에 change 이벤트 부여
		const inputImage = document.getElementById("test")
		inputImage.addEventListener("change", e => {
		    readImage(e.target)
		});
		
		/*기본이미지로 변경*/
		/* $("#default-image").click(function(){
			document.getElementById("preview-image").src = "./img/default-profile.png";
		}); */
		
</script>
</html>