<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>Document</title>
    <style>
        *{
            margin: 0;
            padding: 0;
        }
        .sold-con{
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top:15%;
        }
        table{
            border: 1px solid black;
        }
        h2.bbb{
        margin-right:25vh;
        }
		.categor{
		margin-top:10vh;
		white-space: nowrap;
			
		}
        .categor th,td{
            padding: 15px;
            padding-right: 200px;
        }
        .categor td:hover{
            text-decoration:underline black;
            cursor: pointer;
        }
        .main_sold{
            width: 900px;
            height: 700px;
            margin-left:100px ;
            display: flex;
            align-items: center;
            /*justify-content: center;*/
            flex-direction: column;
        }
        .itembox{
            justify-self: center;
            display: flex;
            justify-content: center;
            flex-direction: column;
        }
        .alinebutton{
            align-self: flex-start;
        }
        .alinebutton button{
            border-color: gray;
            background-color: transparent;
        }
        .alinebutton button:hover{
            border-color: gray;
            background-color: gray;
            color: white;
            cursor: pointer;
        }
        .alinebutton button.checked{
            border-color: gray;
            background-color: gray;
            color: white;
            cursor: pointer;
        }

        .items{
            display: flex;
            flex-wrap: wrap;
            flex-direction: row;
            margin-top: 20%;
        }
        .item-one{
            width: 300px;
            height: 400px;
            border: 1px solid black;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            cursor: pointer;
            margin:5px;
        }
        .img-zoon,.index{
            margin: 5%;
        }
        .index,.bestcost,.nowbuycost,.endtime,.count{
            margin-left: 5%;
        }
        .endtime-count{
                    display: flex;
                    flex-direction: row;
                    justify-content: space-between;
                }
    </style>
</head>
<body>
    
<div class="sold-con">
<table class="categor">
    <tr><th>카테고리</th></tr>
    <tr><td>뷰티잡화</td></tr>
    <tr><td>유아용품</td></tr>
    <tr><td>가구생활</td></tr>
    <tr><td>취미컬랙션</td></tr>
    <tr><td>컴퓨터</td></tr>
    <tr><td>스포트레져</td></tr>
    <tr><td>자동차공구</td></tr>
    <tr><td>생활가전</td></tr>
    <tr><td>도서기타</td></tr>
</table>
    <div class="main_sold">
        <h2 class= "bbb">판매</h2>
        <div class="itembox">
            <div class="items">

            </div>
        </div>
    </div>
</div>


</body>
<script>

$(document).ready(function() {
	
	$.ajax({
		type:'post',
		url:'./soldmainlist',
		data:{  index_button_sold : '뷰티잡화'},
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
	    
	    $index_button_sold = $(".categor tr td:eq(" + $index1 + ")").text();
	    
	
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
				content+= 	"<div class='img-zoon'>";
				content+=		"<img src="+item.i_newName+">";	
				content+=	"</div>";
				content+=	"<div class='index'>"+item.p_title+"</div>";
				content+=	"<div class='bestcost'>가격:"+item.ns_pr+"p</div>";
				content+=	"<div class='nowbuycost'>좋아요:"+item.p_likeCount+"p</div>";
				content+=	"<div class='endtime-count'>";
				content+=		"<div class='endtime'>종료시간:"+item.p_tm+"</div>";
				content+=	"</div>";
				content+= "</div>";
			    });	
			
			$('.main_sold div.items').empty();
			$('.main_sold div.items').append(content);
		}// 경매 리스트 end

</script>
</html>