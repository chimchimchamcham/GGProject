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
<div class="allcontents"><!--���������-->
    
        <div class="contant"><!--�α��Ǹű�-->
        <div class="word"><h2>�Ǹ��α��</h2></div>
        <div class="itemboxs">
            <div class="itembox">
                <h1>1</h1>
                <img src="test.jpg" alt="">
                <div>�ǸŰ�:10000000</div>
                <div><img src="" style="width: 40px;height: 40px;"><div>dbwlgh</div></div>
                <div><div>��:50</div><div>��ȸ��</div><div>tm:2015</div></div>
            </div>
    
            <div class="itembox">
                <h1>2</h1>
                <img src="test.jpg" alt="">
                <div>�ǸŰ�:10000000</div>
            </div>
    
            <div class="itembox">
                <h1>3</h1>
                <img src="test.jpg" alt="">
                <div>�ǸŰ�:10000000</div>
            </div>
        </div>
        </div><!--�α��Ǹű�end-->
    
    
    
    
    
    
        <div class="contant"><!--�α��ű�-->
        <div class="word">
            <h2>�α� ��ű�</h2>
        </div>
        <div class="itemboxs">
            <div class="itembox">
                <h1>1</h1>
                <img src="test.jpg" alt="">
                <div>����������:10000000</div>
                <div><div>���۰�:</div><div>��ᰪ:</div></div>
                <div><div>��:50</div><div>tm:2015</div></div>
            </div>
                
            <div class="itembox">
                <h1>2</h1>
                <img src="test.jpg" alt="">
                <div>�ǸŰ�:10000000</div>
            </div>
    
            <div class="itembox">
                <h1>3</h1>
                <img src="test.jpg" alt="">
                <div>�ǸŰ�:10000000</div>
            </div>
        </div>
        </div><!--�α��ű�end-->
    
        <div class="contant"><!--�α��ű�-->
        <div class="word">
            <h2>�α� Ŀ�´�Ƽ��</h2>
        </div>
            <div class="itembox" style="width: 1000px">
                <h1>2</h1>
                <table>
 					<tr>
						<th>ī�װ�</th>
						<th colspan="2">����</th>
						<th>�ۼ���</th>
						<th>���ƿ�</th>
						<th>�ۼ���</th>
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
</div><!--���������end-->
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