<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>

</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<c:forEach items="${list}" var="i">
			<div 
				<c:if test="${sessionScope.loginId eq i.tc_id }">class="commentBox floatRight"</c:if>
				<c:if test="${sessionScope.loginId ne i.tc_id }">class="commentBox floatLeft"</c:if>	
			>
				<p  class="tradeUser" >
					<span>${i.tc_nname }</span>
					<span>
						<c:choose>
							<c:when test="${sessionScope.loginId eq i.tc_id}">(나)</c:when>
							<c:when test="${(sessionScope.loginId ne i.tc_id) and (i.tc_id eq i.t_saler)}">(판매자)</c:when>
							<c:when test="${(sessionScope.loginId ne i.tc_id) and (i.tc_id eq i.t_buyer)}">(구매자)</c:when>
						</c:choose>
					</span>
				</p>
				<p>${i.tc_content }</p>
				<p id="date">${i.tc_tm }</p>
			</div>
		</c:forEach>			
	</div>
</body>
<script></script>
</html>