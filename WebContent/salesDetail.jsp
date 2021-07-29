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
    #first,#second{width:1200;height:400px;border:1px solid black;/* background-color:purple; */}
    
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
 
 $(document).ready(function(){
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
 });
</script>
</head>
<body>
    <div id="wrap">
        <section>
            <div id="sectionWrap">
                <article>
                    <div id="imgWrap">
                        <img src="img/notebook.PNG" width="400px" height="400px">
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
                        <p>하트<span>${dto.p_likeCount }</span>조회수<span>${dto.p_view }</span></p>
                        <div><a href="#">신고하기</a></div>
                    </div>
                    <div id="threeButton">
                        <%--<button onclick="location.href='lovePlus2?p_no=${dto.p_no }'">찜</button>--%><!-- +1 -->
                        <%--<button onclick="location.href='loveMinus2?p_no=${dto.p_no }'">찜</button>--%><!-- -1 -->
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
                    <div id="first">
                    	${dto.p_content }
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