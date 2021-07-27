<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
</head>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="http://code.jquery.com/jquery-1.8.1.min.js"></script>
<script src="script/jquery-1.12.3.js"></script>
<script>
	$(document).ready(function() {
		$("#dropdown li").mouseover(function() {
			$(this).children("#sub").stop().slideDown();
		});
		
		$("#dropdown li").mouseleave(function() {
			$(this).children("#sub").stop().slideUp();
		});
	});
	
</script>
<style>
body {
	line-height: 1.5em;
	font-size: 1em;
	font-weight: normal;
	color: #333;
}

#wrap {
	width: 1200px;
	margin: 0 auto;
	text-align: left;
}

header {
	width: 1200px;
	height: 60px;
	position: fixed;
	padding-top: 10px;
	margin: 0px auto;
	top: 0;
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
	padding: 7px;
	text-decoration: none;
	background-color: #D8D8D8;
	color:#424242;
	border: 3px #D8D8D8;
	border-radius: 5px;
}

#menu1 button:hover{
	background-color: gray;
}

#menu1 button a:hover{
	color: white;
}

/*메인메뉴*/
nav {
	width: 1200px;
	position: fixed;
	height: 40px; /* 메뉴 높이 지정 */
	border-bottom: 1px solid #ccc;
	border-top: 1px solid #ccc;
	margin: 90px 0px 10px 0px;
	padding-top: 15px;
	background-color: #fff;
}

nav ul#dropdown {
	box-sizing: border-box;
	margin: 0px auto;
	width: 1000px;
	background-color: #fff;
}

nav ul#dropdown li {
	float: left;
	list-style: none;
	margin: 0px auto;
	background-color: #fff;
}

nav ul#dropdown li a {
	color: #000;
	padding: 0 82px;
	text-decoration: none;
	display: block;
}

nav ul#dropdown li a:hover {
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

nav ul#dropdown li ul li {
	float: none;
	display: inline;
}

nav ul#dropdown li ul li a {
	width: 120px;
	height: 30px;
	padding: 10px 20px 0px 10px;
	background-color: #F2F2F2;
	font-size: 0.9em;
	text-transform: capitalize;
	text-align: center;
}

nav ul#dropdown li ul li a:hover {
	background-color: #ffffff;
	background-color: rgba(255, 255, 255, 0.9);
}

nav ul#dropdown:after {
	content: "";
	display: block;
	clear: both;
}

</style>
<body>
	<div id="wrap">
		<header>
			<div id="headerWrap">
				<div id="logo"><a href="index.jsp"><img src="img/logo2.png" width="85"></a></div>
				<div id="search">
					<input type="text" name="search" placeholder="찾고 싶은 상품을 검색해보세요!">
					<img src="img/search-icon.png" alt="search-icon">
				</div>
				<div id="menu1">
				<a href="joinForm.jsp">회원가입</a>
				<a href="#">로그인</a>
				<a href="#">쪽지</a>
				<a href="#">알람</a>
				<a href="myPage.jsp">마이페이지</a>
				<a href="#">거래톡</a>
				<button><a href="writeForm.jsp" >글쓰기</a></button>
				</div>
			</div>
		</header>
		<nav>
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
					<li><a href="#">커뮤니티</a></li>
					<li><a href="#">공지사항</a></li>
				</ul>
			</div>
		</nav>
	</div>
</body>
</html>