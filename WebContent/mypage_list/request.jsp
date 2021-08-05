<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div class="contents">
        <div class="button-layout_req">
            <button class="clicked">전체</button>
            <button>수신</button>
            <button>발신</button>
        </div>
        <div class="content-zoon_req">
            <div class="item-box">
                
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">

$(".button-layout_req button").click(function(){
    $button1 = $(".button-layout_req button");
    $index1 = $button1.index(this);
    
    $index_button = $(".button-layout_req button:eq(" + $index1 + ")");
    
	console.log("$center_index:"+$index1);
	
	
	reqlistCall($index1);
	
	$button1.removeClass('clicked');
	$index_button.addClass('clicked');
	
	
})

function reqlistCall($index1){
	
	console.log("$index1:"+$index1);
	
	$.ajax({
		type:'post',
		url:'./requestlist',
		data:{	index1 : $index1},
		dataType:'JSON',
		success:function(data){
			console.log("data:"+data);
			if(data != null){
				request_list(data.reqlist);
			}
		},
		error:function(e){
			console.log(e);
		}
	});	
	
	}
	

</script>
</html>