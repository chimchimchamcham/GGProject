<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<style>
/* 화면 전체 레이아웃  설정 */
.contents{
    display: flex;
    justify-items: center;
    align-items: center;
    flex-direction: column;

    
}

/*	전체,판매중,판매완료 버튼	*/
	/* 전체 버튼들 레이아웃,정렬 설정 */

.contents{
    display: flex;
    justify-self: center;
    align-items: center;
    align-content: center;
    flex-direction: column;
}    
.content-zoon_flow{
    display: block;
}
.img-zoon img{
    border-radius:75px;
    max-width: 150px;
    max-height: 150px;
}

.item-box *{
    text-align: center;
    margin:5px;
}
.content-zoon_flow{
border:  1px solid rgb(176 176 176);
}
.img-zoon img{
    border-radius:75px;
    max-width: 150px;
    max-height: 150px;
}

.item-box *{
    text-align: center;
}
        /*기본*/
        .button-layout_flow button{
            width: 10vh;
            height: 5vh;
            font-size: 15px;
            background-color:transparent;
            color: black;
        }
        /*버튼위에 마우스포인터 있을때*/
        .button-layout_flow button:hover{
            width: 10vh;
            height: 5vh;
            color:	white;
            background-color:gray;
            cursor: pointer;
        }
        /*버튼을 클릭해서 jq로 버튼애 .clicked 클라스 추가될때*/
        .button-layout_flow button.clicked{
            width: 10vh;
            height: 5vh;
            color:	white;
            background-color:gray;
            cursor: pointer;
        }
        .count{
        	float: left;
        	align-self:flex-start;
        	margin-left:10vh;
        }
        .item-box{
        display: flex;
        justify-content: space-around;
        flex-direction: row;
        }
</style>
  
<body>
    <div class="contents">
        <div class="button-layout_flow">
            <button class="clicked">팔로잉</button>
            <button>팔로워</button>
        </div>
        	<div class="count">팔로워 or 팔로잉:<p style="display: inline-block;"></p> </div>
        <div class="content-zoon_flow">
            <div class="item-box">
                
            </div>
        </div>
    </div>
        
</body>
  <script>
	//목록들 정보 변수
	/* var $how_index = 0;
	var $how_aline_list	= 0;
	
	
	// index들 변수
	let $index_how = 0;
	let $index_aline_how = 0; */
	

	
    $(".button-layout_flow button").click(function(){
	    $button1 = $(".button-layout_flow button");
	    $index1 = $button1.index(this);
	    
	    $index_button = $(".button-layout_flow button:eq(" + $index1 + ")");
	    
		console.log("$center_index:"+$index1);
		
		
		flowlistCall($index1);
		
		$button1.removeClass('clicked');
		$index_button.addClass('clicked');
		
		
    })
    
    $("button.flowPlusMinus").click(function(){
	    $button = $(".button.flowPlusMinus");
	    $index = $button.index(this);
	    $index_button = $(".button-layout_flow button:eq(" + $index + ")");
	    
	    console.log("$center_index:"+$index);
	    
	    var $indexval = $index_button.val();
	    console.log("$indexval:"+$indexval);
	    
    });
    
    function flowlistCall($index1){
		
		console.log("$index1:"+$index1);
		console.log("myPageFollow : ${myPageInfo.u_nname}");
		$.ajax({
			type:'post',
			url:'./flowlist',
			data:{	
				index1 : $index1,
				"oppId": "${myPageInfo.u_nname }"
					},
			dataType:'JSON',
			success:function(data){
				console.log("data:"+data);
				if(data != null){
					flow_list(data.flowlist);
				}
			},
			error:function(e){
				console.log(e);
			}
		});	
		
		}
		
    
    
    $("button.hellow").click(function(){
	    $button1 = $(".button.hellow");
	    $index1 = $button1.index(this);
	    $index_button_hellow = $(".button.hellow:eq(" + $index1 + ")");
	    
		var hellow = $index_button_hellow.text();
		//버튼을 누르면 flow_or_unflow함수 실행
		console.log(hellow);
    })
		
    
   
    

    
</script>
</html>