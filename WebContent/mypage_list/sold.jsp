<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<style>
/* 초기화 */
*{
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}
/* 화면 전체 레이아웃  설정 */
.contents{
    display: flex;
    justify-items: center;
    align-items: center;
    flex-direction: column;

    
}

/*	전체,판매중,판매완료 버튼	*/
	/* 전체 버튼들 레이아웃,정렬 설정 */
    .button-zoon{
        display: flex;
        justify-items: center;
        align-items: center;
        flex-direction: row;
    }
    
    	/*기본*/
        .button-layout button{
            margin: 1vh;
            padding: 1vh;
        }
        /*버튼위에 마우스포인터 있을때*/
        .button-layout button:hover{
            margin: 1vh;
            padding: 1vh;
            background-color: gray;
        }
        /*버튼을 클릭해서 jq로 버튼애 .clicked 클라스 추가될때*/
        .button-layout button.clicked{
            margin: 1vh;
            padding: 1vh;
            background-color: gray;
            border: 1px solid black;
            border-top: 2px solid black;
            border-left: 2px solid black;
        }
        
        
   /*	최신,인기,저가,고가 버튼	*/
   /* 전체 버튼들 레이아웃,정렬 설정 */
        .alien_list{
            display: block;
            align-self: flex-end;
            margin-right: 50vh;
            margin-bottom: 5vh;
        }
        /*기본*/
        .alien_list button{
            border: none;
            font-size: 15px;
            background-color:transparent;
            color: black;
        }
        /*버튼위에 마우스포인터 있을때*/
        .alien_list button:hover{
            color: red;
            cursor: pointer;
        }
        /*버튼을 클릭해서 jq로 버튼애 .clicked 클라스 추가될때*/
        .alien_list button.clicked{
            color: red;
            cursor: pointer;
        }


/*물건들 위치할자리 크기1000*/
    .content-zoon{
        width: 1000px;
        border: 1px solid black;

       
    }   
    /*물건들을 넣을 박스크기 900,그리고 물건들이 .content-zoon크기를 넘을때 줄을넘어서 생성*/
        .item-box{
            width: 900px;
            display: flex;
            flex-wrap: wrap;
            margin: 0 auto;

            
        }
            /*물건 정보 크기 200*300*/
            .item-one{
                width: 200px;
                height: 300px;
                margin: 1%;
                padding: 2vh;
                border: 1px solid black;
            }
            	/* 물건 이미지 틀,만약 이미지가 틀을 넘으면  넘은부분은 보이지않음 그리고 이미지를 가운데를 기준으로 보여짐*/
                .img-zoon{
                    margin: 5px;
                    border: 1px solid black;
                    overflow: hidden;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }
                /*이미지크기==175*150을 넘지 않음*/
                img{
                    max-width: 175px;
                    max-height: 150px;
                }
                .dretion-zoon{
                    margin-top: 2vh;
                }
                /*좋아요,시간은 양쪽끝에둠*/
                .love-time{
                    margin-top: 5vh;
                    display: flex;
                    flex-direction: row;
                    justify-content: space-between;
                }
</style>

<body>
    <div class="contents">
        <div class="button-layout">
            <button class="clicked">전체</button>
            <button>판매중</button>
            <button>판매완료</button>
        </div>
        
        <div class="alien_list">
                <button class="clicked" >최신</button>/
                <button>인기</button>/
                <button>저가</button>/
                <button>고가</button>
        </div>
        
        <div class="content-zoon">
            <div class="item-box">
                
            </div>
        </div>
    </div>
</body>
    <script>

    $(".button-layout button").click(function(){
	    $button = $(".button-layout button");
	    console.log()
	    $index = $button.index(this);
	    $index_button = $(".button-layout button:eq(" + $index + ")");
		console.log("$center_index:"+$index);
		$(".button-layout button").removeClass('.clicked');
		$index_button.addClass('.clicked');
		
		
    })
    
    $(".alien_list button").click(function(){
	    $button = $(".alien_list button");
	    $index = $button.index(this);
	    $index_button = $("alien_list button:eq(" + $index + ")");
		console.log("$alien_list:"+$index);
		$(".button-layout button").removeClass('.clicked');
		$index_button.addClass('.clicked');
    })
</script>
</html>