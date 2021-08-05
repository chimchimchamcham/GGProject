<%@ page import="com.gg.dto.GGDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
    
	#mainHeader{
	z-index: 1000;
	}
	#main {
	/* background-color: gray; */
	width:1200px;
	height:auto;
	position: absolute;
	top:150px;
	z-index: -1;
	margin:0px auto;
	padding:30px;
	}
	#cate{
	margin:50px;
	}
	#commTitle{
	margin:50px;
	}
	#commDetailtable{
	margin:0px auto;
	border:1px solid black;
	text-align:center;
	width:80%;
	padding:20px;
	}
	.box {
    width: 30px;
    height: 30px; 
    border-radius: 50%;
    overflow: hidden;
    margin:0px auto;
	}
	.profile {
    width: 100%;
    height: 100%;
    object-fit: cover;
	}
	#commTextarea{
	width:95%;
	height:300px;
	margin-top:20px;
	resize:none;
	padding:10px;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

</script>
</head>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
    <div id="wrap">
    	<table id = "commDetailtable">
    		<tr>
    			<th colspan ="6"><h1>커뮤니티</h1></th>
    		</tr>
    		<tr>
    			<td colspan ="6" id = "p_title"><h2>${dto.p_title }</h2></td>
    		</tr>
    		<tr>
    			<td colspan ="5" id = "c_name" style="text-align:left"><h5>#  ${dto.c_name }</h5></td>
    			<td id="updatebutton" style="text-align:left">
    				<input type = button value="삭제" onclick="location.href='./postDel?p_no=${dto.p_no}'">
    				<input type = button value="수정" onclick="location.href='./commUpdateForm?p_no=${dto.p_no}'">
    			</td>
    		</tr>
    		<tr>
    			<td>
    				<c:if test="${dto.u_newName  ne ''}">
						<div class="box" ><a href="myPage?id=${dto.u_id}">
	    				<img class="profile" src="./img/default-profile.png">
						</a></div>
					</c:if>
				</td>
    			<td>글 번호 : ${dto.p_no }</td>
				<td>작성자 : ${dto.u_nname }</td>
    			<td>작성 일시 : ${dto.p_tm }</td>
    			<td>조회 수 : ${dto.p_view }</td>
    			<td></td>
			</tr>
	    	<tr>
	    		<td colspan = "6"><hr></hr></td>
	    	</tr>
    		<c:if test = "${dto.i_newName ne null}">
    			<tr>
    				<td colspan ="6" id = "i_newName" style="text-align:left"><img src = "/photo/${dto.i_newName }" width=300px/></td>
    			</tr>
    		</c:if>
    		<tr>
    			<td colspan ="6" id = "p_content"><textarea id="commTextarea" readonly>${dto.p_content }</textarea></td>
    		</tr>
    	</table>
    </div>
    </div>
</body>
<script>
	console.log("${loginId}");
	console.log("${dto.u_id}");
	console.log("${dto.i_newName }");
	if("${loginId}"!=="${dto.u_id}"){
		$("#updatebutton").css("visibility","hidden");
	}

</script>
</html>