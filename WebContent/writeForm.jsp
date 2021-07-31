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
	<div id="wrap">
		<h2>글쓰기</h2>
		<!--글쓰기 폼 선택 버튼-->
		<div id="selectForm">
			<button id="sale">판매</button>
			<button id="trade">경매</button>
			<button id="community">커뮤니티</button>
		</div>
		<div id="communityForm">
			<p>
				<input type="text" name="title" value="" placeholder="제목을 입력해주세요"
					style='width: "1000px"' />
			</p>
		<form method="post" enctype="multipart/form-data" id="uploadForm">
				<label for='test'><img src="img/plus.png" id="preview-image" width="100px" height="100px" style="border: solid 1px gray" /></label>
				 <input type="file" name="imgFile" style="display: none" id="test" />
		</form>

			<p>
				<textarea name="content" rows="30" cols="100" placeholder="내용입력"
					style="overflow-y: scroll"></textarea>
			</p>
			<p id="commuCategory">
				카테고리 선택(필수선택) &nbsp;&nbsp;&nbsp; <select name="commuCat">
					<c:forEach items="${commuCat }" var="CommuCategory">
						<option value="${CommuCategory.p_cate}">${CommuCategory.p_cateName}</option>
					</c:forEach>
				</select>
			</p>
		</div>

		<div id="saleForm">
			<p id="salePr">
				<input type="text" name="price" value="" placeholder="가격 입력(숫자입력)" />&nbsp;Point
			</p>
			<p>
				거래방식(필수선택) &nbsp;&nbsp;&nbsp;<input type="radio" name="deliveryYN"
					value="Y">택배<input type="radio" name="deliveryYN" value="N">직거래
			</p>
			<p id="category">
				카테고리 선택(필수선택) &nbsp;&nbsp;&nbsp; <select name="saleCat">
					<c:forEach items="${saleCat }" var="SaleCategory">
						<option value="${SaleCategory.c_code}">${SaleCategory.c_name}</option>
					</c:forEach>
				</select>
			</p>
			<p>
				공개범위&nbsp;&nbsp;&nbsp; <input type="radio" name="disclosure"
					value="N">전체공개 <input type="radio" name="disclosure"
					value="Y">팔로우한정
			</p>
		</div>
		<!--경매선택시 하단부분-->
		<div id="tradeForm">
			<p>경매시간 설정</p>

			<!--예약 경매 버튼 클릭시-->
			<div id="reservForm">
				<p>
					<input type="date" id="from" placeholder="시작시간" name="from"
						style="width: 80px;" min="" readonly> ~ <input type="date"
						name="to" id="to" min="from" placeholder="종료시간" style="width: 80px;" readonly>
				</p>
				<!--아래에 선택 일자 표시-->
				<!--<p><input type="text" id="alternateFrom" size="30"> ~ <input type="text" id="alternateTo" size="30"></p>-->
			</div>
			<p>
				시작가격&nbsp;<input type="text" name="startPrice" value=""
					placeholder="시작가격 입력(숫자입력)" />&nbsp;Point
			</p>
			<p>
				즉결가격&nbsp;<input type="text" name="promptPrice" value=""
					placeholder="즉결가격 입력(숫자입력)" />&nbsp;Point
			</p>
		</div>
		<div id="twoButton">
			<input type="button" id="submit" value="등록" /> <input type="button"
				onclick="location.href='./index.jsp'" value="취소" />
		</div>

	</div>

</body>
<script>
	//초기상태 - 판매폼만 보이는 상태
	//폼 선택 버튼  클릭시 해당 값이 달라짐
	var param = {};
	param.userId = "${sessionScope.loginId}";
 	
	//경매하단부분 숨겨져있음
	$("#saleForm").show();
	$("#communityForm").show();
	$("#tradeForm").hide();
	$("#reservForm").hide();
	$("#commuCategory").hide();

	//경매버튼클릭시
	$("#trade").click(function() {
		param.select = "P001";

		console.log(param.select);
		$("#tradeForm,#reservForm").show();

		$("commuCategory,#salePr").hide();

	});

	//커뮤니티버튼 클릭시
	$("#community").click(function() {
		param.select = "P004";
		console.log(param.select);
		$("#tradeForm,#saleForm,#reservForm").hide();
		$("#commuCategory").show();
	});

	//판매버튼 클릭시
	$("#sale").click(function() {
		param.select = "P002";
		console.log(param.select);
		$("#tradeForm,#reservForm,#commuCategory").hide();
		$("#saleForm,#salePr").show();
	});

	//경매폼에서 예약경매하기 버튼 클릭시
	$("#reservBtn").click(function() {
		$("#endDate").toggle();
		$("#reservForm").toggle();

	});
	
	//사진 담을 객체
	var form = $('#uploadForm')[0];
	
   var form_data = new FormData(form);
	console.log(form_data);
	//data.append($('#test').prop('files')[0]);
	
	//등록버튼 클릭시 
	$("#submit2").click(function(){
		console.log(form);
		console.log(data);
		//console.log($("form input"));
	 /* var param = {};
		$("form input").each(function(idx,item){
			//console.log(item)
			param[$(item).attr("name")]=$(item).val();
		});
		param.content = $("textarea").val();
		console.log(param); */ 
	});
	
	$("#submit").click(function() {

		if (param.select == "P004") { //커뮤니티글 선택시
			/* $("form input").each(function(idx,item){
				//console.log(item)
				param[$(item).attr("name")]=$(item).val();
			}); */
			param.title = $("input[name='title']").val();
			param.content = $("textarea[name='content']").val();
			param.category = $("select[name='commuCat']").val();//select name으로 값 받기	
			console.log(param);
			
			//ajax url="writeCommunity"
			$.ajax({
				type : 'POST',
				url : 'writeCommunity',
				data : param,
				dataType : 'JSON',
				success : function(data) {
					if (data.success) {
						alert("글 작성 성공했습니다.");
						location.href = 'index.jsp';

					} else {
						alert("커뮤니티 글 작성을 실패하였습니다! ");
					}
				},
				error : function(e) {
					console.log(e);
				}

			})
			

		} else if (param.select == "P002") { //판매글 선택시
			param.title = $("input[name='title']").val();
			param.content = $("textarea[name='content']").val();
			param.category = $("select[name='saleCat']").val();//select name으로 값 받기	
			param.deliveryYN = $("input[name='deliveryYN']:checked").val();
			param.price = $("input[name='price']").val();
			param.disclosure = $("input[name='disclosure']:checked").val();
			//ajax url="sale"
			console.log(param);
			$.ajax({
				type : 'POST',
				url : 'writeSale',
				data : param,
				dataType : 'JSON',
				success : function(data) {
					if (data.success) {
						alert("판매글 작성 성공했습니다.");
						location.href = 'index.jsp';

					} else {
						alert("판매 글 작성을 실패하였습니다! ");
					}
				},
				error : function(e) {
					console.log(e);
				}

			})
		} else if (param.select == "P001") {//경매글 선택시
			param.title = $("input[name='title']").val();// 제목
			param.content = $("textarea[name='content']").val(); //내용
			param.category = $("select[name='saleCat']").val();//select name으로 값 받기	
			param.startPr = $("input[name='startPrice']").val(); //시작가
			param.instantPr = $("input[name='promptPrice']").val(); // 즉결가
			param.deliveryYN = $("input[name='deliveryYN']:checked").val(); //택배여부
			param.followYN = $("input[name='disclosure']:checked").val(); // 팔로워 한정 여부
			param.startTm = $("#from").val(); // 시작 날짜
			param.endTm = $("#to").val();
			var checker = true;
			console.log(param);
			//ajax url="trade"
			if (param.startPr > param.instantPr) {
				alert("시작 가격이 즉결가 보다 높거나 같습니다. 다시 설정해 주세요");
				checker = false;
				$("input[name='promptPrice']").val("");
				$("input[name='promptPrice']").focus();
			}
			if (checker == true) {
				$.ajax({
					type : 'POST',
					url : 'writeTrade',
					data : param,
					dataType : 'JSON',
					success : function(data) {
						console.log(data.p_no);
						form_data.append("p_no",data.p_no);
						console.log("data : ",data);
						$.ajax({
							 type: "POST",
							 enctype: 'multipart/form-data',
						     url: "upload",
						     data: form_data,
						     processData: false,
						     contentType: false,
						     cache: false,
						     success : function(data) {
								console.log(data.success);
						},error : function(e) {
							console.log(e);
						}

					})
						
					},
					error : function(e) {
						console.log(e);
					}

				})
			}

		} else {
			alert("폼을 선택해주세요!");
		}
	});
	
	///////사진 선택시 미리보기 변경/////////
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
	}
	// input file에 change 이벤트 부여
	const inputImage = document.getElementById("test")
	inputImage.addEventListener("change", e => {
	    readImage(e.target)
	})
	
</script>
</html>