<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

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

#wrap {
	width:940px;
	 padding:0 100px; 
	 	 height:auto;
	margin: 0 auto;
	text-align: left;
	
}

textarea {
	resize: none;
}

#sale, #trade, #community{
	border-width:0;
	width:100px; 
	height:50px;
	font-size:1.2rem;
	border-radius: 5px; 
	background-color:#EFEFEB;
	font-color:#757676;
/* 	margin-top:20px;
	margin-right:20px; */
	/* position:absolute; */
	/* padding:0px;
	margin:0px; */
	
	
}
#sale:hover, #trade:hover, #community:hover{
	background-color:#757676;
	color:white;
}

#write_title{
	width:940px;
	height:30px;
	font-size:18px;
}
#input{
	width:940px;
	height:500px;
	
}
#intro_cnt{
	/* float:right; */
}

#communityForm{
	padding-top:30px;
} 
/* #writeFormT tr,#writeFormT td{
	border:1px solid black;

} */
#selectForm{
	/* height:900px; */
	width:940px;
	height:50px;
	/* background-color:#EFEFEB; */
	/* position:relative; */
	
}
#submit, #cancelBtn{
	border-width:0;
	width:70px; 
	height:40px;
	font-size:0.8rem;
	border-radius: 5px;
	
}
#twoButton{
	float:right;
}

</style>
<script>
// 오늘 날짜 설정
var currDate = new Date().toISOString().substring(0,10);
console.log("오늘 날짜 : ",currDate);
</script>

</head>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
		<div id="wrap">
			<h2>커뮤니티 수정</h2>
			<div id="communityForm">
				<p>
					<input type="text" name="title" placeholder="제목을 입력해주세요" value="${commUpdate.p_title }" style='width: "1000px"' />
				</p>
				<form method='POST' enctype="multipart/form-date" id='uploadForm'>
					<label for='test'>
					<c:if test="${commUpdate.i_newName  eq null}">
						<img src="img/plus-icon.png" id="preview-image" width="100px" height="100px" style="border: solid 1px gray" />
					</c:if>
					<c:if test="${commUpdate.i_newName  ne null}">
						<img src="/photo/${commUpdate.i_newName}" id="preview-image" width="100px" height="100px" style="border: solid 1px gray" />
					</c:if>
					</label>
					<input type="file" name="imgFile" style="display: none" id="test" />
				</form>
				<p>
					<textarea name="content" placeholder="내용입력" rows="30" cols="100" id ="update" style="overflow-y: scroll" >${commUpdate.p_content}</textarea>
				</p>
				<div id="update_cnt">(0 / 1000)</div>
				<p id="commuCategory">
					카테고리 선택(필수선택) &nbsp;&nbsp;&nbsp;
					<select name="commuCat">
						<c:forEach items="${commuCat }" var="CommuCategory">
							<option value="${CommuCategory.p_cate}">${CommuCategory.p_cateName}</option>
						</c:forEach>
					</select>
				</p>
			</div>
			<div id="twoButton">
				<input type="button" id="submit" value="등록" /> 
				<input type="button" onclick="location.href='./index.jsp'" value="취소" id="cancelBtn"/>
			</div>
		</div>
	</div>
</body>
<script>
console.log("카테고리 테스트 1 : ","${commUpdate.p_cate}");
/* console.log("${commUpdate.c_name}"); */
console.log("카테고리 테스트 2 : ","${CommuCategory.p_cate}");

/*현재 글의 카테고리 초기에 뿌려주기*/
$("select[name=commuCat]").val("${commUpdate.p_cate}").prop("selected", true);

	var success = false;
  	//초기상태 - 판매폼만 보이는 상태
	//폼 선택 버튼  클릭시 해당 값이 달라짐
	var param = {};
	param.userId = "${sessionScope.loginId}";
 	
	//커뮤니티버튼 클릭시
		param.select = "P004";
		console.log(param.select);

	// 전역변수로 설정해주어야 한다.
	var form = new FormData();
	
	//등록버튼 클릭시 
	$("#submit").click(function() {
		
		// 클릭 시 폼 데이터를 가져와야 한다.		
		var data = $("#test")[0].files[0]; // input type='file'의 id 인 test 에서 첫 번째 파일데이터를 가져온다.
		form.append("imgFile",data); // form 데이터에 key value 형식으로 넣어준다.
		console.log(data);
		if($("input[name='title']").val() ==""){
			alert("제목을 입력해주세요!");
			$("input[name='title']").focus();
			return false;
		}else if($("textarea[name='content']").val() ==""){
			alert("내용을 입력해주세요!");
			$("textarea[name='content']").focus();
			return false;
		}else{
		
			param.p_no = ${commUpdate.p_no};
			param.title = $("input[name='title']").val();
			param.content = $("textarea[name='content']").val();
			param.category = $("select[name='commuCat']").val();
			console.log(param);

			$.ajax({
				type : 'POST',
				url : 'commUpdate',
				data : param,
				dataType : 'JSON',
				success : function(data) {
					if (data.sucP_no == '${commUpdate.p_no}') {
						
						form.append("p_no",data.sucP_no);
						FileUpload(); //사진 업로드
						alert("글 수정에 성공했습니다.");
						//향후 변경사항 커뮤니티 글 상세보기 완성 후 변경
						location.href = "./commDetail?p_no="+data.sucP_no;
						
					} else {
						alert("글 수정을 실패하였습니다. 다시 시도해 주세요.");
						location.href = "./commUpdateForm?p_no="+${commUpdate.p_no};
					}
				},
				error : function(e) {
					console.log(e);
				}
			
			});
		}
	});
	///////사진 선택시 미리보기 변경/////////
	function readImage(input) {
	    // 인풋 태그에 파일이 있는 경우
	    if(input.files && input.files[0]) {
	        // 이미지 파일인지 검사 (생략)
	        // FileReader 인스턴스 생성
	        const reader = new FileReader();
	        // 이미지가 로드가 된 경우
	        reader.onload = e => {
	            const previewImage = document.getElementById("preview-image");
	            previewImage.src = e.target.result;
	        };
	        // reader가 이미지 읽도록 하기
	        reader.readAsDataURL(input.files[0]);
	    }
	};
	
	// input file에 change 이벤트 부여
	const inputImage = document.getElementById("test");
	inputImage.addEventListener("change", e => {
	    readImage(e.target);
	});
	
	// ajax로 파일 보내기 formdata()
	function FileUpload(){
		$.ajax({
			type : 'POST',
			url : 'update',
			data : form,
			asynsc:true,
			contentType:false,
			cache:false,
			processData:false,
			success : function(data) {
				if(data != null){
					alert("사진 수정 성공");
				}else{
					alert("사진 수정 실패");
				}
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
	
	/*글자수 제한*/
	$('#update').on('keyup', function() {
	       $('#update_cnt').html("("+$(this).val().length+" / 1000)");

	       if($(this).val().length > 1000) {
	           $(this).val($(this).val().substring(0, 1000));
	           $('#update_cnt').html("(1000 / 1000)");
	       }
	   });

</script>
</html>