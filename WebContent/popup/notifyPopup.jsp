<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
header {
  width: 100%;
  height: 50px;
  background-color: skyblue;
}

.container {
  width: 1200px;
  height: 50px;
  margin: 0 auto;
  position: relative;
}

.nav {
  float: left;
  width: 100%;
  overflow: hidden;
}

.nav>li {
  float: left;
  width: 25%;
  box-sizing: border-box;
}

.nav>li>a {
  display: block;
  width: 100%;
  text-align: center;
  line-height: 3.4;
  color: #fcfcfc;
  font-size: 15px;
}

.nav>li>a:hover{
  background-color: #3DB7CC;
}

.sub {
  width: 300px;
  margin: 0 auto;
  position: absolute;
  top: 50px;
  left: 0;
  z-index: 1;
  display: none;
}

.sub2 {
  left: 300px;
}

.sub3 {
  left: 600px;
}

.sub4 {
  left: 900px;
}

.sub>li {
  width: 300px;
  height: 50px;
  border-bottom: 1px solid #000;
  color: #fff;
  background-color: #FFD8D8;
  box-sizing: border-box;
}

.sub>li:last-child {
  border: 0;
}

.sub>li>a:hover {
  background-color: #FFA7A7;
  color: #fff;
}

.sub>li>a {
  display: block;
  width: 100%;
  text-align: center;
  line-height: 3.4;
  font-size: 15px;
  font-weight: 500;
}
</style>
</head>
<body>
	<div id="mainheader">신고하기</div>
	<ul class="nav">
		<li><a href="">메뉴1</a>
			<ul class="sub sub1">
				<li><a href="#">메뉴1-1</a></li>
				<li><a href="#">메뉴1-2</a></li>
				<li><a href="#">메뉴1-3</a></li>
			</ul>
		</li>
	</ul>
</body>
</html>