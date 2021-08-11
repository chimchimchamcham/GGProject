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

    div.itemboxs,.itemboxs_sold,.itemboxs_auc,.itemboxs_mainpage_communiti_list{
        display: flex;
        align-items: center;
        flex-wrap: nowrap;
        padding: 5px;
    }
	
	.table{
	width: 120vh;
	text-align: center;
	}
	
	.itemboxs_mainpage_communiti_list tr,td{
	border: 1px solid black;
	border-collapse: collapse;
	margin:5px;
	pading:5px;
	
	}
	
	.itemboxs_mainpage_communiti_list{
		  display: flex;
  flex-direction: column;
  height: 100%;
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
	        <div class="itemboxs_sold">
	            
	        </div>
        </div><!--�α��Ǹű�end-->
    
    
    
    
    
    
        <div class="contant"><!--�α��ű�-->
        <div class="word">
            <h2>�α� ��ű�</h2>
        </div>
        <div class="itemboxs_auc">
            
        </div>
        </div><!--�α��ű�end-->
    
    
    
    
    
        <div class="contant"><!--�α��ű�-->
        <div class="word">
            <h2>�α� Ŀ�´�Ƽ��</h2>
        </div>
            <div class="itembox_com">
                <table class="table">
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
				soled_list(data.mainpage_sold_list);
				auc_list(data.mainpage_auc_list);
				communiti_list(data.mainpage_communiti_list);
			},
			error:function(e){
				console.log(e);
			}
		});	
		
	
})

function soled_list(mainpage_sold_list) {
		console.log("mainpage_sold_list:", mainpage_sold_list);
		var content = "";
		
		mainpage_sold_list.forEach(function(item, idx) {
					console.log("idx:", idx, item);
					var num = idx+1;
					content += "<div class='itembox'>";
					content +=  "<h1>"+num+"</h1>";
					content +=  "<img src='"+item.i_newName+"' alt=''>";
					content +="<div>����:"+item.p_title+"</div>";
					content +="<div>�ǸŰ�:"+item.ns_pr+"</div>";
					content +="<div><img src='"+item.u_newName+"' style='width: 20px;height: 20px;'><div><a href='myPage?id="+item.p_id+"'>"+item.u_nname+"</a></div></div>";
					content +="<div><div>��:"+item.p_likeCount+"</div><div>"+item.p_view+"</div><div>tm:"+item.p_tm+"</div></div>";
					content +="</div>";
				});

		$(".itemboxs_sold").empty();
		$(".itemboxs_sold").append(content);


}


function auc_list(mainpage_auc_list) {
	console.log("mainpage_auc_list:", mainpage_auc_list);
	var content = "";
	
	mainpage_auc_list.forEach(function(item, idx) {
				console.log("idx:", idx, item);
				var num = idx+1;
				content += "<div class='itembox'>";
				content +=  "<h1>"+num+"</h1>";
				content +=  "<img src='"+item.i_newName+"' alt=''>";
				content +="<div>"+item.p_title+"</div>";
				content +="<div>����������:"+item.hm+"</div>";
				content +="<div>"+item.au_startPr+"</div><div>"+item.au_instantPr+"</div>";
				content +="<div><div>��:"+item.au_count+"</div><div>tm:"+item.p_tm+"</div></div>";
				content +="</div>";
			});

	$(".itemboxs_auc").empty();
	$(".itemboxs_auc").append(content);
}


function communiti_list(mainpage_communiti_list) {
	console.log("mainpage_communiti_list:", mainpage_communiti_list);
	var content = "";
	
	mainpage_communiti_list.forEach(function(item, idx) {
				console.log("idx:", idx, item);
				var num = idx+1;
				content += "<tr class='opo'>";
				content += "<td>"+num+"</td>";
				content += "<td>"+item.p_cateName+"</td>";
				content += "<td>"+item.p_title+"</td>";
				content += "<td><a href=myPage?id="+item.p_id+"'>"+item.u_nname+"<a></td>";
				content += "<td>"+item.p_likeCount+"</td>";
				content += "<td>"+item.p_tm+"</td>";
				content += "</tr>";
			});

	$(".opo").empty();
	$(".table").append(content);


}

</script>

</html>