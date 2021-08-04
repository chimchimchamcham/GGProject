<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<style>
#mainHeader{
	z-index: 1000;
}
#main {
	width:1200px;
	height:auto;
	position: absolute;
	top:150px;
	z-index: -1;
	magin:0 auto;
	text-align:center;
}
</style>
<body>
<div id="mainHeader"><jsp:include page="header.jsp" /></div>
<div id="main">
<h3>커뮤니티</h3>
	<input type = "checkbox" class = "category" name = "C001" value="'C001'," checked/>구매대행
	<input type = "checkbox" class = "category" name = "C002" value="'C002'," checked/>동네이야기
	<input type = "checkbox" class = "category" name = "C003" value="'C003'," checked/>같이해요
	<input type = "checkbox" class = "category" name = "C004" value="'C004'," checked/>자랑해요
	<input type = "checkbox" class = "category" name = "C005" value="'C005'," checked/>공유해요
	<input type = "checkbox" class = "category" name = "C006" value="'C006'," checked/>잡담해요
	<input type = "checkbox" class = "category" name = "C007" value="'C007'," checked/>홍보해요
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
		</thead>
		<tbody></tbody>
	</table>
</div>
</body>
<script type="text/javascript">
var lists = [];
$("input.category:checked").each(function(idx,value){   //jQuery로 for문 돌면서 check 된값 배열에 담는다
 	lists.push($(this).val());
});
$.ajax({
	type:"POST",
	data:{
		'categorys':lists
		},
	url:"commList",
	dataType:'JSON',
	success:function(data) {
		drawList(data.list);
	},
	error:function(e){
		console.log(e);
	}
});

 $("input.category").change(function(){ 
 	$("input.category:checked").each(function(idx,value){   //jQuery로 for문 돌면서 check 된값 배열에 담는다
	 	lists.push($(this).val());
 	});

 
	$.ajax({type:"POST",
			data:{
				'categorys':lists
				},
			url:"commList",
			dataType:'JSON',
			success:function(data) {
				drawList(data.list);
    		},
    		error:function(e){
    			console.log(e);
    		}
 		});
});
 
 var isFollow = false;
 $("#total").click(function(){
    if(!isFollow){
       $("#follow").css({"color":"white","background-color":"gray"});
       isFollow = true;
    }else{
       $("#follow").css({"color":"black","background-color":"#E6E6E6"});
       isFollow = false;
    }

 });
 		
 function drawList(list){
		console.log("드로우 리스트");
		console.log(list);
		var content= "";
		
		console.log("forEach문");
		//자바스크립트 foreach문
		list.forEach(function(item,idx){
			console.log(idx,item);
			content += "<tr><td>"+item.c_name+"</td>";
			content += "<td>"+item.p_title+"</td>";
			content += "<td>"+item.u_nname+"</td>";
			content += "<td>"+item.p_tm+"</td>";
			content += "<td>"+item.p_view+"</td>";
			content += "<td>"+item.p_likecount+"</td></tr>";
		});
		$("tbody").empty();
		$("tbody").append(content);
	}
</script>
</html>