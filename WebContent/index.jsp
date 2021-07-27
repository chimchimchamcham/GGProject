<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
</head>
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
	padding-top : 10px;
	margin : 0px auto;
	top:0;
}

#logo{
	float: left;
}

/*검색창*/

#search{
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

#search input{
	display: block;
	width: 568px;
	height: 35px;
	outline: none;
	padding-left: 10px;
	border: 1px solid #D8D8D8;
	border-radius: 3px;
}

#menu1{
	float:right;
	padding: 10px;
}

#menu1 a{
	padding : 5px;
	text-decoration: none;
	color:black;
}

#menu1 a:hover{
	color: gray;
}

/*메인메뉴*/
nav {
width:1200px;
	position:fixed;
	height:40px; /* 메뉴 높이 지정 */
    border-bottom: 1px solid #ccc;
    border-top: 1px solid #ccc;
    margin: 90px 0px 10px 0px;
    padding-top: 15px;
    background-color: #fff;
    
}

nav ul#dropdown {
     box-sizing: border-box;
     margin:0px auto;
     width:1000px;
}

nav ul#dropdown li {
	float:left;
    list-style: none;
     margin:0px auto;
}

nav ul#dropdown li a {
	color:#000;
	padding:0 82px;
	text-decoration: none; 
	display: block;
}

nav ul#dropdown li a:hover{
	color: gray;
}

nav ul#dropdown li ul	{	
	margin:16px 0 0 41px;
	list-style:none;
	position: absolute; 
	visibility:hidden; 
	z-index:100; 
    
}
		
nav ul#dropdown li ul li {	
	float: none;
	display:inline;		
}

		
nav ul#dropdown li ul li a {
	width:120px;
    height:30px;
	padding:10px 20px 0px 10px;
	  background-color: #ffffff;
	font-size:0.9em;
	text-transform: capitalize;
    text-align:center;
}

nav ul#dropdown li ul li a.r_corner {
	border-bottom-left-radius:10px;
	border-bottom-right-radius:10px;
}

		
nav ul#dropdown li ul li a:hover {	
	 background-color: #ffffff;
      background-color: rgba( 255, 255, 255, 0.9  );
}
nav ul#dropdown:after {content: ""; display: block; clear: both;}

</style>
<script>
$(document).ready(function(){    
    $('#slide').bjqs({        
    	'width' : 1300,        
    	'height' : 700,        
    	 'showMarkers' : true,        
    	 'showControls' : false,        
    	 'centerMarkers' : false   
    	 });
    });
    
  /* Dropdown script */
  	var timeout    = 500;
  	var closetimer = 0;
  	var ddmenuitem = 0;
  	
  	function dropdown_open()
  	{  dropdown_canceltimer();
  	   dropdown_close();
  	   ddmenuitem = $(this).find('ul').css('visibility', 'visible');}
  	
  	function dropdown_close()
  	{  if(ddmenuitem) ddmenuitem.css('visibility', 'hidden');}
  	
  	function dropdown_timer()
  	{  closetimer = window.setTimeout(dropdown_close, timeout);}
  	
  	function dropdown_canceltimer()
  	{  if(closetimer)
  	   {  window.clearTimeout(closetimer);
  		  closetimer = null;}}
  	
  	$(document).ready(function()
  	{  $('#dropdown > li').bind('mouseover', dropdown_open)
  	   $('#dropdown > li').bind('mouseout',  dropdown_timer)});
  	
  	document.onclick = dropdown_close;
</script>
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