<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    --%> 
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
    #threeButton>button:nth-last-of-type(1){background-color: red;}
    #threeButton>button:nth-last-of-type(2){background-color: green;}
    #threeButton>button:nth-last-of-type(3){background-color: orange;}
    #threeButton>button:nth-last-of-type(4){background-color: gray;}
    
    #twoButton>button{height:50px;font-size:1.2rem;}
    #twoButton{overflow:hidden;clear:both;}
    #twoButton>button:nth-last-of-type(1){float:left;}
    #twoButton>button:nth-last-of-type(2){float:left;}
    #first,#second{width:1200;height:400px;border:1px solid black;/* background-color:purple; */}
    
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
 
 $(document).ready(function(){
    //구매요청 취소버튼을 숨김
    $("#threeButton>button:nth-last-of-type(1)").hide();
    //댓글 창을 숨김
    $("#second").hide();
    //상세정보 버튼 초기설정
    $("#twoButton>button:nth-of-type(1)").css({"background-color":"gray","color":"white"});

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
    
    //찜버튼 클릭시 빨간색으로 변경
    var isLove = false;
    $("#threeButton>button:nth-last-of-type(4)").click(function(){
    	if(!isLove){
    		$("#threeButton>button:nth-last-of-type(4)").css({"background-color":"red"});
    		isLove = true;
    	}else{
    		$("#threeButton>button:nth-last-of-type(4)").css({"background-color":"gray"});
    		isLove = false;
    	} 
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
                    </div>
                    <div id="description">
                        <h1>아이패드 파우치<sup>판매중</sup></h1>
                        <p id="salePrice">5000P</p>
                        <p>2021-07-13<p>
                        <p>거래방식 : 택배<p>
                        <p>거래지역 : 광명동<p>
                        <p>하트 21  조회수 42<p>
                        <div><a href="#">신고하기</a></div>
                    </div>
                    <div id="threeButton">
                        <button>찜</button>
                        <button>쪽지보내기</button>
                        <button>구매요청</button>
                        <button>구매요청취소</button>
                    </div>
                    <div id="twoButton">
                        <button>상세정보</button>
                        <button>댓글</button>
                    </div>
                    <div id="first">
                    </div>
                    <div id="second">
                    </div>
                    
                </article>
            </div>
        </section>
    </div>
</body>
</html>