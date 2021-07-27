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
fieldset {
	margin: auto;
	width: 500px;
	height: 800px;
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

	<fieldset>
		<div id='logo'>
			<a href='index.jsp'> <img src='./img/logo4.png' id='logobox' />
			</a>
		</div>
		<legend>회원가입 페이지</legend>

		<table>
			<tr>
				<th>아이디</th>
			</tr>
			<tr>
				<td colspan="2"><input type="text" name="id" /> <input
					type='button' id="id_overlay" value='중복확인' /></td>
			</tr>
			<tr>
				<td id='id_check'></td>
			</tr>
			<tr>
				<th>비밀 번호</th>
			</tr>
			<tr>
				<td colspan="2"><input type="password" name="pw"></td>
			</tr>
			<tr>
				<th>비밀 번호 확인</th>
			</tr>
			<tr>
				<td colspan="2"><input type="password" name="re_pw"></td>
			</tr>
			<tr>
				<th>닉네임</th>
			</tr>
			<tr>
				<td colspan="2"><input type='text' name='nname' /> <input
					type='button' id="nname_overlay" value='중복확인' /></td>
			</tr>
			<tr>
				<td id='nname_check'></td>
			</tr>

			<tr>
				<th>이름</th>
			</tr>
			<tr>
				<td colspan="2"><input type="text" name="name"></td>
			</tr>
			<tr>
				<th>핸드폰 번호</th>
			</tr>
			<tr>
				<td colspan="2"><input type='text' name='phone1' maxlength='3' id='phone'/>&nbsp;-
				<input type='text' name='phone2'id='phone' maxlength='4'/>&nbsp;-
				<input type='text' name='phone3'id='phone' maxlength='4'/>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
			</tr>
			<tr>
				<td><input type="text" name="email">&nbsp;@ <select>
						<option value='naver.com'>naver.com</option>
						<option value='daum.net'>daum.net</option>
						<option value='google.com'>google.com</option>
				</select></td>
			</tr>
			<tr>
				<th>주소</th>
			</tr>
			<tr>
				<td><input type='text' name='addr' /> <input type='text'
					name='detailAddr' /></td>
			</tr>
			<tr>
				<td colspan="2">
					<button onclick='join()'>회원가입</button>
					<button onclick='location.href="index.jsp"'>되돌아가기</button>
				</td>
			</tr>
		</table>
	</fieldset>
</body>
<script>
	var overChk = true;
	$("input[name='id']").keyup(function(e) {
		if (!(e.keyCode >= 37 && e.keyCode <= 40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^a-zA-Z0-9]/gi, ''));
		}
	});
	$("#phone").keyup(function(e){
		if (!(e.keyCode >= 37 && e.keyCode <= 40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi, ''));
		}
	});

	function join() {
		console.log("join");
		var $id = $("input[name='id']");//아이디 ==> 객체가 들어간다는건 $표시로 구분함.
		var $pw = $("input[name='pw']");//비번
		var $re_pw = $("input[name='re_pw']"); //비밀번호 확인칸
		var $nname = $("input[name = 'nname']");
		var $name = $("input[name='name']");//이름
		var $phone1 = $("input[name='phone1']");// 전화번호1
		var $phone2 = $("input[name='phone2']");// 전화번호2
		var $phone3 = $("input[name='phone3']");// 전화번호3
		var $gender = $("input[name='gender']:checked");//성별
		var $email = $("input[name='email']");//이메일아이디
		var $mail = $('select'); // 이메일주소
		var $addr = $("input[name='addr']"); //주소
		var $detailAddr = $("input[name='detailAddr']"); // 상세주소
		//중복 체크
		if (overChk) {
			console.log("회원가입 체크");
			if ($id.val() == "") {
				alert("아이디를 입력해 주세요!");
				$id.focus();
			} else if ($pw.val() == "") {
				alert("비밀번호를 입력해 주세요!!");
				$pw.focus();
			} else if ($re_pw.val() == "") {
				alert("비밀번호 확인칸을 입력해 주세요!");
				$re_pw.focus();
			} else if ($pw.val() != $re_pw.val()) {
				alert("비밀번호가 일치하지 않습니다!")
				$re_pw.focus();
			} else if ($nname.val() == "") {
				alert("닉네임을 입력해 주세요!");
				$nname.focus();
			} else if ($name.val() == "") {
				alert("이름 입력해 주세요!!");
				$name.focus();
			}else if($phone1.val() =="") {
				alert("핸드폰 번호를 입력해 주세요!!");
				$phone1.focus();
			}else if($phone2.val() =="") {
				alert("핸드폰 번호를 입력해 주세요!!");
				$phone2.focus();
			}else if($phone3.val() =="") {
				alert("핸드폰 번호를 입력해 주세요!!");
				$phone3.focus();
			}else if ($gender.val() == null) {
				alert("성별을 선택해 주세요!!");
				$gender.focus();
			} else if ($email.val() == "") {
				alert("이메일을 입력해 주세요!!");
				$email.focus();
			} else if ($addr.val() == "") {
				alert("주소를 입력해 주세요!!");
				$addr.focus();
			} else if ($detailAddr.val() == "") {
				alert("상세 주소를 입력해 주세요!!");
				$detailAddr.focus();
			} else {
				console.log("save");
				var param = {};
				param.id = $id.val();
				param.pw = $pw.val();
				param.name = $name.val();
				param.nname = $nname.val();
				param.phone1 = $phone1.val();
				param.phone2 = $phone2.val();
				param.phone3 = $phone3.val();
				param.email = $email.val();
				param.mail = $mail.val();
				param.addr = $addr.val();
				param.detailAddr = $detailAddr.val();
				//저장 가능
				$.ajax({
					type : "POST",
					url : 'join',
					data : param,
					dataType : 'JSON',
					success : function(data) {
						console.log(data);
						if (data.success) {
							alert("회원가입에 성공 했습니다!");
							location.href = 'index.jsp';
						} else {
							alert('회원가입에 실패 했습니다! 다시 시도해 주세요!');
						}
					},
					error : function(e) {
						console.log(e);
					}
				});
			}

		} else {
			alert("아이디 중복 체크를 해 주세요!");
		}
	}

	$("#id_overlay").click(function() {
		var id = $("input[name='id']").val();
		if (id != "") {
			console.log(id);
			$.ajax({
				type : 'get',
				url : 'id_overlay',
				data : {
					'id' : id
				},
				dataType : 'JSON',
				success : function(data) {
					console.log(data);
					if (!data.success) {
						alert("처리 중 문제가 발생했습니다. 다시 시도해 주세요.");
					} else {
						if (data.overlay) {
							$("#id_check").html("아이디가 중복됩니다!");
							$("input[name='id']").val("");
						} else {
							$("#id_check").empty();
							$("#id_check").html("사용가능한 아이디입니다!");
							overChk = true;
						}
					}
				},
				error : function(e) {
					console.log(e);
				}
			});
		} else {
			alert("중복 체크할 아이디를 입력하세요!");
			$("input[name='id']").focus();
		}
	});

	$("#nname_overlay").click(function() {
		var nname = $("input[name='nname']").val();
		console.log(nname);
		if (nname != "") {
			$.ajax({
				type : 'get',
				url : 'nname_overlay',
				data : {
					'nname' : nname
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
</script>
</html>