<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
#mainHeader {
	z-index: 1000;
}

#main {
	width: 1140px;
	height: auto;
	position: absolute;
	top: 150px;
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

td, th {
	padding: 5px;
	/* border: 1px solid black; */
}

.addrBg {
	background-color: #D8D8D8;
	padding: 5px 9px;
	border: 0px;
	border-radius: 10px;
}

#td1 {
	display: block;
}

a {
	text-decoration: none;
	color: black;
}

#userInfoBox {
	width: 300px;
}

#intro {
	width: 500px;
	float: left;
	margin-left: 40px;
	text-align: left;
}

.introBox {
	width: 500px;
	height: 150px;
	overflow-y: scroll;
	background-color: #F2F2F2;
	padding: 15px;
}

#pointBox {
	margin-top: 50px;
	margin-left: 40px;
	text-align: left;
}

#pointBox td:nth-of-type(1) {
	margin-top: 10px;
	width: 120px;
}

#pointBox td:nth-of-type(2) {
	display: inline;
}

#pointBox th {
	width: 130px;
}

#chargeBtn {
	border: 0px;
	padding: 5px 13px;
	border-radius: 10px;
	color: black;
	background-color: #D8D8D8;
}

#chargeBtn:hover {
	background-color: #A4A4A4;
	color: white;
	cursor: pointer;
}

#f_mBtn {
	text-align: center;
}

#f_mBtn button {
	padding: 5 10px;
	margin: 10px;
}

.auction {
	display: flex;
	flex-direction: row;
	font-size: 12px;
	opacity: 0.5;
}

.xianzai {
	font-size: 20px;
}

.endtime-zoon {
	display: flex;
	flex-direction: row;
	color: red;
	font-size: 15px;
}

.nick {
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 30px;
}

.c_code {
	border: 1px solid black;
	justify-self: center;
}

.c_zoon {
	margin: 3%;
	display: flex;
	justify-content: center;
	align-items: center;
}

.mai-time {
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
	margin: 0px auto;
}

.profile {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

a:hover {
	color: hotpink;
}

a:visited {
	color: black;
}

/*====마이페이지 하단====*/
#myBottom {
	width:1140px;
	height:auto;

}

/*탭메뉴*/
#twoButton {
	width:1140px;
	margin: 0px auto;
	padding : 10px 0;

}

#twoButton button {
	width: 110px;
	height: 40px;
	padding:0px;
	margin-right :31px;
	border-bottom: 1px solid #d6d6d6;
	border-top: 1px solid #d6d6d6;
	/* color:#d6d6d6; */
	border-left: 0px;
	border-right: 0px;
	background-color:#fff;
}

#twoButton button:hover {
	border-bottom: 1.7px solid #b7b7b7;
	border-top: 1.7px solid #b7b7b7;
	color: #b7b7b7;
	font-weight:bold;
}
</style>

<%
	String allurl = (String) session.getAttribute("allurl");
%>

<script>
	var loginId = "${sessionScope.loginId}";

	/*팝업창*/
	//충전팝업
	function chargePopup() {
		window.open("./popup/chargePopup.jsp", "chargePop",
				"width=600, height=500, left=600, top=200");
	}
	//포인트내역 팝업
	function pointListPop() {
		window.open("./popup/pointListPop.jsp", "pointList",
				"width=900, height=600, left=450, top=180");
	}
	//신고 팝업
	function notifyPopup() {
		window.open("./popup/notifyPopup.jsp?N_receiveId=${myPageInfo.u_id}",
				"notifyPopup", "width=900, height=600, left=450, top=180");
	}
	function sendMsgPop() {
		window.open("./popup/sendMsgPop.jsp?N_receiveId=${myPageInfo.u_id}&N_receiveNname=${myPageInfo.u_nname}&u_newName=${myPageInfo.u_newName}",
				"chargePop", "width=500, height=500, left=850, top=150");
	}

	var allurl =
<%=allurl%>
	$(document).ready(function() {

		if (allurl == undefined) {
			allurl = './soldlist';
		}

		/*
		 var allurl = ${allurl}


		 이제 마이리스트에 들어갈때 무슨 리스트 보여줄건지 설정하려면 allurl 안에 문자열을 뿌려주어야합니다

		 예) req.setAttribute("allurl", "'./soldlist'");

		 등으로요



		 뿌려줘야하는 목록
		 ./soldlist : 판매리스트
		 ./auctionlist : 경매리스트
		 ./maidelist : 구매리스트
		 ./communitylist : 커뮤니티리스트
		 ./flowlist : 팔로우리스트
		 ./requestlist : 구매요청리스트
		 ./lovelist : 구매요청리스트
		 ./report_list:신고리스트
		 */

		$.ajax({
			type : 'post',
			url : allurl,
			data : {
				index1 : 0,
				index2 : 0
			},
			dataType : 'JSON',
			success : function(data) {
				console.log("data", data);
				if (data != null) {
					if (data.soldlist != null) {//판매
						soled_list(data.soldlist);
						$("#sale").show();
						$("#trade").hide();
						$("#sell").hide();
						$("#commu").hide();
						$("#follow").hide();
						$("#want").hide();
						$("#like").hide();
						$("#alarm").hide();
					} else if (data.auctionlist != null) {//경매
						auction_list(data.auctionlist);
						$("#sale").hide();
						$("#trade").show();
						$("#sell").hide();
						$("#commu").hide();
						$("#follow").hide();
						$("#want").hide();
						$("#like").hide();
						$("#alarm").hide();
					} else if (data.maidelist != null) {//구매
						maide_list(data.maidelist);
						$("#sale").hide();
						$("#trade").hide();
						$("#sell").show();
						$("#commu").hide();
						$("#follow").hide();
						$("#want").hide();
						$("#like").hide();
						$("#alarm").hide();
					} else if (data.communitylist != null) {//커뮤니티
						community_list(data.communitylist);
						$("#sale").hide();
						$("#trade").hide();
						$("#sell").hide();
						$("#commu").show();
						$("#follow").hide();
						$("#want").hide();
						$("#like").hide();
						$("#alarm").hide();
					} else if (data.flowlist != null) {//팔로우 팔로잉
						flow_list(data.flowlist);
						$("#sale").hide();
						$("#trade").hide();
						$("#sell").hide();
						$("#commu").hide();
						$("#follow").show();
						$("#want").hide();
						$("#like").hide();
						$("#alarm").hide();
					} else if (data.reqlist != null) {//거래 요청
						request_list(data.reqlist);
						$("#sale").hide();
						$("#trade").hide();
						$("#sell").hide();
						$("#commu").hide();
						$("#follow").hide();
						$("#want").show();
						$("#like").hide();
						$("#alarm").hide();
					} else if (data.lovelist != null) {//좋아요 요청
						love_list(data.lovelist);
						$("#sale").hide();
						$("#trade").hide();
						$("#sell").hide();
						$("#commu").hide();
						$("#follow").hide();
						$("#want").hide();
						$("#like").show();
						$("#alarm").hide();
					} else if (data.alarmlist != null) {//신고 요청
						alarm_list(data.alarmlist);
						$("#sale").hide();
						$("#trade").hide();
						$("#sell").hide();
						$("#commu").hide();
						$("#follow").hide();
						$("#want").hide();
						$("#like").show();
						$("#alarm").hide();
					}
				}
			}
		});

		$("#twoButton>button").click(function() {
			$button = $("#twoButton>button");
			$index = $button.index(this);
			$index_button = $("#twoButton>button:eq(" + $index + ")");
			console.log("#twoButton>button:" + $index);

			let url = '';

			if ($index == 0) {
				url = './soldlist';
			} else if ($index == 1) {
				url = './auctionlist';
			} else if ($index == 2) {
				url = './maidelist';
			} else if ($index == 3) {
				url = './communitylist';
			} else if ($index == 4) {
				url = './flowlist';
			} else if ($index == 5) {
				url = './requestlist';
			} else if ($index == 6) {
				url = './lovelist';
			} else if ($index == 7) {
				url = './report_list';
			}
			console.log("url:" + url);

			listCall($index, url);

		});

		/*알림*/
		var msg = "${msg}";
		if (msg != "") {
			alert(msg);
		}

		//초기 버튼이눌린 상태
		$("#twoButton>button:nth-of-type(1)").css({
			"background-color" : "#e5e5e5",
			"color" : "#6d6d6d"
		});

		//판매상새목록 include

		//상세정보 버튼 클릭시 
		$("#twoButton>button:nth-of-type(2)").click(function() {
			$("#twoButton>button:nth-of-type(2)").css({
				"background-color" : "#e5e5e5",
				"color" : "#6d6d6d"
			});
			$("#twoButton>button:nth-of-type(1)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(3)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(4)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(5)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(6)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(7)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(8)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#sale").hide();
			$("#trade").show();
			$("#sell").hide();
			$("#commu").hide();
			$("#follow").hide();
			$("#want").hide();
			$("#like").hide();
			$("#alarm").hide();

		});
		$("#twoButton>button:nth-of-type(1)").click(function() {
			$("#twoButton>button:nth-of-type(1)").css({
				"background-color" : "#e5e5e5",
				"color" : "#6d6d6d"
			});
			$("#twoButton>button:nth-of-type(2)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(3)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(4)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(5)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(6)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(7)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(8)").css({
				"background-color" : "white",
				"color" : "#757575"
			});

			$("#sale").show();
			$("#trade").hide();
			$("#sell").hide();
			$("#commu").hide();
			$("#follow").hide();
			$("#want").hide();
			$("#like").hide();
			$("#alarm").hide();

		});
		$("#twoButton>button:nth-of-type(3)").click(function() {
			$("#twoButton>button:nth-of-type(3)").css({
				"background-color" : "#e5e5e5",
				"color" : "#6d6d6d"
			});
			$("#twoButton>button:nth-of-type(2)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(1)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(4)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(5)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(6)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(7)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(8)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#sale").hide();
			$("#trade").hide();
			$("#sell").show();
			$("#commu").hide();
			$("#follow").hide();
			$("#want").hide();
			$("#like").hide();
			$("#alarm").hide();

		});
		$("#twoButton>button:nth-of-type(4)").click(function() {
			$("#twoButton>button:nth-of-type(4)").css({
				"background-color" : "#e5e5e5",
				"color" : "#6d6d6d"
			});
			$("#twoButton>button:nth-of-type(2)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(1)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(3)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(5)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(6)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(7)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(8)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#sale").hide();
			$("#trade").hide();
			$("#sell").hide();
			$("#commu").show();
			$("#follow").hide();
			$("#want").hide();
			$("#like").hide();
			$("#alarm").hide();

		});
		$("#twoButton>button:nth-of-type(5)").click(function() {
			$("#twoButton>button:nth-of-type(5)").css({
				"background-color" : "#e5e5e5",
				"color" : "#6d6d6d"
			});
			$("#twoButton>button:nth-of-type(1)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(2)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(3)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(4)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(6)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(7)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(8)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#sale").hide();
			$("#trade").hide();
			$("#sell").hide();
			$("#commu").hide();
			$("#follow").show();
			$("#want").hide();
			$("#like").hide();
			$("#alarm").hide();

		});
		$("#twoButton>button:nth-of-type(6)").click(function() {
			$("#twoButton>button:nth-of-type(6)").css({
				"background-color" : "#e5e5e5",
				"color" : "#6d6d6d"
			});
			$("#twoButton>button:nth-of-type(1)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(2)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(3)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(4)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(5)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(7)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(8)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#sale").hide();
			$("#trade").hide();
			$("#sell").hide();
			$("#commu").hide();
			$("#follow").hide();
			$("#want").show();
			$("#like").hide();
			$("#alarm").hide();

		});
		$("#twoButton>button:nth-of-type(7)").click(function() {
			$("#twoButton>button:nth-of-type(7)").css({
				"background-color" : "#e5e5e5",
				"color" : "#6d6d6d"
			});
			$("#twoButton>button:nth-of-type(1)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(2)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(3)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(4)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(5)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(6)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(8)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#sale").hide();
			$("#trade").hide();
			$("#sell").hide();
			$("#commu").hide();
			$("#follow").hide();
			$("#want").hide();
			$("#like").show();
			$("#alarm").hide();

		});
		$("#twoButton>button:nth-of-type(8)").click(function() {
			$("#twoButton>button:nth-of-type(8)").css({
				"background-color" : "#e5e5e5",
				"color" : "#6d6d6d"
			});
			$("#twoButton>button:nth-of-type(1)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(2)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(3)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(4)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(5)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(6)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
			$("#twoButton>button:nth-of-type(7)").css({
				"background-color" : "white",
				"color" : "#757575"
			});
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

	function listCall($index, url) {
		$.ajax({
			type : 'post',
			url : url,
			data : {
				index1 : 0,
				index2 : 0
			},
			dataType : 'JSON',
			success : function(data) {
				//console.log("soldlist:",data.soldlist);
				//console.log("auctionlist:",data.auctionlist);
				//console.log("maidelist:",data.maidelist);
				//console.log("communitylist:",data.communitylist);
				//console.log("communitylist:",data.flowlist);
				//console.log("communitylist:",data.);
				//console.log("flowlist:",data.flowlist);
				//console.log("flowlist:",data.alarmlist);
				if (data != null) {
					console.log("index", $index);
					console.log(url);
					if ($index == 0) {//판매
						soled_list(data.soldlist);
					} else if ($index == 1) {//경매
						auction_list(data.auctionlist);
					} else if ($index == 2) {//구매
						maide_list(data.maidelist);
					} else if ($index == 3) {//커뮤니티
						community_list(data.communitylist);
					} else if ($index == 4) {//팔로우 팔로잉
						flow_list(data.flowlist);
					} else if ($index == 5) {//거래 요청
						request_list(data.reqlist);
					} else if ($index == 6) {//좋아요 요청
						love_list(data.lovelist);
					} else if ($index == 7) {//신고 요청
						report_list(data.reportlist);
					}
				}
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
	//데이터 가져와서 뿌려주는 함수 판매 리스트
	function soled_list(soldlist) {
		console.log("soldlist:", soldlist);
		var content = "";

		$(".button-layout_sold").hide();
		$(".alien_list_sold").hide();
		$(".button-layout_auction").hide();

		soldlist.forEach(function(item, idx) {
					console.log("idx:", idx, item);
					content += "<div class='item-one'>";
					content += "<div class='img-zoon'><img src=/photo/"+item.i_newName+"></div>";
					content += "<div class='dretion-zoon'>";
					content += "	<div class='itemindex'>" + "<a href="
							+ "salesDetail?p_no=" + item.p_no + ">"
							+ item.p_title + "</a>" + "</div>";
					content += "	<div class='itempoint'>" + item.ns_pr + "p"
							+ "</div>";
					content += "</div>";
					content += "<div class='love-time'>";
					content += "	<div class='love'>" + item.p_likeCount
							+ "</div>";
					content += "	<div class='time'>" + item.p_tm + "</div>";
					content += "</div>";
					content += "</div>";
				});
		$(".button-layout_sold").show();
		$(".alien_list_sold").show();

		$("#sale .item-box").empty();
		$("#sale .item-box").append(content);

	}//판매 리스트 end

	//데이터 가져와서 뿌려주는 경매 리스트
	function auction_list(auctionlist) {
		console.log("auction_list:", auctionlist);
		var content = "";

		$(".button-layout_sold").hide();
		$(".alien_list_sold").hide();
		$(".button-layout_auction").hide();

		auctionlist.forEach(function(item, idx) {
					console.log("idx:", idx, item);
					content += "<div class='item-one'>";
					content += "<div class='img-zoon'><img src=/photo"+item.i_newName+"></div>";
					content += "<div class='dretion-zoon'>";
					content += "<a href= auctionDetail?p_no=" + item.p_no + ">"
							+ item.p_title + "</a>";
					content += "<div class='xianzai'>현제 입찰가</div><div style='font-size: 25px;'>"
							+ item.hm + "p</div><div class='auction'>";
					content += "<div>시작:" + item.au_startPr + "</div>/<div>즉결:"
							+ item.au_instantPr + "</div></div>";
					content += "</div><div class='endtime-zoon'>종료시간:<div>"
							+ item.au_endTm + "</div></div>";
					content += "<div class='love-time'><div>입찰수:"
							+ item.au_count + "</div><div>" + item.p_tm
							+ "</div></div>";
					content += "</div>";
				});

		$(".button-layout_auction").show();

		$('#trade .item-box').empty();
		$('#trade .item-box').append(content);
	}// 경매 리스트 end

	//데이터 가져와서 뿌려주는 구매 리스트
	function maide_list(maidelist) {
		console.log("maidelist:", maidelist);
		var content = "";

		$(".button-layout_sold").hide();
		$(".alien_list_sold").hide();
		$(".button-layout_auction").hide();

		maidelist.forEach(function(item, idx) {
			console.log("idx:", idx, item);
			content += "<div class='item-one'>";
			content += "<div class='img-zoon'><img src=/photo" + item.i_newName
					+ " class='itemimg' style='margin:3%'></div>";
			content += "<div class='dretion-zoon style='margin: 3%'>";
			content += "		<a href = ./details?p_no=" + item.p_no + ">"
					+ item.p_title + "</a>";
			content += "	<div style='font-size: 25px; justify-self: center;'>"
					+ item.pnt_point + "p</div>";
			content += "</div>";
			content += "<div class='c_zoon'>";
			content += "	<div class='c_code'>" + item.c_name + "</div>";
			content += "</div>";
			content += "<div class='nick' style='margin: 3%;'>";
			content += "	<div>" + item.pnt_otherId + "</div>";
			content += "</div>";
			content += "<div class='mai-time'>";
			content += "	<div>" + item.pnt_tm + "</div>";
			content += "</div></div>";
		});

		$("#sell .item-box").empty();
		$("#sell .item-box").append(content);

	}// 구매 리스트 end

	//데이터 가져와서 뿌려주는 커뮤니티 리스트
	function community_list(communitylist) {
		console.log("communitylist:", communitylist);
		var content = "";

		$(".button-layout_sold").hide();
		$(".alien_list_sold").hide();
		$(".button-layout_auction").hide();

		communitylist.forEach(function(item, idx) {
			console.log("idx:", idx, item);
			content += "<div class='item-one'>";
			content += "<div class='dretion-zoon style='margin: 3%'>";
			content += "	<div>" + item.p_cateName + "</div>";
			content += "	<div><a href = commDetail?p_no=" + item.p_no + ">"
					+ item.p_title + "</a></div>";///경로 고쳐야함
			content += "</div>";
			content += "<div class='c_zoon'>";
			content += "	<div>" + item.p_tm + "</div>";
			content += "</div>";
			content += "<div class='mai-time'>";
			content += "	<div>" + item.p_view + "</div>";
			content += "</div></div>";
		});

		$("#commu .item-box").empty();
		$("#commu .item-box").append(content);

	}//판매 리스트 end

	//데이터 가져와서 뿌려주는 팔로워 팔로잉 리스트
	var users = [];
	var idxs;
	function flow_list(flowlist) {
		console.log("flowlist:", flowlist);
		var content = "";
		$(".button-layout_sold").hide();
		$(".alien_list_sold").hide();
		$(".button-layout_auction").hide();

		console.log('flowlist:' + flowlist.length);

		flowlist.forEach(function(item, idx) {

					content += "<div class='item-one-flow'>"
					content += "<div class='img-zoon'><img src='/photo"+item.u_newname+"'></div>"
					content += "<div class='flowerusername'>" + item.u_nname
							+ "</div>"
					content += "<div class=''>팔로워:" + item.flow_count
							+ "</div>"
					content += "<a href='myPage?id=" + item.u_id +"'>프로필로가기</a>";
					content += item.thisuserFlowingYN;
					content += " </div>"
				});
		$("#follow .item-box").empty();
		$("#follow .item-box").append(content);
		$(".count p").empty();
		$(".count p").append(flowlist.length);
		var aaa = $(".count").text();

	}//팔로워 팔로잉 리스트 end

	$(document).on("click", "button.hellow,button.unhellow", function() {//버튼을 누르면 함수 실행,동적으로 실행

		if ($('div.item-one-flow button').hasClass("hellow")) {
			alert('+팔로우 하였습니다')
			$button1 = $("button.hellow");
			$index1 = $button1.index(this);
			$index_button_f = $("button.hellow:eq(" + $index1 + ")");

			var btntext1 = $index_button_f.text();

			$user_id = $('div.flowerusername');
			$index_user_id = $("div.flowerusername:eq(" + $index1 + ")");
			$index_user_text = $index_user_id.text();

			var nick1 = $index_user_text;

			console.log("index1:"+$index1);
			console.log("btntext1:"+btntext1);
			console.log("nick1:"+nick1);

			$.ajax({
				type : 'post',
				url : './flowadddelect',
				data : {
					btntext : btntext1,
					nick : nick1
				},
				dataType : 'JSON',
				success : function(data) {
					if ($index_button_f.text() == "+팔로우") {
						console.log("-팔로잉");
						$index_button_f.text("-팔로우");

					} else if ($index_button_f.text() == "-팔로우") {
						console.log("+팔로우");
						$index_button_f.text("+팔로우");
					}
				},
				error : function(e) {
					console.log(e);
				}
			});
		} else if ($('div.item-one-flow button').hasClass('unhellow')) {
			alert('-팔로우 하였습니다');

			$button2 = $("button.unhellow");
			$index2 = $button2.index(this);
			$index_button_f = $("button.unhellow:eq(" + $index2 + ")");

			var btntext2 = $index_button_f.text();

			$user_id = $('div.flowerusername');
			$index_user_id = $("div.flowerusername:eq(" + $index2 + ")");
			$index_user_text = $index_user_id.text();

			var nick2 = $index_user_text;

			console.log("index2:"+$index2);
			console.log("btntext2:"+btntext2);
			console.log("nick2:"+nick2);
			$.ajax({
				type : 'post',
				url : './flowadddelect',
				data : {
					btntext : btntext2,
					nick : nick2
				},
				dataType : 'JSON',
				success : function(data) {
					if ($index_button_f.text() == "+팔로우") {
						console.log("-팔로우");
						$index_button_f.text("-팔로우");
						
					}else if ($index_button_f.text() == "-팔로우") {
						console.log("+팔로우");
						$index_button_f.text("+팔로우");
					}  
				},
				error : function(e) {
					console.log(e);
				}
			});
		}

	});

	//데이터 가져와서 뿌려주는 구매요청 리스트
	function request_list(reqlist) {

		console.log("reqlist:", reqlist);
		var content = "";

		$(".button-layout_sold").hide();
		$(".alien_list_sold").hide();
		$(".button-layout_auction").hide();

		reqlist.forEach(function(item, idx) {
			console.log("idx:", idx, item);
			content += "<div class='item-one'>";
			//content += "<form action='./applyreqlist' method='post'>";
			content += "<div class='dretion-zoon style='margin: 3%'>";
			content += "	<div>" + item.sered + "</div>";
			content += "	<div><a href = salesDetail?p_no=" + item.p_no + ">"
					+ item.p_title + "</a></div>";
			content += "</div>";
			content += "<div>" + item.rq_tm + "</div>"
			content += "<div class='c_zoon'>";
			content += "	<div><a class='a' href='myPage?id=" + item.rq_id
					+ "'>" + item.rq_id + "</a></div>";
			content += "</div>";
			content += "<div class='mai-time'>";
			content += "	<div>" + item.buttonORtext + "</div>";
			content += "</div>";
			//content += "</form>";
			content += "</div>";
		});
		$("#want .item-box").empty();
		$("#want .item-box").append(content);

	}//구매요청 리스트 end

	//수락,거절버튼을 누르면
	$(document).on("click", "div.buttonarea button", function() {

		$par = $('.buttonarea button').parents('.buttonarea').index();
		console.log('parent:' + $par);

		$rqno = $('.buttonarea button');
		$index = $rqno.index(this);
		$rqnob = $(".buttonarea button:eq(" + $index + ")");

		
		
		//$itembox = $('.item-one');
		//$item_index = $itembox.index(this);
		
		

		
		
		
		
		var rqnoval = $rqnob.val();
		var rqnotext = $rqnob.text();

		console.log('.buttonarea button:' + $index);
		console.log('rqnoval:' + rqnoval);
		console.log('rqnotext:' + rqnotext);


		 $.ajax({
			type : 'post',
			url : './applyreqlist',
			data : {
				rqno_val : rqnoval,
				rqno_text : rqnotext
			},
			dataType : 'JSON',
			success : function(data) {
				if (data != null) {
					console.log('data1:' + data.info.p_no);
					console.log('data1:' + data.info.rq_id);
					console.log('data1:' + data.info.rq_no);
					console.log('data1:' + data.info.Rq_YN);
					
					var param = {};
					if (rqnotext == '수락') {
						param.Rq_YN = 'Y';
					} else if (rqnotext == '거절') {
						param.Rq_YN = 'N';
						
					}
					param.p_no = data.info.p_no;
					param.rq_id = data.info.rq_id;
					param.rq_no = data.info.rq_no;
					console.log('param1:' + param.p_no);
					console.log('param2:' + param.rq_id);
					console.log('param3:' + param.rq_no);
					console.log('param4:' + param.Rq_YN);
					
					$.ajax({
						type : 'post',
						url : './buyRequestProcess',
						data : param,
						dataType : 'JSON',
						success : function(data) {
							if (data.success) {
								if (data.request) {
									
									$remove_item_box = $(".item-one .buttonarea button:eq(" + $itemboxindex + ")").parents('.item-one');
									
									alert("거래페이지가 생성 되었습니다");
									$remove_item_box.remove();
								}
							}

						},
						error : function(e) {
							console.log(e);
							alert("error:취소 했습니다");
							
						}
					}); 
				}
			},
			error : function(e) {
				console.log(e);
			}
		});
	});

	//데이터 가져와서 뿌려주는 좋아요 리스트
	function love_list(lovelist) {

		console.log("lovelist:", lovelist);
		var content = "";

		$(".button-layout_sold").hide();
		$(".alien_list_sold").hide();
		$(".button-layout_auction").hide();

		lovelist.forEach(function(item, idx) {
			if (item.au_instantPr != 0 && item.au_instantPr != 'undifinded') {
				var price = item.au_instantPr;
				var a = "auctionDetail";
			} else if (item.ns_pr != 0 && item.ns_pr != 'undifinded') {
				var price = item.ns_pr;
				var a = "salesDetail";
			}
			console.log("idx:", idx, item);
			content += "<div class='item-one'>";
			content += "<div class='dretion-zoon style='margin: 3%'>";
			content += "	<div><a href = " + a + "?p_no=" + item.p_no + ">"
					+ item.p_title + "</a></div>";
			content += "</div>";
			content += "<div class='img-zoon'><img src=/photo" + item.i_newName
					+ " class='itemimg' style='margin:3%'></div>";
			content += "<div class='c_zoon'>";
			content += "	<div>" + price + "</div>";
			content += "</div>";
			content += "<div>" + "♥:" + item.p_likeCount + "</div>";
			content += "	<div>" + item.c_name + "</div>";
			content += "<div class='mai-time'>";
			content += "	<div>" + item.p_tm + "</div>";
			content += "</div></div>";
		});
		$("#like .item-box").empty();
		$("#like .item-box").append(content);
	}//좋아요 리스트 end

	//데이터 가져와서 뿌려주는 신고 리스트
	function report_list(reportlist) {

		console.log("reportlist:", reportlist);
		var content = "";

		$(".button-layout_sold").hide();
		$(".alien_list_sold").hide();
		$(".button-layout_auction").hide();

		reportlist.forEach(function(item, idx) {
			console.log('idx:', idx, item);
			
			

			
			content += "<tr class='content-zoon_report'>"
			content += "<td>" + item.n_receiveId + "</td>";
			content += "<td>" + item.n1_name + "신고</td>";
			content += "<td class='n1_name'>" + item.n_content + "</td>";
			content += "<td>" + item.hn_adminid + "</td>";
			content += "<td>" + item.hn_tm + "</td>";
			content += "<td>" + item.c_name + "</td>";
			content += "</tr>"
		});
		$("#alarm #Content").empty();
		$("#alarm #Content").append(content);
	}//신고 리스트 end
</script>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">

		<!-- true일때 실행되는 마이페이지 -->
		<c:if test="${myPageInfo.myYN eq 'true'}">
			<c:if test="${sessionScope.adminYN eq 'Y'}">
				<h2 style="margin-top: 30px;">${myPageInfo.u_nname}님의프로필</h2>
			</c:if>
			<c:if test="${sessionScope.adminYN eq 'N'}">
				<h2 style="margin-top: 30px;">마이페이지</h2>
			</c:if>
			<!-- 마이페이지 상단 -->
			<div id="div1">
				<table id="userInfoBox">
					<tr>
						<td colspan="2"><c:if
								test="${myPageInfo.u_newName  eq 'default-profile.png'}">
								<div class="box">
									<img class="profile" src="./img/default-profile.png">
								</div>
							</c:if> <c:if test="${myPageInfo.u_newName  ne 'default-profile.png'}">
								<div class="box">
									<img class="profile" src="/photo/${myPageInfo.u_newName }">
								</div>
							</c:if>
					</tr>
					<tr>
						<th colspan="2">${myPageInfo.u_nname}</th>
					</tr>
					<tr>
						<td colspan="2" class="addrBg">${myPageInfo.u_addr }&nbsp;${myPageInfo.u_detailAddr }</td>
					</tr>
					<tr style="text-align: left;">
						<th style="padding-top: 30px;">이름</th>
						<td style="padding-top: 30px;">${myPageInfo.u_name }</td>
					</tr>
					<tr style="text-align: left;">
						<th>이메일</th>
						<td>${myPageInfo.u_email }</td>
					</tr>
					<tr style="text-align: left;">
						<th>전화번호</th>
						<td>${myPageInfo.u_phone }</td>
					</tr>
					<c:if test="${sessionScope.adminYN eq 'N'}">
						<tr>
							<td colspan="2" style="padding-top: 20px;"><button
									onclick="location.href='./userUpdateForm?id=${loginId}'">회원정보
									수정</button></td>
						</tr>
					</c:if>
				</table>

				<table id="pointBox">
					<tr>
						<th>현재 포인트</th>
						<td><a href="#" onclick="pointListPop();">${myPageInfo.pnt_point }P</a></td>
						<c:if test="${sessionScope.adminYN eq 'N'}">
							<td><input type="button" value="충전" onclick="chargePopup();"
								id="chargeBtn" /></td>
						</c:if>
					</tr>
				</table>
				<div id="intro" style="margin-top: 20px;">
					<p>
						<b>자기소개 글</b>
					</p>
					<p class="introBox">${myPageInfo.u_intro}</p>
				</div>
			</div>


			<!-- === 마이페이지 하단=== -->
			<div id="myBottom">
				<div id="twoButton">
					<button>판매목록</button>
					<button>경매목록</button>
					<button>구매목록</button>
					<button>커뮤니티</button>
					<button>팔로우</button>
					<button>구매요청</button>
					<button>좋아요</button>
					<button style="margin:0px;">신고목록</button>
				</div>

				<div id="sale" class="categori"
					>
					<jsp:include page="./mypage_list/sold.jsp"></jsp:include>
				</div>
				<div id="trade" class="categori"
					><jsp:include
						page="./mypage_list/auction.jsp"></jsp:include></div>
				<div id="sell" class="categori"
					><jsp:include
						page="./mypage_list/maide.jsp"></jsp:include></div>
				<div id="commu" class="categori"
					><jsp:include
						page="./mypage_list/community.jsp"></jsp:include></div>
				<div id="follow" class="categori"
					><jsp:include
						page="./mypage_list/flows.jsp"></jsp:include></div>
				<div id="want" class="categori"
					><jsp:include
						page="./mypage_list/request.jsp"></jsp:include></div>
				<div id="like" class="categori"
					><jsp:include
						page="./mypage_list/loving.jsp"></jsp:include></div>
				<div id="alarm" class="categori"
					><jsp:include
						page="./mypage_list/report.jsp"></jsp:include></div>
			</div>
		</c:if>













		<!-- fals일때 실행되는 타인프로필 -->
		<c:if test="${myPageInfo.myYN eq 'false'}">
			<h2 style="margin-top: 30px;">${myPageInfo.u_nname}님의프로필</h2>
			<!-- 마이페이지 상단 -->
			<div id="div2">
				<table id="userInfoBox">
					<tr>
						<td colspan="2"><c:if
								test="${myPageInfo.u_newName  eq 'default-profile.png'}">
								<div class="box">
									<img src="./img/default-profile.png" width="130px" />
								</div>
							</c:if> <c:if test="${myPageInfo.u_newName  ne 'default-profile.png'}">
								<div class="box">
									<img src="/photo/${myPageInfo.u_newName}" width="130px" />
								</div>
							</c:if>
					</tr>
					<tr>
						<th colspan="2">${myPageInfo.u_nname}</th>
					</tr>
					<tr>
						<td colspan="2" class="addrBg">${myPageInfo.u_addr}&nbsp;${myPageInfo.u_detailAddr}</td>
					</tr>
					<tr id="f_mBtn">
						<td><button>+팔로우</button>
							<button onclick="sendMsgPop()">쪽지</button></td>
					</tr>
					<tr>
						<td colspan="2"><a href="#" onclick="notifyPopup()">신고하기</a></td>
					</tr>
				</table>
				<div id="intro">
					<p>
						<b>${myPageInfo.u_nname}님의 자기소개</b>
					</p>
					<p class="introBox">${myPageInfo.u_intro}</p>
				</div>
			</div>

			<div id="twoButton">
				<button>판매목록</button>
					<button>경매목록</button>
					<button style="display:none">구매목록</button>
					<button>커뮤니티</button>
					<button>팔로우</button>
					<button  style="display:none">구매요청</button>
					<button  style="display:none">좋아요</button>
					<button style="margin:0px; display:none;" >신고목록</button>
			</div>

			<div id="sale" class="categori"><jsp:include page="./mypage_list/sold.jsp"></jsp:include></div>
			<div id="trade" class="categori" ><jsp:include page="./mypage_list/auction.jsp"></jsp:include></div>
			<div id="commu" class="categori" ><jsp:include page="./mypage_list/community.jsp"></jsp:include></div>
			<div id="follow" class="categori" ><jsp:include page="./mypage_list/flows.jsp"></jsp:include></div>
		</c:if>

	</div>
	<!-- div main end -->
</body>
</html>