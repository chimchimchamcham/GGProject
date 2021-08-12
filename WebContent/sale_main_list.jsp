<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!-- <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>Document</title>
   <style>
#mainHeader {
	z-index: 1000;
}

#main {
	/* background-color: gray; */
	width: 1200px;
	height: auto;
	position: absolute;
	top: 150px;
	z-index: -1;
	margin: 0px auto;
	/* padding: 30px; */
}

h2.bbb {
	text-align: center;
	padding-top: 30px;
}

.categor {
	margin: 50px 30px 0 0;
	padding-left: 20px;
	white-space: nowrap;
	float: left;
	/* border: 1px solid black; */
	width: 180px;
	height: 700px;
	background-color: #F2F2F2;
}

.categor td a:hover {
	text-decoration: underline black;
	cursor: pointer;
	/*  background-color: gray; */
}
.categor td a{
	text-decoration: none;
	color: black;
}
.main_sold {
	margin-top: 50px;
	width: 990px;
	height: auto;
	float: left;
}

.itembox {
	/*  justify-self: center;
            display: flex;
            justify-content: center;
            flex-direction: column; */
	
}

.alinebutton {
	margin-bottom: 30px;
}

.alinebutton button {
	border-color: gray;
	background-color: transparent;
	border-top: 1px solid gray;
	border-bottom: 1px solid gray;
	border-left: 0px;
	border-right:  0px;
	cursor: pointer;
	padding:5px 10px;
}

.alinebutton button:hover {
	/*   border-color: gray;
            background-color: gray;
            color: white;
            cursor: pointer; */
	
}

.alinebutton button.checked {
	border-color: gray;
	background-color: #E6E6E6;
	border:0px;
	padding:5px 10px;
}

.items {
	/* display: flex;
            flex-wrap: wrap;
            flex-direction: row;
            margin-top: 20%; */
	margin: 0px auto;
}

.item-one {
	width: 325px;
	height: 400px;
	border: 1px solid #F2F2F2;
	/* display: flex; */
	/* flex-direction: column;
            justify-content: space-between; */
	cursor: pointer;
	margin:;
	float: left;
}

.item-one:hover {
	background-color: #F2F2F2;
}


.item-one table{
	width: 280px;
	margin: 0px auto;
	padding-top:30px;
}

.item-one table td a{
	/* border: 1px solid black;  */
	color:#555;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	width:260px;

}

.img-zoon {
	width: 280px;
	height: 200px;
	overflow: hidden;
	margin: 0px auto;
	padding-top: 20px;
	/*  text-align: center; */
/* 	border:1px solid red; */
}

.index {
	
}

.img-zoon img {
	width: 100%;
}

.index, .bestcost, .nowbuycost, .endtime, .count {
	margin-left: 5%;
}

.endtime-count {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
}

</style>
</head>
<body>
    <div id="mainHeader"><jsp:include page="header.jsp" /></div>
<div id="main">
<div class="sold-con">
<h2 class="bbb">판매</h2>
<table class="categor">
    <!-- <tr><th>카테고리</th></tr> -->
    <tr><td><a href="#">패션의류</a></td></tr>
    <tr><td><a href="#">뷰티잡화</a></td></tr>
    <tr><td><a href="#">유아용품</a></td></tr>
    <tr><td><a href="#">가구생활</a></td></tr>
    <tr><td><a href="#">취미/스타굿즈</a></td></tr>
    <tr><td><a href="#">전자기기</a></td></tr>
    <tr><td><a href="#">스포트레저</a></td></tr>
    <tr><td><a href="#">자동차</a></td></tr>
    <tr><td><a href="#">생활가전</a></td></tr>
    <tr><td><a href="#">도서기타</a></td></tr>
    <tr><td><a href="#">기타</a></td></tr>
</table>
    <div class="main_sold">
        <div class="itembox">
            <div class="items">

            </div>
        </div>
    </div>
</div>

</div>
</body>
<script>
$(document).ready(function() {
	function getParameterByName(name) { name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex.exec(location.search); return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " ")); }
	
	var cate = getParameterByName('cate');
	console.log("cate",cate);

	
	$.ajax({
		type:'post',
		url:'./soldmainlist',
		data:{  index_button_sold : cate},
		dataType:'JSON',
		success:function(data){
			console.log("data",data);
			if(data != null){
				sold_list(data.soldmainlist);
			}
		},
		error:function(e){
			console.log(e);
		}
	});
	
})

$(".categor tr td").click(function(){//카테고리
	    $button1 = $(".categor tr td");
	    $index1 = $button1.index(this);
	    
	    $index_button_sold = $(".categor tr td a:eq(" + $index1 + ")").text();

	
		console.log("$index_button_sold:"+$index_button_sold);
		
		sold_listCall($index_button_sold);
		//alert('hellow');
		
    })
    
    
    function sold_listCall($index_button_sold){
		
		
		$.ajax({
			type:'post',
			url:'./soldmainlist',
			data:{	index_button_sold : $index_button_sold},
			dataType:'JSON',
			success:function(data){
				console.log("data:"+data);
				if(data != null){
					sold_list(data.soldmainlist);
				}
			},
			error:function(e){
				console.log(e);
			}
		});	
		
		}
	
	
		
		//데이터 가져와서 뿌려주는 경매 리스트
		function sold_list(soldmainlist){	
			console.log("sold=="+soldmainlist)
			var content="";
			
			soldmainlist.forEach(function(item,idx){
				console.log("idx:",idx,item);
				content+= "<div class='item-one' onclick="+"window.location.href='salesDetail?p_no=" + item.p_no  +"\'" +">"
				content+= 	"<div class='wrapBox' >";
				content+= 	"<div class='img-zoon'>"
				content+=		"<img src=/photo/"+item.i_newName+">";	
				content+=		"</div>";
				content +="<table class='content-box'>";
				content +="<tr>";
				content +=	"<td style='padding-bottom:10px; font-size:18px; color:black; '><b>"+item.p_title+"</b></td>";
				content +="</tr>";
				content +="<tr>";
				content +=	"<td> <b>가격   "+item.ns_pr+" P</b></td>";
				content +="</tr>";
				content +="<tr>";
				content +=	"<td>♥ "+item.p_likeCount+"</td>";
				content +="</tr>";
				content +="<tr>";
				content +=	"<td><small>작성일   "+item.p_tm+" </small></td>";
				content +="</tr>";
				content +="</table>";
				content+= "</div>";
				content+= "</div>";
			    });
			
			$('.main_sold div.items').empty();
			$('.main_sold div.items').append(content);
		}// 경매 리스트 end

		/* var test = $(".categor tr td a").text(cate);
		console.log("test",test); */
		
</script>
</html>