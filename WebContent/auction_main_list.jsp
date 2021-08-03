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
        .auc-con{
            display: flex;
            align-items: center;
            justify-content: center;
        }
        table{
            border: 1px solid black;
        }

        .categor th,td{
            padding: 15px;
            padding-right: 200px;
        }
        .categor td:hover{
            text-decoration:underline black;
            cursor: pointer;
        }
        .main_auc{
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
    
<div class="auc-con">
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
    <div class="main_auc">
        <h2>경매</h2>
        <div class="itembox">
            <div class="alinebutton">
                <button class="checked" style="margin-right: 1px;">신규등록순</button><button>마감임박순</button>
            </div>
            <div class="items">

            </div>
        </div>
    </div>
</div>


</body>
<script>

let $index_button_auction = '뷰티잡화';
let $index2 = 0;

$(document).ready(function() {
	
	$.ajax({
		type:'post',
		url:'./auctionmainlist',
		data:{  index_button_auction : '뷰티잡화',
				index2 : 0 },
		dataType:'JSON',
		success:function(data){
			console.log("data",data);
			if(data != null){
				auction_list(data.auctionmainlist);
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
	    
	    $index_button_auction = $(".categor tr td:eq(" + $index1 + ")").text();
	    
	
		console.log("$index_button_auction:"+$index_button_auction);
		console.log("$alien_list:"+$index2);
		
		auction_listCall($index_button_auction,$index2);
		//alert('hellow');
		
    })
    
    $(".alinebutton button").click(function(){//정렬
	    
	    $button2 = $(".alinebutton button");
	    $index2 = $button2.index(this);
	    
	    console.log("$index_button_auction:"+$index_button_auction);
		console.log("$alien_list_sold:"+$index2);
		
		auction_listCall($index_button_auction,$index2);
		//alert('hellow');

		
    })
    
    function auction_listCall($index_button_auction,index2){
		
		
		$.ajax({
			type:'post',
			url:'./auctionmainlist',
			data:{	index_button_auction : $index_button_auction,
					index2 : $index2},
			dataType:'JSON',
			success:function(data){
				console.log("data:"+data);
				if(data != null){
					auction_list(data.auctionlist);
				}
			},
			error:function(e){
				console.log(e);
			}
		});	
		
		}
	
	
		
		//데이터 가져와서 뿌려주는 경매 리스트
		function auction_list(auctionlist){	
			console.log("auc=="+auctionlist)
			var content="";
			
			auctionlist.forEach(function(item,idx){
				console.log("idx:",idx,item);
				content+= "<div class='item-one'>";
				content+= 	"<div class='img-zoon'>";
				content+=		"<img src="+item.i_newName+">";
				content+=	"</div>";
				content+=	"<div class='index'>"+item.p_title+"</div>";
				content+=	"<div class='bestcost'>현재 최고 입찰가:"+item.hm+"p</div>";
				content+=	"<div class='nowbuycost'>즉시구매가:"+item.au_instantPr+"p</div>";
				content+=	"<div class='endtime-count'>";
				content+=		"<div class='endtime'>종료시간:"+item.p_tm+"</div>";
				content+=		"<div class='count'>입찰자:"+item.au_count+"명</div>";
				content+=	"</div>";
				content+= "</div>";
				});	
			
			$('.main_auc div.items').empty();
			$('.main_auc div.items').append(content);
		}// 경매 리스트 end	
	
		 
				
		////////////////////////////////////////////////////////////
		$(".alinebutton button").click(function(){
		    $(".alinebutton button").toggleClass("checked");
		});


</script>
</html>