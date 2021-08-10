<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
.allcontents{
margin-top: 30vh;
}
    .contant{
    	
        display: flex;
        align-items: center;
        justify-content: center;
        flex-direction: column;
        margin: 5vh;
    }

    div.itemboxs{
        display: flex;
        align-items: center;
        flex-wrap: nowrap;
        padding: 5px;
    }
    .itembox{
        display: flex;
        flex-direction: column;
        align-items: center;
        flex-wrap: nowrap;
        margin: 5px;
        border:1px solid black;
        padding: 5px;
        width: 35vh;
    }
   .itembox img{
   	border: 1px solid black;
   	max-width: 200px;
   	max-height: 200px;
   }
</style>

</head>
<body>
<div class="allcontents"><!--모든컨탠츠-->
    
        <div class="contant"><!--인기판매글-->
        <div class="word"><h2>판매인기글</h2></div>
        <div class="itemboxs">
            <div class="itembox">
                <h1>1</h1>
                <img src="test.jpg" alt="">
                <div>판매값:10000000</div>
                <div><img src="" style="width: 40px;height: 40px;"><div>dbwlgh</div></div>
                <div><div>♥:50</div><div>조회수</div><div>tm:2015</div></div>
            </div>
    
            <div class="itembox">
                <h1>2</h1>
                <img src="test.jpg" alt="">
                <div>판매값:10000000</div>
            </div>
    
            <div class="itembox">
                <h1>3</h1>
                <img src="test.jpg" alt="">
                <div>판매값:10000000</div>
            </div>
        </div>
        </div><!--인기판매글end-->
    
    
    
    
    
    
        <div class="contant"><!--인기경매글-->
        <div class="word">
            <h2>인기 경매글</h2>
        </div>
        <div class="itemboxs">
            <div class="itembox">
                <h1>1</h1>
                <img src="test.jpg" alt="">
                <div>현제입찰가:10000000</div>
                <div><div>시작가:</div><div>즉결값:</div></div>
                <div><div>♥:50</div><div>tm:2015</div></div>
            </div>
                
            <div class="itembox">
                <h1>2</h1>
                <img src="test.jpg" alt="">
                <div>판매값:10000000</div>
            </div>
    
            <div class="itembox">
                <h1>3</h1>
                <img src="test.jpg" alt="">
                <div>판매값:10000000</div>
            </div>
        </div>
        </div><!--인기경매글end-->
    
        <div class="contant"><!--인기경매글-->
        <div class="word">
            <h2>인기 커뮤니티글</h2>
        </div>
            <div class="itembox" style="width: 1000px">
                <h1>2</h1>
                <table>
 					<tr>
						<th>카테고리</th>
						<th colspan="2">제목</th>
						<th>작성자</th>
						<th>좋아요</th>
						<th>작성일</th>
					</tr>
					<tr>
						<td colspan="6" style="padding: 0; border-bottom: 1px solid gray"></td>
					</tr>

					<tr class="">

					</tr>
                </table>
            </div>
        </div>
</div>
</div><!--모든컨탠츠end-->
</body>
<script type="text/javascript">

$(document).ready(function() {
	
	console.log("mianpage include");

		$.ajax({
			type:'post',
			url:'./mainpage',
			data:{},
			dataType:'JSON',
			success:function(data){
				console.log("data",data.mainpage_sold_list);
				console.log("data",data.mainpage_auc_list);
				console.log("data",data.mainpage_communiti_list);
			},
			error:function(e){
				console.log(e);
			}
		});	
		
	
})








</script>

</html>