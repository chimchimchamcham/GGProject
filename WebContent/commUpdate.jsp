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

<!--예약하기 달력 관련 링크-->
<!-- jquery UI 링크 -->
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- jquery UI CDN -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<!-- 언어 별 CDN -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.9.2/i18n/jquery.ui.datepicker-ko.min.js"></script>
<!-- Date 라이브러리 -->
<script type="text/javascript"
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<!--------------//////////////////////////////------------->

<style>
#mainHeader {
	z-index: 1000;
}

#main {
	background-color: gray;
	width: 1200px;
	height: 2000px;
	position: absolute;
	top: 150px;
	z-index: -1;
}

#wrap {
	width: 1200px;
	margin: 0 auto;
	text-align: left;
}

textarea {
	resize: none;
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
					<input type="text" name="title" value="" placeholder="제목을 입력해주세요" style='width: "1000px"' />
				</p>
				<form method='POST' enctype="multipart/form-date" id='uploadForm'>
					<label for='test'>
						<img src="img/plus.png" id="preview-image" width="100px" height="100px" style="border: solid 1px gray" />
					</label>
					<input type="file" name="imgFile" style="display: none" id="test" />
				</form>
				<p>
					<textarea name="content" rows="30" cols="100" placeholder="내용입력" id ="input" style="overflow-y: scroll"></textarea>
				</p>
				<div id="intro_cnt">(0 / 1000)</div>
				<p id="commuCategory">
					카테고리 선택(필수선택) &nbsp;&nbsp;&nbsp; <select name="commuCat">
						<c:forEach items="${commuCat }" var="CommuCategory">
							<option value="${CommuCategory.p_cate}">${CommuCategory.p_cateName}</option>
						</c:forEach>
					</select>
				</p>
			</div>
			<div id="twoButton">
				<input type="button" id="submit" value="등록" /> 
				<input type="button" onclick="location.href='./index.jsp'" value="취소" />
			</div>
		</div>
	</div>
</body>
<script>
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

			param.title = $("input[name='title']").val();
			param.content = $("textarea[name='content']").val();
			param.category = $("select[name='commuCat']").val();//select name으로 값 받기	
			console.log(param);
			
			//ajax url="writeCommunity"
			$.ajax({
				type : 'POST',
				url : 'updateCommunity',
				data : param,
				dataType : 'JSON',
				success : function(data) {
					if (data.p_no > 0) {
						form.append("p_no",data.p_no);
						FileUpload();
						alert("글 작성 성공했습니다.");
						//향후 변경사항 커뮤니티 글 상세보기 완성 후 변경
						location.href = "./salesDetail?p_no="+data.p_no;
						
					} else {
						alert("커뮤니티 글 작성을 실패하였습니다! ");
					}
				},
				error : function(e) {
					console.log(e);
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
			url : 'upload',
			data : form,
			asynsc:true,
			contentType:false,
			cache:false,
			processData:false,
			success : function(data) {
				if(data!=null){ // 들어오는게 String[] 이라 null인지만 판단.
					alert("사진 등록 성공");
				}else{
					alert("사진 등록 실패");
				}
			},
			error : function(e) {
				console.log(e);
			}
		});
	};
	
	/*글자수 제한*/
    $('#input').on('keyup', function() {
           $('#intro_cnt').html("("+$(this).val().length+" / 1000)");
    
           if($(this).val().length > 1000) {
               $(this).val($(this).val().substring(0, 1000));
               $('#intro_cnt').html("(1000 / 1000)");
           }
       });
	
</script>
</html>