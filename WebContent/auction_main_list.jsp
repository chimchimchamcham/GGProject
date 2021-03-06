<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>Document</title>
<style>
#mainHeader {
	z-index: 1000;
}

#main {
	/* background-color: gray; */
	width: 1200px;
	height: auto;
	position: absolute;
	top: 150px;
	z-index: -1;
	margin: 0px auto;
	/* padding: 30px; */
}

h2.bbb {
	text-align: center;
	padding-top: 30px;
}

.categor {
	margin: 50px 30px 0 0;
	padding-left: 20px;
	white-space: nowrap;
	float: left;
	/* border: 1px solid black; */
	width: 180px;
	height: 700px;
	background-color: #F2F2F2;
}

.categor td:hover {
	text-decoration: underline black;
	cursor: pointer;
	/*  background-color: gray; */
}

.main_auc {
	margin-top: 50px;
	width: 990px;
	height: auto;
	float: left;
}

.itembox {
	/*  justify-self: center;
            display: flex;
            justify-content: center;
            flex-direction: column; */
	
}

.alinebutton {
	margin-bottom: 30px;
}

.alinebutton button {
	border-color: gray;
	background-color: transparent;
	border-top: 1px solid gray;
	border-bottom: 1px solid gray;
	border-left: 0px;
	border-right:  0px;
	cursor: pointer;
	padding:5px 10px;
}

.alinebutton button:hover {
	/*   border-color: gray;
            background-color: gray;
            color: white;
            cursor: pointer; */
	
}

.alinebutton button.checked {
	border-color: gray;
	background-color: #E6E6E6;
	border:0px;
	padding:5px 10px;
}

.items {
	/* display: flex;
            flex-wrap: wrap;
            flex-direction: row;
            margin-top: 20%; */
	margin: 0px auto;
}

.item-one {
	width: 325px;
	height: 400px;
	border: 1px solid #F2F2F2;
	/* display: flex; */
	/* flex-direction: column;
            justify-content: space-between; */
	cursor: pointer;
	margin:;
	float: left;
}

.item-one:hover {
	background-color: #F2F2F2;
}


.item-one table{
	width: 280px;
	margin: 0px auto;
	padding-top:15px;
}

.item-one table td{
	/* border: 1px solid black; */
	color:#555;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	
}

.img-zoon {
	width: 280px;
	height: 230px;
	overflow: hidden;
	margin: 0px auto;
	padding-top: 10px;
	/*  text-align: center; */
}

.index {
	
}

.img-zoon img {
	width: 100%;
}

.index, .bestcost, .nowbuycost, .endtime, .count {
	margin-left: 5%;
}

.endtime-count {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
}

</style>
</head>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
		<h2 class="bbb">??????</h2>
		<table class="categor">
			<!--  <tr><th>????????????</th></tr> -->
			<tr>
				<td>????????????</td>
			</tr>
			<tr>
				<td>????????????</td>
			</tr>
			<tr>
				<td>????????????</td>
			</tr>
			<tr>
				<td>????????????</td>
			</tr>
			<tr>
				<td>??????/????????????</td>
			</tr>
			<tr>
				<td>????????????</td>
			</tr>
			<tr>
				<td>???????????????</td>
			</tr>
			<tr>
				<td>?????????</td>
			</tr>
			<tr>
				<td>????????????</td>
			</tr>
			<tr>
				<td>????????????</td>
			</tr>
			<tr>
				<td>??????</td>
			</tr>
		</table>
		<div class="main_auc">
			<!-- <div class="itembox"> -->
			<div class="alinebutton">
				<button class="checked" style="margin-right: 5px;">???????????????</button>
				<button>???????????????</button>
			</div>
			<div class="items">

			</div>
			<!-- </div> -->

		</div>
	</div>
</body>
<script>
	let $index_button_auction = '????????????';
	let $index2 = 0;

	$(document)
			.ready(
					function() {
						function getParameterByName(name) {
							name = name.replace(/[\[]/, "\\[").replace(/[\]]/,
									"\\]");
							var regex = new RegExp("[\\?&]" + name
									+ "=([^&#]*)"), results = regex
									.exec(location.search);
							return results == null ? ""
									: decodeURIComponent(results[1].replace(
											/\+/g, " "));
						}

						var cate = getParameterByName('cate');
						$.ajax({
							type : 'post',
							url : './auctionmainlist',
							data : {
								index_button_auction : cate,
								index2 : 0
							},
							dataType : 'JSON',
							success : function(data) {
								console.log("data", data);
								if (data != null) {
									auction_list(data.auctionmainlist);
								}
							},
							error : function(e) {
								console.log(e);
							}
						});

					})

	$(".categor tr td").click(function() {//????????????
		$button1 = $(".categor tr td");
		$index1 = $button1.index(this);

		$index_button_auction = $(".categor tr td:eq(" + $index1 + ")").text();

		console.log("$index_button_auction:" + $index_button_auction);
		console.log("$alien_list:" + $index2);

		auction_listCall($index_button_auction, $index2);
		//alert('hellow');

	})

	$(".alinebutton button").click(function() {//??????

		$button2 = $(".alinebutton button");
		$index2 = $button2.index(this);

		console.log("$index_button_auction:" + $index_button_auction);
		console.log("$alien_list_sold:" + $index2);

		auction_listCall($index_button_auction, $index2);
		//alert('hellow');

	})

	function auction_listCall($index_button_auction, index2) {

		$.ajax({
			type : 'post',
			url : './auctionmainlist',
			data : {
				index_button_auction : $index_button_auction,
				index2 : $index2
			},
			dataType : 'JSON',
			success : function(data) {
				console.log("data:" + data);
				if (data != null) {
					auction_list(data.auctionmainlist);
				}
			},
			error : function(e) {
				console.log(e);
			}
		});

	}

	//????????? ???????????? ???????????? ?????? ?????????
	function auction_list(auctionmainlist) {
		console.log("auc==" + auctionmainlist)
		var content = "";

		auctionmainlist
				.forEach(function(item, idx) {
					console.log("idx:", idx, item);
					content += "<div class='item-one' onclick="
							+ "window.location.href='auctionDetail?p_no="
							+ item.p_no + "\'" + ">"
					content += "<div class='img-zoon'>";
					content += "<img src='/photo/"+item.i_newName+"'>";
					content += "</div>";
					content +="<table class='content-box'>";
					content +="<tr>";
					content +=	"<td colspan='2' style='padding-bottom:10px; font-size:18px; color:black; width:260px;'><b>"+ item.p_title +"</b></td>";
					content +="</tr>";
					content +="<tr>";
					content +=	"<td colspan='2' width='260'> <b>?????? ?????? ?????????     "+ item.hm+" P</b></td>";
					content +="</tr>";
					content +="<tr>";
					content +=	"<td colspan='2' width='260'><small>?????? ?????????   "+ item.au_instantPr +" P</small></td>";
					content +="</tr>";
					content +="<tr>";
					content +=	"<td width='140' style='color:red'> <b>????????????   </b>  "+ item.au_endTm+"</td>";
					content +=	"<td style='text-align:right; width:80px'><b>?????????   </b>"+ item.au_count+" </td>";
					content +="</tr>";
					content +="</table>";
					content += "</div>";
				});

		$('.main_auc div.items').empty();
		$('.main_auc div.items').append(content);
	}// ?????? ????????? end	

	////////////////////////////////////////////////////////////
	$(".alinebutton button").click(function() {
		$(".alinebutton button").toggleClass("checked");
	});
</script>
</html>