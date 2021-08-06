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
h2 {
	text-align: center;
}

#tradeWrap {
	width: 480px;
	/* text-align: center; */
	margin: 0px auto;
	/* background-color: blue; */
}

.content {
	/* background-color: yellow; */
	/* 	text-align: center; */
	display: inline-block;
	margin-top: 30px;
}

.content td{
	border: 1px solid black;
}

#buttonTwo {
	width: 480px;
	/* background-color: green; */
	text-align: center;
	display: inline-block;
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
		<table class="content">
				<tr>
					<td rowspan="2">프사</td>
					<td>ㅇㅇㅇ님과 거래중</td>
					<td>2021.08.06 15:56</td>
				</tr>
				<tr>
					<td>안녕하세요~~!!@#^^^</td>
					<td>배송중</td>
				</tr>
		</table>
	</div>
</body>
<script>
	
</script>
</html>