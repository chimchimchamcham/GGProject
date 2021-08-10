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

#prev, #next{
	cursor:pointer;
} 
#pageNumWrap{
	font-size:1.3rem;
	text-align:center;
}
#pageNumList span{
	margin:3px;
	cursor:pointer;
}
.selectPageNum{
	color:blue;
	font-weight:600;
	cursor:default;
}
</style>
<body>
	<h2>거래톡</h2>
	<div id="tradeWrap">
		<div id="buttonTwo">
			<button id="wholeBtn" value="P000">전체</button>
			<button id="auctionBtn" value="P001">경매</button>
			<button id="saleBtn" value="P002">판매</button>
		</div>
		<div class="tableWrap">
			<!-- 여기에 거래페이지 목록이 들어간다 -->
		</div>
		<div id="pageNumWrap">
			<!-- 여기에 페이징이 들어간다 -->
			<span id="prev">prev </span>
			<span id="pageNumList">	
				<!-- <span class="selectPageNum">1</span>
				<span>2</span> -->
			</span>	
			<span id="next"> next</span>	
		</div>
	</div>
</body>
<script>
/* ================페이징 처리 관련==================== */
	var p_code = $("#wholeBtn").val();
	var pageNum = 1;
	var totalPage = 2;
	
	//숫자를 클릭하면 반응
	$(document).on("click","#pageNumList span",function(){
		$("#pageNumList span").removeClass("selectPageNum");
		$(this).addClass("selectPageNum");
		pageNum = $(this).text();
		console.log(pageNum);
		tradeListCall(p_code, pageNum);
	});

	//숫자를 클릭하면 
/* ================거래페이지 목록 관련 ================= */
	//화면이 켜지면 목록 뿌려주기 무조건 실행
	tradeListCall('P000',1);
	
	//자바단에 접속하여 전체 목록을 가져오기
	function tradeListCall(p_code, pageNum) {
		console.log("거래페이지 리스트 요청 ");
		var param = {};
		param.id = "${sessionScope.loginId}";
		param.p_code = p_code;
		param.pageNum = pageNum
		$.ajax({
			type : "POST",
			url : "../tradeList",
			data : param,
			dataType : "JSON",
			success : function(data) {
				console.log("받아온 list 확인 : ", data.list);
				console.log("받아온 currentPage 확인 : ", data.currentPage);
				console.log("받아온 totalPage 확인 : ", data.totalPage);
				
				drawTradeList(data.list);
				drawPageNumList(data.currentPage, data.totalPage);
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
		
	//판매버튼을 클릭 했을 때 판매에 관련된 목록만 가져오기
	$(document).on("click","#buttonTwo button",function(){
		var p_name = $(this).text();
		if(p_name == '경매'){
			//경매 목록 가져오기
			tradeListCall('P001',1);
		}else if(p_name == '판매'){
			//구매 목록 가져오기
			tradeListCall('P002',1);
		}else if(p_name == '전체'){
			//전체 목록 가져오기
			tradeListCall('P000',1);
		}
	});
	
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
				
				content +="<div class='tradeList' id='"+item.t_no+"'  >";
				content +="<div id='"+item.t_no+"' >";
				content +=	"<input type='hidden' id='t_no' value='"+item.t_no+"'>";
				content +="<table class='content'>";
				content +=	"<tr>";
				content +=		"<td rowspan='2'><a href='#'><img src='../test/default-profile.png' width='60' id='profile' ></a></td>";
				content +=		"<th style='width:240px;  padding:0 20px; text-align: left;'><a href='#'>"+dealNname+"님과 거래중</a></th>";
				content +=		"<td style='width:110px; text-align: right;'><a href='#'><small>"+item.ht_date+"</small></a></td>";
				content +=	"</tr>";
				content +=	"<tr>";
				content +=		"<td>";
				content +=			"<p onclick='moveTrade("+item.t_no+");'>"+item.p_title+"</p>"
				content +=			"<p style='overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width:240px; padding:0 20px; text-align: left;'>";	
				content +=			"<a href='#' onclick='moveTrade("+item.t_no+");'>"+item.tc_content+"</a>";	
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
	
	//클릭시 해당 거래페이지로 이동
	 function moveTrade(t_no){
		console.log("t_no : "+t_no);
		window.open("../tradeDetail?t_no="+t_no, "tradeDetail", "width=900, height=650, left=700, top=400");
	}

	function drawPageNumList(currentPage, totalPage){
		
		console.log("페이징 그려주기 ");
		var content = "";
		for(var i=1;i<=totalPage;i++){
			if(i == currentPage){
				content += "<span class='selectPageNum'>"+i+"</span>";
			}else{
				content += "<span>"+i+"</span>";
			}
		}
		$("#pageNumList").empty();
		$("#pageNumList").append(content);
		if(currentPage == 1){
			$("#prev").hide();
			$("#next").show();
		}
		if(currentPage == totalPage){
			$("#prev").show();
			$("#next").hide();
		}
	}
	
	//prev를 클릭하면 다음페이지로 넘어감
	$("#prev").on("click",function(){
		tradeListCall(p_code,--pageNum);
	});
	
	//next를 클릭하면 다음페이지로 넘어감
	$("#next").on("click",function(){
		tradeListCall(p_code,++pageNum);
	});
</script>
</html>