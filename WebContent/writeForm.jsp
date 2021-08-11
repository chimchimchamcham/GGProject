<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

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
	 height:1500px; 
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
	float:right;
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
			<!--글쓰기 폼 선택 버튼-->
					<c:if test="${sessionScope.adminYN eq 'N'}">
						<div id="selectForm">
						<button id="sale">판매</button>
						<button id="trade">경매</button>
						<button id="community">커뮤니티</button>
						</div>
					</c:if>
			<div id="communityForm">
				<p>
					<input type="text" name="title" value="" id="write_title" placeholder="제목을 입력해주세요" maxlength='30'
						style='width: "1000px"' />
				</p>
				<form method='POST' enctype="multipart/form-date" id='uploadForm'>
					<label for='test'><img src="img/plus-icon.png"
						id="preview-image" width="100px" height="100px"
						style="border: solid 1px gray" /></label> <input type="file"
						name="imgFile" style="display: none" id="test" />
				</form>
				<p>
					<textarea name="content" placeholder="내용입력"
						id="input" style="overflow-y: scroll"></textarea>
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
			<div id="saleForm">
				<p id="salePr">
					<input type="text" name="price" value="" maxlength='9' placeholder="가격 입력(숫자입력)" />&nbsp;Point
				</p>
				<p id='delivery'>
					거래방식(필수선택) &nbsp;&nbsp;&nbsp;<input type="radio" name="deliveryYN"
						value="Y">택배<input type="radio" name="deliveryYN"
						value="N">직거래
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
						<input type="date" id="from" name="from" style="width: 120px;">
						~ <input type="date" id="to" name="to" style="width: 120px;">
					</p>
					<!--아래에 선택 일자 표시-->
					<!--<p><input type="text" id="alternateFrom" size="30"> ~ <input type="text" id="alternateTo" size="30"></p>-->
				</div>
				<p>
					시작가격&nbsp;<input type="text" name="startPrice" value="" maxlength='9'
						placeholder="시작가격 입력(숫자입력)" />&nbsp;Point
				</p>
				<p> 
					즉결가격&nbsp;<input type="text" name="promptPrice" value="" maxlength='9'
						placeholder="즉결가격 입력(숫자입력)" />&nbsp;Point
				</p>
			</div>
			<div id="twoButton">
				<input type="button" id="submit" value="등록" /> <input type="button"
					onclick="location.href='./index.jsp'" value="취소" id="cancelBtn"/>
			</div>
		</div>
	</div>
</body>
<script>


	// 예약
	// 경매 예약 시작 시간 초기 설정 (오늘)
	document.getElementById('from').value = currDate;
	// 경매 예약 시작 최소 시간 설정 (오늘)
    document.getElementById('from').min = currDate;
    var setting = new Date(); // 최대 날짜를 설정하기 위함.
   	console.log("setting",setting);
   	setting.setDate(setting.getDate()+30); // 오늘 기준 30일 제한 설정
   	console.log("재 세팅" ,setting);
   	// 맥스 날짜 제한 적용
    document.getElementById('from').max = setting.toISOString().substring(0,10);
	
    $("#to").click(function(){
    	//경매 종료 날 설정 (최소 시작 시간.);
    	document.getElementById('to').min= document.getElementById('from').value;
    	var maxDate = new Date(document.getElementById('from').value);
    	console.log("maxDate", maxDate);
    	// 최대 경매 기간은 7일 이내이다.
    	maxDate.setDate(maxDate.getDate()+7);
    	document.getElementById('to').max = maxDate.toISOString().substring(0,10);
    });
	/////////////////////////////////////
	var success = false;
  	//초기상태 - 판매폼만 보이는 상태
	//폼 선택 버튼  클릭시 해당 값이 달라짐
	var param = {};
	param.userId = "${sessionScope.loginId}";
    var adminYN = "${sessionScope.adminYN}";
    console.log(adminYN);
	
	if(adminYN == "N"){
	//경매하단부분 숨겨져있음
	$("#saleForm").show();
	$("#communityForm").show();
	$("#tradeForm").hide();
	$("#reservForm").hide();
	$("#commuCategory").hide();
	}else{//공지사항
		$("#saleForm").hide();
		$("#communityForm").show();
		$("#tradeForm").hide();
		$("#reservForm").hide();
		$("#commuCategory").hide();
	}

	
	//경매버튼클릭시
	$("#trade").click(function() {
		param.select = "P001";
		
		console.log(param.select);
		$("#tradeForm,#reservForm,#saleForm").show();

		$("#commuCategory,#salePr").hide();
		
		$("#trade").css({"background-color":"white","color":"black"});
		$("#community").css({"background-color":"#EFEFEB","color":"black"});
		$("#sale").css({"background-color":"#EFEFEB","color":"black"});
	});

	//커뮤니티버튼 클릭시
	$("#community").click(function() {
		param.select = "P004";
		console.log(param.select);
		$("#tradeForm,#saleForm,#reservForm").hide();
		$("#commuCategory").show();
		
		$("#trade").css({"background-color":"#EFEFEB","color":"black"});
		$("#sale").css({"background-color":"#EFEFEB","color":"black"});
		$("#community").css({"background-color":"white","color":"black"});
		
	});

	//판매버튼 클릭시
	$("#sale").click(function() {
		param.select = "P002";
		console.log(param.select);
		$("#reservForm,#tradeForm,#commuCategory").hide();
		$("#saleForm,#salePr").show();
		
		$("#trade").css({"background-color":"#EFEFEB","color":"black"});
		$("#sale").css({"background-color":"white","color":"black"});
		$("#community").css({"background-color":"#EFEFEB","color":"black"});
	});

	//경매폼에서 예약경매하기 버튼 클릭시
	$("#reservBtn").click(function() {
		$("#endDate").toggle();
		$("#reservForm").toggle();

	});
	
	// 전역변수로 설정해주어야 한다.
	var form = new FormData();
	
	//등록버튼 클릭시 
	$("#submit").click(function() {
		
		// 클릭 시 폼 데이터를 가져와야 한다.		
		var data = $("#test")[0].files[0]; // input type='file'의 id 인 test 에서 첫 번째 파일데이터를 가져온다.
		form.append("imgFile",data); // form 데이터에 key value 형식으로 넣어준다.
		console.log(data);
		//글을 작성하지 않았을 경우.
		if($("input[name='title']").val() == ""){
			alert("제목을 입력하셔야 합니다.");
			$("input[name='title']").focus();
			return false;
		}else if($("textarea[name='content']").val()==""){
			alert("내용을 입력하셔야 합니다!");
			$("textarea[name='content']").focus();
			return false;
		}else if (param.select == "P004") { //커뮤니티글 선택시
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
					if (data.p_no > 0) {
						form.append("p_no",data.p_no);
						FileUpload();
						alert("글 작성 성공했습니다.");
						//향후 변경사항 커뮤니티 글 상세보기 완성 후 변경
						location.href = "./commDetail?p_no="+data.p_no;
						
					} else {
						alert("커뮤니티 글 작성을 실패하였습니다! ");
					}
				},
				error : function(e) {
					console.log(e);
				}
				
			});
			
		} else if (param.select == "P002") { //판매글 선택시

			param.title = $("input[name='title']").val();
			param.content = $("textarea[name='content']").val();
			if(data==null){
				alert("사진을 등록하셔야만 합니다!");
				
			}else if($("input[name='price']").val() == ""){
				alert("가격을 선택하셔야 합니다!");
				$("input[name='price']").focus();
				return false;
			}else if(!$("input[name='deliveryYN']").is(":checked") ){
				alert("택배/ 직거래 선택을 하셔야 합니다!");
				$("input[name='deliveryYN']").focus();
				return false;
			}else if(!$("input[name='disclosure']").is(":checked")){
				alert("팔로우 공개 여부를 선택해주세요!");
				return false;
			}
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
					if (data.p_no>0) {
						form.append("p_no",data.p_no);
						FileUpload();
						alert("판매글 작성 성공했습니다.");
						location.href="./salesDetail?p_no="+data.p_no;
					} else {
						alert("판매 글 작성을 실패하였습니다! ");
					}
				},
				error : function(e) {
					console.log(e);
				}

			});
		} else if (param.select == "P001") {//경매글 선택시
			param.title = $("input[name='title']").val();// 제목
			param.content = $("textarea[name='content']").val(); //내용
			param.category = $("select[name='saleCat']").val();//select name으로 값 받기
			if(data==null){
				alert("사진을 등록하셔야만 합니다!");
				
			}else if($("input[name='startPrice']").val() ==""){
				alert("시작 가격을 설정해주세요!");
				$("input[name='startPrice']").focus();
				return false;
			}else if($("input[name='promptPrice']").val() ==""){
				alert("즉결 가격을 설정해 주세요!");
				$("input[name='promptPrice']").focus();
				return false;
			}else if(!$("input[name='deliveryYN']").is(":checked") ){
				alert("택배/ 직거래 선택을 하셔야 합니다!");
				$("input[name='deliveryYN']").focus();
				return false;
			}else if(!$("input[name='disclosure']").is(":checked")){
				alert("팔로우 공개 여부를 선택해주세요!");
				return false;
			}else if($("#to").val()==""){
				alert("경매 종료 날짜를 선택해 주세요!");
				return false;
			}
			
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
						console.log("글 작성 번호 :",data.p_no);
						form.append("p_no",data.p_no);
						FileUpload();
						//향후 변경사항 경매상세보기 만들고 보내주는 페이지 편집
						location.href='./auctionDetail?p_no='+data.p_no;
					},
					error : function(e) {
						console.log(e);
					}
				});
			}

		}else if(adminYN == 'Y'){ //공지사항
			   param.title = '(공지)'+$("input[name='title']").val();
			   param.content = $("textarea[name='content']").val();
			   param.adminYN = adminYN;
			   param.select = "P003";
			   console.log(param);
			   
			   $.ajax({
			      type : 'POST',
			      url : 'writeCommunity',
			      data : param,
			      dataType : 'JSON',
			      success : function(data) {
			         if (data.p_no > 0) {
			            form.append("p_no",data.p_no);
			            FileUpload();
			            alert("공지사항 글 작성 성공했습니다.");
			            location.href = "./noticeDetail?p_no="+data.p_no;
			            
			         } else {
			            alert("공지사항 글 작성을 실패하였습니다! ");
			            location.href = "./writeForm";
			         }
			      },
			      error : function(e) {
			         console.log(e);
			      }
			   }); 
		
		}else {
			alert("폼을 선택해주세요!");
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
	
    $("input[name='price']").keyup(function(e){
		if (!(e.keyCode >= 37 && e.keyCode <= 40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi, ''));
		}
	});
    $("input[name='startPrice']").keyup(function(e){
		if (!(e.keyCode >= 37 && e.keyCode <= 40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi, ''));
		}
	});
    $("input[name='promptPrice']").keyup(function(e){
		if (!(e.keyCode >= 37 && e.keyCode <= 40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi, ''));
		}
	});

</script>
</html>