<%@ page import="com.gg.dto.GGDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
    *{margin:0;padding:0;border-width:0;list-style-type:none;}
    body{width:100%;background-color:white;}
	#wrap{margin-top:120px;}
	
    section{width:100%;}
    #sectionWrap{width:1200px;margin:0 auto;border-top:1px solid gray;padding:30px;}
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
    button{margin:3px;width:190px;height:80px;}
    
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
    
    
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
 
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

    //상세정보 버튼 클릭시 창이 표시
    $("#twoButton>button:nth-of-type(2)").click(function(){
        $("#twoButton>button:nth-of-type(2)").css({"background-color":"gray","color":"white"});
        $("#twoButton>button:nth-of-type(1)").css({"background-color":"white","color":"black"});
        $("#second").show();
        $("#first").hide();
    });

    //댓글 버튼 클릭시 창이 표시
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
  		var p_no = ${dto.p_no};
  		var toppr = ${dto.ha_bidPr};
  		var endpr = ${dto.au_instantPr};
  		window.open("./popup/auctionBidPopup.jsp?p_no="+p_no+"&toppr="+toppr+"&endpr="+endpr, "auctionBidPopup", "width=400, height=200, left=700, top=400");
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
    	$("#description>div:nth-of-type(1)").hide();
    	$("#description>div:nth-of-type(2)").show();
    }
    
    //즉결 가격이 999999999999 일 경우, 즉결 버튼이 비활성화 된다.
    if("${dto.au_instantPr }" == 999999999999){
    	$("#threeButton>button:nth-of-type(2)").css({"background-color":"gray"}).attr("disabled", true);
    }
    
 });
</script>
</head>
<body>
    <div id="wrap">
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
                        <div><a href="#">수정 /</a>&nbsp;<a href="#">삭제</a></div>
                        <span>현재최고 입찰가</span>
                        <div><sup>${dto.ha_bidUsr }</sup><span>${dto.ha_bidPr }P</span></div>
                        <span>즉시구매가</span>
                        <span><c:if test="${dto.au_instantPr ne 999999999999 }">${dto.au_instantPr}P</c:if>/시작가 ${dto.au_startPr }P</span>
                        <span>입찰 수</span>
                        <span>${dto.au_count }회</span>
                        <span>종료 시간</span>
                        <span>${dto.au_endTm}</span>
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
                        <button>상세정보</button>
                        <button>댓글</button>
                    </div>
                    <div id="first">
                    	<div>
                    		내용                   		
                    	</div>
                    	<div>
                    		<p>상점정보</p>
                    		<div>
	                    		<div><a href="#"><img src="./img/profile.PNG" width="100" height="100"></a></div>
	                    		<div>
	                    			<p id="u_nname">판매자 닉네임</p>
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
                    		<p><a href="#">판매자의 다른 상품 더보기 > </a></p>                    	
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
			data : {'p_no' : ${dto.p_no}},
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

</script>
</html>