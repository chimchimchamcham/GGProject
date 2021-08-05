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
#wrap{width:900px;height:650px;background-color:white;position:relative;}

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


#comment{position:absolute; top:350px;  background-color:red; width:900px; height:300px}
#comment_cnt{position:relative; left:30px; height:20px;}
#comment_cnt>#refresh_btn{background-color:white; top:3px;position:relative;}
#commentBox{background-color:yellow; width:900px; height:277px;position:relative; top:3px}
</style>

<script>
	$(document).ready(function(){
		
	 //초기상태 
	$("#condition").css({"color":"#C1C6C6"});
	$("#sendY").css({"background-color":"#FF7E00"});
	$("#chargeBtn").css({"backgroud-color":"#0048FF"});
	$("#top_content_1").show();
	$("#top_content_2,#top_content_3").hide(); 
	$("#receiveY").hide();
	$("#sendY,#chargeBtn").attr("disabled",true);	
	$("#reply").hide();
	$("#content").show();
	$("#reply").hide();	  
	
	/* /* 거래 후기 >>>> 향후 삭제 */
	//$("#content").hide();
	//$("#reply").show();	
	//$("#chargeBtn").hide();
	/*-------------*/ 
		
	//신고하기 버튼을 누르면 팝업창 띄우기
	$("#report").click(function(){
		var N_receiveId = "${dto.p_id}"
  		window.open("./notifyPopup.jsp?N_receiveId="+N_receiveId, "notifyPopup", "width=400, height=400, left=700, top=400");
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
		$("#sendY,#chargeBtn").attr("disabled",false);
	}else if(trade_con == "HT003"){//거래페이지 승인거부인 경우 -> 송금 전 상태와 동일
		$("#condition").css({"color":"#C1C6C6"});
		$("#sendY").css({"background-color":"#FF7E00"});
		$("#chargeBtn").css({"backgroud-color":"#0048FF"});
		$("#sendY,#chargeBtn").attr("disabled",true);	
	}else if(trade_con == "HT004"){//거래페이지 배송대기의 경우
		$("#send_price").attr('readonly',true);
		$("#send,#approval").css({"color":"#3BC312"}); 
		$("#sendY,#chargeBtn").css({"background-color":"gray"});
		$("#sendY,#chargeBtn").attr("disabled",false);
		$("#top_content_2").show();
		$("#top_content_1,#top_content_3").hide();
	}else if(trade_con == "HT005"){//거래페이지 수취대기 상태의 경우
		$("#send_price").attr('readonly',true);
		$("#send,#approval,#shipping").css({"color":"#3BC312"}); 
		$("#chargeBtn").css({"background-color":"gray"});
		$("#chargeBtn").attr("disabled",false);
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
		$("#send_price").attr('value',${dto.ha_bidpr});
		
	}else{//판매인경우 입력가능 
		$("#send_price").attr('readonly',false);
		$("#send_price").attr('value',0);
	}
	
	//
	
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
		<div id="writePoint"><input type="text" name="send_price" id="send_price" value="5500"></div>
		<span class="p"><b>P</b></span>
		<div id="remainPoint"><span>${dto.t_buyer}</span>님의 잔여 포인트 : <span>25000</span>P</div>
		<div id="threeBtn">
			<button type="button" id="sendY">송금</button>
			<button type="button" id="receiveY">수취확인</button>
			<button type="button" id="chargeBtn">포인트 충전</button>
			<button type="button" id="reply">거래후기</button>
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
		<div id="comment_cnt">댓글&nbsp;<span><b>6</b></span>&nbsp;<button type="button" id="refresh_btn"><img src="../img/refresh_btn.png" width="15px" height="15px"/></button></div>
		<div id="commentBox">
			<textarea>댓글창 예시</textarea>
		</div>
		
	</div>
	

	<input type="hidden" name="t_no" value="${dto.t_no}"/>
	<input type="hidden" name="p_no" value="${dto.p_no }"/>
	
	
	

	<p>${dto.t_no}/${dto.ht_code }</p>
	
</div>
</form>
</body>
</html>