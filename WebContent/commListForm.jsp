<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src = "https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<c:forEach items="${list }" var="item">
	<div>
	<span>${item.c_name}</span>&nbsp;&nbsp;&nbsp;&nbsp;
	<span>${item.u_id}</span>&nbsp;&nbsp;&nbsp;&nbsp;
	<span>${item.u_nname}</span>&nbsp;&nbsp;&nbsp;&nbsp;
	<span>${item.p_title}</span>&nbsp;&nbsp;&nbsp;&nbsp;
	<span>${item.p_tm}</span>&nbsp;&nbsp;&nbsp;&nbsp;
	<span>${item.p_view}</span>&nbsp;&nbsp;&nbsp;&nbsp;
	</div>
	</c:forEach>
</body>
</html>