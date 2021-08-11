<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리페이지</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
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
	margin: 0px auto;
	padding: 30px;
}

/*tab 메뉴*/
#manageButton {
	width: 1140px;
	height: 50px;
	margin: 0px auto;
}

#manageButton button {
	/* display:inline-block; */
	width: 285px;
	height: 50px;
	float: left;
	background-color: #fff;
	border: 1px solid #D8D8D8;
	border-collapse: collapse;
}

#manageButton button:hover {
	background-color: #F2F2F2;
	cursor: pointer;
}

#userInfo, #notifyInfo, #blackInfo {
	width: 1140px;
	height: auto;
	border: 0.7px solid #eaeaea;
	margin: 0px auto;
}

#Content {
	clear: both;
	padding: 10px 0;
}

#Content table {
	width: 1050px;
	margin: 0px auto;
	border-top: 1px solid gray;
}

#Content table th {
	/* border: 1px solid black; */
	padding: 10px 0;
}

#Content table td {
	/* border: 1px solid black; */
	padding: 8px 0;
	text-align: center;
}

#Content table td a {
	text-decoration: none;
	color: #000;
}

#Content table td a:hover {
	text-decoration: underline;
}

.userTr:hover, .notifyFilter:hover, .blackListTr:hover{
	background-color: #D8D8D8;
	cursor: pointer;
}

h2 {
	text-align: center;
	padding-bottom: 30px;
}

h3 {
	text-align: center;
	padding: 30px 0 30px 0;
}

/*검색창*/
#searchBox {
	width: 500px;
	/* margin: 0px auto; */
}

#searchBox img {
	width: 20px;
	cursor: pointer;
	transition: 0.5s;
	float: left;
	padding-left: 5px;
}

#searchBox input {
	display: block;
	width: 280px;
	height: 25px;
	outline: none;
	border: 1px solid gray;
	border-radius: 3px;
	float: left;
}

/*검색, select있는bar*/
#headerBar {
	width: 1050px;
	margin: 0px auto;
}

#headerBar {
	width: 1050px;
	margin: 0px auto;
}

#headerBar select {
	width: 90px;
}

#headerBar td {
/* 	border:1px solid black; */
	
}
</style>
</head>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
		<h2>관리페이지</h2>
		<p style="margin-left: 20px;">${sessionScope.loginId}님의 관리페이지</p>
		<div id="manageButton">
			<button class="userBtn">회원목록</button>
			<button class="notifyBtn">신고</button>
			<button class="blackBtn">블랙리스트</button>
			<button class="myBtn">작성 글 목록</button>
		</div>

		<!-- ===========회원목록============= -->
		<div id="userInfo">
			<h3>회원목록</h3>
			<table id="headerBar">
				<tr>
					<td>
						<div id="searchBox">
							<input type="text" name="search" placeholder="검색">
							<img src="img/search-icon.png" alt="search-icon">
						</div>
					</td>
				</tr>
			</table>
			<div id="Content">
				<table>
					<tr>
						<th>아이디</th>
						<th>닉네임</th>
						<th>이름</th>
						<th>이메일</th>
						<th>전화번호</th>
						<th>가입날짜</th>
					</tr>
					<tr>
						<td colspan="6" style="padding: 0; border-bottom: 1px solid gray"></td>
					</tr>
					<c:forEach items="${userList}" var="userList">
					<tr class="userTr" id="${userList.u_id }">
						<td class="u_id">${userList.u_id}</td>
						<td>${userList.u_nname}</td>
						<td>${userList.u_name}</td>
						<td>${userList.u_email}</td>
						<td>${userList.u_phone}</td>
						<td>${userList.u_joinTm}</td>
					</tr>
					<tr>
						<td colspan="6"
							style="padding: 0; border-bottom: 0.7px solid #e8e8e8"></td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>


		<!-- ===========신고============= -->
		<div id="notifyInfo">
			<h3>신고</h3>

			<table id="headerBar">
				<tr>
					<td>
						<div id="searchBox">
							<input type="text" name="search" placeholder="검색"> <img
								src="img/search-icon.png" alt="search-icon">
						</div>
					</td>
					<td style="text-align: right;  width:160px;">
					<small>처리상태  </small><select  id="n_stateCat">
					<option value="all">전체</option>
					<c:forEach items="${n_stateCat }" var="n_stateCategory">
							<option value="${n_stateCategory.c_code }">${n_stateCategory.c_name }</option>
					</c:forEach>
					</select></td>
				</tr>
			</table>
			<div id="Content">
				<table >
					<tr>
						<th>신고번호</th>
						<th>신고받은 아이디</th>
						<th>신고한 아이디</th>
						<th>대분류명</th>
						<th>신고날짜</th>
						<th>처리상태</th>
						<th>담당자</th>
					</tr>
					<tr class="beforeTr">
						<td colspan="7" style="padding: 0; border-bottom: 1px solid gray"></td>
					</tr>
					<c:forEach items="${notifyList}" var="notifyList">
					<tr class="notifyFilter" id="${notifyList.n_no}">
						<td>${notifyList.n_no}</td>
						<td>${notifyList.n_receiveId}</td>
						<td>${notifyList.n_sendId}</td>
						<td>${notifyList.n1_name}</td>
						<td>${notifyList.n_tm}</td>
						<td>${notifyList.c_name}</td>
						<td>${notifyList.hn_adminid}</td>
					</tr>
					<tr class="notifyLine">
						<td colspan="7"
							style="padding: 0; border-bottom: 0.7px solid #e8e8e8"></td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>


		<!-- ===========블랙리스트============= -->
		<div id="blackInfo">
			<h3>블랙리스트</h3>

			<table id="headerBar">
				<tr>
					<td>
						<div id="searchBox">
							<input type="text" name="search" placeholder="검색">
							<img src="img/search-icon.png" alt="search-icon">
						</div>
					</td>

				</tr>
			</table>
			<div id="Content">
				<table>
					<tr>
						<th>아이디</th>
						<th>등록 날짜</th>
						<th>등록 종료 날짜</th>
						<th>담당자</th>
					</tr>
					<tr>
						<td colspan="5" style="padding: 0; border-bottom: 1px solid gray"></td>
					</tr>
					<c:forEach items="${blackList}" var="blackList">
					<tr class="blackListTr" id="${blackList.b_no }">
						<td>${blackList.b_id }</td>
						<td>${blackList.b_startTm }</td>
						<td>${blackList.b_endTm }</td>
						<td>${blackList.b_adminId }</td>
					</tr>
					<tr>
						<td colspan="5"
							style="padding: 0; border-bottom: 0.7px solid #e8e8e8"></td>
					</tr>
					</c:forEach>
				</table>
			</div>
		</div>


		<!-- ===========작성 글 목록============= -->
		<div id="myInfo">
			<h3>작성 글 목록</h3>
			<div id="Content">
				<table id="noticeTable">
			<tr>
				<th>글번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<tr>
				<td colspan="5" style="padding:0; border-bottom:1px solid gray"></td>
			</tr>
			<c:if test="${noticeList eq null || noticeList eq ''}">
				<tr>
					<td colspan="5" style="padding:100px ">작성한 글이 없습니다.</td>
				</tr>
			</c:if>
			<c:forEach items="${noticeList}" var="noticeList">
				<tr>
					<td>${noticeList.p_no}</td>
					<td style="text-align: left;"><a href="noticeDetail?p_no=${noticeList.p_no}">${noticeList.p_title}</a></td>
					<td>${noticeList.u_nname}</td>
					<td>${noticeList.p_tm}</td>
					<td>${noticeList.p_view}</td>
				</tr>
				<tr>
				<td colspan="5" style="padding:0; border-bottom:0.7px solid #e8e8e8"></td>
			</tr>
			</c:forEach>
		</table>
			</div>
			
		</div>


	</div>
	<!-- main end -->
</body>
<script type="text/javascript">

	//초기 화면 설정
	$(".userBtn").css({
		"background-color" : "#D8D8D8"
	});
	$("#userInfo").show();
	$("#notifyInfo, #blackInfo, #myInfo").hide();

	//회원목록 버튼 클릭 했을 때
	$(".userBtn").click(function() {
		$(".userBtn").css({
			"background-color" : "#D8D8D8"
		});
		$(".notifyBtn, .blackBtn, .myBtn").css({
			"background-color" : "#fff"
		});
		$("#userInfo").show();
		$("#notifyInfo, #blackInfo, #myInfo").hide();
	});

	//신고 버튼 클릭 했을 때
	$(".notifyBtn").click(function() {
		$(".notifyBtn").css({
			"background-color" : "#D8D8D8"
		});
		$(".userBtn, .blackBtn, .myBtn").css({
			"background-color" : "#fff"
		});
		$("#notifyInfo").show();
		$("#userInfo, #blackInfo, #myInfo").hide();
	});

	//블랙리스트 버튼 클릭 했을 때
	$(".blackBtn").click(function() {
		$(".blackBtn").css({
			"background-color" : "#D8D8D8"
		});
		$(".userBtn, .notifyBtn, .myBtn").css({
			"background-color" : "#fff"
		});
		$("#blackInfo").show();
		$("#notifyInfo, #userInfo, #myInfo").hide();
	});

	//마이페이지 버튼 클릭 했을 때
	$(".myBtn").click(function() {
		$(".myBtn").css({
			"background-color" : "#D8D8D8"
		});
		$(".userBtn, .blackBtn, .notifyBtn").css({
			"background-color" : "#fff"
		});
		$("#myInfo").show();
		$("#notifyInfo, #blackInfo, #userInfo").hide();
	});
	
	
	/*회원 프로필 이동*/
    $(".userTr").on("click", function(){
    	var u_id = $(this).attr("id");
    	console.log(u_id);
    	console.log("회원프로필 이동 요청");
        location.href="./myPage?id="+u_id;
     });
	
	var param={};
	
	var newName, n=0;
	 function newWindow(value)
	    {
	       n = n + 1;
	       newName = value + n;     
	    }

	 
	
	/*신고 상세보기*/
    $(document).on("click",".notifyFilter", function(){
    	console.log("신고 상세보기 팝업");
    	 var n_no = $(this).attr("id");
    	 console.log(n_no);
    	  newWindow("MyWindow");
    	 window.open("notifyDetail?n_no="+n_no , newName, "width=900, height=600, left=450, top=180");
     });
	
	
	/*블랙리스트 상세보기*/
    $(document).on("click",".blackListTr", function(){
    	console.log("신고 상세보기 팝업");
    	 b_no = $(this).attr("id");
    	 console.log(b_no);
    	  newWindow("MyWindow");
    	 window.open("blackLstDet?b_no="+b_no , newName, "width=900, height=600, left=450, top=180");
     });
	
	
	var param = {};
	/*==신고목록==*/
	//대분류명 select
 	$("select#n_stateCat").on("change", function(){
 		 console.log("필터 요청");
 		param.n_stateCatSel = $("select#n_stateCat option:selected").val();
 		
 		$.ajax({
			type : 'POST',
			url : 'n_stateCatSel',
			data : param,
			dataType : 'JSON',
			success : function(data) {
				console.log("필터 list가져오기 성공");			
				re_draw(data.n_stateCatSel);
			},
			error : function(e) {
				console.log(e);
			}
		});
	});
	
 
 	
	function re_draw(n_stateCatSel){
		 console.log("필터 리스트 : ", n_stateCatSel);
		var re_comment = "";
		 if(n_stateCatSel != null){
			
			 
			 n_stateCatSel.forEach(function(item,idx){
				 console.log("아이템 :", item , "idx : ", idx);
				 re_comment += "<tr class='notifyFilter' id='"+item.n_no+"'>";
				 re_comment +=		"<td>"+item.n_no+"</td>";
				 re_comment +=		"<td>"+item.n_receiveId+"</td>";
				 re_comment +=		"<td>"+item.n_sendId+"</td>";
				 re_comment +=		"<td>"+item.n1_name+"</td>";
				 re_comment +=		"<td>"+item.hn_tm+"</td>";
				 re_comment +=		"<td>"+item.c_name+"</td>";
				 re_comment +=		"<td>"+item.hn_adminid+"</td>";
				 re_comment +=	"</tr>";
				 re_comment +=	"<tr class='notifyLine'>";
				 re_comment +=		"<td colspan=7 style='padding: 0; border-bottom: 0.7px solid #e8e8e8'></td>";
				 re_comment +=	"</tr>";
			 });
			 
			 delTr();
			 
			 $(".beforeTr").after(re_comment);
			 
			 
		 }else{
			 re_comment += "<h2>해당하는 내용이 없습니다.</h2>";
		 }

	}
	function delTr() {
		$("table tr.notifyFilter").remove();
		 $("table tr.notifyLine").remove();
		
	}
	
	var msg = "${msg}";
	
	if(msg != ""){
		alert(msg);
	}
	
	
</script>
</html>