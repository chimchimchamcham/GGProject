<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
</head>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="http://code.jquery.com/jquery-1.8.1.min.js"></script>
<script>
	var loginId = "${sessionScope.loginId}"

	$(document).ready(function() {
		
		/*드롭다운메뉴 마우스오버, 마우스리브*/
		$("#dropdown li").mouseover(function() {
			$(this).children("#sub").stop().slideDown();
		});

		$("#dropdown li").mouseleave(function() {
			$(this).children("#sub").stop().slideUp();
		});
		
		/*쪽지함 토글기능*/
		$("#messageList").hide();
		$(".messageA").click(function(){
			$("#messageList").slideToggle('slow');
			$("#alarmList").hide();
		});
		
		/*알람 토글기능*/
		$("#alarmList").hide();
		$(".alarmA").click(function(){
			$("#alarmList").slideToggle('slow');
			$("#messageList").hide();
		});
		
		/*쪽지 로그인 체크*/
		$(".messageA").click(function(){
		if(loginId == ""){
			$("#messageList").html("<h2>로그인이 필요한 서비스 입니다.</h2><br><a href='login.jsp'>로그인 하러가기</a>");
		}
		});
		
		/*알람 로그인 체크*/
		$(".alarmA").click(function(){
		if(loginId == ""){
			$("#alarmList").html("<h2>로그인이 필요한 서비스 입니다.</h2><br><a href='login.jsp'>로그인 하러가기</a>");
		}
		});
		
		/*마이페이지 로그인 체크*/
		$(".myPageA").click(function(){
			if(loginId == ""){
				alert("로그인이 필요한 서비스 입니다.");
				location.href="login.jsp";
			}else{
				location.href="myPage";
			}	
			});
		
		/*거래톡 로그인 체크*/
		$(".tradeA").click(function(){
			if(loginId == ""){
				alert("로그인이 필요한 서비스 입니다.");
				location.href="login.jsp";
			}else{
				alert("거래톡보여주기~~~");
			}	
			});
		
		/*글쓰기 로그인 체크*/
		$(".writeA").click(function(){
		 	if(loginId == ""){
				alert("로그인이 필요한 서비스 입니다.");
				location.href="login.jsp";
			}else{
				location.href="writeForm";
			}	
			});

	});
	
</script>
<style>

body {
	line-height: 1.5em;
	font-size: 1em;
	font-weight: normal;
	color: #333;
	width:1200px;
	margin: 0px auto;
}

#hWrap {
	width: 1200px;
	margin: 0 auto;
	text-align: left;
	background-color: #fff;
}

.Hheader {
	width: 1200px;
	height: 90px;
	position: fixed;
	padding-top: 10px;
	margin: 0px auto;
	background-color: #fff;
	float: top;
}

#logo {
	float: left;
}

/*검색창*/
#search {
	position: absolute;
	left: 100px;
	top: 20px;
}

#search img {
	width: 20px;
	height: 20px;
	position: absolute;
	right: 10px;
	top: 10px;
	cursor: pointer;
	transition: 0.5s;
	
}

#search input {
	display: block;
	width: 568px;
	height: 35px;
	outline: none;
	padding-left: 10px;
	border: 1px solid #D8D8D8;
	border-radius: 3px;
}

/*상단 우측 메뉴*/
#menu1 {
	float: right;
	padding: 10px;
}

#menu1 a {
	padding: 5px;
	text-decoration: none;
	color: black;
}

#menu1 a:hover {
	color: gray;
}

#menu1 button{
margin-left:7px;
	padding: 7px 15px;
	text-decoration: none;
	background-color: #D8D8D8;
	color:#424242;
	border: 3px #D8D8D8;
	border-radius: 5px;
}

#menu1 button:hover{
	background-color: gray;
	color: white;
	cursor:pointer;
}


/*메인메뉴*/
.header_nav {
	width: 1200px;
	position: fixed;
	height: 40px;
	border-bottom: 1px solid #ccc;
	border-top: 1px solid #ccc;
	margin: 90px 0px 10px 0px;
	padding-top: 15px;
	background-color: #fff;
}

.header_nav ul#dropdown {
	box-sizing: border-box;
	margin: 0px auto;
	width: 1000px;
	background-color: #fff;
}

.header_nav ul#dropdown li {
	float: left;
	list-style: none;
	margin: 0px auto;
	background-color: #fff;
}

.header_nav ul#dropdown li a {
	color: #000;
	padding: 0 82px;
	text-decoration: none;
	display: block;
}

.header_nav ul#dropdown li a:hover {
	color: gray;
}


/*드롭다운 하위 메뉴*/
#sub {
 	display: none;
	margin: 16px 0 0 -13px;
	list-style: none;
	position: absolute;
	z-index: 100;
}

.header_nav ul#dropdown li ul li {
	float: none;
	display: inline;
}

.header_nav ul#dropdown li ul li a {
	width: 120px;
	height: 30px;
	padding: 10px 20px 0px 10px;
	background-color: #F2F2F2;
	font-size: 0.9em;
	text-transform: capitalize;
	text-align: center;
}

.header_nav ul#dropdown li ul li a:hover {
	background-color: #ffffff;
	background-color: rgba(255, 255, 255, 0.9);
}

.header_nav ul#dropdown:after {
	content: "";
	display: block;
	clear: both;
}


/*쪽지함*/
#messageList{
	width: 450px;
	height:500px;
	position: fixed;
	background-color:#E6E6E6;
	z-index: 1000;
	top:60px;
	right:340px;
	text-align: center;
	}
	
#alarmList{
	width: 450px;
	height:500px;
	position: fixed;
	background-color:#E6E6E6;
	z-index: 1000;
	top:60px;
	right:290px;
	text-align: center;
}

</style>
<body>
	<div id="hWrap">
		<header class="Hheader">
			<div>
				<div id="logo"><a href="index.jsp"><img src="img/logo2.png" width="80"></a></div>
				<div id="search">
					<input type="text" name="search" placeholder="찾고 싶은 상품을 검색해보세요!">
					<img src="img/search-icon.png" alt="search-icon">
				</div>
				<div id="menu1">
				

				<!-- 로그인이 안되어있을 때 -->
				<c:if test="${loginId eq null }">
				<a href="joinForm.jsp" class="joinA">회원가입</a>
					<a href="login.jsp"  class="loginA">로그인</a>
				</c:if>
				
				<!-- 로그인이 되어있을 때 -->
				<c:if test="${loginId ne null }"> 
					<a href="logout"  class="logoutA">로그아웃</a>
				</c:if>

				<a href="#"  class="messageA">쪽지</a>
				<a href="#"  class="alarmA">알람</a>
				<a href="#"  class="myPageA">마이페이지</a>
				<a href="#"  class="tradeA">거래톡</a>
				<button class="writeA">글쓰기</button>
				</div>
			</div>
		</header>
		<nav class="header_nav">
			<div id="navWrap">
				<ul id="dropdown">
					<li><a href="#">판매</a>
						<ul id="sub">
							<li><a href="#">패션의류</a></li>
							<li><a href="#">뷰티잡화</a></li>
							<li><a href="#">유아용품</a></li>
							<li><a href="#">가구생활</a></li>
							<li><a href="#">취미/스타굿즈</a></li>
							<li><a href="#">전자기기</a></li>
							<li><a href="#">스포츠레져</a></li>
							<li><a href="#">자동차</a></li>
							<li><a href="#">생활가전</a></li>
							<li><a href="#">도서기타</a></li>
							<li><a href="#">기타</a></li>
						</ul></li>
	
					<li><a href="#">경매</a>
						<ul id="sub">
							<li><a href="#">패션의류</a></li>
							<li><a href="#">뷰티잡화</a></li>
							<li><a href="#">유아용품</a></li>
							<li><a href="#">가구생활</a></li>
							<li><a href="#">취미/스타굿즈</a></li>
							<li><a href="#">전자기기</a></li>
							<li><a href="#">스포츠레져</a></li>
							<li><a href="#">자동차</a></li>
							<li><a href="#">생활가전</a></li>
							<li><a href="#">도서기타</a></li>
							<li><a href="#">기타</a></li>
						</ul></li>
					<li><a href="commList">커뮤니티</a></li>
					<li><a href="#">공지사항</a></li>
				</ul>
			</div>
		</nav>
	</div>
	<div id="messageList">
		<h2>쪽지</h2>
	</div>
	<div id="alarmList">
		<h2>알람</h2>
	</div>
</body>
</html>