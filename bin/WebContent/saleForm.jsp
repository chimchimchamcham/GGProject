<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
	<form action="writeSale" method="POST" enctype="multipart/form-data">
		<div id="communityForm">
			<p>
				<input type="text" name="title" value="" placeholder="제목을 입력해주세요"
					style='width: "1000px"' />
			</p>
			<p class="imgFileUpload">
				<label for='test'><img src="img/plus.png" id="preview-image"
					width="100px" height="100px" style="border: solid 1px gray" /></label> <input
					type="file" name="imgFile" style="display: none" id="test" />
			</p>
			<p>
				<textarea name="content" rows="30" cols="100" placeholder="내용입력"
					style="overflow-y: scroll"></textarea>
			</p>
			<p id="commuCategory">
				카테고리 선택(필수선택) &nbsp;&nbsp;&nbsp; <select name="commuCat">
					<c:forEach items="${commuCat }" var="CommuCategory">
						<option value="${CommuCategory.p_cate}">${CommuCategory.p_cateName}</option>
					</c:forEach>
				</select>
			</p>
		</div>

		<div id="saleForm">
			<p id="salePr">
				<input type="text" name="price" value="" placeholder="가격 입력(숫자입력)" />&nbsp;Point
			</p>
			<p>
				거래방식(필수선택) &nbsp;&nbsp;&nbsp;<input type="radio" name="deliveryYN"
					value="Y">택배<input type="radio" name="deliveryYN" value="N">직거래
			</p>
			<p id="category">
				카테고리 선택(필수선택) &nbsp;&nbsp;&nbsp; <select name="saleCat">
					<c:forEach items="${saleCat }" var="SaleCategory">
						<option value="${SaleCategory.c_code}">${SaleCategory.c_name}</option>
					</c:forEach>
				</select>
			</p>
			<p>
				공개범위&nbsp;&nbsp;&nbsp; <input type="radio" name="disclosure"
					value="N">전체공개 <input type="radio" name="disclosure"
					value="Y">팔로우한정
			</p>
		</div>
		<div>
			<button>등록</button>
			<input type="button" onclick='location.href="index.jsp"' value='뒤로가기'/>
		</div>
	</form>
</body>
</html>