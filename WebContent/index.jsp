<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
</head>
<style>
@charset "utf-8";
/* header */
	header{width:100%;height:60px;background-color:white;position:fixed;left:0;top:0;z-index:100; background-color: gray;}
	#headerWrap{width:1000px;height:60px;margin:0 auto;position:relative;}
	#headerWrap>img{transition:0.5s}
	#headerWrap>img:hover{opacity:0.7;transition:0.5s}
	#headerWrap>div:nth-of-type(1){position:absolute;left:220px;top:10px;}
	#headerWrap>div:nth-of-type(1)>img{width:20px;height:20px;position:absolute;right:10px;top:10px;
		cursor:pointer;transition:0.5s;}
	#headerWrap>div:nth-of-type(1)>img:hover{opacity:0.8;transition:0.5s;}
	#headerWrap>button:nth-of-type(1){position:absolute;right:100px;top:14px;background-color:#DF0101;
		color:white;}
	#headerWrap>button:nth-of-type(2){position:absolute;right:5px;top:14px;background-color:white;
		color:#DF0101;border:1px solid #DF0101;transition:0.5s;}
	#headerWrap>button:nth-of-type(2):hover{background-color:#DF0101;color:white;transition:0.5s;}
	.roundBox{border-radius:3px;text-align:center;}
	.inputBox{display:block;width:568px;height:40px;outline:none;
		padding-left:10px;border:1px solid #D8D8D8;border-radius:3px;}
	.inputBox:focus{border:1px solid #01A9DB;}
	.boxBtn{display:block;width:80px;height:34px;line-height:30px;cursor:pointer;}
	/* aside */
	aside{width:100%;height:300px;}
	#asideWrap{width:1000px;height:300px;margin:0 auto;overflow:hidden;position:relative;}
	#asideWrap>ul#mailAd{width:5000px;height:300px;}
	#asideWrap>ul#mailAd>li{float:left;}
	#asideWrap>ul#thumbnail{width:90px;height:150px;opacity:0.3;position:absolute;top:75px;right:20px;}
	/* #asideWrap>ul#thumbnail>li{float:left;} */
	#asideWrap>ul#thumbnail>li>a>img{width:90px;height:30px;}
	
	/* nav1 */
	#nav1{width:100%;background-color:white;z-index:100; position:fixed;left:0;top:60px;background-color:red;}
	#navWrap1{width:1000px;height:60px;margin:0 auto;}
	#navWrap1>span:nth-of-type(1){float:left;}
	#navWrap1>span:nth-of-type(1)>a{font-size:1.1rem;font-weight:500;
		text-decoration:none;color:#2E2E2E;}
	#navWrap1>span:nth-of-type(1)>a>img{width:35px;height:22px;margin:19px 10px 0px 10px;}
	#navWrap1>span:nth-of-type(2){float:right;color:#2E2E2E;margin-right:10px;}
	#navWrap1>span:nth-of-type(2)>a{font-size:0.9rem;text-decoration:none;color:#2E2E2E;}
	#navWrap1>span:nth-of-type(2)>a>img{width:27px;height:23px;margin:18px 5px 0px 25px;}
	#navWrap1>span:nth-of-type(3){float:right;color:#2E2E2E;}
	#navWrap1>span:nth-of-type(3)>a{font-size:0.9rem;text-decoration:none;color:#2E2E2E;}
	#navWrap1>span:nth-of-type(3)>a>img{width:23px;height:23px;margin:18px 5px 0px 25px;}
	#navWrap1>span:nth-of-type(4){float:right;color:#2E2E2E;}
	#navWrap1>span:nth-of-type(4)>a{font-size:0.9rem;text-decoration:none;color:#2E2E2E;}
	#navWrap1>span:nth-of-type(4)>a>img{width:23px;height:23px;margin:18px 5px 0px 25px;}

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
} */


/*메인메뉴*/
#nav2 {
	height: 40px; /* 메뉴 높이 지정 */
	background-color: #fff;
	border-bottom: 1px solid #ccc;
	border-top: 1px solid #ccc;
	margin: 30px 0px 0px 0px;
	padding-top: 15px;
}

#dropdown {
	box-sizing: border-box;
}

#dropdown li {
	float: left;
}

#dropdown li a {
	color: #000; /* 색상 지정 */
	padding: 0 82px; /* 패딩으로 각 메뉴 사이 간격 조정 */
	text-transform: uppercase; /* 메뉴 글자 대문자 */
	text-decoration: none; /* 링크의 밑줄 없앰 */
	display: block;
}

#dropdown li a:hover {
	opacity: 0.5;
	transform: scale(1.03);
}

#dropdown li ul {
	margin: 16px 0 0 41px;
	list-style: none;
	position: absolute;
	visibility: hidden;
	z-index: 100;
}

#dropdown li ul li {
	float: none;
	display: inline;
}

#dropdown li ul li a {
	width: 120px;
	height: 30px;
	padding: 10px 20px 0px 10px;
	background-color: #ffffff;
	background-color: rgba(255, 255, 255, 0.7);
	font-size: 0.9em;
	text-transform: capitalize;
	text-align: center;
}

#dropdown li ul li a.r_corner {
	border-bottom-left-radius: 10px;
	border-bottom-right-radius: 10px;
}

#dropdown li ul li a:hover {
	background-color: #ffffff;
	background-color: rgba(255, 255, 255, 0.9);
}

#dropdown:after {
	content: "";
	display: block;
	clear: both;
}
</style>
<script>
	
</script>
<body>
<div id="wrap">
		<header>
			<div id="headerWrap">
				<img src="img/logo.png" width="100">
				<div>
					<input type="text" name="search" class="inputBox" placeholder="찾고 싶은 상품을 검색해보세요!">
					<img src="img/search-icon.png" alt="search-icon">
				</div>
				<button class="roundBox boxBtn">회원가입</button>
				<button class="roundBox boxBtn">로그인</button>
			</div>
		</header>
		<nav id="nav1">
			<div id="navWrap1">
				<span><a href="#">쪽지</a></span>
				<span><a href="#">알람</a></span>
				<span><a href="myPage.jsp">마이페이지</a></span>
				<span><a href="#">거래톡</a></span>
				<span><a href="writeForm.jsp">글쓰기</a></span>
			</div>
		</nav>
		<nav  id="nav2">
			<ul id="dropdown">
				<li><a href="#">판매</a></li>
				<li><a href="#">경매</a>
					<ul>
						<li><a href="#">프로그램 정보</a></li>
						<li><a href="#">스토리</a></li>
					</ul></li>
				<li><a href="#">커뮤니티</a>
					<ul>
						<li><a href="#">TV클립</a></li>
						<li><a href="#">포스터</a></li>
						<li><a href="#">현장포토</a></li>
					</ul></li>
				<li><a href="#">공지사항</a></li>
			</ul>
		</nav>
	</div>
</body>
</html>