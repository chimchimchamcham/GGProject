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

</script>
</head>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
		<div id="wrap">
			<h2>경매 글 수정</h2>
			<p>
				<input type="text" name="title" value="${auctionUpdate.p_title }"
					style='width: "1000px"' placeholder="제목을 입력해주세요" />
			</p>
			<form method='POST' enctype="multipart/form-date" id='uploadForm'>
				<label for='test'> <img
					src="/photo/${auctionUpdate.i_newName}" id="preview-image"
					width="100px" height="100px" style="border: solid 1px gray" />
				</label> <input type="file" name="oriFileImg" style="display: none"
					id="test" /> <input type="file" name="oriFileImg"
					style="display: none" id="test" />
			</form>
			<p>
				<textarea name="content" rows="30" cols="100" id="update"
					style="overflow-y: scroll;" placeholder="내용입력" >
					${auctionUpdate.p_content}</textarea>
			</p>
			<div id="update_cnt">( 0 / 1000)</div>
				<p>
					거래방식(필수선택) &nbsp;&nbsp;&nbsp;
						<input type="radio" name="deliveryYN" value="Y"   <c:if test="${auctionUpdate.s_DeliveryYN eq 'Y'}">checked="checked"</c:if>/>택배
						<input type="radio" name="deliveryYN" value="N"   <c:if test="${auctionUpdate.s_DeliveryYN eq 'N'}">checked="checked"</c:if>/>직거래
				</p>
				<p id="category">
					카테고리 선택(필수선택) &nbsp;&nbsp;&nbsp;
					<select name="saleCat">
						<c:forEach items="${saleCat }" var="SaleCategory">
							<option value="${SaleCategory.c_code}">${SaleCategory.c_name}</option>
						</c:forEach>
					</select>
				</p>
				<p>
					공개범위&nbsp;&nbsp;&nbsp;
					<input type="radio" name="disclosure" value="N"  <c:if test="${auctionUpdate.s_followLimYN eq 'N'}">checked="checked"</c:if>>전체공개
					<input type="radio" name="disclosure" value="Y"  <c:if test="${auctionUpdate.s_followLimYN eq 'Y'}">checked="checked"</c:if>>팔로우한정
				</p>
			<!--예약 경매 버튼 클릭시-->
			<p>경매시간 설정</p>
			<div >
				<p>
					<input type="date" id="from" name="from" style="width: 120px;" value="${auctionUpdate.au_startTm}" >
					 ~ <input type="date" id="to" name="to" style="width: 120px;" value="${auctionUpdate.au_endTm}" >
				</p>
				<!--아래에 선택 일자 표시-->
				<!--<p><input type="text" id="alternateFrom" size="30"> ~ <input type="text" id="alternateTo" size="30"></p>-->
			</div>
			<p>
				시작가격&nbsp;<input type="text" name="startPrice"
					value="${auctionUpdate.au_startPr}" placeholder="시작가격 입력(숫자입력)" />&nbsp;Point
			</p>
			<p >
				즉결가격&nbsp;<input type="text" name="promptPrice"
					value="${auctionUpdate.au_instantPr}" placeholder="즉결가격 입력(숫자입력)" />&nbsp;Point
			</p>
			<div id="twoButton">
			<input type="button" id="submit" value="등록" /> <input type="button"
				onclick="location.href='./index.jsp'" value="취소" id="cancelBtn"/>
		</div>
		</div>
		
	</div>
	<!-- main div end -->

</body>

<script>
console.log($('input[name=deliveryYN]').val());
console.log("${auctionUpdate.s_DeliveryYN}");

/*경매중인지 여부*/
var now = new Date();
console.log(now);
console.log(now.getTime());

var startTm = "${auctionUpdate.au_startTm}";
var startTime = new Date(startTm);
console.log(startTm);
console.log(startTime);
console.log(startTime.getTime()-now.getTime());

/*경매중 일때만*/
if(startTime.getTime()-now.getTime()<0){
    console.log("경매중");
    if(${auctionUpdate.au_count} > 0){ //입찰자가 있을 때
    	console.log("입찰자 있음"); 
    	$("input[name=deliveryYN]").attr('disabled', 'disabled'); //택배 여부
    	 $("input[name=disclosure]").attr('disabled', 'disabled');  //팔로우 한정여부
    	 $("#from").attr("readonly",true); //시작시간
    	 $("#to").attr("readonly",true); //종료시간
    	 $("input[name=startPrice]").attr("readonly",true);//시작가
    	 $("input[name=promptPrice]").attr("readonly",true); //즉결가
    }else{ //입찰자가 없을 때 
    	console.log("입찰자 없음");
    	document.getElementById('from').readOnly = true;
    }
}else{
	console.log("경매 전");
}

//예약
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


$("select[name=saleCat]").val("${auctionUpdate.s_code}").prop("selected", true);
$("input[name=deliveryYN]").val("${auctionUpdate.s_DeliveryYN}").prop("checked", true);
$("input[name=disclosure]").val("${auctionUpdate.s_followLimYN}").prop("checked", true);

	var success = false;
	var param = {};
	param.userId = "${sessionScope.loginId}";

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
		}else if($("input[name='startPrice']").val() ==""){
				alert("시작 가격을 설정해주세요!");
				$("input[name='startPrice']").focus();
				return false;
			}else if($("input[name='promptPrice']").val() ==""){
				alert("즉결 가격을 설정해 주세요!");
				$("input[name='promptPrice']").focus();
				return false;
			}else if($("#to").val()==""){
				alert("경매 종료 날짜를 선택해 주세요!");
				return false;
			}else{
			
				param.p_no = ${auctionUpdate.p_no};
				param.title = $("input[name='title']").val();// 제목
				param.content = $("textarea[name='content']").val(); //내용
				param.category = $("select[name='saleCat']").val();//카테고리
				param.deliveryYN = $("input[name='deliveryYN']:checked").val(); //택배여부
				param.followYN = $("input[name='disclosure']:checked").val();; //팔로워한정 판매 여부
				param.instantPr = $("input[name=promptPrice]").val(); // 즉결가
				param.startPr = $("input[name=startPrice]").val(); // 시작가
				param.startTm = $("input[name=from]").val(); // 시작 시간
				param.endTm = $("input[name=to]").val(); // 종료 시간

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
					url : 'auctionUpdate',
					data : param,
					dataType : 'JSON',
					success : function(data) {
						console.log("글 작성 번호 :",data.sucP_no);
						form.append("p_no",data.sucP_no);
						FileUpload();
						alert("경매 글 수정을 성공했습니다.");
						location.href="./auctionDetail?p_no="+data.sucP_no;
					},
					error : function(e) {
						alert("경매 글 수정을 실패하였습니다!");
						location.href = "./auctionUpdateForm?P_no="+ ${auctionUpdate.p_no};
					}
				})
			}
		}
		})

		
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

	//시작가, 즉결가 숫자만 들어가게
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