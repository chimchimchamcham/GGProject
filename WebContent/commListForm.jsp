<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
#mainHeader {
	z-index: 1000;
}

#main {
	width: 1200px;
	height: auto;
	position: absolute;
	top: 150px;
	z-index: -1;
	magin: 0 auto;
	text-align: center;
}

#tableHeader {
	width: 90%;
	margin: auto;
	height: 470px;
	overflow-y: scroll;
}

#tableHeader table {
	width: 100%;
	margin: auto;
}

.category {
	display: none;
	margin: auto;
}

.category+label{
	color: black;
	background-color: white;
	cursor: pointer;
	border: 3px solid white;
}
.category:checked+label{
	color:white;
	background-color:black;
	border:3px solid black;
	cursor: pointer;
}
.currRadio{
	
}
.currRadio:checked+label{
	color:blue;
}
.currLabel{
	cursor: pointer;
}
</style>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
		<h3>커뮤니티</h3>
		<input type="checkbox" id="C001" class="category" name="C001"
			value="C001" checked /><label class="commLabel" for="C001"># 구매대행</label> 
		<input type="checkbox" id="C002" class="category" name="C002"
			value="C002" checked /><label class="commLabel" for="C002"># 동네이야기</label>
		<input type="checkbox" id="C003" class="category" name="C003"
			value="C003" checked /><label class="commLabel" for="C003"># 같이해요</label> 
		<input type="checkbox" id="C004" class="category" name="C004"
			value="C004" checked /><label class="commLabel" for="C004"># 자랑해요</label> 
		<input type="checkbox" id="C005" class="category" name="C005"
			value="C005" checked /><label class="commLabel" for="C005"># 공유해요</label> 
		<input type="checkbox" id="C006" class="category" name="C006"
			value="C006" checked /><label class="commLabel" for="C006"># 잡담해요</label> 
		<input type="checkbox" id="C007" class="category" name="C007"
			value="C007" checked /><label class="commLabel" for="C007"># 홍보해요</label>
		<div id="tableHeader">
			<table>
				<thead>
					<tr>
						<th>카테고리</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
						<th>조회수</th>
						<th>좋아요</th>
					</tr>
					<tr>
						<hr></hr>
					</tr>
				</thead>
				<tbody id="listBody"></tbody>
			</table>
			<div id="pageNum">
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	var lists = [];
	var currPageNum = 1;
	$("input.category:checked").each(function(idx, value) { //jQuery로 for문 돌면서 check 된값 배열에 담는다
		lists.push($(this).val());
	});
	$.ajax({
		type : "POST",
		data : {
			'categorys' : lists,
			"currPage" : 1,
			'currPageNum':currPageNum
		},
		url : "commList",
		dataType : 'JSON',
		success : function(data) {
			drawList(data.list);
			lists = [];
			console.log("처음 접속시 작동하는 ajax");
		},
		error : function(e) {
			console.log(e);
		}
	});

	$(document).on("change","input.category",function(){changeList();});
	/*가끔씩 .change가 안먹을 때가 있어서 아래와 같은 방식으로 처리하면 적용됨.*/
	$(document).on("change","input.currRadio",function(){changeList();});

	function changeList() {
		$("input.category:checked").each(function(idx, value) { //jQuery로 for문 돌면서 check 된값 배열에 담는다
			lists.push($(this).val());
		});

		$.ajax({
			type : "POST",
			data : {
				'categorys' : lists,
				'currPage' : $("input:radio[name=currPage]:checked").val(),
				'currPageNum':currPageNum
			},
			url : "commList",
			dataType : 'JSON',
			success : function(data) {
				drawList(data.list);
				lists = [];
				console.log("change시 작동하는 ajax");
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
	
	function drawList(list) {
		console.log("드로우 리스트");
		console.log(list);
		var content = "";

		console.log("forEach문");
		//자바스크립트 foreach문
		list.forEach(function(item, idx) {
			console.log(idx, item);
			content += "<tr><td>" + item.c_name + "</td>";
			content += "<td><a href='commDetail?p_no=" + item.p_no + "'>"
					+ item.p_title + "</td>";
			content += "<td><a href='myPage?id=" + item.u_id + "'>"
					+ item.u_nname + "</td>";
			content += "<td>" + item.p_tm + "</td>";
			content += "<td>" + item.p_view + "</td>";
			content += "<td>" + item.p_likecount + "</td></tr>";
		});
		// tbody에 아이디를 안하면 태그 두게에 달리는듯 그래서 아이디를 주고하자.
		$("tbody#listBody").empty();
		$("tbody#listBody").append(content);
		// 페이지 번호 뽑아주기.
		content = "";
		for (let i = list[0].currPageStart; i <= list[0].currPageEnd; i++) {
			if(list[0].currPage == i){
				content +="<input type='radio' name='currPage' class='currRadio' id='currPage"+i+"' value="+i+" checked/>";
				content +="<label class='currLabel' for='currPage"+i+"'>"+i+"</label>&nbsp;";
			}else{
				content +="<input type='radio' name='currPage' class='currRadio' id='currPage"+i+"' value="+i+" />";
				content +="<label class='currLabel' for='currPage"+i+"'>"+i+"</label>&nbsp;";
			}
		}
		$("div#pageNum").empty();
		$("div#pageNum").append(content);
	}
</script>
</html>