<%@ page import="com.gg.dto.GGDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
    #mainHeader{
	z-index: 1000;
	}
	#main {
		background-color: gray;
		width:1200px;
		height:auto;
		position: absolute;
		top:150px;
		z-index: -1;
	}
    
    /* *{margin:0;padding:0;border-width:0;list-style-type:none;}
    body{width:100%;background-color:white;}
	#wrap{margin-top:120px;} */
	
	
    section{width:100%;}
    #sectionWrap{width:1200px;margin:0 auto;border-top:1px solid gray;padding:30px;}
    #sectionWrap>article{width:1200px;height:1000px;/* border:1px solid black; */clear: both;}
    #imgWrap{width:400px;height:400px;/* background-color:green; */float:left;}
    
    #description{width:740px;height:400px;float:left;margin-left:50px;position:relative;/* background-color:white; */}
    #description>h1{margin-left:10px;margin-top:10px;font-size:2rem;}
    #description>h1>sup{border-radius:5px;margin-left:10px;background-color:blue;font-size:1rem;color:white;}
    #salePrice{margin-left:10px;margin-top:10px;margin-bottom:50px;font-weight:700;font-size:3rem;}
    #description>p:not(:nth-of-type(1)){color:gray;margin:20px;font-size:1.2rem;}
    #description>div{position:absolute;top:30px;left:600px;width:100px;height:40px;}
    #description>div>a{text-decoration:none;color:gray;}
    
    #threeButton{line-height:100px;margin-left:400px;width:600px;height:100px;/* background-color:rosybrown; */float:right;}
    button{margin:3px;width:190px;height:80px;}
    
    #threeButton>button{color:white;font-size:1.5rem;font-weight:700}
    #threeButton>button:nth-last-of-type(5){background-color: red;}
    #threeButton>button:nth-last-of-type(4){background-color: gray;}
    #threeButton>button:nth-last-of-type(3){background-color: green;}
    #threeButton>button:nth-last-of-type(2){background-color: orange;}
    #threeButton>button:nth-last-of-type(1){background-color: gray;}
    
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
	$("#description>div:nth-of-type(2)").hide();
    //이전에 해당 판매글에 대해 구매요청을 누른적이 있는지 확인
    <c:if test="${isBuyRequested eq true}">$("#threeButton>button:nth-last-of-type(2)").hide();</c:if>
    <c:if test="${isBuyRequested eq false}">$("#threeButton>button:nth-last-of-type(1)").hide();</c:if>
    
    //댓글 창을 숨김
    $("#second").hide();
    //상세정보 버튼 초기설정
    $("#twoButton>button:nth-of-type(1)").css({"background-color":"gray","color":"white"});
    //이전에 해당 판매글에 대해 좋아요를 누른적이 있는지 확인
    <c:if test="${isLiked eq true}">$("#threeButton>button:nth-last-of-type(5)").hide();</c:if>
    <c:if test="${isLiked eq false}">$("#threeButton>button:nth-last-of-type(4)").hide();</c:if>

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

    ////구매요청 버튼 클릭시 숨겨짐
    $("#threeButton>button:nth-last-of-type(2)").click(function(){
        $("#threeButton>button:nth-last-of-type(2)").hide();
        $("#threeButton>button:nth-last-of-type(1)").show();
    });
    //구매요청취소 버튼 클릭시 숨겨짐
    $("#threeButton>button:nth-last-of-type(1)").click(function(){
        $("#threeButton>button:nth-last-of-type(1)").hide();
        $("#threeButton>button:nth-last-of-type(2)").show();
    });
    
    //찜1버튼 클릭시 숨겨짐
    $("#threeButton>button:nth-last-of-type(5)").click(function(){
    	$("#threeButton>button:nth-last-of-type(5)").hide();
    	$("#threeButton>button:nth-last-of-type(4)").show();
    });
    
    //찜2버튼 클릭시 숨겨짐
    $("#threeButton>button:nth-last-of-type(4)").click(function(){
    	$("#threeButton>button:nth-last-of-type(4)").hide();
    	$("#threeButton>button:nth-last-of-type(5)").show();
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
    if($("#description>h1>sup").text()=="거래중" || $("#description>h1>sup").text()=="판매완료"){
    	$("#description>h1>sup").css({"background-color":"gray"});
    	$("#threeButton>button").css({"background-color":"gray"}).attr("disabled", true);
    }
    //판매자가 자신의 글을 본다면 수정 삭제 표시, 팔로우 숨기기, 버튼 색상변경과 비활성화 시키기
    if("${sessionScppe.loginId} == "${dto.p_id}"){
    /* if("user2" == "${dto.p_id}"){ */
    	$("#threeButton>button").css({"background-color":"gray"}).attr("disabled", true);
    	$("#follow").css({"background-color":"gray"}).attr("disabled", true);
    	$("#description>div:nth-of-type(1)").hide();
    	$("#description>div:nth-of-type(2)").show();
    }
 });
</script>
</head>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
    <div id="wrap">
        <section>
            <div id="sectionWrap">
                <article>
                    <div id="imgWrap">
                        <img src="/photo/${dto.i_newName }" width="400px" height="400px">
                    	<p>i_newName ${dto.i_newName }</p>
                    </div>
                    <div id="description">
                        <h1>${dto.p_title }<sup>${dto.ns_name }</sup></h1>
                        <p id="salePrice">${dto.ns_pr } P</p>
                        <p>${dto.p_tm }<p>
                        <p>거래방식 :              
                       		<c:if test="${dto.s_DeliveryYN eq 'Y' }">택배</c:if>
                       		<c:if test="${dto.s_DeliveryYN eq 'N' }">직거래</c:if>                       		
                       	</p>
                       	<% GGDto dto = (GGDto) request.getAttribute("dto"); %>
                        <%-- <p>거래주소 : ${dto.u_addr }</p> --%>
                        <p>거래주소 : <%=dto.getU_addr() %></p><!-- 주소가 넘어오지를 않음 dao에서는 정상적으로 받아옴 -->
                        <p>하트<span>${dto.p_likeCount }</span>&nbsp;&nbsp;&nbsp;&nbsp;조회수<span>${dto.p_view }</span></p>
                        <div><a href="#">신고하기</a></div>
                        <div><a href="#">수정 /</a>&nbsp;<a href="#">삭제</a></div>
                    </div>
                    <div id="threeButton">
                    	<!-- 새로고침 방법 -->
                        <%--<button onclick="location.href='lovePlus2?p_no=${dto.p_no }'">찜</button>--%><!-- +1 -->
                        <%--<button onclick="location.href='loveMinus2?p_no=${dto.p_no }'">찜</button>--%><!-- -1 -->
                        <!-- ajax 방법 -->
                        <button>찜+</button><!-- +1 -->
                        <button>찜-</button><!-- -1 -->
                        <button>쪽지보내기</button>
                        <button onclick="location.href='buyRequest?p_no=${dto.p_no }'">구매요청</button>
                        <button onclick="location.href='buyRequestCancel?p_no=${dto.p_no }'">구매요청취소</button>
                    </div>
                    <div id="twoButton">
                        <button>상세정보</button>
                        <button>댓글</button>
                    </div>
                    <!-- #first>div:nth-of-type(1) -->
                    <div id="first">
                    	<div>
                    		${dto.p_content }                   		
                    	</div>
                    	<div>
                    		<p>상점정보</p>
                    		<div>
	                    		<div><a href="#"><img src="./img/profile.PNG" width="100" height="100"></a></div>
	                    		<div>
	                    			<p id="u_nname">${dto.u_nname }</p>
	                    			<p id="reviewAvg">별점 4.5</p>
	                    		</div>
                    		</div>
                    		<button id="follow">팔로우</button>
                    		<div>
                    			
                    				<c:forEach items="${sale3List }" var="dto">
                    					<div>
                    						<a href="salesDetail?p_no=${dto.p_no}"><img src="#" alt="${dto.i_newName }"></a>
                    						<p>${dto.ns_pr } P</p>                    					
                    					</div>
                    				</c:forEach>
                    		
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
					var love = $("#description>p:nth-of-type(6)>span:nth-of-type(1)").text();
					$("#description>p:nth-of-type(6)>span:nth-of-type(1)").text(++love);
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
					var love = $("#description>p:nth-of-type(6)>span:nth-of-type(1)").text();
					$("#description>p:nth-of-type(6)>span:nth-of-type(1)").text(--love);
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