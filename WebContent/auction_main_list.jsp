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
    
    #mainHeader {
	z-index: 1000;
}

#main {
	/* background-color: gray; */
	width: 1140px;
	height: auto;
	position: absolute;
	top: 150px;
	z-index: -1;
	margin: 0px auto;
	padding: 30px;
}

        .auc-con{
            display: flex;
            align-items: center;
            justify-content: center;
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
       <div id="mainHeader"><jsp:include page="header.jsp" /></div>
<div id="main">
<div class="auc-con">
<table class="categor">
    <tr><th>카테고리</th></tr>
    <tr><td>패션의류</td></tr>
    <tr><td>뷰티잡화</td></tr>
    <tr><td>유아용품</td></tr>
    <tr><td>가구생활</td></tr>
    <tr><td>취미/스타굿즈</td></tr>
    <tr><td>전자기기</td></tr>
    <tr><td>스포트레저</td></tr>
    <tr><td>자동차</td></tr>
    <tr><td>생활가전</td></tr>
    <tr><td>도서기타</td></tr>
    <tr><td>기타</td></tr>
</table>
    <div class="main_auc">
        <h2 class= "bbb">경매</h2>
        <div class="itembox">
            <div class="alinebutton">
                <button class="checked" style="margin-right: 1px;">신규등록순</button><button>마감임박순</button>
            </div>
            <div class="items">

            </div>
        </div>
    </div>
</div>

</div>
</body>
<script>

let $index_button_auction = '뷰티잡화';
let $index2 = 0;






$(document).ready(function() {
	function getParameterByName(name) { name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
	var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"), results = regex.exec(location.search); return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " ")); }
	
	var cate = getParameterByName('cate');
	$.ajax({
		type:'post',
		url:'./auctionmainlist',
		data:{  index_button_auction :cate,
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
					auction_list(data.auctionmainlist);
				}
			},
			error:function(e){
				console.log(e);
			}
		});	
		
		}
	
	
		
		//데이터 가져와서 뿌려주는 경매 리스트
		function auction_list(auctionmainlist){	
			console.log("auc=="+auctionmainlist)
			var content="";
			
			auctionmainlist.forEach(function(item,idx){
				console.log("idx:",idx,item);
				content+= "<div class='item-one' onclick="+"window.location.href='auctionDetail?p_no=" + item.p_no  +"\'" +">"
				content+= 	"<div class='img-zoon'>";
				content+=		"<img src="+item.i_newName+">";	
				content+=	"</div>";
				content+=	"<div class='index'>"+item.p_title+"</div>";
				content+=	"<div class='bestcost'>현재 최고 입찰가:"+item.hm+"p</div>";
				content+=	"<div class='nowbuycost'>즉시구매가:"+item.au_instantPr+"p</div>";
				content+=	"<div class='endtime-count'>";
				content+=		"<div class='endtime'>종료시간:"+item.au_endTm+"</div>";
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