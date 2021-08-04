<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
#mainHeader {
	z-index: 1000;
}

#main {
	background-color: gray;
	width: 1200px;
	height: auto;
	position: absolute;
	top: 150px;
	z-index: -1;
}

#wrap {
	margin: 0 auto;
	text-align: left;
}

textarea {
	resize: none;
}
</style>
<script>
// 오늘 날짜 설정
var currDate = new Date().toISOString().substring(0,10);
console.log("오늘 날짜 : ",currDate);
</script>

</head>
<body>
	<div id="mainHeader"><jsp:include page="header.jsp" /></div>
	<div id="main">
		<div id="wrap">
			<h2>판매글 수정</h2>
			<div id="saleForm">
				<p>
					<input type="text" name="title" value="${salesUpdate.p_title }"
						style='width: "1000px"' placeholder="제목을 입력해주세요" />
				</p>
				<form method='POST' enctype="multipart/form-date" id='uploadForm'>
					<label for='test'> <c:if
							test="${salesUpdate.i_newName  eq null}">
							<img src="img/plus-icon.png" id="preview-image" width="100px"
								height="100px" style="border: solid 1px gray" />
						</c:if> <c:if test="${salesUpdate.i_newName  ne null}">
							<img src="/photo/${salesUpdate.i_newName}" id="preview-image"
								width="100px" height="100px" style="border: solid 1px gray" />
						</c:if>
					</label> <input type="file" name="oriFileImg" style="display: none"
						id="test" />
				</form>
				<p>
					<textarea name="content" rows="30" cols="100" id="update"
						style="overflow-y: scroll" placeholder="내용입력">${salesUpdate.p_content}</textarea>
				</p>
				<div id="update_cnt">( 0 / 1000)</div>
				<p>
					<input type="text" name="price" value="${salesUpdate.ns_pr}"
						placeholder="가격 입력(숫자입력)" /> P
				</p>
				<p>
					거래방식(필수선택) &nbsp;&nbsp;&nbsp; <input type="radio" name="deliveryYN"
						value="Y"
						<c:if test = "${salesUpdate.s_DeliveryYN eq 'Y'}">checked="checked"</c:if> />택배
					<input type="radio" name="deliveryYN" value="N"
						<c:if test = "${salesUpdate.s_DeliveryYN eq 'N'}">checked="checked"</c:if> />직거래
				</p>

				<p id="commuCategory">
					카테고리 선택(필수선택) &nbsp;&nbsp;&nbsp; <select name="saleCat">
						<c:forEach items="${saleCat }" var="SaleCategory">
							<option value="${SaleCategory.c_code}">${SaleCategory.c_name}</option>
						</c:forEach>
					</select>
				</p>

				<p>
					공개범위&nbsp;&nbsp;&nbsp; <input type="radio" name="disclosure"
						value="N"
						<c:if test="${salesUpdate.s_followLimYN eq 'N'}">checked="checked"</c:if>>전체공개
					<input type="radio" name="disclosure" value="Y"
						<c:if test="${salesUpdate.s_followLimYN eq 'Y'}">checked="checked"</c:if>>팔로우한정
				</p>
			</div>
			<div id="twoButton">
				<input type="button" id="submit" value="등록" /> <input type="button"
					id="console" value="콘솔" /> <input type="button"
					onclick="location.href='./index.jsp'" value="취소" />
			</div>
		</div>
	</div>
	<!-- main div end -->
</body>

<script>
console.log("${salesUpdate.s_DeliveryYN}");
console.log("${salesUpdate.s_followLimYN}");

//카테고리 기존값 뿌려주기
$("select[name=saleCat]").val("${salesUpdate.s_code}").prop("selected", true);

//택배여부, 팔로우 여부 뿌려주기
//var deliveryInput = $("input[name=deliveryYN]").val();

//$("input[name=deliveryYN]").val("${salesUpdate.s_DeliveryYN}").prop("checked",true);
//$("input[name=disclosure]").val("${salesUpdate.s_followLimYN}").prop("checked",true);

   var success = false;
   var param = {};
   param.userId = "${sessionScope.loginId}";

   // 전역변수로 설정해주어야 한다.
   var form = new FormData();
   $("#console").click(function() {
      console.log($("input[name=deliveryYN]:checked").val());
      console.log($("input[name=disclosure]:checked").val());
   })
   
   //등록버튼 클릭시 
   $("#submit").click(function() {
      
      // 클릭 시 폼 데이터를 가져와야 한다.      
      var data = $("#test")[0].files[0]; // input type='file'의 id 인 test 에서 첫 번째 파일데이터를 가져온다.
      form.append("imgFile",data); // form 데이터에 key value 형식으로 넣어준다.
      console.log(data);

      if($("input[name='title']").val() ==""){
			alert("제목을 입력해주세요!");
			$("input[name='title']").focus();
			return false;
		}else if($("textarea[name='content']").val() ==""){
			alert("내용을 입력해주세요!");
			$("textarea[name='content']").focus();
			return false;
		}else if($("input[name='price']").val() ==""){
				alert("가격을 설정해주세요!");
				$("input[name='price']").focus();
				return false;
			}else{
      param.p_no = ${salesUpdate.p_no};
      param.title = $("input[name='title']").val();
      param.content = $("textarea[name='content']").val();
      param.category = $("select[name='saleCat']:selected").val();
      param.deliveryYN =$("input[name=deliveryYN]:checked").val();
      //param.deliveryYN = $("input[name='deliveryYN']:checked").val();
      param.price = $("input[name='price']").val();
      param.followLimYN = $("input[name=disclosure]:checked").val();
      
      //ajax url="sale"
      console.log(param);
      $.ajax({
         type : 'POST',
         url : 'salesUpdate',
         data : param,
         dataType : 'JSON',
         success : function(data) {
            if (data.sucP_no == '${salesUpdate.p_no}') {
               form.append("p_no",data.sucP_no);
               FileUpload();
               alert("판매글 수정을 성공했습니다.");
               location.href="./salesDetail?p_no="+data.sucP_no;
               
            } else {
               alert("판매글 수정을 실패하였습니다! ");
               location.href = "./salesUpdateForm?P_no="+ ${salesUpdate.p_no};
            }
         },
         error : function(e) {
            console.log(e);
         }

      });
			}
   });
   
   ///////사진 선택시 미리보기 변경/////////
   function readImage(input) {
       // 인풋 태그에 파일이 있는 경우
       if(input.files && input.files[0]) {
           // 이미지 파일인지 검사 (생략)
           // FileReader 인스턴스 생성
           const reader = new FileReader();
           // 이미지가 로드가 된 경우
           reader.onload = e => {
               const previewImage = document.getElementById("preview-image");
               previewImage.src = e.target.result;
           };
           // reader가 이미지 읽도록 하기
           reader.readAsDataURL(input.files[0]);
       }
   };
   
   // input file에 change 이벤트 부여
   const inputImage = document.getElementById("test");
   inputImage.addEventListener("change", e => {
       readImage(e.target);
   });
   
   // ajax로 파일 보내기 formdata()
   function FileUpload(){
      $.ajax({
         type : 'POST',
         url : 'update',
         data : form,
         asynsc:true,
         contentType:false,
         cache:false,
         processData:false,
         success : function(data) {
            if(data != null){
               alert("사진 수정 성공");
            }else{
               alert("사진 수정 실패");
            }
         },
         error : function(e) {
            console.log(e);
         }
      });
   }
   
   /*글자수 제한*/
   $('#update').on('keyup', function() {
          $('#update_cnt').html("("+$(this).val().length+" / 1000)");

          if($(this).val().length > 1000) {
              $(this).val($(this).val().substring(0, 1000));
              $('#update_cnt').html("(1000 / 1000)");
          }
      });

</script>
</html>