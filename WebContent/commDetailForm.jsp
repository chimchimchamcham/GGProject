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

/* λκΈ μμ­ */
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
a.pro {
	text-decoration: none;
	color : black;
	font-weight: bold;
}
a.pro:hover {
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
					<th colspan="6"><h1>μ»€λ?€λν°</h1></th>
				</tr>
				<tr>
					<td colspan="6" id="p_title"><h2>${dto.p_title }</h2></td>
				</tr>
				<tr>
					<td colspan="5" id="c_name" style="text-align: left"><h5>#
							${dto.c_name }</h5></td>
					<td id="updatebutton" style="text-align: left"><input
						type=button value="μ­μ "
						onclick="location.href='./postDel?p_no=${dto.p_no}'"> <input
						type=button value="μμ "
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
					<td>κΈ λ²νΈ : ${dto.p_no }</td>
					<td>μμ±μ : ${dto.u_nname }</td>
					<td>μμ± μΌμ : ${dto.p_tm }</td>
					<td>μ‘°νμ : ${dto.p_view }</td>
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
	/* λ‘κ·ΈμΈ μ²΄ν¬ */
	console.log("${loginId}");
	console.log("${dto.u_id}");
	console.log("${dto.i_newName }");
	if ("${loginId}" !== "${dto.u_id}") {
		$("#updatebutton").css("visibility", "hidden");
	}
	/*=====  λκΈ μμ­   =====*/
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
				console.log("μ₯μλ¦¬μ€νΈ μ§μ");
				$("#comm_comment").html(data);
			},
			error : function(e) {
				console.log("μ§μ μ€ν¨");
			}

		});
	};
	
	/* λλκΈ λΆλ¬μ€κΈ° */
	 var re_call = true;
	 $(document).on("click",".re_Arrow", function() {
		console.log("λλκΈ λ³΄κΈ° λ²νΌ ν΄λ¦­");
		var pc_parentno = $(this).attr("id");
		console.log("λ³΄μ¬μ€ λλκΈ λΆλͺ¨ λ²νΈ :", pc_parentno);
	 
	 	re_show(pc_parentno);
	 
	 });
	 var re_drawChecker = true;
		/* λλκΈ λ¦¬μ€νΈ λΆλ¬μ€κΈ° */
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
						console.log("λλκΈ λ¦¬μ€νΈ λ³΄μ¬μ£ΌκΈ°.");
						console.log(data.list);
						re_draw(data.list,pc_parentno);	
						
					},
					error : function(e) {
						console.log(e);
					}
				});
			};
			var id = "${sessionScope.loginId}";
		 /* λλκΈ λ¦¬μ€νΈ κ·Έλ¦¬κΈ° */
		 function re_draw(list,pc_parentno) {
			 console.log("λλκΈ λ¦¬μ€νΈ : ", list);
			 
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
			 re_comment += "<td colspan=3><textarea id='"+pc_parentno+"' class='re_text' style='resize: none;' placeholder='λλκΈμ μλ ₯ν΄ μ£ΌμΈμ' maxlength=300></textarea></td>";
			 re_comment += "<td><button class='re_enter' id='"+pc_parentno+"'>μν°</button></td>";
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
		
		//λλκΈ λ±λ‘ λ²νΌμ λλ μ κ²½μ°.
		 $(document).on("click",".re_enter", function(){
			console.log("λλκΈ λ±λ‘ ");
			var p_no = "${dto.p_no}";
			var pc_parentno = $(this).attr("id");
			console.log("λΆλͺ¨ λκΈ λ²νΈ :", pc_parentno);
			var pc_content = $("#"+pc_parentno+".re_text").val();
			console.log("λλκΈ λ΄μ©  :", pc_content );
			if(pc_content == ''){
				alert("λλκΈμ μλ ₯ν΄μ£ΌμΈμ!");
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
						console.log("μ±κ³΅");
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
	/* μμ  λ²νΌ */
	$(document).on('click','.update_comment', function(){
		var update_comm = $(this).attr("id");
		var update_no ={};
		update_no.pc_no = update_comm;
		console.log("λ³ν ν ", update_comm);
		
		var update_comment ="";
		
		update_comment += "<tr id='update_form'>";
		update_comment += "<td colspan=3><textarea id='"+update_comm +"' class='update_text' style='resize: none;' placeholder='μμ ν  λκΈμ μλ ₯ν΄ μ£ΌμΈμ' maxlength=300></textarea></td>";
		update_comment += "<td><button id='update_enter'>μν°</button></td>";
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
	/* μμ νκΈ° μν°  λ²νΌ λλ₯΄κΈ°.*/
	$(document).on("click","#update_enter",function(){
		console.log("μμ  λ²νΌ ν΄λ¦­");
		var update_text = $(".update_text").val();
		
		if(update_text != ''){
			var update_no =$(".update_text").attr("id");
			console.log("μμ ν  λκΈ λ²νΈ : ", update_no);	
			comm_update(update_no,update_text);
			
		}else {
			alert("μμ ν  λκΈμ μλ ₯νμΈμ!");
		}	
	});
	/* μμ  κΈ°λ₯ */
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
				console.log("μ±κ³΅");
				showCommentList();
				check=true;
			},
			error : function(e){
				console.log("μλ¬");		
			}
		});
	};
	
	/* μ­μ  λ²νΌ */
	$(document).on('click','.comm_del', function(){
		var del_comm = $(this).attr("id");
		console.log(del_comm);
		var param = {};
		param.pc_no = del_comm;
		console.log("λ³ν ν ", del_comm);
		
		$.ajax({
			type: "POST",
			url : "comm_del",
			data: param,
			dataType : "JSON",
			success : function(data){
				alert("μ­μ  μ±κ³΅ μ¬λΆ"+data.success);
				showCommentList();
			},
			error : function(e){
				console.log("μλ¬");		
			}
		});
	});

	/* μ΄μ  λ€μ λ²νΌ */
	$(document).on("click", "#before",function(){
		console.log("page :", page);
			console.log("μ΄μ ");
			if(page >1){
				page = page-1;
				showCommentList();
			}else {
				alert("λ§μ§λ§ νμ΄μ§μλλ€!");
			}
	});
	/* λ€μ λ²νΌ */
	$(document).on("click","#after", function(){
		console.log("page : ", page);
		console.log("λ€μ");
		console.log("λ°λκΈ° μ  νμ΄μ§ : " , page);
		page = Number(page) + 1;
		console.log("λ°λ νμ΄μ§ : " , page);
		showCommentList();
	
	});
	/* νμ΄μ§ λ²νΈλ‘ μ΄λν  κ²½μ° */
	$(document).on("click",".comment_nav", function(){
		
		page = $(this).attr("id");
		console.log("νμ΄μ§ λλ¦ page :",page);
		showCommentList();
		
	});
	
	
	/*κΈμμ μ ν*/
	$(document).on('keyup', ".board_text", function() {
		$('#board_text_controll').html("(" + $(this).val().length + " / 300)");
		if ($(this).val().length > 300) {
			$(this).val($(this).val().substring(0, 300));
			$('#board_text_controll').html("(300 / 300)");
		}
	});
	/*λκΈ λλ¬ μ κ³  νκΈ° */
	$(document).on('click','.reporter', function() {
			var test = $(this).attr('id');
			console.log(test)
			var N_receiveId = test;
			console.log("μ κ³ ν  μμ΄λ", N_receiveId);
			window.open("./popup/notifyPopup.jsp?N_receiveId="
					+ N_receiveId, "notifyPopup",
					"width=400, height=400, left=700, top=400");
	});
	var comment ={};
	/* λκΈ λ±λ‘ */
	$(document).on("click",".enter",function() {

		if ("${sessionScope.loginId}" == '') {
			alert("λ‘κ·ΈμΈ ν΄μ£ΌμΈμ!");
		}else if($(".board_text").val==''){
			alert("λκΈμ μλ ₯ν΄ μ£ΌμΈμ!");
		}else {
			comment.id = "${sessionScope.loginId}";
			comment.p_no = "${dto.p_no}";
			comment.pc_content = $(".board_text").val();
			comment.pc_parentno = 0;
			console.log("λκΈ λ€λ μμ΄λ : ", comment.id);
			console.log("λκΈ λ¬λ¦¬λ κ²μκΈ : ", comment.p_no);
			console.log("λκΈ λ΄μ© : ", comment.pc_content);
			console.log("λΆλͺ¨ λκΈ λ²νΈ :", comment.pc_parentno);
			console.log("λκΈ λ±λ‘")

			$.ajax({
				type : "POST",
				url : "./pushComment",
				data : comment,
				dataType : "JSON",
				success : function(data) {
					console.log("λ°ν λ°μ΄ν° : ", data);
					$(".board_text").empty();
					showCommentList();

				},
				error : function(e) {
					console.log("μλ¬ λ°μ : ", e);
				}

			});
		}
	});
</script>
</html>