<%@ page import="com.gg.dto.GGDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

/* *{margin:0;padding:0;border-width:0;list-style-type:none;}
    body{width:100%;background-color:white;}
	*/
#mainHeader {
	z-index: 1000;
}

#main {
	/* background-color: gray; */
	width: 1140px;
	height: auto;
	position: absolute;
	top: 150px;
	z-index: -1;
}
/* #wrap{margin-top:150px;}  */
#category {
	font-weight: 600;
	font-color: #848484;
	font-size: 1.2rem;
}

section {
	width: 100%;
}

#sectionWrap {
	width: 1200px;
	margin: 0 auto;
}

#sectionWrap>article {
	width: 1200px;
	height: 1000px; /* border:1px solid black; */
	clear: both;
}

#imgWrap {
	width: 400px;
	height: 400px; /* background-color:green; */
	float: left;
}

#description {
	width: 740px;
	height: 400px;
	float: left;
	margin-left: 50px;
	position: relative; /* background-color:white; */
}

#description>h1 {
	margin-left: 10px;
	margin-top: 10px;
	font-size: 2rem;
}

#description>h1>sup {
	border-radius: 5px;
	margin-left: 10px;
	background-color: blue;
	font-size: 1rem;
	color: white;
}

#salePrice {
	margin-left: 10px;
	margin-top: 10px;
	margin-bottom: 50px;
	font-weight: 700;
	font-size: 3rem;
}

#description>p:not(:nth-of-type(1)) {
	color: gray;
	margin: 20px;
	font-size: 1.2rem;
}

#description>div {
	position: absolute;
	top: 30px;
	left: 600px;
	width: 100px;
	height: 40px;
}

#description>div>a {
	text-decoration: none;
	color: gray;
}

#threeButton {
	line-height: 100px;
	margin-left: 400px;
	width: 600px;
	height: 100px; /* background-color:rosybrown; */
	float: right;
}

#threeButton>button {
	margin: 3px;
	width: 190px;
	height: 80px;
}

#threeButton>button {
	color: white;
	font-size: 1.5rem;
	font-weight: 700
}

#threeButton>button:nth-last-of-type(5) {
	background-color: red;
}

#threeButton>button:nth-last-of-type(4) {
	background-color: gray;
}

#threeButton>button:nth-last-of-type(3) {
	background-color: green;
}

#threeButton>button:nth-last-of-type(2) {
	background-color: orange;
}

#threeButton>button:nth-last-of-type(1) {
	background-color: gray;
}

#twoButton>button {
	height: 50px;
	font-size: 1.2rem;
}

#twoButton {
	overflow: hidden;
	clear: both;
}

#twoButton>button:nth-last-of-type(1) {
	float: left;
}

#twoButton>button:nth-last-of-type(2) {
	float: left;
}

#first, #second {
	width: 1200px;
	border: 1px solid black;
	clear: both;
}

#first>div:nth-of-type(1) {
	border: 1px solid #D8D8D8;
	width: 738px;
	height: 400px;
	float: left;
	margin: 10px;
	padding: 20px;
}

#first>div:nth-of-type(2) {
	width: 380px;
	float: left;
	margin: 10px;
}

#first>div:nth-of-type(2)>p:nth-of-type(1) {
	font-weight: 700;
	font-size: 2rem;
	border-bottom: 1px solid gray;
	margin-left: 10px;
}

#first>div:nth-of-type(2)>div:nth-of-type(1) {
	width: 400px;
	height: 120px;
	clear: both;
}

#first>div:nth-of-type(2)>div:nth-of-type(1)>div:nth-of-type(1) {
	width: 100px;
	height: 100px;
	margin: 20px 20px 10px 20px;
	float: left;
}

#first>div:nth-of-type(2)>div:nth-of-type(1)>div:nth-of-type(2) {
	width: 210px;
	height: 100px;
	margin: 20px 20px 10px 10px;
	float: left;
}

#u_nname {
	font-weight: 700;
	font-size: 1.5rem;
	margin: 10px;
}

#reviewAvg {
	font-weight: 500;
	font-size: 1.3rem;
	margin: 10px;
}

/*댓글*/
#second	table.board {
	border: 1px solid #D8D8D8;
	width: 1196px;
	height: 50vh;
	float: left;
	border-collapse: collapse;
}

.board_text , .update_text  {
	border: 1px solid #D8D8D8;
	width: 1190px;
	height: 5vh;
	float: left;
}
.plus_reText {
	border: 1px solid #D8D8D8;
	width: 1140px;
	height: 5vh;
	float: left;
}
.re_enter{
	width: 43px;
	height: 5vh;
	float:right;
}

.enter {
	margin-bottom: 10px;
	margin-left: 10px;
	padding: 20px;
}

.content {
	float: left;
	margin-left: 3px;
	background-color: white;
	height: 120px;
	width: 950px;
}
/* .content p{ float : left; background-color: white; } */
.one-text {
	border: 1px solid black;
	border-radius: 10px;
	width: 1190px;
	height: 150px;
	margin-bottom: 10px;
	
}

;
.one-text .one-img-time {
	display: block;
	justify-content: space-between;
	align-items: center;
}

.one-text .one-img-time img.commentProfile {
	width: 90px;
	height: 90px;
	border-radius: 50px;
	float: right;
	overflow: hidden;
	margin: 0px auto;
	border: 0.5px solid lightgray;
}

#follow {
	background-color: #E6E6E6;
	width: 340px;
	height: 60px;
	color: black;
	font-size: 1.5rem;
	font-weight: 700;
	margin: 20px;
	border-radius: 5px/5px;
}

#first>div:nth-of-type(2)>div:nth-of-type(2) {
	width: 340px;
	height: 100px;
	margin: 10px 20px;
}

#first>div:nth-of-type(2)>div:nth-of-type(2)>div {
	width: 98px;
	height: 98px;
	margin: 0 6px;
	float: left;
	position: relative;
	border: 1px solid gray;
	border-radius: 5px/5px;
}

#first>div:nth-of-type(2)>div:nth-of-type(2)>div>p {
	color: white;
	background-color: black;
	opacity: 0.5;
	bottom: 0;
	left: 10px;;
	position: absolute;
}

#first>div:nth-of-type(2)>p:last-child {
	text-align: center;
	margin: 10px;
}

.usertext:hover {
	color: lightblue;
}

#commentNickname {
	float: left;
	height: 10px;
	width: 100px;
	text-align: center;
	font-weight: bold;
	color: black;
	text-decoration: none;
}

#report img {
	cursor: pointer;
	float: right;
}

.commentChange {
	float: right;
	cursor: hand;
}
#comm_update, #comm_del, .re{
	cursor: pointer;
}
.commentChange:hover {
	font-weight: bold;
}

li {
	list-style-image: url("./img/re_Comment.png");
 	
}

</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	//팔로우를 했는지 안했는지 판별하는 변수, false일 경우, 팔로우 하지 않았음을 의미
	var isFollowed = false;
	$(document).ready(
			function() {
				//수정 삭제버튼 숨기기
				$("#description>div:nth-of-type(2)").hide();
				//이전에 해당 판매글에 대해 구매요청을 누른적이 있는지 확인
				<c:if test="${isBuyRequested eq true}">$(
						"#threeButton>button:nth-last-of-type(2)").hide();
				</c:if>
				<c:if test="${isBuyRequested eq false}">$(
						"#threeButton>button:nth-last-of-type(1)").hide();
				</c:if>

				//댓글 창을 숨김
				$("#second").hide();
				//상세정보 버튼 초기설정
				$("#twoButton>button:nth-of-type(1)").css({
					"background-color" : "gray",
					"color" : "white"
				});
				//이전에 해당 판매글에 대해 좋아요를 누른적이 있는지 확인
				<c:if test="${isLiked eq true}">$(
						"#threeButton>button:nth-last-of-type(5)").hide();
				</c:if>
				<c:if test="${isLiked eq false}">$(
						"#threeButton>button:nth-last-of-type(4)").hide();
				</c:if>
				
				//이전에 이용자가 판매자를 팔로우한 적이 있는지 확인
				//팔로우를 했을 경우
				<c:if test="${isFollowed eq true}">
					$("#follow").css({"color" : "white", "background-color" : "gray"});
					$("#follow").text("-팔로우");
					isFollowed = true; //팔로우를 했다는 뜻
				</c:if>

				//팔로우 클릭시 버튼 변경
				//false는 팔로우를 안했다는 뜻 기존값 그대로
				$("#follow").click(function() {
					//팔로우를 안한 상태에서 팔로우 하기
					if (!isFollowed) {
						
						var param = {};
						param.btntext = "+팔로우";
						param.nick = "${dto.u_nname }";
						
						$.ajax({
							type: "POST",
							data: param,
							dataType: "JSON",
							url: "flowadddelect",
							success : function(data){ 
								if(data.success){
									//클릭함으로 인해 팔로우하게 됨
									//팔로우 해제를 할 수 있는 모양으로 바뀜
									$("#follow").css({"color" : "white", "background-color" : "gray"});
									$("#follow").text("-팔로우");
									//팔로우 한 상태가 됨
									isFollowed = true;
									alert("팔로우 성공");			
								}else{
									alert("팔로우 실패");
								}
							},
							error : function(e) {
								console.log(e);
							}
						});
					//팔로우한 상태에서 팔로우 해제	
					} else {
						
						var param = {};
						param.btntext = "-팔로우";
						param.nick = "${dto.u_nname }";
						
						$.ajax({
							type: "POST",
							data: param,
							dataType: "JSON",
							url: "flowadddelect",
							success : function(data){ 
								if(data.success){
									//클릭함으로 인해 팔로우 해제됨
									//다시 팔로우를 할 수 있는 모양으로 바뀜
									$("#follow").css({"color" : "black", "background-color" : "#E6E6E6"});
									$("#follow").text("+팔로우");
									isFollowed = false;
									alert("팔로우 해제 성공");
								}else{
									alert("팔로우 해제 실패");
								}
							},
							error : function(e) {
								console.log(e);
							}
						});
					}
				});
				
				//상세정보 버튼 클릭시 창이 표시
				$("#twoButton>button:nth-of-type(2)").click(function() {
					$("#twoButton>button:nth-of-type(2)").css({
						"background-color" : "gray",
						"color" : "white"
					});
					$("#twoButton>button:nth-of-type(1)").css({
						"background-color" : "white",
						"color" : "black"
					});
					$("#second").show();
					$("#first").hide();
				});

				//댓글 버튼 클릭시 창이 표시
				$("#twoButton>button:nth-of-type(1)").click(function() {
					$("#twoButton>button:nth-of-type(1)").css({
						"background-color" : "gray",
						"color" : "white"
					});
					$("#twoButton>button:nth-of-type(2)").css({
						"background-color" : "white",
						"color" : "black"
					});
					$("#first").show();
					$("#second").hide();
				});

				//찜1버튼 클릭시 숨겨짐
				$("#threeButton>button:nth-last-of-type(5)").click(function() {
					$("#threeButton>button:nth-last-of-type(5)").hide();
					$("#threeButton>button:nth-last-of-type(4)").show();
				});

				//찜2버튼 클릭시 숨겨짐
				$("#threeButton>button:nth-last-of-type(4)").click(function() {
					$("#threeButton>button:nth-last-of-type(4)").hide();
					$("#threeButton>button:nth-last-of-type(5)").show();
				});

				//dto.ns_name 가 거래중 또는 판매완료일 경우 버튼 색상변경과 비활성화 시키기
				if ($("#description>h1>sup").text() == "거래중"
						|| $("#description>h1>sup").text() == "판매완료") {
					$("#description>h1>sup").css({
						"background-color" : "gray"
					});
					$("#threeButton>button").css({
						"background-color" : "gray"
					}).attr("disabled", true);
				}
				//판매자가 자신의 글을 본다면 수정 삭제 표시, 팔로우 숨기기, 버튼 색상변경과 비활성화 시키기
				if ("${sessionScope.loginId}" == "${dto.p_id}") {
					/* if("user2" == "${dto.p_id}"){ */
					$("#threeButton>button").css({
						"background-color" : "gray"
					}).attr("disabled", true);
					$("#follow").css({
						"background-color" : "gray"
					}).attr("disabled", true);
					$("#description>div:nth-of-type(1)").hide();
					$("#description>div:nth-of-type(2)").show();
				}
					
				 //로그인이 안된 상태로 경매글 진입시, 모든 버튼과 팔로우 숨기기, 버튼 색상변경과 비활성화 시키기
			    if("${sessionScope.loginId}" == ""){
			    //if("user2" == "${dto.p_id}"){
			    	$("#threeButton>button").css({"background-color":"gray"}).attr("disabled", true);
			    	$("#follow").css({"background-color":"gray"}).attr("disabled", true);
			    	$("#description>a:nth-of-type(1)").hide();
			    	$("#description>div:nth-of-type(1)").hide();
			    }	
			});
</script>
</head>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
		<div id="wrap">
			<p id="category">${dto.p_name }> ${dto.s_name }</p>
			<section>
				<div id="sectionWrap">
					<article>
						<div id="imgWrap">
							<img src="/photo/${dto.i_newName }" width="400px" height="400px">
							<p>i_newName ${dto.i_newName }</p>
						</div>
						<div id="description">
							<h1>${dto.p_title }<sup>${dto.ns_name }</sup>
							</h1>
							<p id="salePrice">${dto.ns_pr }P</p>
							<p>${dto.p_tm }</p>
							<p>
								거래방식 :
								<c:if test="${dto.s_DeliveryYN eq 'Y' }">택배</c:if>
								<c:if test="${dto.s_DeliveryYN eq 'N' }">직거래</c:if>
							</p>
							<%
								GGDto dto = (GGDto) request.getAttribute("dto");
							%>
							<%-- <p>거래주소 : ${dto.u_addr }</p> --%>
							<p>
								거래주소 :
								<%=dto.getU_addr()%></p>
							<!-- 주소가 넘어오지를 않음 dao에서는 정상적으로 받아옴 -->
							<p>
								하트<span>${dto.p_likeCount }</span>&nbsp;&nbsp;&nbsp;&nbsp;조회수<span>${dto.p_view }</span>
							</p>
							<div>
								<a href="#" class="reporter">신고하기</a>
							</div>
							<div>
								<a href="./salesUpdateForm?p_no=${dto.p_no}">수정 /</a>&nbsp;<a
									href="#" onclick="delChk()">삭제</a>
							</div>
						</div>
						<div id="threeButton">
							<!-- 새로고침 방법 -->
							<%--<button onclick="location.href='lovePlus2?p_no=${dto.p_no }'">찜</button>--%>
							<!-- +1 -->
							<%--<button onclick="location.href='loveMinus2?p_no=${dto.p_no }'">찜</button>--%>
							<!-- -1 -->
							<!-- ajax 방법 -->
							<button>찜+</button>
							<!-- +1 -->
							<button>찜-</button>
							<!-- -1 -->
							<button>쪽지보내기</button>
							<button onclick="location.href='buyRequest?p_no=${dto.p_no }'">구매요청</button>
							<button
								onclick="location.href='buyRequestCancel?p_no=${dto.p_no }'">구매요청취소</button>
						</div>
						<div id="twoButton">
							<button>상세정보</button>
							<button class='board_button'>댓글</button>
						</div>
						<!-- #first>div:nth-of-type(1) -->
						<div id="first">
							<div>${dto.p_content }</div>
							<div>
								<p>상점정보</p>
								<div>
									<div>
										<a href="myPage?id=${dto.p_id }"><img src="./img/profile.PNG" width="100"
											height="100"></a>
									</div>
									<div>
										<p id="u_nname">${dto.u_nname }</p>
										<p id="reviewAvg">별점 4.5</p>
									</div>
								</div>
								<button id="follow">+팔로우</button>
								<div>
									<c:forEach items="${sale3List }" var="dto">
										<div>
											<a href="salesDetail?p_no=${dto.p_no}"><img src="#"
												alt="${dto.i_newName }"></a>
											<p>${dto.ns_pr }P</p>
										</div>
									</c:forEach>

								</div>
								<p>
									<a href="myPage?id=${dto.p_id }">판매자의 다른 상품 더보기 > </a>
								</p>

							</div>
						</div>
						<div id="second">
							<!-- 댓글처리 -->
							<table class='board'>



							</table>
							<div class="board_t_b">
								<textarea class="board_text" style="resize: none;"></textarea>
								<div id="board_text_controll">(0 / 300)</div>
								<button class="enter">enter</button>
							</div>
						</div>
					</article>
				</div>
			</section>
		</div>
	</div>
</body>
<script>
	//좋아요 등록
	$("#threeButton > button:nth-of-type(1)").click(
	function() {
			$.ajax({
				type : 'get',
				url : 'lovePlus2',
				data : {
					'p_no' : "${dto.p_no}"
				},
				dataType : 'JSON',
				success : function(data) {
						console.log(data);
						if (data.success) {
				var love = $(
						"#description>p:nth-of-type(5)>span:nth-of-type(1)").text();
							$("#description>p:nth-of-type(5)>span:nth-of-type(1)").text(++love);
											alert('좋아요 등록 성공.');
										} else {
											alert('좋아요 등록 실패.');
										}
									},
									error : function(e) {
										console.log(e);
									}
								});
					});

	//좋아요 해제
	$("#threeButton>button:nth-of-type(2)")
			.click(
					function() {
						$
								.ajax({
									type : 'get',
									url : 'loveMinus2',
									data : {
										'p_no' : "${dto.p_no}"
									},
									dataType : 'JSON',
									success : function(data) {
										console.log(data);
										if (data.success) {
											var love = $(
													"#description>p:nth-of-type(5)>span:nth-of-type(1)")
													.text();
											$(
													"#description>p:nth-of-type(5)>span:nth-of-type(1)")
													.text(--love);
											alert('좋아요 해제 성공');
										} else {
											alert('좋아요 해제 실패');
										}
									},
									error : function(e) {
										console.log(e);
									}
								});
					});


	//판매글 삭제 버튼 클릭시
	function delChk(){
		var delChk = confirm("글을 삭제하시겠습니까?");
		if(delChk){
			location.href = "./postDel?p_no="+${dto.p_no};
			/* var delMsg = "${delMsg}";
			alert(delMsg); */
		}
	}
	
	//판매글 블라인드 체크 여부 확인
	/*var p_blindYN = "${dto.p_blindYN}";
	if("${dto.p_blindYN}"=="Y"){
			$("#mainHeader").hide();
			$("#main").hide();
			alert("삭제된 경매글 입니다.");
			location.href = "./index.jsp";	
	};*/
	
	
	//댓글 버튼 누르면 이상세 페이지에서 마지막에 쓴 댓글 보여주기
	$("div#twoButton>button.board_button").click(function() {
		commentListCall();
	});
	var comment = {};

	$(".enter").click(function() {

		if ("${sessionScope.loginId}" == '') {
			alert("로그인 해주세요!");
		}else if($(".board_text").val==''){
			alert("댓글을 입력해 주세요!");
		}else {
			comment.id = "${sessionScope.loginId}";
			comment.p_no = "${dto.p_no}";
			comment.pc_content = $(".board_text").val();
			comment.pc_parentno = 0;
			console.log("댓글 다는 아이디 : ", comment.id);
			console.log("댓글 달리는 게시글 : ", comment.p_no);
			console.log("댓글 내용 : ", comment.pc_content);
			console.log("부모 댓글 번호 :", comment.pc_parentno);
			console.log("댓글 등록")

			$.ajax({
				type : "POST",
				url : "./pushComment",
				data : comment,
				dataType : "JSON",
				success : function(data) {
					console.log("반환 데이터 : ", data);
					$(".board_text").empty();
					commentListCall();

				},
				error : function(e) {
					console.log("에러 발생 : ", e);
				}

			});
		}
	});

	function commentListCall() {
		console.log("댓글 리스트 요청 ");
		var param = {};
		param.p_no = "${dto.p_no}";
		$.ajax({
			type : "POST",
			url : "commentListCall",
			data : param,
			dataType : "JSON",
			success : function(data) {
				console.log("받아온 데이터 확인 : ", data.list);
				drawComment(data.list);
			},
			error : function(e) {
				console.log(e);
			}
		});
	};

	function drawComment(list) {
		console.log("리스트 정보 확인 : ", list);
		var comment = "";
		console.log("시간 확인 : ", list.pc_tm);
		var id = "${sessionScope.loginId}";
		list.forEach(function(item, idx) {

					comment += "<tr><td>";
					comment += "<div class = 'one-text' id='"+item.pc_no+"'>";
					comment += "<div class='one-img-time'>";
					comment += "<div class='uploadimg'>";
					comment += "<a id='commentNickname' href='./myPage?id="
							+ item.pc_id
							+ "'><img class='commentProfile' src='/photo/"+item.u_newName+"'/>";
					comment += "<div class='usertext'>" + item.u_nname
							+ "</div></a>";
					comment += "</div>";
					comment += "<div class='content' id='"+item.pc_no+"'>" + item.pc_content
							+ "</div>";
					comment += "<div class='uploadtime' id='report' ><input type='text' value='"+item.pc_id+"' id='"+idx+"' hidden='hidden'/><label for='"+idx+"'id='"+idx+"' class='reporter'><img src='./img/notify-icon.png'/ style='width:20px; height: 20px;'></label></div>";
					comment += "<div style='float:right;'>" + item.pc_tm
							+ "</div>";
					if( id == item.pc_id){
					comment += "<div class='commentChange' ><input type='text' value='"+item.pc_no+"' id='update_"+item.pc_no+"' hidden='hidden'/><label for='update_"+item.pc_no+"' id='comm_update'> 수정하기 </label></div> ";
					comment += "<div class='commentChange' ><input type='text' value='"+item.pc_no+"' id='del_"+item.pc_no+"' hidden='hidden'/><label for='del_"+item.pc_no+"' id='comm_del'>삭제하기 </label></div>";
					}
					//대댓글 영역
					comment += "<div class='re_comment' id='"+item.pc_no+"'><img src='./img/CommentArrow.png' style='float:right; width:30px; height: 30px; margin-top: 70px;' class='re' id='"+item.pc_no+"'></div>";
					comment += "</div>";
					comment += "</div>";
					comment += "</td></tr>";
				});
		$(".board").empty();
		$(".board").append(comment);
	};
	var re_comm = {};
	var checker ="";
	/* 대댓글 보여주며 쓰는 공간 만들어주기. */
	$(document).on("click","img.re",function(){
		checker = $(this).attr("id");
		console.log(checker,"의 대댓글 보기");
		
		re_comm.pc_parentno = checker;
		re_comm.p_no = "${dto.p_no}";
		var comment ="";
		
		wantReshow();
		
	});
	
	function wantReshow(){
		$.ajax({
			type: "POST",
			data: re_comm,
			dataType: "JSON",
			url: "showReComment",
			success : function(data){ 
				console.log("대댓글 리스트 보여주기.");
				console.log(data.list);
				reCommentDrawList(data.list,checker);	
				
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
	
	//대댓글 보여주기
	var re_open = true;
	function reCommentDrawList(list,checker){
		console.log("리스트 내용  :",list);
		var comment ="";
		
		if(list != null){
			list.forEach(function(item,idx){
				
				comment +="<div id='recomments' style='float: right; width:1190px; height: 150px; margin-top:15px;'>";
				comment += "<ul>";
				comment += "<li>";
				comment += "<span><a href='./myPage?id="+item.pc_id+"' style='text-decoration:none; color: black; font-weight:bold;'>"+item.u_nname+"</a></span>";
				comment += "<div id='re_comment'>"+item.pc_content+"</div>";
				comment += "</li>";
				comment += "</ul>";
				comment += "</div>";
			});
			
		}
	
		//대댓글 달 수 있는 곳.
		comment += "<div class='plus_reComm'>";
		comment += "<textarea class='plus_reText' style='resize:none;'placeholder='대댓글을 작성해 주세요' maxlength='300'></textarea>";
		
		comment += "<button class='re_enter' id='"+checker+"'>입력</button>";
		
		comment += "</div>";
		
		if(re_open){
			
			$(".updater").remove();
			$("div#recomments").remove();
			$("div.plus_reComm").remove();
			$("div.one-text#"+checker).append(comment);
			re_open = false;
		}else {
			$(".updater").remove();
			$("div#recomments").remove();
			$("div.plus_reComm").remove();
			re_open = true;
		}
		
		
	};
	
	$(document).on("click",".re_enter",function(){
		
		var plus_reComm = {};
		plus_reComm.pc_parentno = $(this).attr("id");
		console.log("부모댓글 : ", plus_reComm.pc_parentno);
		plus_reComm.pc_content = $(".plus_reText").val();
		console.log("대댓글 작성 내용 : ", plus_reComm);
		plus_reComm.p_no = ${dto.p_no};
		plus_reComm.pc_id = "${sessionScope.loginId}";
		console.log("대댓글달기 글 번호 : ",  plus_reComm.p_no);
		$.ajax({
			type: "GET",
			url : "re_comment",
			data : plus_reComm,
			dataType: "JSON",
			success : function(data){
				console.log("성공");
				wantReshow();
				reCommentDrawList(data.list,plus_reComm.pc_parentno);
			},
			error : function(e){
				console.log(e);	
			}
		});
		

	});
			

	/* 대댓글 추가하기 */
	function plus_reComm(){
		
		$.ajax({
			type: "GET",
			url : "re_comment",
			data : re_comm,
			dataType: "JSON",
			success : function(data){
				console.log("성공");
				
			},
			error : function(e){
				console.log(e);	
			}
		});
	};

	
	var check = true;
	var update_no ={};
	/* 수정 버튼 */
	$(document).on('click','label#comm_update', function(){
		var update_comm = $(this).attr("for");
		console.log(update_comm);
		update_comm = update_comm.substring(7); // update_ 부분을 잘라 idx만 가져오기input[id='update_"+ "']")
		update_no.pc_no = update_comm;
		console.log("변환 후 ", update_comm);

		var update_comment ="";
		update_comment += "<div class='updater'><textarea class='update_text' maxlength='300' placeholder='300자 제한입니다.' style='resize: none;'></textarea>";
		update_comment += "<input type='text' value='"+update_comm + "' hidden='hidden'>";
		update_comment += "<div class='update_button'><button class='update_enter' style='float:right'>수정</button></div>";
		update_comment += "</div>";
		if(check){
			$("div#recomments").remove();
			$("div.plus_reComm").remove();
			$(".updater").remove();
			$(".one-text#"+update_comm).append(update_comment);
			check = false;
		}else {
			
			$("div#recomments").remove();
			$("div.plus_reComm").remove();
			$(".updater").remove();
			check = true;
		}
		console.log(check);	
		
	});
	// 수정 버튼 클릭 시.
	$(document).on("click",".update_button",function(){
		console.log("수정 버튼 클릭");
		console.log(update_no.pc_no); // 해당 번호 클릭.
		update_no.context = $(".update_text").val();
		comm_update(update_no);
	});
	
	
	
	
	
	/* 수정 기능 */
	function comm_update(update_no){
		
		$.ajax({
			type: "POST",
			url : "comm_update",
			data: update_no,
			dataType : "JSON",
			success : function(data){
				console.log("성공");
				commentListCall();
				check=true;
			},
			error : function(e){
				console.log("에러");		
			}
		});
	}
	
	/* 삭제 버튼 */
	$(document).on('click','label#comm_del', function(){
		var del_comm = $(this).attr("for");
		console.log(del_comm);
		del_comm = del_comm.substring(4); // del_ 부분을 잘라 idx만 가져오기
		var param = {};
		param.pc_no = del_comm;
		console.log("변환 후 ", del_comm);
		
		$.ajax({
			type: "POST",
			url : "comm_del",
			data: param,
			dataType : "JSON",
			success : function(data){
				alert("삭제 성공 여부"+data.success);
				commentListCall();
			},
			error : function(e){
				console.log("에러");		
			}
		});
	});
	
	
	/* 신고 버튼 */
	$(document).on('click','.reporter', function() {
			var test = $(this).attr('id');
			console.log(test)
			var N_receiveId = $("input[id=" + test + "]").val();
			console.log("신고할 아이디", N_receiveId);
			window.open("./popup/notifyPopup.jsp?N_receiveId="
					+ N_receiveId, "notifyPopup",
					"width=400, height=400, left=700, top=400");
	});
	
	
	/*글자수 제한*/
	$(".board_text, .update_text").on('keyup', function() {
		$('#board_text_controll').html("(" + $(this).val().length + " / 300)");

		if ($(this).val().length > 300) {
			$(this).val($(this).val().substring(0, 300));
			$('#board_text_controll, update_text_controll').html("(300 / 300)");
		}
	});
	// 경매 리스트 end
	
	
</script>
</html>