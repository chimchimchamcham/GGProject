<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거래톡</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
</style>
</head>
<style>
*{
	margin:0;
	padding:0;
}

h2 {
margin-top:20px;
	text-align: center;
}

#tradeWrap {
	width: 500px;
	/* text-align: center; */
	margin: 0px auto;
	/* background-color: blue; */
}

.content {
	/* background-color: yellow; */
	/* 	text-align: center; */
	/* display: inline-block; */
	/* background-color: yellow; */
	width: 460px;
	cursor: pointer;
	margin:10px 0 0 0;
}

.tableWrap{
	text-align:center;
}
.content:hover{
background-color: #f7f7f7;
}

.content td{
	/*  border: 1px solid black; */
}

.content img:hover{
opacity:0.9;
}

#buttonTwo {
	width: 500px;
	/* background-color: green; */
	text-align: center;
	display: inline-block;
	margin : 20px 0 30px 0;
}

#buttonTwo button {
	width: 70px;
	text-align: center;
	margin: 0px auto;
	display: inline-block;
}

a{
	text-decoration: none;
	color: black;
}


/*읽었을때*/
.read {
	opacity: 0.3;
}

</style>
<body>
	<h2>거래톡</h2>
	<div id="tradeWrap">
		<div id="buttonTwo">
			<button id="saleBtn">판매</button>
			<button id="auctionBtn">경매</button>
		</div>
		<div class="tableWrap">
			<div>
			<table class="content">
				<tr>
					<td rowspan="2"><a href="#"><img src="../test/default-profile.png" width="60" id="profile" ></a></td>
					<th style="width:240px;  padding:0 20px; text-align: left;"><a href="#">ㅇㅇㅇ님과 거래중</a></th>
					<td style="width:110px; text-align: right;"><a href="#"><small>2021.08.06 15:56</small></a></td>
				</tr>
				<tr>
					<td>
						<p style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width:240px; padding:0 20px; text-align: left;">
							<a href="#">안녕하세요~~!!@#^^^호ㅓㅎ외ㅓㅗ이ㅏㅓ노리아ㅓ로이ㅏ러ㄹ하어ㅣ헝라ㅣ허;하넝ㄹ</a>
						</p>
					</td>
					<td style="width:110px; text-align: right;"><a href="#">배송중</a></td>
				</tr>
				<tr>
					<td style="border-bottom:1px solid black; padding-top:10px;" colspan="3"></td>
				</tr>
			</table>
		</div>
	</div>
</body>
<script>
/* ================거래페이지 목록 관련 ================= */
	//화면이 켜지면 목록 뿌려주기 무조건 실행
	tradeListCall();
	
	//자바단에 접속하여 목록을 가져오기
	function tradeListCall() {
		console.log("거래페이지 리스트 요청 ");
		var param = {};
		param.id = "${sessionScope.loginId}";
		$.ajax({
			type : "POST",
			url : "../tradeList",
			data : param,
			dataType : "JSON",
			success : function(data) {
				console.log("받아온 데이터 확인 : ", data.list);
				drawTradeList(data.list);
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
	
	//가져온 데이터를 뿌려주기
	function drawTradeList(list) {
		console.log("리스트 정보 확인 : ", list);
		var content = "";
		var id = "${sessionScope.loginId}";
		if(list != ""){
			list.forEach(function(item, idx) {
				/* 클릭했을 때  부모창에 해당 프로필이 보여주는 기능*/
				/* 클릭했을 때 해당 거래페이지로 이동하는 기능 */
				var dealId = (id == item.t_saler)? item.t_buyer : item.t_saler;
				var dealNname = (id == item.t_saler)? item.t_buyer_nname : item.t_saler_nname;
				console.log("dealId/dealNname : "+dealId+"/"+dealNname);
				console.log("idx : ",idx);
				
				content +="<div class='tradeList' id='"+item.t_no+"' onclick='clickEvent();' >";
				content +=	"<input type='hidden' id='t_no' value='"+item.t_no+"'>";
				content +="<table class='content'>";
				content +=	"<tr>";
				content +=		"<td rowspan='2'><a href='#'><img src='../test/default-profile.png' width='60' id='profile' ></a></td>";
				content +=		"<th style='width:240px;  padding:0 20px; text-align: left;'><a href='#'>"+dealNname+"님과 거래중</a></th>";
				content +=		"<td style='width:110px; text-align: right;'><a href='#'><small>"+item.ht_date+"</small></a></td>";
				content +=	"</tr>";
				content +=	"<tr>";
				content +=		"<td>";
				content +=			"<p>"+item.p_title+"</p>"
				content +=			"<p style='overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width:240px; padding:0 20px; text-align: left;'>";	
				content +=			"<a href='#'>"+item.tc_content+"</a>";	
				content +=			"</p>";
				content +=		"</td>";
				content +=		"<td style='width:110px; text-align: right;'><a href='#'>"+item.ht_name+"</a></td>";
				content +=	"</tr>";
				content +=	"<tr>";
				content +=		"<td style='border-bottom:1px solid black; padding-top:10px;' colspan='3'></td>";
				content +=	"</tr>";
				content +="</table>";
				content +="</div>";
			});
		}
		
		//일단 랩을 다 비우고 나서 그리기
		$(".tableWrap").empty();
		$(".tableWrap").append(content);
	};
	
	//각 해당 테이블을 클릭 했을 때 해당 거래번호에 해당하는 거래페이지 팝업을 뿌려주기 
 	/* $(".tradeList").on("click",function(event){
		console.log($(event.target).parent("tradeList").children("#t_no").val());
		console.log($(event.target));
		alert("clicked");
	}); */
	/* $("table").click(function(){
		console.log($(this).find("#t_no").val());
		alert("clicked");
	}); */
	
	 function clickEvent(){
		console.log($(this).find("#t_no").val());
		console.log($(this));
		alert("clicked");
	}
</script>
</html>