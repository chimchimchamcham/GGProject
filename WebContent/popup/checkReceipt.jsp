<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
*{margin:0;padding:0;border-width:0;list-style-type:none;}
body{width:100%;background-color:gray;}
#wrap{width:400px;height:250px;background-color:white;position:relative;}
#message>#title{color:red; font-size:1.2rem; position:relative;/* background-color:yellow; */  top:10px; left:10px}
#message>#inner{font-size:0.95rem; position:relative;/* background-color:pink; */ top:30px; left:10px}
#message>#last{position:relative;  /* background-color:green;  */ top:140px; left:10px}
#last>#check{font-size:1.1rem; /* color:gray; */}
#last>input{top:10px; float:left;}
#last>button{width:60px; height:30px; border-radius:3px/3px; background-color:gray; color:white;}
</style>
</head>
<body>
<form action="">
	<div id="wrap">
		<div id="message">
			<span id="title"><b>물건을 받으셨나요?</b></span>
			<div id="inner">
				<p><b>1. 물품을 수취한 후에 수취확인 버튼을 누르셨나요?</b></p>
	
				<p><b>2. 판매 사진과 동일한 상품이 도착했나요?</b></p>
			</div>
			<div id="last">
				<span id="check"><b>제대로 확인하셨으면 체크해주세요.</b></span>
				<input style="zoom:1.8;" type="checkbox" name="checkRC" value="get"/>
				<button type="button">수취확인</button>
			</div>
		</div>
	</div>
	
	</form>
</body>
<script> 
$("input:checkbox").click(function(){
	var isChecked = $(this).prop('checked');
	console.log("check!");
	if(isChecked){
		$("button").css({"background-color":"#21641B"});
		$("button").attr("disabled",true);
	}else{
		$("button").css({"background-color":"gray"});
		$("button").attr("disabled",false);
	}
});

//수취완료를 클릭했을 경우
$("button").click(function(){
	$("form").submit();
	/* opener.parent.location.reload();
	window.close(); */
})

</script>
</html>