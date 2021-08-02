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
    			<td colspan ="6" id = "p_code" style="text-aling:left"><h5> ${dto.p_code }</h5></td>
    		</tr>
    		<tr>
    			<td colspan = "6"><hr></hr></td>
    		</tr>
    		<tr>
    			<td></td>
    			<td></td>
    			<td></td>
    			<td></td>
    			<td></td>
    			<td></td>
    		</tr>
    		<tr>
    			<td colspan ="6" id = "p_content">${dto.p_content }</td>
    		</tr>
    		<tr>
    			<td colspan="6"><textarea></textarea></td>
    		</tr>
    	</table>
    	<h3 ></h3>
	    <input type = text value = ${dto.u_newName }>유저 사진 이름
	    <input type = text value = ${dto.p_no }>글 번호
	    <input type = text value = >글 제목${dto.u_nname }
	   
	    <input type = text value = ${dto.p_content }>글 내용
	    <input type = text value = ${dto.p_tm }>작성 시간
	    <input type = text value = ${dto.p_view }>조회수
	    <input type = text value = ${dto.i_newName }>글 사진 이름
    </div>
    </div>
</body>
<script>

</script>
</html>