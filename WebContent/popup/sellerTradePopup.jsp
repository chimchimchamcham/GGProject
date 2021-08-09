<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
*{margin:0;padding:0;border-width:0;list-style-type:none;}
body{width:100%;background-color:gray;}
#wrap{width:900px;height:650px;background-color:#F2F2F2;position:relative;}

#twoButton{position:absolute; left:10px;top:15px; width:200px; /* background-color:orange; */ height:45px}
#twoButton>input{ width:65px; height:30px; border-radius:5px/5px;font-size:0.8rem; float:left;margin:5px}
#trade_cancel{background-color:#919999;color:white;}

#condition{position:absolute; left: 280px; top:20px; color:#C1C6C6; /* background-color:purple; */ width:400px; height:45px}
#send,#approval,#shipping,#receive{display:inline-block; position:absolute;} 
#approval{left:100px}
#shipping{left:200px}
#receive{left:300px}

#imgDiv{left:140px; top:100px; position:absolute; /* background-color:pink; */ width:200px; height:200px}
.img{display:block; width:180px; height:180px;}
#img_condition{position:absolute; left:20px; bottom:-5px;}
#s_a_code{background-color:#C1C6C6;border-radius:5px/5px;text-align:center;font-size:0.8rem; padding:2px}
#subject{font-size:0.8rem;}

#content{position:absolute; left:420px; top:100px;width:320px;height:200px;background-color:#F9F9F4;/*  border:2px solid #5F5F5F; */}

#top_content{position:relative; /* background-color:yellow; */ width:200px; top:30px;left:60px;text-align:center;}

/*----------해당 부분 이후 변경---------*/
#view_pnt{display:inline-block; position:relative; top:40px;left:38px;width:190px;height:50px;text-align:center;font-weight:500;font-size:2.5rem;/* border:1px solid gray; */border-radius:5px/5px;padding-left:10px;padding-right:40px;}
.p{font-size:2.0rem; position:absolute; top:65px;left:230px }

#threeBtn{position:absolute; top:130px; background-color:pink;width:180px; left:75px}
#threeBtn>button{width:80px; height:40px; border-radius:5px/5px;font-size:0.8rem; float:left;margin:5px}
#sendOk{background-color:#0048FF;color:white}
#sendRF{color:white;background-color:#FF7E00;}
#shippingOK{background-color:#21641B;color:white;}
#replyBtn{background-color:#0048FF; color:white;}

#reply{position:absolute; left:420px; top:100px;width:320px;height:200px;background-color:#F9F9F4;}
#reply>span{position:relative; left:110px; top:10px;font-size:1.5rem;}
#reply_content>span{position:relative; top:10px; left:10px; font-size:0.8rem}
#write_content{position:relative; top:20px; left:10px;}
#sendReply{position:relative; top:25px;left:130px; width:60px;height:35px;border-radius:5px/5px;font-size:0.7rem;background-color:#0048FF; color:white}

/* 구경톡 UI */
#comment{position:absolute; background-color:#A9E2F3;top:350px; width:900px; height:300px}
#comment_cnt{height:20px;padding-left:20px;background-color:gray;}
#viewWrap{height:280px;width:600px;float:left;overflow-y:scroll;}
#commentReload{margin-left:20px;}
#commentReload:hover{cursor:pointer;}

.tradeUser{font-weight:700;font-size:1.1rem;background-color:yellow;}
.commentBox{width:300px;margin:10px;background-color:white;border-radius:5px/5px;padding:5px;}
.floatLeft{float:left;}
.floatRight{float:right;}

#writeWrap{height:280px;width:300px;float:left;position:relative;}
#tradeNname{position:absolute;top:20px;left:40px;font-weight:700;font-size:1.5rem;}
#writeComment{padding:5px;resize:none;border-radius:5px/5px;position:absolute;display:block;top:60px;left:30px;}
#commentSubmit{position:absolute;top:230px;left:150px;border-radius:5px/5px;display:block;height:30px;width:100px;background-color:#BDBDBD;color:black;font-weight:700;font-size:1.5rem;}
#commentSubmit:hover{cursor:pointer;}
</style>

<script>
	var loginId = "${sessionScope.loginId}";
	$(document).ready(function(){
		
	 //초기상태 
	$("#condition").css({"color":"#C1C6C6"}); //상단 거래페이지 상태 
	$("#sendOk,#sendRF").css({"background-color":"#919999"});
	$("#top_content_1").show();
	$("#top_content_2,#top_content_3").hide(); 
	$("#sendOk,#sendRF").attr("disabled",true);	
	$("#replyBtn,#shippingOK").hide();
	$("#content").show();
	$("#reply").hide();	 
	
	/* /* 거래 후기 >>>> 향후 삭제 */
	//$("#content").hide();
	//$("#reply").show();	
	//$("#chargeBtn").hide();
	/*-------------*/ 
		
	
	
	
	
	
	
	 
	//거래상태 받아와서 상태 변경
	var trade_con ="${dto.ht_code}"; //${dto.ht_code}
	//거래페이지 생성상태인 경우 
	//dto.c_code ="HT001" = 초기상태
	
	//거래페이지 생성 상태, 승인거절 상태에서 0으로 표시
	if(trade_con=="HT001" || trade_con=="HT003"){
		$("#view_pnt").text("0");
	};
	
	
	
	//거래페이지 송금상태인 경우
	//dto.c_code ="HT002"
	 if(trade_con == "HT002"){ 
		$("#send").css({"color":"#3BC312"}); //송금상태 불들어오는거
		$("#sendRF").css({"background-color":"#FF7E00"});
		$("#sendOk").css({"background-color":"#0048FF"});
		$("#sendRF,#sendOk").attr("disabled",false);
	}else if(trade_con == "HT003"){//거래페이지 승인거부인 경우 -> 송금 전 상태와 동일
		$("#condition").css({"color":"#C1C6C6"});
		$("#sendOk,#sendRF").css({"background-color":"gray"});
		$("#sendY,#chargeBtn").attr("disabled",true);	
	}else if(trade_con == "HT004"){//거래페이지 배송대기의 경우
		$("#send,#approval").css({"color":"#3BC312"}); 
		$("#replyBtn,#shippingOK").show();
		$("#replyBtn").css({"background-color":"gray"});
		$("#replyBtn").attr("disabled",true);	
		/* $("#trade_cancel").attr("disabled",true);
		$("#trade_cancel").css({"background-color":"black"}); */
		$("#sendOk,#sendRF").hide();
		$("#view_pnt").hide();
		$(".p").hide();
		$("#top_content_2").show();
		$("#top_content_1,#top_content_3").hide();
	}else if(trade_con == "HT005"){//거래페이지 수취대기 상태의 경우
		$("#send,#approval,#shipping").css({"color":"#3BC312"}); 
		$("#replyBtn,#shippingOK").show();
		$("#sendOk,#sendRF").hide();
		$("#replyBtn,#shippingOK").css({"background-color":"gray"});
		$("#replyBtn,#shippingOK").attr("disabled",true);
		$("#trade_cancel").css({"background-color":"black"});
		 $("#trade_cancel").attr("disabled",true);
		$("#view_pnt").hide();
		$(".p").hide();
		$("#top_content_3").show();
		$("#top_content_1,#top_content_2").hide();
	}else if(trade_con == "HT006"){//거래페이지 수취확인 상태의 경우 
		$("#send,#approval,#shipping,#receive").css({"color":"#3BC312"}); 
		$("#trade_cancel").attr("disabled",true);
		$("#trade_cancel").css({"background-color":"black"});
		$("#reply").show();
		$("#content").hide();
		$("#sendOk,#sendRF").hide();
	 }else if(trade_con == "HT007"){//거래페이지 거래취소인 상태의 경우
		 $("#trade_cancel").attr("disabled",true);
		 $("#trade_cancel").css({"background-color":"black"});
	 }
		


	
	
	});
</script>

</head>
<body>
<form action="" method="post">
<div id="wrap">
	<div id="twoButton">
		<input type="button" id="trade_cancel" value="거래취소"/>
		<input type="button" id="report" value="신고하기"/>
	</div>

	<div id="condition">
		<div id="send"><b>송금 &nbsp;&nbsp;&nbsp;&nbsp;→</b></div>
		<div id="approval"><b>승인&nbsp;&nbsp;&nbsp;&nbsp;→</b></div>
		<div id="shipping"><b>배송&nbsp;&nbsp;&nbsp;&nbsp;→</b></div>
		<div id="receive"><b>수취확인</b></div>
	</div>
	
	<div id="imgDiv">
		<img class="img" src="/photo/${dto.i_newName}"/>
		<div id="img_condition">
			<span id="s_a_code">${dto.p_name}</span>
			<span id="subject">${dto.p_title }</span>
		</div>
	</div>
	
	<div id="content">
		<div id="top_content">
			<div id="top_content_1"><span>${dto.t_buyer}</span>님이 보낸 포인트</div>
			<div id="top_content_2">배송대기중...</div>
			<div id="top_content_3">수취대기중...</div>
		</div>
		<div id="writePoint"><p id="view_pnt">${dto.ht_point}</p><input type="hidden" name="ht_point" id="send_price" value="${dto.ht_point}"></div>
		<span class="p"><b>P</b></span>
		<div id="threeBtn">
			<button type="button" id="sendOk">송금확인</button>
			<button type="button" id="shippingOK">배송</button>
			<button type="button" id="sendRF">송금거절</button>
			<button type="button" id="replyBtn">거래후기</button>
		</div>
		<div></div>
	</div>
	
	<div id="reply">
		<span><b>거래후기</b></span>
		<div id="reply_content">
		<span><b>후기작성(선택사항)</b></span>
		<div id="write_content"><textarea rows="5" cols="40">좋은 상품, 좋은 가격에 잘 구매하였습니다.</textarea></div>
		<input type="button" id="sendReply" value="작성완료">
		</div>
	</div>
	
	<div id="comment">
		<div id="comment_cnt"><span>구경톡 </span><span>10</span><button id="commentReload">톡읽어오기</button></div>
		<div id="tradeCommentWrap">
			<div id="viewWrap">
				<div class="commentBox floatLeft">
					<p  class="tradeUser" ><span>유저2</span><span>(구매자)</span></p>
					<p>안녕하세요? 혹시 네고 가능할까요? 5000원 네고 해주시면 감사하겠습니다.</p>
				</div>
				<div class="commentBox floatRight">
					<p class="tradeUser"><span>유저1</span><span>(나)</span></p>
					<p>안녕하세요? 3천원 까지는 가능합니다</p>
				</div>
				<div class="commentBox floatLeft">
					<p class="tradeUser"><span>유저2</span><span>(구매자)</span></p>
					<p>그럼 3천원 네고 해주세요 ㅋㅋ</p>
				</div>
				<div class="commentBox floatRight">
					<p class="tradeUser"><span>유저1</span><span>(나)</span></p>
					<p>넹, 포인트 보내주세용~</p>
				</div>
			</div>
			
			<div id="writeWrap">
				<span id="tradeNname">유저1</span>
				<textarea id="writeComment" cols="30" rows="10">안녕하세요.</textarea>
				<button id="commentSubmit">등록</button>
			</div>	
		</div>
		
	</div>
	
</div>

	<input type="hidden" name="t_no" value="${dto.t_no}"/>
	<input type="hidden" name="p_no" value="${dto.p_no }"/>
	<input type="hidden" name="t_buyer" value="${dto.t_buyer }"/>
	<input type="hidden" name="t_saler" value="${dto.t_saler }"/>
	<input type="hidden" name="p_code" value="${dto.p_code }"/>

</form>
</body>
<script>

var view_pnt = $("#view_pnt").text();
var  t_no = $("input[name=t_no]").val();


//신고하기 버튼을 누르면 팝업창 띄우기
$("#report").click(function(){
		window.open("./popup/notifyPopup.jsp?N_receiveId="+loginId, "notifyPopup", "width=400, height=400, left=700, top=400");
});



//배송하기를 눌렀을 때
$("#shippingOK").click(function(){
	window.open("./popup/checkShipping.jsp?ht_point="+view_pnt+"&t_no="+t_no, "checkShipping", "width=400, height=250,left=700, top=400");
});

//송금확인을 눌렀을 때
$("#sendOk").click(function(){
	console.log("click");
	$("form").attr("action", "pointApproval");
	$("form").submit(); 
});

//송금거절을 눌렀을 때
$("#sendRF").click(function(){
	console.log("click");
	$("form").attr("action", "pointDeny");
	$("form").submit(); 
});

//팝업창에서 실행할 함수 >배송확인시
function receiptClick(){
	$("form").attr("action", "productShipping");
	$("form").submit(); 
}

//거래취소를 눌렀을 때
$("#trade_cancel").click(function(){
	console.log("click");
	var trade_cancel = confirm("거래취소하시겠습니까?");
	if(trade_cancel){
		$("form").attr("action", "cancelTrade");
		$("form").submit(); 
	}
	
})

</script>
</html>