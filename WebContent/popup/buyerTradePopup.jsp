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

#top_content{position:relative; /* background-color:yellow; */ width:200px; top:15px;left:60px;text-align:center;}

#send_price{display:inline-block; position:relative; top:25px;left:38px;width:190px;height:50px;text-align:center;font-weight:500;font-size:2.5rem;border:1px solid gray;border-radius:5px/5px;padding-left:10px;padding-right:40px;}
.p{font-size:2.5rem; position:absolute; top:46px;left:240px }
#remainPoint{position:relative;top:36px;left:45px;width:230px; height:25px; background-color:#C1C6C6;border-radius:5px/5px;text-align:center;font-size:0.9rem}
#threeBtn{position:absolute; top:140px; /* background-color:blue; */width:180px; left:75px}
#threeBtn>button{width:80px; height:40px; border-radius:5px/5px;font-size:0.8rem; float:left;margin:5px}
#sendY{background-color:#FF7E00;color:white}
#chargeBtn{color:white;background-color:#0048FF;}
#receiveY{background-color:#FF7E00;color:white;}

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
#date{text-align:right;font-size:0.8rem;}

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
	$("#condition").css({"color":"#C1C6C6"});
	$("#sendY").css({"background-color":"#FF7E00"});
	$("#chargeBtn").css({"backgroud-color":"#0048FF"});
	$("#top_content_1").show();
	$("#top_content_2,#top_content_3").hide(); 
	$("#receiveY").hide();
	$("#sendY,#chargeBtn").attr("disabled",false);	
	$("#reply").hide();
	$("#content").show();
	$("#replyBtn").hide();	 	  
	
	/* /* 거래 후기 >>>> 향후 삭제 */
	//$("#content").hide();
	//$("#reply").show();	
	//$("#chargeBtn").hide();
	/*-------------*/ 
		
	//신고하기 버튼을 누르면 팝업창 띄우기
	//세션 아이디 가져오기
	
	$("#report").click(function(){
		
  		window.open("./popup/notifyPopup.jsp?N_receiveId="+loginId, "notifyPopup", "width=400, height=250, left=700, top=400");
    });
	 
	//거래상태 받아와서 상태 변경
	var trade_con ="${dto.ht_code}"; //${dto.ht_code}
	//거래페이지 생성상태인 경우 
	//dto.c_code ="HT001" = 초기상태
	
	//거래페이지 송금상태인 경우
	//dto.c_code ="HT002"
	 if(trade_con == "HT002"){ 
		$("#send").css({"color":"#3BC312"}); //송금상태 불들어오는거
		$("#sendY,#chargeBtn").css({"background-color":"gray"});
		$("#sendY,#chargeBtn").attr("disabled",true);
	}else if(trade_con == "HT003"){//거래페이지 승인거부인 경우 -> 송금 전 상태와 동일
		$("#condition").css({"color":"#C1C6C6"});
		$("#sendY").css({"background-color":"#FF7E00"});
		$("#chargeBtn").css({"backgroud-color":"#0048FF"});
		$("#sendY,#chargeBtn").attr("disabled",false);	
	}else if(trade_con == "HT004"){//거래페이지 배송대기의 경우
		$("#send_price").attr('readonly',true);
		$("#send,#approval").css({"color":"#3BC312"}); 
		$("#sendY,#chargeBtn").css({"background-color":"gray"});
		$("#sendY,#chargeBtn").attr("disabled",true);
		$("#top_content_2").show();
		$("#top_content_1,#top_content_3").hide();
	}else if(trade_con == "HT005"){//거래페이지 수취대기 상태의 경우
		$("#send_price").attr('readonly',true);
		$("#send,#approval,#shipping").css({"color":"#3BC312"}); 
		$("#chargeBtn").css({"background-color":"gray"});
		$("#chargeBtn").attr("disabled",true);
		$("#sendY").hide();
		$("#receiveY").show();
	}else if(trade_con == "HT006"){//거래페이지 수취확인 상태의 경우 
		$("#send,#approval,#shipping,#receive").css({"color":"#3BC312"}); 
		$("#reply").show();
		$("#content,#chargeBtn").hide();
		$("#sendY").hide();
		$("#reply").show();
	 }else if(trade_con == "HT007"){//거래페이지 거래취소인 상태의 경우
		 $("#sendY,#chargeBtn").css({"background-color":"gray"});
		 $("#sendY,#chargeBtn,#trade_cancel,#report").attr("disabled",true);
		 $("#send_price").attr('readonly',true);
	 }
	//경매냐 판매냐에 따라 가격 입력 부분 조정
	var p_code ="${dto.p_code}";
	if(p_code=="P001"){//경매인경우 넘겨준 가격 그대로 설정
		$("#send_price").attr('readonly',true);
		$("#send_price").attr('value',"${dto.ha_bidPr}");

	}else{//판매인경우 입력가능 (거래히스토리에 저장된 값을 불러옴)
		$("#send_price").attr('readonly',false);
		$("#send_price").attr('value',"${dto.ht_point}");
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
			<div id="top_content_1"><span>${dto.t_saler}</span>님에게 <span>승인요청</span>중...</div>
			<div id="top_content_2">배송대기중...</div>
			<div id="top_content_3">수취대기확인중...</div>
		</div>
		<div id="writePoint"><input type="text" name="ht_point" id="send_price" value="0"></div>
		<span class="p"><b>P</b></span>
		<div id="remainPoint"><span>${dto.t_buyer}</span>님의 잔여 포인트 : <span id="wallet">${dto.t_point }</span>P</div>
		<div id="threeBtn">
			<button type="button" id="sendY">송금</button>
			<button type="button" id="receiveY">수취확인</button>
			<button type="button" id="chargeBtn">포인트 충전</button>
			<button type="button" id="replyBtn">거래후기</button>
		</div>
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
				<!-- <div class="commentBox floatLeft">
					<p  class="tradeUser" ><span>유저2</span><span>(구매자)</span></p>
					<p>안녕하세요? 혹시 네고 가능할까요? 5000원 네고 해주시면 감사하겠습니다.</p>
					<p id="date">2021-07-27</p>
				</div>
				<div class="commentBox floatRight">
					<p class="tradeUser"><span>유저1</span><span>(나)</span></p>
					<p>안녕하세요? 3천원 까지는 가능합니다</p>
					<p id="date">2021-07-27</p>
				</div>
				<div class="commentBox floatLeft">
					<p class="tradeUser"><span>유저2</span><span>(구매자)</span></p>
					<p>그럼 3천원 네고 해주세요 ㅋㅋ</p>
					<p id="date">2021-07-27</p>
				</div>
				<div class="commentBox floatRight">
					<p class="tradeUser"><span>유저1</span><span>(나)</span></p>
					<p>넹, 포인트 보내주세용~</p>
					<p id="date">2021-07-27</p>
				</div> -->
			</div>
			
			<div id="writeWrap">
				<span id="tradeNname">톡 보내기</span>
				<textarea id="writeComment" cols="30" rows="10" placeholder="메시지를 입력하세요"></textarea>
				<input type="button" id="commentSubmit" value="등록">
			</div>	
		</div>
		
	</div>

	<input type="hidden" name="t_no" value="${dto.t_no}"/>
	<input type="hidden" name="p_no" value="${dto.p_no }"/>
	<input type="hidden" name="t_buyer" value="${dto.t_buyer }"/>
	<input type="hidden" name="t_saler" value="${dto.t_saler }"/>
	<input type="hidden" name="p_code" value="${dto.p_code }"/>

</div>
</form>
</body>
<script>
//수취확인 눌렀을 때 

var ht_point = $("input[name=ht_point]").val();
var t_saler = "${dto.t_saler}";
var p_no = $("input[name=p_no]").val();
var t_no = $("input[name=t_no]").val();
var p_code = $("input[name=p_code]").val();

$("#receiveY").click(function(){
	console.log(loginId);
	window.open("./popup/checkReceipt.jsp?t_buyer="+loginId+"&ht_point="+ht_point+"&t_saler="+t_saler+"&p_no="+p_no+"&t_no="+t_no+"&p_code="+p_code, "checkReceipt", "width=400, height=250,left=700, top=400");
});
//송금하기를 눌렀을 때
$("#sendY").click(function(){
	console.log("click");
	$("form").attr("action", "sendPoint");
	$("form").submit(); 
});

//입력한 값이 잔여 포인트보다 클 경우 입찰 버튼 비활성화, 검정색으로 바뀜 //
$("#send_price").on("propertychange change keyup paste input",function(){
	var $bidpr = $("#send_price").val();
	var $wallet = $("#wallet").text();
	if(Number($bidpr)>Number($wallet)){
		$("#sendY").attr("disabled", true).css({"background-color":"gray"});
	}else{
		$("#sendY").attr("disabled", false).css({"background-color":"#FF7E00"});
	}
});
//팝업창에서 실행할 함수 >수취확인시
function receiptClick(){
	$("form").attr("action", "productReceive");
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

//후기작성완료버튼 클릭시 
$("#sendReply").click(function(){
	console.log("click!");
	alert("후기 작성이 완료되었습니다.");
	window.close();
});

//포인트버튼 클릭시 알람 뜸
$("#chargeBtn").click(function(){
	/* alert("포인트 충전 팝업 이동"); */
	window.open("./popup/chargePopup.jsp","chargePopup", "width=400, height=200, left=1100, top=400");
});

/* 거래댓글 관련 */
//처음에 무조건 실행
showCommentList();
$("#viewWrap").scrollTop($("#viewWrap")[0].scrollHeight);
$("#viewWrap").scrollTop($("#viewWrap")[0].scrollHeight);

/* 댓글 창 보여주기 */
function showCommentList(){
	console.log("${dto.t_no}");
	$.ajax({
  	url:"tradeCommentList",
  	data: {"t_no" : "${dto.t_no}"	
  	},
  	success: function(data){
  		console.log("거래댓글 리스트 진입");
  		$("#viewWrap").html(data);
  		$("#viewWrap").scrollTop($("#viewWrap")[0].scrollHeight);
  	},
  	error: function(e){
  		console.log("진입 실패");
  	}

  });
}

/* 톡 읽어오기를 클릭하면 댓글 목록을 다시 불러온다*/
$("#commentReload").on("click",function(){
	showCommentList();
});

/* 엔터키를 눌렀을 때 등록버튼을 클릭하게 하기*/
  $("#writeComment").keypress(function(event){
     if(event.which == 13){
        $("#commentSubmit").click();
     }
  });

/* 등록버튼을 누르면 댓글이 추가된다.*/
$("#commentSubmit").on("click",function(){
	var param = {};
	param.t_no = "${dto.t_no}";
	param.tc_content = $("#writeComment").val();
	
	console.log("t_no : "+param.t_no);
	console.log("tc_content : "+param.tc_content);
	
	$.ajax({
		type: "POST",
		url : "insertTradeComment",
		data: param,
		dataType : "JSON",
		success : function(data){
			console.log("댓글 추가 완료");
			showCommentList();
			$("#writeComment").val("");
			
		},
		error : function(e){
			console.log("에러");	
			showCommentList();
			$("#writeComment").val("");
			
		}
	});
});
</script>
</html>