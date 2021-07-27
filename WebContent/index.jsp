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
header {
	width: 100%;
	height: 60px;
	background-color: white;
	position: fixed;
	left: 0;
	top: 0;
	z-index: 100;
	background-color: gray;
}

#headerWrap {
	width: 1000px;
	height: 60px;
	margin: 0 auto;
	position: relative;
}

#headerWrap>img {
	transition: 0.5s
}

#headerWrap>img:hover {
	opacity: 0.7;
	transition: 0.5s
}

#search{
	position: absolute;
	left: 100px;
	top: 10px;
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

#headerWrap>button:nth-of-type(1) {
	position: absolute;
	right: 100px;
	top: 14px;
	background-color: #DF0101;
	color: white;
}

#headerWrap>button:nth-of-type(2) {
	position: absolute;
	right: 5px;
	top: 14px;
	background-color: white;
	color: #DF0101;
	border: 1px solid #DF0101;
	transition: 0.5s;
}


.searchBox{
	display: block;
	width: 568px;
	height: 40px;
	outline: none;
	padding-left: 10px;
	border: 1px solid #D8D8D8;
	border-radius: 3px;
}

#logo{
	
}

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

/* nav1 */
#nav1 {

}

/*메인메뉴*/
#nav2 {
	height:40px; /* 메뉴 높이 지정 */
	background-color:#fff;
    border-bottom: 1px solid #ccc;
    border-top: 1px solid #ccc;
    margin: 30px 0px 0px 0px;
    padding-top: 15px;
}

#nav2 ul{
	 box-sizing: border-box;
	}
	
	#nav2 ul li{
		float:left;
	}
	
	#nav2 ul li a{
		color:#000; /* 색상 지정 */
	padding:0 82px; /* 패딩으로 각 메뉴 사이 간격 조정 */
	text-transform: uppercase; /* 메뉴 글자 대문자 */
	text-decoration: none; /* 링크의 밑줄 없앰 */
	display: block;
	}
</style>
<script>
	
</script>
<body>
	<div id="wrap">
		<header>
			<div id="headerWrap">
				<img src="img/logo.png" width="80" id="logo">
				<div id="search">
					<input type="text" name="search" class="searchBox" placeholder="찾고 싶은 상품을 검색해보세요!">
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
		<nav>
			<ul id="dropdown">
				<li><a href="#">판매</a>
					<ul>
						<li><a href="#">의류</a></li>
						<li><a href="#">전자기기</a></li>
						<li><a href="#">패션잡화</a></li>
						<li><a href="#">기타</a></li>
					</ul></li>

				<li><a href="#">경매</a>
					<ul>
						<li><a href="#">의류</a></li>
						<li><a href="#">전자기기</a></li>
						<li><a href="#">패션잡화</a></li>
						<li><a href="#">기타</a></li>
					</ul></li>
				<li><a href="#">커뮤니티</a></li>
				<li><a href="#">공지사항</a></li>
			</ul>
		</nav>
	</div>
</body>
</html>