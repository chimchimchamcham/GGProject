<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>충전 팝업</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
</style>
</head>
<style>
h2 {
	text-align: center;
	padding: 5px 0 5px 0;
}

#wrap {
	width: 892px;
	height: 592px;
	float: left;
}

#detailTb {
	width: 750px;
	height: 440px;
	margin: 0px auto;
}

#detailTb, #detailTb td {
	border: 1px solid gray;
	border-collapse: collapse;
}

#detailTb td {
	padding-left: 20px;
}

#button {
	width: 750px;
	margin: 0px auto;
	/* 	border:1px solid black; */
	clear: both;
}

#button button {
	float: right;
	margin: 10px 5px;
}

a{
	text-decoration: none;
	color: black;
}

a:hover{
	text-decoration: underline;
}

</style>
<body>
	<div id="wrap">
		<h2>신고 상세내용</h2>
		<table id="detailTb">
			<tr>
				<td>신고번호</td>
				<td>${notifyDet.n_no}</td>
			</tr>
			<tr>
				<td>신고받은 아이디</td>
				<td><a href="#" class="receiverProfile" style="color:red"><b>${notifyDet.n_receiveId}</b></a></td>
			</tr>
			<tr>
				<td>신고한 아이디</td>
				<td><a href="#" class="senderProfile">${notifyDet.n_sendId}</a></td>
			</tr>
			<tr>
				<td>신고 날짜</td>
				<td>${notifyDet.n_tm}</td>
			</tr>
			<tr>
				<td>신고분류</td>
				<td>${notifyDet.n1_name}&gt; ${notifyDet.n2_name}</td>
			</tr>
			<tr>
				<td>관리자 아이디</td>
				<td  class="adminTd">${notifyDet.hn_adminid}</td>
			</tr>
			<tr>
				<td>처리상태</td>
				<td>
					<select  name="n_stateCat">
					<c:forEach items="${n_stateCat }" var="n_stateCategory">
							<option value="${n_stateCategory.c_code }">${n_stateCategory.c_name }</option>
					</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>신고내용</td>
				<td>${notifyDet.n_content}</td>
			</tr>
		</table>
		<div id="button">
			<button id="save">저장</button>
			<button id="blackBtn">블랙리스트 처리</button>
		</div>
	</div>
</body>
<script>
console.log("hello");
var c_code = "${notifyDet.c_code}";
//카테고리 기존값 뿌려주기
$("select[name=n_stateCat]").val("${notifyDet.hn_code}").prop("selected", true);

/*부모페이지가 이동하도록 하기*/
$(document).on("click",".senderProfile",function(){
	 opener.parent.location="myPage?id=${notifyDet.n_sendId}";
});

$(document).on("click",".receiverProfile",function(){
	 opener.parent.location="myPage?id=${notifyDet.n_receiveId}";
});

var param={};
/*저장 버튼 클릭 시*/
 $(document).on("click","#save",function(){
	 
	 param.n_no = "${notifyDet.n_no}";
     param.hn_code = $("select[name=n_stateCat]:selected").val();
     param.hn_admin = "${sessionScope.loginId}";
     
	 $.ajax({
         type : 'POST',
         url : 'notifyHistory',
         data : param,
         dataType : 'JSON',
         success : function(data) {
        	 console.log("신고 히스토리 등록 성공");
        	 
        	 var hn_admin = "${sessionScope.loginId}";
        	 console.log("세션 아이디 : ",hn_admin);
        	 console.log("성공한 처리상태 : ",data.sucHn_code);
        	 
        	 if(data.sucHn_code != null){
	        	 $(".adminTd").empty();
	        	 $(".adminTd").text(hn_admin);
	        	 
	        	 $("select[name=n_stateCat]").val(data.sucHn_code).prop("selected", true);
        		alert("신고 처리상태가 저장되었습니다.");
        	 }else{
        		 alert("신고 처리상태 저장에 실패하였습니다! 다시 시도해 주세요");
        	 }
         },
         error : function(e) {
            console.log(e);
         }

      });
 });
 
	var newName, n=0;
	 function newWindow(value)
	    {
	       n = n + 1;
	       newName = value + n;     
	    }
	 
	 var n_receiveid = "${notifyDet.n_receiveId}";
 /*블랙리스트 처리 버튼 클릭 시*/
 $(document).on("click","#blackBtn",function(){
	 newWindow("MyWindow");
	 window.open("./popup/blackListPr.jsp?n_receiveid="+n_receiveid , newName, "width=900, height=600, left=450, top=180");
 })

</script>
</html>