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
	<c:forEach items="${list }" val="item">
	<div>
	<span>${item.c_name}</span>
	<span>${item.p_title}</span>
	<span>${item.U_id}</span>
	<span>${item.U_nname}</span>
	<span>${item.p_tm}</span>
	<span>${item.p_view}</span>
	</div>
	</c:forEach>
</body>
</html>