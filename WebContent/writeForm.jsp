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

<!-- 종료시간/예약경매시간 설정 달력 -->
<link href="./air-datepicker/dist/css/datepicker.min.css"
	rel="stylesheet" type="text/css" media="all">
<!-- Air datepicker css -->
<script src="./air-datepicker/dist/js/datepicker.js"></script>
<!-- Air datepicker js -->
<script src="./air-datepicker/dist/js/i18n/datepicker.ko.js"></script>
<!-- 달력 한글 추가를 위해 커스텀 -->


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
			<p class="imgFileUpload">
				<img src="img/plus.png" class="imgFileBtn" alt="plus" width="100px" />
				<input type="file" name="imgFile" style="display: none" />
			</p>
			<p>
				<textarea name="content" rows="30" cols="100" placeholder="내용입력"
					style="overflow-y: scroll"></textarea>
			</p>
			<p id="commuCategory">
				카테고리 선택(필수선택) &nbsp;&nbsp;&nbsp; <select name="commuCat">
					<c:forEach items="${commuCat }" var="CommuCategory">
						<option value="${CommuCategory.c_code}">${CommuCategory.c_name}</option>
					</c:forEach>
				</select>
			</p>
		</div>

		<div id="saleForm">
			<p>
				<input type="text" name="price" value="" placeholder="가격 입력(숫자입력)" />&nbsp;Point
			</p>
			<p>
				거래방식(필수선택) &nbsp;&nbsp;&nbsp;<input type="radio" name="deliveryYN"
					value="delivery">택배<input type="radio" name="deliveryYN"
					value="direct">직거래
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
					value="all">전체공개 <input type="radio" name="disclosure"
					value="follow">팔로우한정
			</p>
		</div>
		<!--경매선택시 하단부분-->
		<div id="tradeForm">
			<p>경매시간 설정</p>
			<p>
				현재시간 ~ 종료시간<input type="text" name="endDate" value=""
					id="datepicker" readonly>
			</p>


			<!--예약 경매 버튼 클릭시-->
			<button id="reservBtn">예약경매하기</button>
			<div id="reservForm">
				<p>
					<input type="text" id="datepicker1" placeholder="시작시간"
						style="width: 80px;" readonly> ~ <input type="text"
						id="datepicker2" placeholder="종료시간" style="width: 80px;" readonly>
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
			<button id="submit">등록</button>
			<button onclick="location.href='./index.jsp'">취소</button>
		</div>
	</div>
</body>
<script>




//종료 날짜 설정 달력/////////////////////////////////////////////////////////////////
$("#datepicker").datepicker({
	language: 'ko'
}); 


	datePickerSet($("#datepicker1"), $("#datepicker2"), true); //다중은 시작하는 달력 먼저, 끝달력 2번째

		/*
		 * 달력 생성기
		 * @param sDate 파라미터만 넣으면 1개짜리 달력 생성
		 * @example   datePickerSet($("#datepicker"));
		 * 
		 * 
		 * @param sDate, 
		 * @param eDate 2개 넣으면 연결달력 생성되어 서로의 날짜를 넘어가지 않음
		 * @example   datePickerSet($("#datepicker1"), $("#datepicker2"));
		 */
		function datePickerSet(sDate, eDate, flag) {

			//시작 ~ 종료 2개 짜리 달력 datepicker	
			if (!isValidStr(sDate) && !isValidStr(eDate) && sDate.length > 0
					&& eDate.length > 0) {
				var sDay = sDate.val();
				var eDay = eDate.val();

				if (flag && !isValidStr(sDay) && !isValidStr(eDay)) { //처음 입력 날짜 설정, update...			
					var sdp = sDate.datepicker().data("datepicker");
					sdp.selectDate(new Date(sDay.replace(/-/g, "/"))); //익스에서는 그냥 new Date하면 -을 인식못함 replace필요

					var edp = eDate.datepicker().data("datepicker");
					edp.selectDate(new Date(eDay.replace(/-/g, "/"))); //익스에서는 그냥 new Date하면 -을 인식못함 replace필요
				}

				//시작일자 세팅하기 날짜가 없는경우엔 제한을 걸지 않음
				if (!isValidStr(eDay)) {
					sDate.datepicker({
						maxDate : new Date(eDay.replace(/-/g, "/"))
					});
				}
				sDate.datepicker({
					language : 'ko',
					autoClose : true,
					onSelect : function() {
						datePickerSet(sDate, eDate);
					}
				});

				//종료일자 세팅하기 날짜가 없는경우엔 제한을 걸지 않음
				if (!isValidStr(sDay)) {
					eDate.datepicker({
						minDate : new Date(sDay.replace(/-/g, "/"))
					});
				}
				eDate.datepicker({
					language : 'ko',
					autoClose : true,
					onSelect : function() {
						datePickerSet(sDate, eDate);
					}
				});

				//한개짜리 달력 datepicker
			} else if (!isValidStr(sDate)) {
				var sDay = sDate.val();
				if (flag && !isValidStr(sDay)) { //처음 입력 날짜 설정, update...			
					var sdp = sDate.datepicker().data("datepicker");
					sdp.selectDate(new Date(sDay.replace(/-/g, "/"))); //익스에서는 그냥 new Date하면 -을 인식못함 replace필요
				}

				sDate.datepicker({
					language : 'ko',
					autoClose : true
				});
			}

			function isValidStr(str) {
				if (str == null || str == undefined || str == "")
					return true;
				else
					return false;
			}
		}
	/////////////////////////////////////////////////////////////////////////////////////
	
	
	
		//초기상태 - 판매폼만 보이는 상태
		//폼 선택 버튼  클릭시 해당 값이 달라짐
		var param={};
		param.userId ="${sessionScope.loginId}";
		
		//경매하단부분 숨겨져있음
		$("#saleForm").show();
		$("#communityForm").show();
		$("#tradeForm").hide();
		$("#reservForm").hide();
		$("#commuCategory").hide();

		//경매버튼클릭시
		$("#trade").click(function() {
			param.select ="P001";
			
			console.log(param.select);
			$("#tradeForm").show();
			$("#reservForm,#commuCategory").hide();
			
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
			$("#saleForm").show();
		});

		//경매폼에서 예약경매하기 버튼 클릭시
		$("#reservBtn").click(function() {
			$("#reservForm").toggle();
		})
		
		
		
		//등록버튼 클릭시 
		$("#submit").click(function(){
			
			if(param.select == "P004"){ //커뮤니티글 선택시
				param.title = $("input[name='title']").val();
				param.content = $("textarea[name='content']").val();
				param.category = $("select[name='commuCat']").val();//select name으로 값 받기			
				console.log(param);
				//ajax url="community"
				$.ajax({
					type:'POST',
					url:'writeCommunity',
					data:param,
					dataType:'JSON',
					success:function(data){
						console.log(data);
					},
					error:function(e){
						console.log(e);
					}
					
				
				})
				
				
			}else if(param.select == "P002"){ //판매글 선택시
				param.title = $("input[name='title']").val();
				param.content = $("textarea[name='content']").val();
				param.category = $("select[name='saleCat']").val();//select name으로 값 받기	
				param.deliveryYN = $("input[name='deliveryYN']:checked").val();
				param.price = $("input[name='price']").val();
				//ajax url="sale"
				console.log(param);
				$.ajax({
					type:'POST',
					url:'writeSale',
					data:param,
					dataType:'JSON',
					success:function(data){
						console.log(data);
					},
					error:function(e){
						console.log(e);
					}
					
				
				})
			}else if(param.select == "P001"){//경매글 선택시
				param.title = $("input[name='title']").val();
				param.content = $("textarea[name='content']").val();
				param.category = $("select[name='saleCat']").val();//select name으로 값 받기	
				param.price = $("input[name='price']").val();
				//ajax url="trade"
				$.ajax({
					type:'POST',
					url:'writeTrade',
					data:param,
					dataType:'JSON',
					success:function(data){
						console.log(data);
					},
					error:function(e){
						console.log(e);
					}
					
				
				})
			}else{
				alert("폼을 선택해주세요!");
			}
			
				
			
			});
		
	
</script>
</html>