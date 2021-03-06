<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	*{margin:0;padding:0;border-width:0;list-style-type:none;}
    body{width:100%;background-color:white;}
	#wrap{width:400px;height:200px;background-color:white;position:relative;}
	#wrap>div:nth-of-type(1){position:absolute;top:10px;left:20px;}
	#wrap>div:nth-of-type(1)>p{font-size:1.5rem;}
	
	#wrap>div:nth-of-type(2){position:absolute;top:60px;left:20px;line-height:50px;}
	#wrap>div:nth-of-type(2)>input{width:240px;height:50px;text-align:center;padding-right:30px;font-weight:700;font-size:2.5rem;border:1px solid gray;border-radius:5px/5px;}
	
	#bid{display:inline-block;margin-left:10px;width:90px;height:40px;color:white;background-color:#6E6E6E;font-size:1.1rem;border-radius:5px/5px;}
	
	#wrap>div:nth-of-type(3){position:absolute;top:140px;left:20px;}
	#wrap>div:nth-of-type(3)>div{display:inline-block;width:270px;height:40px;background-color:#BDBDBD;border-radius:5px/5px;text-align:center;font-weight:500;font-size:1.1em;line-height:40px;}
	#charge{display:inline-block;margin-left:10px;width:90px;height:40px;color:white;background-color:#6E6E6E;border-radius:5px/5px;font-size:1.1rem;}
	
	#wrap>span{top:60px;left:260px;font-weight:700;font-size:2.5rem;position:absolute;}
		
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="wrap">
		<input type="hidden" id="p_no" value="${param.p_no }">
		<input type="hidden" id="toppr" value="${param.toppr }">
		<input type="hidden" id="endpr" value="${param.endpr }">
		<div><p>${param.title } 에 <b>즉시구매하기</b></p></div>
		<div><input type="text" name="au_instantpr" id="au_instantpr" value="${param.endpr }" readonly><button id="bid">즉시구매</button></div>
		<div><div>잔여 포인트 <span id="wallet">0</span>P</div><input type="button" id="charge" value="포인트충전"></div>
		<span>P</span>
	</div>
</body>
<script>
	var loginId = "${sessionScope.loginId}";
	var param = {};
	param.id = loginId;
	$.ajax({
		type : "POST",
		url : "../pointPop",
		data : param,
		dataType : "JSON",
		success : function(data) {
			console.log(data.success);
			console.log(data.myPoint);
			if (data.success) {
				myPoint = data.myPoint;
				nickname = data.nickname;
				console.log("내포인트 : ", myPoint);
				$("#wallet").text(myPoint);
			} else {
				alert("페이지 로딩 중 오류가 발생하였습니다.");
			}
		},
		error : function(e) {
			console.log(e);
		}
	
	});
	$("#bid").click(function(){
		/* if($("#au_instantpr").val()==0){
			alert("즉결구매가를 입력하세요");
			$("#au_instantpr").focus();
		} else if($("#au_instantpr").val()<$("#toppr").val()){
			alert("현재 입찰 가격보다 큰 값을 입력하세요.");
			$("#au_instantpr").focus();
		} else{ */
			//즉결가 보다 큰 값을 입력한 경우, 즉결가 가격으로 변경
			/* var $bidpr = 0;
			if($("#au_instantpr").val()>$("#endpr").val()){
				$bidpr = $("#endpr").val();
			}else{
				$bidpr = $("#au_instantpr").val();
			}
			console.log($bidpr); */
			
			alert("즉결 구매하시겠습니까?");
			//ajax로 보낼 파라미터 값
			var param = {};
			param.p_no = $("#p_no").val();
			param.au_instantpr = $("#au_instantpr").val();
			console.log(param);
			
		 	 $.ajax({
				type : 'post',
				url : '../buyNow',
				data : param,
				dataType : 'JSON',
				success : function(data){
					console.log(data);
					if(data.success){
						alert(data.msg);
						opener.parent.location.reload();
						window.close();
					}else{
						alert(data.msg);
					}
				},
				error : function(e){
					console.log("접속 실패");
					console.log(e);
				}
			}); 
			/* alert("입찰 완료 bidpr : "+bidpr);
			opener.parent.location.reload();
			window.close(); */
		/* } */
	});
	
	//포인트버튼 클릭시 알람 뜸
	$("#charge").click(function(){
		/* alert("포인트 충전 팝업 이동"); */
		window.open("./chargePopup.jsp","chargePopup", "width=400, height=200, left=1100, top=400");

	});
	
	//입력한 값이 잔여 포인트보다 클 경우 입찰 버튼 비활성화, 검정색으로 바뀜
	/* $("#au_instantpr").on("propertychange change keyup paste input",function(){
		var $bidpr = $("#au_instantpr").val();
		var $wallet = $("#wallet").text();
		if($bidpr>$wallet){
			$("#bid").attr("disabled", true).css({"background-color":"black"});
		}else{
			$("#bid").attr("disabled", false).css({"background-color":"#6E6E6E"});
		}
	}); */
</script>
</html>