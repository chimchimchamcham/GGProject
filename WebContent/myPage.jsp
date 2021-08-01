<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
#mainHeader{
	z-index: 1000;
}
#main {
	width:1200px;
	height:auto;
	position: absolute;
	top:150px;
	z-index: -1;
}

#navWrap2 {
   width: 1000px;
   height: 60px;
   line-height: 60px;
   margin: 0 auto;
}

#navWrap2>span {
   display: inline-block;
   margin: 0px 20px;
}

#navWrap2>span:nth-of-type(1) {
   margin: 0px 30px;
}

#navWrap2>span>a {
   display: block;
   color: #2E2E2E;
   text-decoration: none;
   width: 100%;
   height: 100%
}

#navWrap2>span>a:hover {
   text-decoration: underline;
}

#navWrap2>span:nth-of-type(1)>a {
   text-decoration: underline;
   font-weight: 600;
}


body {
   width: 100%;
   text-align: center;
}


#div1 {
	width: 840px;
	display: block;
	height: 520px;
	margin: 0px auto;
	clear: both;
	padding-top: 20px;
	/* border:1px solid black; */
}

#div2 {
	width: 840px;
	display: block;
	height: 400px;
	margin: 0px auto;
	clear: both;
	padding-top: 20px;
	/* border:1px solid black; */
}

table {
	float: left;
}

 td,th {
	padding : 5px;
	/* border: 1px solid black; */
}

.addrBg{
	background-color: #D8D8D8;
	padding :5px 9px;
	border: 0px;
	border-radius: 10px;
}

#td1 {
	display: block;
}

a{
	text-decoration: none;
	color: balck;
}

#userInfoBox{
	width : 300px;
}

#intro{
	width:500px;
	float: left;
	margin-left: 40px;
	text-align: left;
}

.introBox{
width:500px;
	height:150px;
	overflow: scroll;
	background-color: #F2F2F2;
	padding : 15px;
}

#pointBox{
margin-top:50px;
	margin-left: 40px;
	text-align:left;
}

#pointBox td:nth-of-type(1){
	margin-top:10px;
	width:120px;
}

#pointBox td:nth-of-type(2){
	display: inline;
}

#pointBox th{
	width:130px;
}

#chargeBtn{
	border: 0px;
	padding:5px 13px;
	border-radius: 10px;
	color: black;
	background-color: #D8D8D8;
}

#chargeBtn:hover{
		background-color: #A4A4A4;
	color: white;
	cursor: pointer;
	
}

#f_mBtn{
	text-align:center;
}

#f_mBtn button{
	padding : 5 10px;
	margin : 10px;
}
.auction{
                    display: flex;
                    flex-direction: row;
                    font-size: 12px;
                    opacity: 0.5;
                }
                .xianzai{
                    font-size: 20px;
                }
                .endtime-zoon{
                    display: flex;
                    flex-direction: row;
                    color: red;
                    font-size: 15px;
                }
                .nick{
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    font-size: 30px;
                }
                .c_code{
                    border: 1px solid black;
                    justify-self: center;
                }
                .c_zoon{
                    margin: 3%;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                }
                .mai-time{
                    margin-left: 6%;
                    display: flex;
                    justify-content: center;
                    align-items: center;
}

/*프로필 사진*/
.box {
    width: 130px;
    height: 130px; 
    border-radius: 50%;
    overflow: hidden;
    margin:0px auto;
}

.profile {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

</style>
<script>
var loginId = "${sessionScope.loginId}";

/*팝업창*/
 //충전팝업
function chargePopup() { window.open("./popup/chargePopup.jsp", "charge", "width=600, height=500, left=600, top=200"); }
//포인트내역 팝업
function pointListPop() { window.open("./popup/pointListPop.jsp", "charge", "width=600, height=500, left=600, top=200"); }

	
	$(document).ready(function() {
		$.ajax({
			type:'post',
			url:'./soldlist',
			data:{  index1 : 0,
					index2 : 0 },
			dataType:'JSON',
			success:function(data){
				console.log("data",data);
				if(data.soldlist != null){
					soled_list(data.soldlist);
				}
			},
			error:function(e){
				console.log(e);
			}
		});
		
		
		$("#twoButton>button").click(function(){
			
			$button = $("#twoButton>button");
			$index = $button.index(this);
			$index_button = $("#twoButton>button:eq(" + $index + ")");
			console.log("#twoButton>button:"+$index);

			let url ='';
			
			if ($index == 0) {
				url ='./soldlist';
			}else if($index == 1) {
				url ='./auctionlist';
			}else if($index == 2){
				url ='./maidelist';
			}
			console.log("url:"+url);

			listCall($index,url);

			})
		
		
		/*알림*/
		var msg = "${msg}";
		if(msg != ""){
			alert(msg);
		}
		
		//초기상태 판매목록만 보여짐
		$("#sale").show();
		$("#trade").hide();
		$("#sell").hide();
		$("#commu").hide();
		$("#follow").hide();
		$("#want").hide();
		$("#like").hide();
		$("#alarm").hide();

		//초기 버튼이눌린 상태
		$("#twoButton>button:nth-of-type(1)").css({"background-color":"gray","color":"white"});
		
		//판매상새목록 include
		

		//상세정보 버튼 클릭시 
		$("#twoButton>button:nth-of-type(2)").click(function(){
		    $("#twoButton>button:nth-of-type(2)").css({"background-color":"gray","color":"white"});
		    $("#twoButton>button:nth-of-type(1)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(3)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(4)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(5)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(6)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(7)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(8)").css({"background-color":"white","color":"black"});
		    $("#sale").hide();
		    $("#trade").show();
		    $("#sell").hide();
		    $("#commu").hide();
		    $("#follow").hide();
		    $("#want").hide();
		    $("#like").hide();
		    $("#alarm").hide();
			

		    
		    
		    
		});
		$("#twoButton>button:nth-of-type(1)").click(function(){
		    $("#twoButton>button:nth-of-type(1)").css({"background-color":"gray","color":"white"});
		    $("#twoButton>button:nth-of-type(2)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(3)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(4)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(5)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(6)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(7)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(8)").css({"background-color":"white","color":"black"});
		    
		    $("#sale").show();
		    $("#trade").hide();
		    $("#sell").hide();
		    $("#commu").hide();
		    $("#follow").hide();
		    $("#want").hide();
		    $("#like").hide();
		    $("#alarm").hide();
		    

		    
		});
		$("#twoButton>button:nth-of-type(3)").click(function(){
		    $("#twoButton>button:nth-of-type(3)").css({"background-color":"gray","color":"white"});
		    $("#twoButton>button:nth-of-type(2)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(1)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(4)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(5)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(6)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(7)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(8)").css({"background-color":"white","color":"black"});
		    $("#sale").hide();
		    $("#trade").hide();
		    $("#sell").show();
		    $("#commu").hide();
		    $("#follow").hide();
		    $("#want").hide();
		    $("#like").hide();
		    $("#alarm").hide();
		    
		});
		$("#twoButton>button:nth-of-type(4)").click(function(){
		    $("#twoButton>button:nth-of-type(4)").css({"background-color":"gray","color":"white"});
		    $("#twoButton>button:nth-of-type(2)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(1)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(3)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(5)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(6)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(7)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(8)").css({"background-color":"white","color":"black"});
		    $("#sale").hide();
		    $("#trade").hide();
		    $("#sell").hide();
		    $("#commu").show();
		    $("#follow").hide();
		    $("#want").hide();
		    $("#like").hide();
		    $("#alarm").hide();
		    
		});
		$("#twoButton>button:nth-of-type(5)").click(function(){
		    $("#twoButton>button:nth-of-type(5)").css({"background-color":"gray","color":"white"});
		    $("#twoButton>button:nth-of-type(1)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(2)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(3)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(4)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(6)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(7)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(8)").css({"background-color":"white","color":"black"});
		    $("#sale").hide();
		    $("#trade").hide();
		    $("#sell").hide();
		    $("#commu").hide();
		    $("#follow").show();
		    $("#want").hide();
		    $("#like").hide();
		    $("#alarm").hide();
		    
		});
		$("#twoButton>button:nth-of-type(6)").click(function(){
		    $("#twoButton>button:nth-of-type(6)").css({"background-color":"gray","color":"white"});
		    $("#twoButton>button:nth-of-type(1)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(2)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(3)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(4)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(5)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(7)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(8)").css({"background-color":"white","color":"black"});
		    $("#sale").hide();
		    $("#trade").hide();
		    $("#sell").hide();
		    $("#commu").hide();
		    $("#follow").hide();
		    $("#want").show();
		    $("#like").hide();
		    $("#alarm").hide();
		    
		});
		$("#twoButton>button:nth-of-type(7)").click(function(){
		    $("#twoButton>button:nth-of-type(7)").css({"background-color":"gray","color":"white"});
		    $("#twoButton>button:nth-of-type(1)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(2)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(3)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(4)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(5)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(6)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(8)").css({"background-color":"white","color":"black"});
		    $("#sale").hide();
		    $("#trade").hide();
		    $("#sell").hide();
		    $("#commu").hide();
		    $("#follow").hide();
		    $("#want").hide();
		    $("#like").show();
		    $("#alarm").hide();
		   
		});
		$("#twoButton>button:nth-of-type(8)").click(function(){
		    $("#twoButton>button:nth-of-type(8)").css({"background-color":"gray","color":"white"});
		    $("#twoButton>button:nth-of-type(1)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(2)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(3)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(4)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(5)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(6)").css({"background-color":"white","color":"black"});
		    $("#twoButton>button:nth-of-type(7)").css({"background-color":"white","color":"black"});
		    $("#sale").hide();
		    $("#trade").hide();
		    $("#sell").hide();
		    $("#commu").hide();
		    $("#follow").hide();
		    $("#want").hide();
		    $("#like").hide();
		    $("#alarm").show();
		    
		});
		
	});
	


	function listCall($index,url){
		$.ajax({			
			type:'post',
			url:url,
			data:{
				index1:0,
				index2:0
			},
			dataType:'JSON',
			success:function(data){
				console.log("soldlist:",data.soldlist);
				console.log("auctionlist:",data);
				if(data != null){
					console.log("data:",data);
					console.log($index);
					console.log(url);
					if($index == 0){//판매
						console.log("soled_list:",data.soldlist);
						soled_list(data.soldlist);
					}else if ($index == 1) {//경매
						console.log("auction_list:",data.auctionlist);
						auction_list(data.auctionlist);
					}else if ($index == 2) {//구매
						console.log("maide_list:",data.maidelist);
						auction_list(data.maidelist);
					}
				}
			},
			error:function(e){
				console.log(e);
			}
		});			
		}
			//데이터 가져와서 뿌려주는 함수 판매 리스트
		function soled_list(soldlist){	
			console.log("soldlist:", soldlist);
			var content="";
			
			soldlist.forEach(function(item,idx){
				console.log("idx:",idx,item);
				content += "<div class='item-one'>";
				content += "<div class='img-zoon'><img src="+item.i_newName+"></div>";
				content += "<div class='dretion-zoon'>";
				content += "	<div class='itemindex'>"+"<a href="+"salesDetail?p_no="+item.p_no+">"+item.p_title+"</a>"+"</div>";
				content += "	<div class='itempoint'>"+item.ns_pr+"p"+"</div>";
				content += "</div>";
				content += "<div class='love-time'>";
				content += "	<div class='love'>"+item.p_likeCount+"</div>";
				content += "	<div class='time'>"+item.p_tm+"</div>";	
				content += "</div>";	
				content += "</div>";
			});	
			$("#sale .item-box").empty();
			$("#sale .item-box").append(content);
			
		}//판매 리스트 end
			
		//데이터 가져와서 뿌려주는 경매 리스트
		function auction_list(auctionlist){	
			console.log("auction_list:", auctionlist);
			var content="";
			
			auctionlist.forEach(function(item,idx){
				console.log("idx:",idx,item);
				content +="<div class='item-one'>";
				content +="<div class='img-zoon'><img src='test.jpg' alt=''#'></div>";
				content +="<div class='dretion-zoon'>";
				content +="<h2>제목.....</h2>";
				content +="<div class='xianzai'>현제 입찰가</div><div style='font-size: 25px;'>5000p</div><div class='auction'>";
				content +="<div>시작:5000p</div>/<div>즉결:5000p</div></div>";
				content +="</div><div class='endtime-zoon'>종료시간:<div>2021/07/03</div></div>";
				content +="<div class='love-time'><div>입찰수:2</div><div>2시간 전</div></div>";
				content +="</div>";
				});	
				$('#trade .item-box').empty();
				$('#trade .item-box').append(content);
		}// 경매 리스트 end
		
		//데이터 가져와서 뿌려주는 구매 리스트
		function maide_list(maidelist){	
			console.log("maidelist:", maidelist);
			var content="";
			
			auctionlist.forEach(function(item,idx){
				console.log("idx:",idx,item);
				content += "<div class='item-one'>";
				content += "<div class='img-zoon'><img src="+item.i_newName+" class='itemimg' style='margin:3%'></div>";
				content += "<div class='dretion-zoon style='margin: 3%'>";
				content +="		<h2>제목.....</h2>";
				content += "	<div style='font-size: 25px; justify-self: center;'>5000p</div>";
				content += "</div>";
				content += "<div class='c_zoon'>";
				content += "	<div class='c_code'>판매</div>";	
				content += "</div>";	
				content += "<div class='nick' style='margin: 3%;'>";
				content += "	<div>닉네임</div>";
				content += "</div>";
				content += "<div class='mai-time'>";
				content += "	<div> 구매날짜:2시간 전</div>";
				content += "</div></div>";
			});	
			$("#sell .item-box").empty();
			$("#sell .item-box").append(content);
			
		}// 구매 리스트 end
			
			
</script>
<body>
<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
	
<!-- true일때 실행되는 마이페이지 -->
	<c:if test ="${myPageInfo.myYN eq 'true'}">
	<h2 style="margin-top:30px;">마이페이지</h2>
	<!-- 마이페이지 상단 -->
	<div id="div1">
		<table id="userInfoBox">
			<tr>
				<td colspan="2">
			<c:if test="${myPageInfo.u_newName  eq 'default-profile.png'}">
			<div class="box" >
    			<img class="profile" src="./img/default-profile.png">
			</div>
			</c:if>
			<c:if test="${myPageInfo.u_newName  ne 'default-profile.png'}">
			<div class="box" >
    			<img class="profile" src="/ProfilePhoto/${myPageInfo.u_newName }">
			</div>
			</c:if>
			</tr>
			<tr>
				<th colspan="2">${myPageInfo.u_nname}</th>
			</tr>
			<tr>
				<td colspan="2" class="addrBg">${myPageInfo.u_addr }&nbsp;${myPageInfo.u_detailAddr }</td>
			</tr>
			<tr style="text-align:left;">
				<th  style="padding-top:30px;">이름</th>
				<td style="padding-top:30px;">${myPageInfo.u_name }</td>
			</tr>
			<tr style="text-align:left;">
				<th >이메일</th>
				<td>${myPageInfo.u_email }</td>
			</tr>
			<tr style="text-align:left;">
				<th>전화번호</th>
				<td>${myPageInfo.u_phone }</td>
			</tr>
			<tr >
				<td colspan="2" style="padding-top:20px;"><button onclick="location.href='./userUpdateForm?id=${loginId}'">회원정보 수정</button></td>
			</tr>
		</table>

		<table id="pointBox">
			<tr>
				<th>현재 포인트</th>
				<td><a href="#" onclick="pointListPop();">${myPageInfo.pnt_point }P</a></td>	
				<td><input type="button" value="충전" onclick="chargePopup();" id="chargeBtn"/></td>
			</tr>
		</table>
		<div id="intro" style="margin-top: 20px;">
			<p><b>자기소개 글</b></p>
			<p class="introBox">${myPageInfo.u_intro}</p>
		</div>
	</div>
			
	 <div id="twoButton">
      <button>판매목록	</button>
      <button>경매목록</button> 
      <button>구매목록</button>
      <button>커뮤니티</button> 
      <button>팔로우</button>
      <button>구매요청</button> 
      <button>좋아요</button> 
      <button>신고목록</button>
   </div>

   

   <div id="sale" style="background-color:red; padding:20px;"><jsp:include page="./mypage_list/sold.jsp"></jsp:include></div>
   <div id="trade" style="background-color:orange; padding:20px;"><jsp:include page="./mypage_list/auction.jsp"></jsp:include></div>
   <div id="sell" style="background-color:yellow; padding:20px;">구매목록입니다.</div>
   <div id="commu" style="background-color:green; padding:20px;">커뮤니티목록입니다.</div>
   <div id="follow" style="background-color:blue; padding:20px;">팔로우목록입니다.</div>
   <div id="want" style="background-color:pink; padding:20px;">구매요청목록입니다.</div>
   <div id="like" style="background-color:purple; padding:20px;">좋아요목록입니다.</div>
   <div id="alarm" style="background-color:lime; padding:20px;">신고목록입니다.</div>
</c:if>













<!-- fals일때 실행되는 타인프로필 -->
	<c:if test ="${myPageInfo.myYN eq 'false'}">
	<h2 style="margin-top:30px;">${myPageInfo.u_nname}님의 프로필</h2>
	<!-- 마이페이지 상단 -->
	<div id="div2">
		<table id="userInfoBox">
			<tr>
				<td colspan="2">
			<c:if test="${myPageInfo.u_newName  eq 'default-profile.png'}">
				<img src="./img/default-profile.png" width="130px"/>
			</c:if>
			<c:if test="${myPageInfo.u_newName  ne 'default-profile.png'}">
				<img src="/ProfilePhoto/${myPageInfo.u_newName }" width="130px"/>
			</c:if>
			</tr>
			<tr>
				<th colspan="2">${myPageInfo.u_nname}</th>
			</tr>
			<tr>
				<td colspan="2" class="addrBg">${myPageInfo.u_addr }&nbsp;${myPageInfo.u_detailAddr }</td>
			</tr>
			<tr id="f_mBtn">
				 <td><button>+팔로우</button><button>쪽지</button></td>
			</tr>
			<tr >
				<td colspan="2"><a href = "#">신고하기</a></td>
			</tr>
		</table>
		<div id="intro">
			<p><b>${myPageInfo.u_nname}님의 자기소개</b></p>
			<p class="introBox">${myPageInfo.u_intro}</p>
		</div>
	</div>
			
	 <div id="twoButton">
      <button>판매목록	</button>
      <button>경매목록</button> 
      <button>구매목록</button>
      <button>커뮤니티</button> 
      <button>팔로우</button>
      <button>구매요청</button> 
      <button>좋아요</button> 
      <button>신고목록</button>
   </div>

   <div id="sale" style="background-color:red; padding:20px;"><jsp:include page="./mypage_list/sold.jsp"></jsp:include></div>
   <div id="trade" style="background-color:orange; padding:20px;"><jsp:include page="./mypage_list/auction.jsp"></jsp:include></div>
   <div id="sell" style="background-color:yellow; padding:20px;"><jsp:include page="./mypage_list/maide.jsp"></div>
   <div id="commu" style="background-color:green; padding:20px;">커뮤니티목록입니다.</div>
   <div id="follow" style="background-color:blue; padding:20px;">팔로우목록입니다.</div>
   <div id="want" style="background-color:pink; padding:20px;">구매요청목록입니다.</div>
   <div id="like" style="background-color:purple; padding:20px;">좋아요목록입니다.</div>
   <div id="alarm" style="background-color:lime; padding:20px;">신고목록입니다.</div>
</c:if>
   
	</div> <!-- div main end -->
</body>
</html>