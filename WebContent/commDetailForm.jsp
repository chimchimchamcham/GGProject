<%@ page import="com.gg.dto.GGDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#mainHeader {
	z-index: 1000;
}

#main {
	/* background-color: gray; */
	width: 1200px;
	height: auto;
	position: absolute;
	top: 150px;
	z-index: -1;
	margin: 0px auto;
	padding: 30px;
}

#cate {
	margin: 50px;
}

#commTitle {
	margin: 50px;
}

#commDetailtable {
	margin: 0px auto;
	border: 1px solid black;
	text-align: center;
	width: 80%;
	padding: 20px;
}

.box {
	width: 30px;
	height: 30px;
	border-radius: 50%;
	overflow: hidden;
	margin: 0px auto;
}

.profile {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

#commTextarea {
	width: 95%;
	height: 300px;
	margin-top: 20px;
	resize: none;
	padding: 10px;
}

/* 댓글 영역 */
#comm_comment {
	margin: 0px auto;
	border: 1px solid black;
	border-collapse: collapse;
	text-align: center;
	width: 80%;
	text-align: center;
}

.board_text {
	margin: 0px auto;
	border: 1px solid black;
	border-collapse: collapse;
	text-align: center;
	float: left;
	width: 90%;
	padding: 20px;
}
.update_text, .re_text {
	margin: 0px auto;
	border: 1px solid black;
	border-collapse: collapse;
	text-align: center;
	float: left;
	width: 857px;
	padding: 20px;
}
.enter, #update_enter,.re_enter {
	width: 53px;
	height: 71px;
	float: left;
	border: 0.5px solid gray;
	text-align: center;
	border-collapse: collapse;
}

.enter:hover, #update_enter:hover, .re_enter:hover {
	background-color: gray;
}
#board_text_controll {
	display :inline;
	white-space : nowrap;
	
}
#comments_table td#profile{
	text-align: center;
	border-bottom: 0.5px solid lightgray;
	width: 92px;
	height : 117px;
}
#comments_img {
	width: 90px;
	height: 90px;
	border-radius: 50px;
	float: right;
	overflow: hidden;
	margin: 0px auto;
	border: 0.5px solid lightgray;

}
td#content {
	width: 710px;
	border-bottom : 0.5px solid lightgray;
}
a {
	text-decoration: none;
	color : black;
	font-weight: bold;
}
a:hover {
	color: pink;
}
.re_Arrow, .reporter {
	cursor: pointer;
}
#before, #after {
	cursor: pointer
}
#before:hover, #after:hover {
	color: pink;
}
.comment_nav {
	cursor : pointer;
}
.comm_del, .update_comment {
	cursor: pointer;
}
.comm_del:hover, .update_comment:hover {
	color: pink;
}
.update_comment, .comm_del{
	display :inline;
	white-space : nowrap;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
		<div id="wrap">
			<table id="commDetailtable">
				<tr>
					<th colspan="6"><h1>커뮤니티</h1></th>
				</tr>
				<tr>
					<td colspan="6" id="p_title"><h2>${dto.p_title }</h2></td>
				</tr>
				<tr>
					<td colspan="5" id="c_name" style="text-align: left"><h5>#
							${dto.c_name }</h5></td>
					<td id="updatebutton" style="text-align: left"><input
						type=button value="삭제"
						onclick="location.href='./postDel?p_no=${dto.p_no}'"> <input
						type=button value="수정"
						onclick="location.href='./commUpdateForm?p_no=${dto.p_no}'">
					</td>
				</tr>
				<tr>
					<td><c:if test="${dto.u_newName  ne ''}">
							<div class="box">
								<a href="myPage?id=${dto.u_id}"> <img class="profile"
									src="./img/default-profile.png">
								</a>
							</div>
						</c:if></td>
					<td>글 번호 : ${dto.p_no }</td>
					<td>작성자 : ${dto.u_nname }</td>
					<td>작성 일시 : ${dto.p_tm }</td>
					<td>조회수 : ${dto.p_view }</td>
					<td></td>
				</tr>
				<tr>
					<td colspan="6"><hr></hr></td>
				</tr>
				<c:if test="${dto.i_newName ne null}">
					<tr>
						<td colspan="6" id="i_newName" style="text-align: left"><img
							src="/photo/${dto.i_newName }" width=300px /></td>
					</tr>
				</c:if>
				<tr>
					<td colspan="6" id="p_content"><textarea id="commTextarea"
							readonly>${dto.p_content }</textarea></td>
				</tr>
			</table>

		</div>
		<div id='comm_comment'></div>
	</div>
</body>
<script>
	/* 로그인 체크 */
	console.log("${loginId}");
	console.log("${dto.u_id}");
	console.log("${dto.i_newName }");
	if ("${loginId}" !== "${dto.u_id}") {
		$("#updatebutton").css("visibility", "hidden");
	}
	/*=====  댓글 영역   =====*/
	var page = 1;

	showCommentList();
	console.log(page);
	console.log("${dto.p_no}");
	function showCommentList() {

		$.ajax({
			url : "auctionCommentList",
			data : {
				"page" : page,
				"p_no" : "${dto.p_no}"
			},
			success : function(data) {
				console.log("옥션리스트 진입");
				$("#comm_comment").html(data);
			},
			error : function(e) {
				console.log("진입 실패");
			}

		});
	};
	
	/* 대댓글 불러오기 */
	 var re_call = true;
	 $(document).on("click",".re_Arrow", function() {
		console.log("대댓글 보기 버튼 클릭");
		var pc_parentno = $(this).attr("id");
		console.log("보여줄 대댓글 부모 번호 :", pc_parentno);
	 
	 	re_show(pc_parentno);
	 
	 });
	 var re_drawChecker = true;
		/* 대댓글 리스트 불러오기 */
		 function re_show(pc_parentno){
			 	
		 	var re_comm = {};
		 	re_comm.pc_parentno = pc_parentno;
		 	re_comm.p_no = "${dto.p_no}";
				$.ajax({
					type: "POST",
					data: re_comm,
					dataType: "JSON",
					url: "showReComment",
					success : function(data){ 
						console.log("대댓글 리스트 보여주기.");
						console.log(data.list);
						re_draw(data.list,pc_parentno);	
						
					},
					error : function(e) {
						console.log(e);
					}
				});
			};
			var id = "${sessionScope.loginId}";
		 /* 대댓글 리스트 그리기 */
		 function re_draw(list,pc_parentno) {
			 console.log("대댓글 리스트 : ", list);
			 
			 var re_comment = "";
			 if(list != null){
				list.forEach(function(item,idx){
					
				 	re_comment += "<tr id='redrawForm'>";
				 	re_comment += 	"<td style='border-bottom:0.5px solid lightgray;'><img src='./img/re_Comment.png' />"+item.u_nname +" </td>";
				 	re_comment +=  	"<td id='content'>" + item.pc_content + "</td>";
				 	re_comment += 	"<td id='right' style='border-bottom: 0.5px solid lightgray'>";
				 	if(id == item.pc_id){
				 		re_comment += 		"<img src='./img/trashbox.png' width='35px' height='35px' style='float:left' id='"+item.pc_no+"' class='comm_del'>";
				 	}
				 	else{
				 		re_comment += "<img src='./img/notify-icon.png' width='17px' height='17px' style='float:right' class='reporter' id='"+item.pc_id+"'>";
				 	}
				 	re_comment += 	"<p style='float:right; margin-right:8px'>"+item.pc_tm+"</p>";
				 	re_comment +=	"</td>";
			 		re_comment += "</tr>";
				});	 

			 }
			 
			 re_comment += "<tr id='re_comment'>";
			 re_comment += "<td colspan=3><textarea id='"+pc_parentno+"' class='re_text' style='resize: none;' placeholder='대댓글을 입력해 주세요' maxlength=300></textarea></td>";
			 re_comment += "<td><button class='re_enter' id='"+pc_parentno+"'>엔터</button></td>";
			 re_comment += "</tr>"; 
			 
			 if(re_drawChecker){
				 $("tr#update_form").remove();
				 $("tr#re_comment").remove();
				 $("tr#redrawForm").remove();
				 $("tr#"+pc_parentno).after(re_comment);
				 re_drawChecker = false;
			 }else {
				 
				 $("tr#update_form").remove();
				 $("tr#re_comment").remove();
				 $("tr#redrawForm").remove();
				 re_drawChecker = true;
			 }
			 
		 };
		
		//대댓글 등록 버튼을 눌렀을 경우.
		 $(document).on("click",".re_enter", function(){
			console.log("대댓글 등록 ");
			var p_no = "${dto.p_no}";
			var pc_parentno = $(this).attr("id");
			console.log("부모 댓글 번호 :", pc_parentno);
			var pc_content = $("#"+pc_parentno+".re_text").val();
			console.log("대댓글 내용  :", pc_content );
			if(pc_content == ''){
				alert("대댓글을 입력해주세요!");
			}else {
				
			var plus_reComm = {};
			plus_reComm.p_no = p_no;
			plus_reComm.pc_parentno = pc_parentno;
			plus_reComm.pc_content = pc_content;
			plus_reComm.pc_id = "${sessionScope.loginId}";
			
				$.ajax({
					type: "GET",
					url : "re_comment",
					data : plus_reComm,
					dataType: "JSON",
					success : function(data){
						console.log("성공");
						re_drawChecker = true;
						re_show(pc_parentno);
					},
					error : function(e){
						console.log(e);	
					}
				});
			}
			
		 });
	
	var check = true;
	/* 수정 버튼 */
	$(document).on('click','.update_comment', function(){
		var update_comm = $(this).attr("id");
		var update_no ={};
		update_no.pc_no = update_comm;
		console.log("변환 후 ", update_comm);
		
		var update_comment ="";
		
		update_comment += "<tr id='update_form'>";
		update_comment += "<td colspan=3><textarea id='"+update_comm +"' class='update_text' style='resize: none;' placeholder='수정할 댓글을 입력해 주세요' maxlength=300></textarea></td>";
		update_comment += "<td><button id='update_enter'>엔터</button></td>";
		update_comment += "</tr>"; 
		
		
		if(check){
			$("tr#"+update_comm).after(update_comment);
			 $("tr#redrawForm").remove();
			 $("tr#re_comment").remove();
			check = false;
		}else {
			$("tr#update_form").remove();
			$("tr#re_comment").remove();
			$("tr#redrawForm").remove();
			check = true;
		}
		console.log(check);	
		
	}); 
	/* 수정하기 엔터  버튼 누르기.*/
	$(document).on("click","#update_enter",function(){
		console.log("수정 버튼 클릭");
		var update_text = $(".update_text").val();
		
		if(update_text != ''){
			var update_no =$(".update_text").attr("id");
			console.log("수정할 댓글 번호 : ", update_no);	
			comm_update(update_no,update_text);
			
		}else {
			alert("수정할 댓글을 입력하세요!");
		}	
	});
	/* 수정 기능 */
	function comm_update(pc_no,context){
		var update_no = {};
		update_no.pc_no = pc_no;
		
		update_no.context = context;
		
		$.ajax({
			type: "POST",
			url : "comm_update",
			data: update_no,
			dataType : "JSON",
			success : function(data){
				console.log("성공");
				showCommentList();
				check=true;
			},
			error : function(e){
				console.log("에러");		
			}
		});
	};
	
	/* 삭제 버튼 */
	$(document).on('click','.comm_del', function(){
		var del_comm = $(this).attr("id");
		console.log(del_comm);
		var param = {};
		param.pc_no = del_comm;
		console.log("변환 후 ", del_comm);
		
		$.ajax({
			type: "POST",
			url : "comm_del",
			data: param,
			dataType : "JSON",
			success : function(data){
				alert("삭제 성공 여부"+data.success);
				showCommentList();
			},
			error : function(e){
				console.log("에러");		
			}
		});
	});

	/* 이전 다음 버튼 */
	$(document).on("click", "#before",function(){
		console.log("page :", page);
			console.log("이전");
			if(page >1){
				page = page-1;
				showCommentList();
			}else {
				alert("마지막 페이지입니다!");
			}
	});
	/* 다음 버튼 */
	$(document).on("click","#after", function(){
		console.log("page : ", page);
		console.log("다음");
		console.log("바뀌기 전 페이지 : " , page);
		page = Number(page) + 1;
		console.log("바뀐 페이지 : " , page);
		showCommentList();
	
	});
	/* 페이지 번호로 이동할 경우 */
	$(document).on("click",".comment_nav", function(){
		
		page = $(this).attr("id");
		console.log("페이지 누름 page :",page);
		showCommentList();
		
	});
	
	
	/*글자수 제한*/
	$(document).on('keyup', ".board_text", function() {
		$('#board_text_controll').html("(" + $(this).val().length + " / 300)");
		if ($(this).val().length > 300) {
			$(this).val($(this).val().substring(0, 300));
			$('#board_text_controll').html("(300 / 300)");
		}
	});
	/*댓글 눌러 신고 하기 */
	$(document).on('click','.reporter', function() {
			var test = $(this).attr('id');
			console.log(test)
			var N_receiveId = test;
			console.log("신고할 아이디", N_receiveId);
			window.open("./popup/notifyPopup.jsp?N_receiveId="
					+ N_receiveId, "notifyPopup",
					"width=400, height=400, left=700, top=400");
	});
	var comment ={};
	/* 댓글 등록 */
	$(document).on("click",".enter",function() {

		if ("${sessionScope.loginId}" == '') {
			alert("로그인 해주세요!");
		}else if($(".board_text").val==''){
			alert("댓글을 입력해 주세요!");
		}else {
			comment.id = "${sessionScope.loginId}";
			comment.p_no = "${dto.p_no}";
			comment.pc_content = $(".board_text").val();
			comment.pc_parentno = 0;
			console.log("댓글 다는 아이디 : ", comment.id);
			console.log("댓글 달리는 게시글 : ", comment.p_no);
			console.log("댓글 내용 : ", comment.pc_content);
			console.log("부모 댓글 번호 :", comment.pc_parentno);
			console.log("댓글 등록")

			$.ajax({
				type : "POST",
				url : "./pushComment",
				data : comment,
				dataType : "JSON",
				success : function(data) {
					console.log("반환 데이터 : ", data);
					$(".board_text").empty();
					showCommentList();

				},
				error : function(e) {
					console.log("에러 발생 : ", e);
				}

			});
		}
	});
</script>
</html>