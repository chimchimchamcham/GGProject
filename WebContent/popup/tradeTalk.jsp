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
	display: inline-block;
	/* background-color: yellow; */
	width: 460px;
	cursor: pointer;
	margin:10px 0 0 0;
}

.tableWrap{
	text-align:center;
}
.tableWrap:hover{
background-color: #f7f7f7;
}

.content td{
	/*  border: 1px solid black; */
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
		<table class="content">
				<tr>
					<td rowspan="2"><a href="#"><img src="../test/default-profile.png" width="60"></a></td>
					<th style="width:240px;  padding:0 20px; text-align: left;">ㅇㅇㅇ님과 거래중</th>
					<td style="width:110px; text-align: right;"><small>2021.08.06 15:56</small></td>
				</tr>
				<tr>
					<td><p  style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width:240px; padding:0 20px; text-align: left;">
					안녕하세요~~!!@#^^^호ㅓㅎ외ㅓㅗ이ㅏㅓ노리아ㅓ로이ㅏ러ㄹ하어ㅣ헝라ㅣ허;하넝ㄹ</p>
					</td>
					<td style="width:110px; text-align: right;">배송중</td>
				</tr>
					<tr>
				<td style="border-bottom:1px solid black; padding-top:10px;" colspan="3"></td>
			</tr>
		</table>
		</div>
	</div>
</body>
<script>

	/*클릭시 거래페이지 팝업*/
	$(".content").click(function(){
		console.log("거래페이지 팝업");
	});
	
</script>
</html>