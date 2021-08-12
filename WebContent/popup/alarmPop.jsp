<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알람</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
</style>
</head>
<style>
* {
	margin: 0;
	padding: 0;
}

h2 {
	margin-top: 20px;
	text-align: center;
}

#alarmWrap {
	width: 500px;
	/* text-align: center; */
	margin: 0px auto;
	/* background-color: blue; */
}

.tableWrap {
	text-align: center;
}

.tableWrap:hover {
	background-color: #f7f7f7;
}

.content {
	/* background-color: yellow;  */
	/* 	text-align: center; */
	display: inline-block;
	margin-top: 30px;
	width: 460px;
	margin: 10px 0 0 0;
	cursor: pointer;
}

.content td {
	width: 500px;
	text-align: left;
	display: inline-block;
	/* border: 1px solid black; */
}

#buttonTwo {
	width: 500px;
	/* background-color: green; */
	text-align: center;
	display: inline-block;
	margin: 20px 0 30px 0;
}

#buttonTwo button {
	width: 70px;
	text-align: center;
	margin: 0px auto;
	display: inline-block;
}

/*읽었을때 */
/*불러올때 읽음 여부 체크해서 read class 추가*/
.read {
	opacity: 0.3;
}

/*알람번호, 읽음 여부 숨기기*/
.a_no, .a_readYN, .a_path,.a_code{
	display:none;
}


.delBtn{
	display:inline;
}

</style>
<body>
	<h2>알람</h2>
	<div id="alarmWrap">
		<div id="buttonTwo">
			<button id="allAL">전체알람</button>
			<button id="importAL">중요알람</button>
		</div>
		<c:if test="${list eq null || list eq ''}">
			<h2>알람이 존재하지 않습니다.</h2>
		</c:if>
		<c:forEach items="${list}" var="dto">
			<div class="tableWrap <c:if test="${dto.a_readYN eq 'Y'}">read</c:if> ">
				<table class="content">
					<tr>
						<td>
							<span class="a_no">${dto.a_no }</span>
							<span class="a_readYN">${dto.a_readYN}</span>
							<span class="a_path">${dto.a_path }</span>
							<span class="a_code">${dto.a_code }</span>
							<p  style="width:310px;  padding:0 20px; text-align: left; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">${dto.a_content}</p>
						</td>
				
						<td></td>
					</tr>
					<tr>
						<td><p style="width:310px;  padding:0 20px; text-align: left; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"><small>${dto.a_sendTm }</small></p></td>
					</tr>
					<tr>
						<td style="border-bottom: 1px solid black; padding-top: 10px;"></td>
					</tr>

				</table>
			</div>
		</c:forEach>
	</div>
</body>
<script>
	var loginId = "${sessionScope.loginId}";
	var a_no = ''; //알람 번호 가져오기
	var a_readYN = ''; //읽음 여부 가져오기
	var a_path=''; //경로 가져오기
	var a_code = '';
	
	var insert_success = ''; //읽은 시간과 읽음여부 집어넣은 결과 확인용
	
	/*전체 알람 보이기*/
	$("#allAL").click(function() {
		console.log("전체 알람 보이기");
		location.href="./alarmlist?u_id="+loginId+"&a_impoyn=N";
			
		});
	
	/*중요 알람 보이기*/
	$("#importAL").click(function() {
		console.log("중요 알람 보이기");
		location.href="./alarmlist?u_id="+loginId+"&a_impoyn=Y";
	});
	
	
	/*클릭시 읽음 처리*/
	//알람 읽은 시간, 읽음 여부 집어넣고 성공했음을 보내주면 클래스 추가 시키기
	//해당 링크로 부모 페이지 이동시키기
	$(".tableWrap").click(function(){
		console.log("알림클릭");
		$(this).addClass("read"); //클릭했을 경우 읽음 표시로
		a_code = $(this).find('.a_code').text();
		a_no=$(this).find('.a_no').text(); 	//자손에 있는 값 가져오기
		a_readYN = $(this).find('.a_readYN').text();
		a_path = $(this).find('.a_path').text();
		console.log("알람번호 : ",a_no);
		console.log("알람 읽음 여부 : ",a_readYN);
		console.log("알람 경로 : ",a_path);
		console.log("알람 코드:",a_code);
		
		//읽음여부 상관없이 클릭시 해당 페이지로 부모페이지 이동
		if(a_code == 'A004' || a_code == "A008" || a_code == "A012" || a_code == "A013" || a_code == "A014" || a_code =="A015" || a_code == "A016" || a_code == "A017"){
			window.open(a_path, "거래페이지", "width=900px, height=650px");
		}else{
			opener.parent.location=a_path;
		} 
		/* opener.parent.location=a_path; */
		//읽음여부 확인하고 변경
		if(a_readYN == "N"){
			$.ajax({
				type:'GET',
				url:'readAlarm',
				data:{"a_no":a_no},
				dataType:'JSON',
				success:function(data){
					console.log(data.success);
					insert_success = data.success;
					
				},
				error:function(e){
					console.log(e);
				}
				
			});
			
		}
		
	});
	
	
</script>
</html>