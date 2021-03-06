<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
</head>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="http://code.jquery.com/jquery-1.8.1.min.js"></script>
<script>
   var loginId = "${sessionScope.loginId}";
   var adminYN = "${sessionScope.adminYN}";

   $(document).ready(function() {
      
      /*드롭다운메뉴 마우스오버, 마우스리브*/
      $("#dropdown li").mouseover(function() {
         $(this).children("#saleCat, #auctionCat").stop().slideDown();
      });

      $("#dropdown li").mouseleave(function() {
         $(this).children("#saleCat, #auctionCat").stop().slideUp();
      });
      
      
      
      /*거래톡 팝업*/
      $(".tradeA").click(function(){
         window.open("./popup/tradeTalk.jsp", "chargePop", "width=470, height=630, left=850, top=150");
      });
      
      /*쪽지 팝업*/
      /*  $(".messageA").click(function(){
          window.open("./popup/msgPop.jsp", "msgPop", "width=500, height=500, left=850, top=150");
      });
 		*/
 		
      /*알람 팝업*/
     $(".alarmA").click(function(){ //./popup/alarmPop.jsp
        window.open("./alarmlist?u_id="+loginId+"&a_impoyn=N", "alarmPop", "width=500, height=500, left=850, top=150");
      });
      
      
      /*쪽지함 토글기능*/
     /*  $("#messageList").hide();
      $(".messageA").click(function(){
         $("#messageList").slideToggle('slow');
         $("#alarmList").hide();
         $("#tradeList").hide();
      }); */
      
      /*알람 토글기능*/
    /*   $("#alarmList").hide();
      $(".alarmA").click(function(){
         $("#alarmList").slideToggle('slow');
         $("#messageList").hide();
         $("#tradeList").hide();
      }); */
      
      /*거래톡 토글기능*/
      /* $("#tradeList").hide();
      $(".tradeA").click(function(){
         $("#tradeList").slideToggle('slow');
         $("#messageList").hide();
         $("#alarmList").hide();
      });
       */
      /*쪽지 로그인 체크*/
     /*   $(".messageA").click(function(){
      if(loginId == ""){
         $("#messageList").html("<h2>로그인이 필요한 서비스 입니다.</h2><br><a href='login.jsp'>로그인 하러가기</a>");
      }
      }); */

      /*알람 로그인 체크*/
     $(".alarmA").click(function(){
      if(loginId == ""){
         $("#alarmList").html("<h2>로그인이 필요한 서비스 입니다.</h2><br><a href='login.jsp'>로그인 하러가기</a>");
      }
      });
      
      /*마이페이지 로그인 체크*/
       $(".myPageA").click(function(){
         if(loginId == ""){
            alert("로그인이 필요한 서비스 입니다.");
            location.href="login.jsp";
         }else{
            location.href="myPage";
         }   
         });
      
      /*거래톡 로그인 체크*/
   $(".tradeA").click(function(){
         if(loginId == ""){
        	 $("#messageList").html("<h2>로그인이 필요한 서비스 입니다.</h2><br><a href='login.jsp'>로그인 하러가기</a>");
            location.href="login.jsp";
         } 
         });
      
      /*글쓰기 로그인 체크*/
     $(".writeA").click(function(){
          if(loginId == ""){
            alert("로그인이 필요한 서비스 입니다.");
            location.href="login.jsp";
         }else{
            location.href="writeForm";
         }   
         });
      
     /*검색기능 구현*/
     var search = '';
	$("#search img").click(function(){
		search = $("input[name=search]").val();
		console.log("검색 내용 : ",search);
		
		//location.href="./search.jsp";
		location.href="./search?insert="+search;
		
	})
	
	$("input[name=search]").keypress(function(event){
		if(event.which == 13){
			$("#search img").click();
		}
	});
      
   });
   
   
   $(document).on("click",".header_nav ul#dropdown li a",function(){//카테고리
	   console.log("클릭");
	    $button1 = $(".header_nav ul#dropdown li a");
	    $index1 = $button1.index(this);
	    
	    $index_button_sold = $(".header_nav ul#dropdown li a:eq(" + $index1 + ")").text();
	    
	
		console.log("$index_button_sold:"+$index_button_sold);
		
		sold_listCall($index_button_sold);
		//alert('hellow');
		
   })
   
   
   function sold_listCall($index_button_sold){
		
		$.ajax({
			type:'post',
			url:'./soldmainlist',
			data:{	index_button_sold : $index_button_sold},
			dataType:'JSON',
			success:function(data){
				console.log("data:"+data);
				if(data != null){
					sold_list(data.soldmainlist);
				}
			},
			error:function(e){
				console.log(e);
			}
		});	
		
		}

</script>
<style>

body {
   line-height: 1.5em;
   font-size: 1em;
   font-weight: normal;
   color: #333;
   width:1200px;
   margin: 0px auto;
}

#hWrap {
   width: 1200px;
   margin: 0 auto;
   text-align: left;
   background-color: #fff;
}

.Hheader {
   width: 1200px;
   height: 90px;
   position: fixed;
   padding-top: 10px;
   margin: 0px auto;
   background-color: #fff;
   float: top;
}

#logo {
   float: left;
}

/*검색창*/
#search {
   position: absolute;
   left: 100px;
   top: 20px;
}

#search img {
   width: 20px;
   height: 20px;
   position: absolute;
   right: 10px;
   top: 10px;
   cursor: pointer;
   transition: 0.5s;
   
}

#search input {
   display: block;
   width: 568px;
   height: 35px;
   outline: none;
   padding-left: 10px;
   border: 1px solid #D8D8D8;
   border-radius: 3px;
}

/*상단 우측 메뉴*/
#menu1 {
   float: right;
   padding: 10px;
   width:440px;
}

#menu1 a {
   padding: 0 7px;
   text-decoration: none;
   color: black;
	float: right;
}

#menu1 a:hover {
   color: gray;
}

#writeBtn{
   margin-left:7px;
   padding: 7px 15px;
   text-decoration: none;
   background-color: #D8D8D8;
   color:#424242;
   border: 3px #D8D8D8;
   border-radius: 5px;
   float: right;
}

#writeBtn:hover{
   background-color: gray;
   color: white;
   cursor:pointer;
}

.messageA:hover, .alarmA:hover, .tradeA:hover{
	opacity: 60%;
}

/*메인메뉴*/
.header_nav {
   width: 1200px;
   position: fixed;
   height: 40px;
   border-bottom: 1px solid #ccc;
   border-top: 1px solid #ccc;
   margin: 90px 0px 10px 0px;
   padding-top: 15px;
   background-color: #fff;
}

.header_nav ul#dropdown {
   box-sizing: border-box;
   margin: 0px auto;
   width: 1000px;
   background-color: #fff;
}

.header_nav ul#dropdown li {
   float: left;
   list-style: none;
   margin: 0px auto;
   background-color: #fff;
}

.header_nav ul#dropdown li a {
   color: #000;
   padding: 0 82px;
   text-decoration: none;
   display: block;
}

.header_nav ul#dropdown li a:hover {
   color: gray;
}


/*드롭다운 하위 메뉴*/
#saleCat, #auctionCat {
    display: none;
   margin: 16px 0 0 -30px;
   list-style: none;
   position: absolute;
   z-index: 100;
}

.header_nav ul#dropdown li ul li {
   float: none;
   display: inline;
}

.header_nav ul#dropdown li ul li a {
   width: 150px;
   height: 35px;
   padding: 10px 20px 0px 10px;
   background-color: #F2F2F2;
   font-size: 0.9em;
   text-transform: capitalize;
   text-align: center;
}

.header_nav ul#dropdown li ul li a:hover {
   background-color: #ffffff;
}

.header_nav ul#dropdown:after {
   content: "";
   display: block;
   clear: both;
}


/*쪽지함*/
/* #messageList{
   width: 420px;
   height:500px;
   position: fixed;
   background-color:#E6E6E6;
   z-index: 1000;
   top:60px;
   right:470px;
   text-align: center;
   overflow: scroll;
   } */

/*알람 목록*/
#alarmList{
   width: 420px;
   height:500px;
   position: fixed;
   background-color:#E6E6E6;
   z-index: 1000;
   top:60px;
   right:420px;
   text-align: center;
   overflow: scroll;
}

/*거래톡*/
#tradeList{
   width: 420px;
   height:500px;
   position: fixed;
   background-color:#E6E6E6;
   z-index: 1000;
   top:60px;
   right:380px;
   text-align: center;
   overflow: scroll;
   }

/*회원가입 버튼*/
.joinBtn{
   margin-left:7px;
   padding: 7px 15px;
   text-decoration: none;
   background-color:   #fff;
   color: #424242;
   border: 1.5px solid #cecece;
   border-radius: 5px;
   float:right;
}

.joinBtn:hover{
 	background-color:#f7f7f7;
 	cursor: pointer;
 	
}


/*로그인 버튼*/
.loginBtn{
   margin-left:7px;
   padding: 7px 15px;
   text-decoration: none;
   background-color: #D8D8D8;
   color:#424242;
   border: 1.5px #D8D8D8;
   border-radius: 5px;
   float:right;
}

.loginBtn:hover{
	background-color:#c4c4c4;
 	cursor: pointer;
}


    
</style>
<body>
   <div id="hWrap">
      <header class="Hheader">
         <div>
            <div id="logo"><a href="index.jsp"><img src="test/logo2.png" width="80"></a></div>
            <div id="search">
               <input type="text" name="search" placeholder="찾고 싶은 상품을 검색해보세요!">
               <img src="img/search-icon.png" alt="search-icon">
            </div>
            <div id="menu1">
            <!-- 로그인이 안되어있을 때 -->
            <c:if test="${loginId eq null }">
            <button onclick="location.href='joinForm.jsp'" class="joinBtn">회원가입</button>
            <button onclick="location.href='login.jsp'" class="loginBtn">로그인</button>
            </c:if>
            <!-- 로그인이 되어있을 때 -->
            <c:if test="${loginId ne null}"> 
               <!-- 사용자 상단바 -->
          <button id="writeBtn" onclick="location.href='writeForm'">글쓰기</button>  
             	<a href="logout"  class="logoutA">로그아웃</a>
             <c:if test="${adminYN eq 'Y'}">
            	 <a href="manageList">관리페이지</a>
             </c:if>
              <c:if test="${adminYN eq 'N'}"> 
              <a href="#"  class="myPageA">마이페이지</a>
               	<a href="#"  class="tradeA" title="거래톡"><img src="img/ggTalk.png" alt="거래톡" width="25" style="opacity:80%;  margin-right:30px; padding:0 5px;"></a>
               	<a href="#"  class="alarmA" title="알람"><img src="img/notify-icon.png" alt="알람" width="25" style="opacity:80%; padding:0 5px;" ></a>
               	<!-- <a href="#"  class="messageA" title="쪽지"><img src="img/message-icon.png" alt="쪽지" width="25" style="opacity:80%; padding:0 5px;"></a> -->
            </c:if>
            </c:if>
            </div>
         </div>
      </header>
      <nav class="header_nav">
         <div id="navWrap">
            <ul id="dropdown">
               <li><a href="./sale_main_list.jsp?cate=패션의류" class="sale">판매</a>
                  <ul id="saleCat">
                     <li><a href="sale_main_list.jsp?cate=패션의류">패션의류</a></li>
                     <li><a href="sale_main_list.jsp?cate=뷰티잡화">뷰티잡화</a></li>
                     <li><a href="sale_main_list.jsp?cate=유아용품">유아용품</a></li>
                     <li><a href="sale_main_list.jsp?cate=가구생활">가구생활</a></li>
                     <li><a href="sale_main_list.jsp?cate=취미/스타굿즈">취미/스타굿즈</a></li>
                     <li><a href="sale_main_list.jsp?cate=전자기기">전자기기</a></li>
                     <li><a href="sale_main_list.jsp?cate=스포츠레져">스포츠레져</a></li>
                     <li><a href="sale_main_list.jsp?cate=자동차">자동차</a></li>
                     <li><a href="sale_main_list.jsp?cate=생활가전">생활가전</a></li>
                     <li><a href="sale_main_list.jsp?cate=도서기타">도서기타</a></li>
                     <li><a href="sale_main_list.jsp?cate=기타">기타</a></li>
                  </ul></li>
   
               <li><a href="auction_main_list.jsp?cate=패션의류" class="action">경매</a>
                  <ul id="auctionCat">
                     <li><a href="auction_main_list.jsp?cate=패션의류">패션의류</a></li>
                     <li><a href="auction_main_list.jsp?cate=뷰티잡화">뷰티잡화</a></li>
                     <li><a href="auction_main_list.jsp?cate=유아용품">유아용품</a></li>
                     <li><a href="auction_main_list.jsp?cate=가구생활">가구생활</a></li>
                     <li><a href="auction_main_list.jsp?cate=취미/스타굿즈">취미/스타굿즈</a></li>
                     <li><a href="auction_main_list.jsp?cate=전자기기">전자기기</a></li>
                     <li><a href="auction_main_list.jsp?cate=스포츠레져">스포츠레져</a></li>
                     <li><a href="auction_main_list.jsp?cate=자동차">자동차</a></li>
                     <li><a href="auction_main_list.jsp?cate=생활가전">생활가전</a></li>
                     <li><a href="auction_main_list.jsp?cate=도서기타">도서기타</a></li>
                     <li><a href="auction_main_list.jsp?cate=기타">기타</a></li>
                  </ul></li>
               <li><a href="commListForm.jsp">커뮤니티</a></li>
               <li><a href="noticeList">공지사항</a></li>
            </ul>
         </div>
      </nav>
   </div>
</body>
<script>



</script>

</html>