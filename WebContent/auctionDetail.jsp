<%@ page import="com.gg.dto.GGDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#mainHeader{position: relative;z-index: 1}
    *{margin:0;padding:0;border-width:0;list-style-type:none;}
    body{width:100%;background-color:white;}
	#wrap{position: absolute;top:150px;}
	
	#category{font-weight:600;font-color:#848484;font-size:1.2rem;}
    section{width:100%;}
    #sectionWrap{width:1200px;margin:0 auto;/*border-top:1px solid gray; padding:30px; */}
    #sectionWrap>article{width:1200px;height:1000px;/* border:1px solid black; */clear: both;}
    #imgWrap{width:400px;height:400px;/* background-color:green; */float:left;}
    
    #description{width:740px;height:400px;float:left;margin-left:50px;position:relative;/* background-color:white; */}
    #description>h1{margin-left:10px;margin-top:10px;font-size:2rem;}
    #description>h1>sup{border-radius:5px;margin-left:10px;background-color:blue;font-size:1rem;color:white;}
    #description>a:nth-of-type(1){position:absolute;top:10px;left:650px;text-decoration:none;color:gray;}
    #description>div:nth-of-type(1){position:absolute;top:10px;left:650px;color:gray;}
    #description>div:nth-of-type(1)>a{text-decoration:none;color:gray;}
    #description>span:nth-of-type(1){position:absolute;top:80px;left:60px;font-size:1.5rem;}
    #description>div:nth-of-type(2){position:absolute;top:60px;right:30px;}
    #description>div:nth-of-type(2)>sup{font-size:1.1rem;background-color:yellow;border-radius:3px/3px;}
    #description>div:nth-of-type(2)>span{font-size:3rem;color:red;font-weight:700;margin-left:10px;}
    #description>span:nth-of-type(2){position:absolute;top:140px;left:60px;font-size:1.5rem;}
    #description>span:nth-of-type(3){position:absolute;top:140px;right:30px;font-size:1.5rem;font-weight:600}
    #description>span:nth-of-type(4){position:absolute;top:200px;left:60px;font-size:1.5rem;}
    #description>span:nth-of-type(5){position:absolute;top:200px;right:30px;font-size:1.5rem;font-weight:600}
    #description>span:nth-of-type(6){position:absolute;top:260px;left:60px;font-size:1.5rem;color:red;font-weight:700}
    #description>span:nth-of-type(7){position:absolute;top:260px;right:30px;font-size:1.5rem;color:red;font-weight:700}
    #description>span:nth-of-type(8){position:absolute;top:320px;left:60px;font-size:1.1rem;color:gray;}
    #description>span:nth-of-type(9){position:absolute;top:350px;left:60px;font-size:1.1rem;color:gray;}
    #description>span:nth-of-type(10){position:absolute;top:320px;right:30px;font-size:1.1rem;color:gray;}
    #description>span:nth-of-type(11){position:absolute;top:350px;right:30px;font-size:1.1rem;color:gray;}
     
    #threeButton{line-height:100px;margin-left:400px;width:600px;height:100px;/* background-color:rosybrown; */float:right;}
    #threeButton>button{margin:3px;width:190px;height:80px;}
    
    #threeButton>button{color:white;font-size:1.5rem;font-weight:700}
    #threeButton>button:nth-last-of-type(4){background-color: red;}
    #threeButton>button:nth-last-of-type(3){background-color: gray;}
    #threeButton>button:nth-last-of-type(2){background-color: green;}
    #threeButton>button:nth-last-of-type(1){background-color: orange;}
    
    #twoButton>button{height:50px;font-size:1.2rem;}
    #twoButton{overflow:hidden;clear:both;}
    #twoButton>button:nth-last-of-type(1){float:left;}
    #twoButton>button:nth-last-of-type(2){float:left;}
    
    #first,#second{width:1200px;border:1px solid black;clear:both;}
    #first>div:nth-of-type(1){border:1px solid #D8D8D8;width:738px;height:400px;float:left;margin:10px;padding:20px;}
    #first>div:nth-of-type(2){width:380px;float:left;margin:10px;}
    #first>div:nth-of-type(2)>p:nth-of-type(1){font-weight:700;font-size:2rem;border-bottom:1px solid gray;margin-left:10px;}
    #first>div:nth-of-type(2)>div:nth-of-type(1){width:400px;height:120px;clear:both;}
    #first>div:nth-of-type(2)>div:nth-of-type(1)>div:nth-of-type(1){width:100px;height:100px;margin:20px 20px 10px 20px;float:left;}
    #first>div:nth-of-type(2)>div:nth-of-type(1)>div:nth-of-type(2){width:210px;height:100px;margin:20px 20px 10px 10px;float:left;}
    #u_nname{font-weight:700;font-size:1.5rem;margin:10px;}
    #reviewAvg{font-weight:500;font-size:1.3rem;margin:10px;}
    
    #follow{background-color:#E6E6E6;width:340px;height:60px;color:black;font-size:1.5rem;font-weight:700;margin:20px;border-radius:5px/5px;}
    
    #first>div:nth-of-type(2)>div:nth-of-type(2){width:340px;height:100px;margin:10px 20px;}
    #first>div:nth-of-type(2)>div:nth-of-type(2)>div{width:98px;height:98px;margin:0 6px;float:left;position:relative;border:1px solid gray;border-radius:5px/5px;}
    #first>div:nth-of-type(2)>div:nth-of-type(2)>div>p{color:white;background-color:black;opacity:0.5;bottom:0;left:10px;;position:absolute;}
    
    #first>div:nth-of-type(2)>p:last-child{text-align:center;margin:10px;}
    #first>div:nth-of-type(2)>p:last-child>a{text-decoration:none;color:#6E6E6E;font-size:1.3rem;}
    
    
    
    /* 댓글달기 영역 */
	.board_text  {
	border: 1px solid #D8D8D8;
	width: 1140px;
	height: 5vh;
	float: left;
	}
    div.pageArea{
		margin: 10px;
	}
	span.page {
		padding: 2px 10px;
		margin : 5px;
		border : 1px solid lightskyblue;
	}
.enter, #update_enter, .re_enter {
	width: 55px;
	height: 5vh;
	border : 0.5px solid gray;
	text-align: center;
	margin-bottom: 10px;
}
.enter:hover, #update_enter:hover, .re_enter:hover {
	background-color: gray;
}
.pageArea{
	margin : 0 auto;
	text-align : center;
}
#comments_img {
	width: 90px;
	height: 90px;
	border-radius: 50px;
	float: right;
	overflow: hidden;
	margin: 0px auto;
	border: 0.5px solid lightgray;

}
#comments_table {
	width: 1190px;
}
#comments_table td#profile{
	text-align: center;
	border-bottom: 0.5px solid lightgray;
	width: 92px;
	height : 117px;
}
td#content {
	width: 900px;
	border-bottom : 0.5px solid lightgray;
}
td {
	margin: 0px;
	padding: 0px;
}
a {
	text-decoration: none;
	color : black;
	font-weight: bold;
}
a:hover {
	color: pink;
}
.comm_del, .update_comment {
	cursor: pointer;
}
.comm_del:hover, .update_comment:hover {
	color: pink;
}
.update_text, .re_text {
	border: 1px solid #D8D8D8;
	width: 1140px;
	height: 5vh;
	float: left;
}
.re_Arrow, .reporter {
	cursor: pointer;
}
#before, #after {
	cursor: pointer
}
#before:hover, #after:hover {
	color: pink;
}
.comment_nav {
	cursor : pointer;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
 var page = 0;
 var id = "${sessionScope.loginId}";
 console.log("테스트용 옥션 디테일 아이디 : ", id);
 $(document).ready(function(){
	//수정 삭제버튼 숨기기
	$("#description>div:nth-of-type(1)").hide();
    //댓글 창을 숨김
    $("#second").hide();
    //상세정보 버튼 초기설정
    $("#twoButton>button:nth-of-type(1)").css({"background-color":"gray","color":"white"});
    //이전에 해당 판매글에 대해 좋아요를 누른적이 있는지 확인
    $("#threeButton>button:nth-last-of-type(3)").hide();
    /* <c:if test="${isLiked eq true}">$("#threeButton>button:nth-last-of-type(5)").hide();</c:if>
    <c:if test="${isLiked eq false}">$("#threeButton>button:nth-last-of-type(4)").hide();</c:if> */

    //댓글 버튼 클릭시 창이 표시
    $("#twoButton>button:nth-of-type(2)").click(function(){
        $("#twoButton>button:nth-of-type(2)").css({"background-color":"gray","color":"white"});
        $("#twoButton>button:nth-of-type(1)").css({"background-color":"white","color":"black"});
        page =1; // 댓글을 눌렀을 때, 페이징 처리 1로 초기화가 된다.
        $("#first").hide();
        showCommentList();
        $("#second").show();
    });

    //상세보기 버튼 클릭시 창이 표시
    $("#twoButton>button:nth-of-type(1)").click(function(){
        $("#twoButton>button:nth-of-type(1)").css({"background-color":"gray","color":"white"});
        $("#twoButton>button:nth-of-type(2)").css({"background-color":"white","color":"black"});
        $("#first").show();
        $("#second").hide();
        
    });
    
    //찜+버튼 클릭시 숨겨짐
    $("#threeButton>button:nth-last-of-type(4)").click(function(){
    	$("#threeButton>button:nth-last-of-type(4)").hide();
    	$("#threeButton>button:nth-last-of-type(3)").show();
    });
    
  	//찜-버튼 클릭시 숨겨짐
    $("#threeButton>button:nth-last-of-type(3)").click(function(){
    	$("#threeButton>button:nth-last-of-type(3)").hide();
    	$("#threeButton>button:nth-last-of-type(4)").show();
    });
    
  	//입찰하기 버튼을 누르면 팝업창 띄우기
  	$("#threeButton>button:nth-last-of-type(1)").click(function(){
  		
  	    	var p_no = "${dto.p_no}";
  	  		var toppr = "${dto.ha_bidPr}";
  	  		var endpr = "${dto.au_instantPr}";
  	  		var title = "${dto.p_title}";
  	  		var startpr = "${dto.au_startPr}";
	  		
	  		console.log("글번호 : "+p_no);
	  		console.log("시작가격 : "+toppr);
	  		console.log("즉결가격 : "+endpr);
	  		console.log("현재최고입찰가격 : "+title);
	  		console.log("타이틀 : "+startpr);
	  		
  	  		window.open("./popup/auctionBidPopup.jsp?p_no="+p_no+"&startpr="+startpr+"&toppr="+toppr+"&endpr="+endpr+"&title="+title, "auctionBidPopup", "width=400, height=200, left=700, top=400"); 	
  	    
  	});
  	
	//즉시구매 버튼을 누르면 팝업창 띄우기
  	$("#threeButton>button:nth-last-of-type(2)").click(function(){
  	
  	    	var p_no = "${dto.p_no}";
  	  		var toppr = "${dto.ha_bidPr}";
  	  		var endpr = "${dto.au_instantPr}";
  	  		var title = "${dto.p_title}";
  	  		var startpr = "${dto.au_startPr}";
  	  		
  	  		console.log("글번호 : "+p_no);
  	  		console.log("시작가격 : "+toppr);
  	  		console.log("즉결가격 : "+endpr);
  	  		console.log("현재최고입찰가격 : "+title);
  	  		console.log("타이틀 : "+startpr);
	  		
  	  		window.open("./popup/buyNowPopup.jsp?p_no="+p_no+"&startpr="+startpr+"&toppr="+toppr+"&endpr="+endpr+"&title="+title, "buyNowPopup", "width=400, height=200, left=700, top=400");
  	    
  	});
  	
	//신고하기 버튼을 누르면 팝업창 띄우기
	$("#description>a:nth-of-type(1)").click(function(){
		var N_receiveId = "${dto.p_id}"
  		window.open("./popup/notifyPopup.jsp?N_receiveId="+N_receiveId, "notifyPopup", "width=400, height=400, left=700, top=400");
    });
  	
    //팔로우 클릭시 버튼 변경
    var isFollow = false;
    $("#follow").click(function(){
    	if(!isFollow){
    		$("#follow").css({"color":"white","background-color":"gray"});
    		isFollow = true;
    	}else{
    		$("#follow").css({"color":"black","background-color":"#E6E6E6"});
    		isFollow = false;
    	}
    });
    
    //dto.ns_name 가 거래중 또는 판매완료일 경우 버튼 색상변경과 비활성화 시키기
    if($("#description>h1>sup").text()=="거래중" || $("#description>h1>sup").text()=="경매종료"){
    	$("#description>h1>sup").css({"background-color":"gray"});
    	$("#threeButton>button").css({"background-color":"gray"}).attr("disabled", true);
    }
    //판매자가 자신의 글을 본다면 수정 삭제 표시, 팔로우 숨기기, 버튼 색상변경과 비활성화 시키기
    if("${sessionScope.loginId}" == "${dto.p_id}"){
    //if("user2" == "${dto.p_id}"){
    	$("#threeButton>button").css({"background-color":"gray"}).attr("disabled", true);
    	$("#follow").css({"background-color":"gray"}).attr("disabled", true);
    	$("#description>a:nth-of-type(1)").hide();
    	$("#description>div:nth-of-type(1)").show();
    }
    
  //로그인이 안된 상태로 경매글 진입시, 모든 버튼과 팔로우 숨기기, 버튼 색상변경과 비활성화 시키기
    if("${sessionScope.loginId}" == ""){
    //if("user2" == "${dto.p_id}"){
    	$("#threeButton>button").css({"background-color":"gray"}).attr("disabled", true);
    	$("#follow").css({"background-color":"gray"}).attr("disabled", true);
    	$("#description>a:nth-of-type(1)").hide();
    	$("#description>div:nth-of-type(1)").hide();
    }
    
    //즉결 가격이 999999999999 일 경우, 즉결 버튼이 비활성화 된다.
    if("${dto.au_instantPr }" == 999999999999){
    	$("#threeButton>button:nth-of-type(2)").css({"background-color":"gray"}).attr("disabled", true);
    }
    
    //현재날짜를 가져와서 경매시작 날짜를 비교한다. 현재날짜가 더 빠를 경우, 경매상태를 경매시작전상태로 바꾸고, 좋아요, 즉시구매, 입찰하기 버튼을 비활성화 시킨다.

    var now = new Date();
    console.log(now);
    console.log(now.getTime());
     
    //양수 = 경매전
    var startTm = "${startTm}";
    var startTime = strToDate(startTm);
    console.log(startTm);
    console.log(startTime);
    console.log(startTime.getTime()-now.getTime());
    if(startTime.getTime()-now.getTime()>0){
        console.log("경매전");
        $("#description>h1>sup").text("경매전");
        $("#threeButton>button").css({"background-color":"gray"}).attr("disabled", true);
    }

    //양수 = 경매완료
    var endTm = "${endTm}";
    var endTime = strToDate(endTm);
    console.log(endTm);
    console.log(endTime);
    console.log(now.getTime()-endTime.getTime());
    if(now.getTime()-endTime.getTime()>0){
        console.log("경매완료");
        $("#description>h1>sup").text("경매완료");
        $("#threeButton>button").css({"background-color":"gray"}).attr("disabled", true);
    }
    
    //문자열을 날짜로 변경해주는 메서드
    function strToDate(str){
        var yyyy = str.substring(0,4);
        var MM = str.substring(4,6)-1;
        var dd = str.substring(6,8);
        var HH = str.substring(8,10);
        var mm = str.substring(10,12);
        var ss = str.substring(12,14);
        var time = new Date(yyyy,MM,dd,HH,mm,ss);
        return time;
    }
 });
</script>
</head>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
    <div id="wrap">
    	<p id="category">${dto.p_name } > ${dto.s_name }</p>
        <section>
            <div id="sectionWrap">
                <article>
                    <div id="imgWrap">
                        <img src="/photo/${dto.i_newName}" width="400px" height="400px">
                    	<p>i_newName ${dto.i_newName}</p>
                    </div>
                    <div id="description">
                        <h1>${dto.p_title}<sup>${dto.c_name }</sup></h1>
                        <a href="#">신고하기</a>
                        <div><a href="./auctionUpdateForm?p_no=${dto.p_no}">수정 /</a>&nbsp;<a href="#" onclick="delChk()">삭제</a></div>
                        <span>현재최고 입찰가</span>
                        <div><sup>${dto.ha_bidUsr }</sup><span>${dto.ha_bidPr }P</span></div>
                        <span>즉시구매가</span>
                        <span><c:if test="${dto.au_instantPr ne 999999999999 }">${dto.au_instantPr}P</c:if>/시작가 ${dto.au_startPr }P</span>
                        <span>입찰 수</span>
                        <span>${dto.au_count }회</span>
                        <span>시작시간 / 종료 시간</span>
                        <span>${dto.au_startTm} / ${dto.au_endTm}</span>
                        <span>거래방식 :
                        	<c:if test="${dto.s_DeliveryYN eq 'Y' }">택배</c:if>
                       		<c:if test="${dto.s_DeliveryYN eq 'N' }">직거래</c:if>  
                       	</span>
                      <% GGDto dto = (GGDto) request.getAttribute("dto"); %>
                        <span>거래지역 : ${dto.u_addr }</span> 
                        <span>좋아요 <span>${dto.p_likeCount }</span></span>
                        <span>조회수 ${dto.p_view }</span>
                         
                    </div>
                    <div id="threeButton">                    
                        <button>찜+</button><!-- +1 -->
                        <button>찜-</button><!-- -1 -->
                        <button>즉시구매</button>
                        <button>입찰하기</button>
                    </div>
                    <div id="twoButton">
                        <button>내용</button>
                        <button>댓글</button>
                    </div>
                    <div id="first">
                    	<div>
                    		${dto.p_content }                   		
                    	</div>
                    	<div>
                    		<p>상점정보</p>
                    		<div>
	                    		<div><a href="myPage?id=${dto.p_id }&url=./auctionlist"><img src="./img/profile.PNG" width="100" height="100"></a></div>
	                    		<div>
	                    			<p id="u_nname">${dto.u_nname }</p>
	                    			<p id="reviewAvg">별점 4.5</p>
	                    		</div>
                    		</div>
                    		<button id="follow">팔로우</button>
                    		<div>
                    				<%-- <c:forEach items="${sale3List }" var="dto">
                    					<div>
                    						<a href="salesDetail?p_no=${dto.p_no}"><img src="#" alt="${dto.i_newName }"></a>
                    						<p>${dto.ns_pr } P</p>                    					
                    					</div>
                    				</c:forEach> --%>
                    		</div>
                    		<p><a href="myPage?id=${dto.p_id }&list=1">판매자의 다른 상품 더보기 > </a></p>                    	
                    	</div>          
                    </div>
                    <div id="second">
      				
                    </div>
                </article>
            </div>
        </section>
    </div>
</body>
<script>
	//좋아요 등록
	$("#threeButton>button:nth-of-type(1)").click(function(){
		$.ajax({
			type : 'get',
			url : 'lovePlus2',
			data : {'p_no' : ${ dto.p_no }},
			dataType : 'JSON',
			success : function(data){
				console.log(data);
				if(data.success){
					var love = $("#description>span:nth-of-type(10)>span:nth-of-type(1)").text();
					$("#description>span:nth-of-type(10)>span:nth-of-type(1)").text(++love);
					alert('좋아요 등록 성공.');
				}else{
					alert('좋아요 등록 실패.');
				}
			},
			error : function(e){
				console.log(e);
			}
		});
	});
	
	//좋아요 해제
	$("#threeButton>button:nth-of-type(2)").click(function(){
		$.ajax({
			type : 'get',
			url : 'loveMinus2',
			data : {'p_no' : ${dto.p_no}},
			dataType : 'JSON',
			success : function(data){
				console.log(data);
				if(data.success){
					var love = $("#description>span:nth-of-type(10)>span:nth-of-type(1)").text();
					$("#description>span:nth-of-type(10)>span:nth-of-type(1)").text(--love);
					alert('좋아요 해제 성공');
				}else{
					alert('좋아요 해제 실패');
				}
			},
			error : function(e){
				console.log(e);
			}
		});
	});

	
	//경매글 삭제 버튼 클릭시
	function delChk(){
		var delChk = confirm("글을 삭제하시겠습니까?");
		if(delChk){
			location.href = "./postDel?p_no="+${dto.p_no};
			var delMsg = "${delMsg}";
			alert(delMsg);
		}
	}
	
	 /*========================== 댓글 영역  ===================================== */
	 /* 대댓글 불러오기 */
	 var re_call = true;
	 $(document).on("click",".re_Arrow", function() {
		console.log("대댓글 보기 버튼 클릭");
		var pc_parentno = $(this).attr("id");
		console.log("보여줄 대댓글 부모 번호 :", pc_parentno);
	 
	 	re_show(pc_parentno);
	 
	 });
	 var re_drawChecker = true;
	/* 대댓글 리스트 불러오기 */
	 function re_show(pc_parentno){
		 	
	 	var re_comm = {};
	 	re_comm.pc_parentno = pc_parentno;
	 	re_comm.p_no = "${dto.p_no}";
			$.ajax({
				type: "POST",
				data: re_comm,
				dataType: "JSON",
				url: "showReComment",
				success : function(data){ 
					console.log("대댓글 리스트 보여주기.");
					console.log(data.list);
					re_drawChecker =true;
					re_draw(data.list,pc_parentno);	
					
				},
				error : function(e) {
					console.log(e);
				}
			});
		};
	
	 /* 대댓글 리스트 그리기 */
	 function re_draw(list,pc_parentno) {
		 console.log("대댓글 리스트 : ", list);
		 
		 var re_comment = "";
		 if(list != null){
			list.forEach(function(item,idx){
				
			 	re_comment += "<tr id='redrawForm'>";
			 	re_comment += 	"<td style='border-bottom:0.5px solid lightgray;'><img src='./img/re_Comment.png' />"+item.u_nname +" </td>";
			 	re_comment +=  	"<td id='content'>" + item.pc_content + "</td>";
			 	re_comment += 	"<td id='right' style='border-bottom: 0.5px solid lightgray'>";
			 	if(id == item.pc_id){
			 		re_comment += 		"<img src='./img/trashbox.png' width='35px' height='35px' style='float:left' id='"+item.pc_no+"' class='comm_del'>";
			 	}
			 	else{
			 		re_comment += "<img src='./img/notify-icon.png' width='17px' height='17px' style='float:right' class='reporter' id='"+item.pc_id+"'>";
			 	}
			 	re_comment += 	"<p style='float:right; margin-right:8px'>"+item.pc_tm+"</p>";
			 	re_comment +=	"</td>";
		 		re_comment += "</tr>";
			});	 

		 }
		 
		 re_comment += "<tr id='re_comment'>";
		 re_comment += "<td colspan=3><textarea id='"+pc_parentno+"' class='re_text' style='resize: none;' placeholder='대댓글을 입력해 주세요' maxlength=300></textarea></td>";
		 re_comment += "<td><button class='re_enter' id='"+pc_parentno+"'>엔터</button></td>";
		 re_comment += "</tr>"; 
		 
		 if(re_drawChecker){
			 $("tr#update_form").remove();
			 $("tr#re_comment").remove();
			 $("tr#redrawForm").remove();
			 $("tr#"+pc_parentno).after(re_comment);
			 re_drawChecker = false;
		 }else {
			 
			 $("tr#update_form").remove();
			 $("tr#re_comment").remove();
			 $("tr#redrawForm").remove();
			 re_drawChecker = true;
		 }
		 
	 };
	
	//대댓글 등록 버튼을 눌렀을 경우.
	 $(document).on("click",".re_enter", function(){
		console.log("대댓글 등록 ");
		var p_no = "${dto.p_no}";
		var pc_parentno = $(this).attr("id");
		console.log("부모 댓글 번호 :", pc_parentno);
		var pc_content = $("#"+pc_parentno+".re_text").val();
		console.log("대댓글 내용  :", pc_content );
		if(pc_content == ''){
			alert("대댓글을 입력해주세요!");
		}else {
			
		var plus_reComm = {};
		plus_reComm.p_no = p_no;
		plus_reComm.pc_parentno = pc_parentno;
		plus_reComm.pc_content = pc_content;
		plus_reComm.pc_id = "${sessionScope.loginId}";
		
			$.ajax({
				type: "GET",
				url : "re_comment",
				data : plus_reComm,
				dataType: "JSON",
				success : function(data){
					console.log("성공");
					re_show(pc_parentno);
				},
				error : function(e){
					console.log(e);	
				}
			});
		}
		
	 });
	 
	 
	 
	/*댓글 눌러 신고 하기 */
	$(document).on('click','.reporter', function() {
			var test = $(this).attr('id');
			console.log(test)
			var N_receiveId = test;
			console.log("신고할 아이디", N_receiveId);
			window.open("./popup/notifyPopup.jsp?N_receiveId="
					+ N_receiveId, "notifyPopup",
					"width=400, height=400, left=700, top=400");
	});
	
	var check = true;
	/* 수정 버튼 */
	$(document).on('click','.update_comment', function(){
		var update_comm = $(this).attr("id");
		var update_no ={};
		update_no.pc_no = update_comm;
		console.log("변환 후 ", update_comm);
		
		var update_comment ="";
		
		update_comment += "<tr id='update_form'>";
		update_comment += "<td colspan=3><textarea id='"+update_comm +"' class='update_text' style='resize: none;' placeholder='수정할 댓글을 입력해 주세요' maxlength=300></textarea></td>";
		update_comment += "<td><button id='update_enter'>엔터</button></td>";
		update_comment += "</tr>"; 
		
		
		if(check){
			$("tr#"+update_comm).after(update_comment);
			 $("tr#redrawForm").remove();
			 $("tr#re_comment").remove();
			check = false;
		}else {
			$("tr#update_form").remove();
			$("tr#re_comment").remove();
			$("tr#redrawForm").remove();
			check = true;
		}
		console.log(check);	
		
	}); 
	
	/* 수정하기 엔터  버튼 누르기.*/
	$(document).on("click","#update_enter",function(){
		console.log("수정 버튼 클릭");
		var update_text = $(".update_text").val();
		
		if(update_text != ''){
			var update_no =$("textarea").attr("id");
			console.log("수정할 댓글 번호 : ", update_no);	
			comm_update(update_no,update_text);
			
		}else {
			alert("수정할 댓글을 입력하세요!");
		}	
	});
	/* 수정 기능 */
	function comm_update(pc_no,context){
		var update_no = {};
		update_no.pc_no = pc_no;
		
		update_no.context = context;
		
		$.ajax({
			type: "POST",
			url : "comm_update",
			data: update_no,
			dataType : "JSON",
			success : function(data){
				console.log("성공");
				showCommentList();
				check=true;
			},
			error : function(e){
				console.log("에러");		
			}
		});
	};
	/* 삭제 버튼 */
	$(document).on('click','.comm_del', function(){
		var del_comm = $(this).attr("id");
		console.log(del_comm);
		var param = {};
		param.pc_no = del_comm;
		console.log("변환 후 ", del_comm);
		
		$.ajax({
			type: "POST",
			url : "comm_del",
			data: param,
			dataType : "JSON",
			success : function(data){
				alert("삭제 성공 여부"+data.success);
				showCommentList();
			},
			error : function(e){
				console.log("에러");		
			}
		});
	});
	//경매글 블라인드 체크 여부 확인
	//판매자일경우 보이고 그 외의 사람들은 튕기기
	/*var p_blindYN = "${dto.p_blindYN}";
	if("${dto.p_blindYN}"=="Y"){
		if("${sessionScope.loginId}"!="${dto.p_id}"){
			$("#content_hide").show();
			alert("삭제된 경매글 입니다.");
			history.go(-1);
		}
	}*/
	/*글자수 제한*/
	$(document).on('keyup',".board_text", function() {
		$('#board_text_controll').html("(" + $(this).val().length + " / 300)");
		if ($(this).val().length > 300) {
			$(this).val($(this).val().substring(0, 300));
			$('#board_text_controll').html("(300 / 300)");
		}
	});	
	/* 이전 다음 버튼 */
	$(document).on("click", "#before",function(){
		console.log("page :", page);
			console.log("이전");
			if(page >1){
				page = page-1;
				showCommentList();
			}else {
				alert("마지막 페이지입니다!");
			}
	});
	/* 다음 버튼 */
	$(document).on("click","#after", function(){
		console.log("page : ", page);
		console.log("다음");
		console.log("바뀌기 전 페이지 : " , page);
		page = Number(page) + 1;
		console.log("바뀐 페이지 : " , page);
		showCommentList();
	
	});
	
		
	/* 페이지 번호로 이동할 경우 */
	$(document).on("click",".comment_nav", function(){
		
		page = $(this).attr("id");
		console.log("페이지 누름 page :",page);
		showCommentList();
		
	});

	/* 댓글 창 보여주기 */
	function showCommentList(){
		
		$.ajax({
        	url:"auctionCommentList",
        	data: {"page": page,
        			"p_no" : "${dto.p_no}"	
        	},
        	success: function(data){
        		console.log("옥션리스트 진입");
        		$("#second").html(data);
        	},
        	error: function(e){
        		console.log("진입 실패");
        	}

        });
	}
	
</script>
</html>