<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
<style type="text/css">
#wrap {
	background-color: gray;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp" />
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
					<a href="login.jsp">로그인</a>
					<a href="#">쪽지</a>
					<a href="#">알람</a>
					<a href="myPage.jsp">마이페이지</a>
					<a href="#">거래톡</a>
					<a href="writeForm.jsp">글쓰기</a>
				</div>
			</div>
		</header>
		<nav>
			<div id="navWrap">
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
			</div>
		</nav>
	</div>
</body>
</html>