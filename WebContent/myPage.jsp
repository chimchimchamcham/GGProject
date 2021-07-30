<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
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
	width: 1200px;
	display: block;
	height: 500px;
	background-color: gray;
	margin: 0px auto;
	clear: both;
}

table {
	float: left;
}

td {
	border: 1px solid black;
}

#soge {
	heigth: 100px;
	background-color: yellow;
	display: block;
}

#td1 {
	display: block;
}

a{
	text-decoration: none;
	color: balck;
}

</style>
<script>
var loginId = "${sessionScope.loginId}";



/*충전 팝업*/
function showPopup() { window.open("./popup/chargePopup.jsp", "charge", "width=600, height=500, left=600, top=200"); }

	$(document).ready(function() {

		let $index1 = 0;
		let $index2 = 0;
		
		/*알림*/
		firstcall();//처음에만 뿌려주는 거
		
		
		
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
	
	function firstcall(){//처음에 보여주는거  목록 종류 0 = 판매 목록
		console.log('call 처음 목록');
		$.ajax({
			type:'post',
			url:'./list',
			data:{  index1 : 0,
					index2 : 0 },
			dataType:'JSON',
			success:function(data){
				console.log("data",data);
				if(data.list != null){
					soled_list(data.list);
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	}

			
			
	function listCall($index_top){
		if ($index_top==0) {//전체
		$.ajax({
			type:'post',
			url:'./list',
			data:{},
			dataType:'JSON',
			success:function(data){
				console.log("data:"+data);
				if(data.list != null){
					soled_list(data.list);
				}
			},
			error:function(e){
				console.log(e);
			}
		});			
		}
		
		
		}
			//데이터 가져와서 뿌려주는 함수 판매 리스트
			function soled_list(list){	
			
			console.log("list:", list);
			var content="";
			
			list.forEach(function(item,idx){
				console.log(idx,item);
				content += "<div class='item-one'>";
				content += "<div class='img-zoon'><img src="+item.i_newName+" class='itemimg'></div>";
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
			
			
			
</script>
<body>
	<h2>마이페이지</h2>
	<div id="div1">
		<table style="text-align: center; width: 40%;">
			<tr>
				<td><img src="${myPageInfo.u_newName }" width="150"></td>
			</tr>
			<tr>
				<td>${myPageInfo.u_nname} </td>
			</tr>
			<tr>
				<td>${myPageInfo.u_addr }</td>
			</tr>
			<tr>
				<td><button onclick="location.href='./userUpdateForm?id=${loginId}'">회원정보 수정</button></td>
			</tr>
		</table>

		<table style="width: 60%;">
			<tr>
				<td>현재 포인트</td>
				<td>${myPageInfo.pnt_point }P</td>	
				<td><input type="button" value="충전" onclick="showPopup();" /></td>
			</tr>
			<tr>
				<td>평점</td>
				<td colspan="2"></td>
			</tr>
			<tr>
				<td colspan="3">자기소개</td>
			</tr>
			<tr>
				<td colspan="3">
					<p>${myPageInfo.u_intro }</p>
				</td>
			</tr>
		</table>
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
   <div id="trade" style="background-color:orange; padding:20px;">경매목록입니다.</div>
   <div id="sell" style="background-color:yellow; padding:20px;">구매목록입니다.</div>
   <div id="commu" style="background-color:green; padding:20px;">커뮤니티목록입니다.</div>
   <div id="follow" style="background-color:blue; padding:20px;">팔로우목록입니다.</div>
   <div id="want" style="background-color:pink; padding:20px;">구매요청목록입니다.</div>
   <div id="like" style="background-color:purple; padding:20px;">좋아요목록입니다.</div>
   <div id="alarm" style="background-color:lime; padding:20px;">신고목록입니다.</div>
	
</body>
<script type="text/javascript">

$("#twoButton>button").click(function(){
	
$button = $("#twoButton>button");
$index = $button.index(this);
$index_button = $("#twoButton>button:eq(" + $index + ")");
console.log("#twoButton>button:"+$index);

})

</script>
</html>