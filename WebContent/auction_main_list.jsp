<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>Document</title>
    <style>
        *{
            margin: 0;
            padding: 0;
        }
        .auc-con{
            display: flex;
            align-items: center;
            justify-content: center;
        }
        table{
            border: 1px solid black;
        }

        .categor th,td{
            padding: 15px;
            padding-right: 200px;
        }
        .main_auc{
            width: 900px;
            height: 700px;
            margin-left:100px ;
            display: flex;
            align-items: center;
            /*justify-content: center;*/
            flex-direction: column;
        }
        .itembox{
            justify-self: center;
            display: flex;
            justify-content: center;
            flex-direction: column;
        }
        .alinebutton{
            align-self: flex-start;
        }
        .alinebutton button{
            border-color: gray;
            background-color: transparent;
        }

        .items{
            display: flex;
            flex-direction: row;
            margin-top: 20%;
        }
        .item-one{
            width: 300px;
            height: 400px;
            border: 1px solid black;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .img-zoon,.index{
            margin: 5%;
        }
        .index,.bestcost,.nowbuycost,.endtime,.count{
            margin-left: 5%;
        }
        .endtime-count{
                    display: flex;
                    flex-direction: row;
                    justify-content: space-between;
                }
    </style>
</head>
<body>
    
<div class="auc-con">
<table class="categor">
    <tr><th>카테고리</th></tr>
    <tr><td>뷰티잡화</td></tr>
    <tr><td>유아용품</td></tr>
    <tr><td>가구생활</td></tr>
    <tr><td>취미컬랙션</td></tr>
    <tr><td>컴퓨터</td></tr>
    <tr><td>스포트레져</td></tr>
    <tr><td>자동차공구</td></tr>
    <tr><td>생활가전</td></tr>
    <tr><td>도서기타</td></tr>
</table>
    <div class="main_auc">
        <h2>경매</h2>
        <div class="itembox">
            <div class="alinebutton">
                <button>신규등록순</button><button>마감임박순</button>
            </div>
            <div class="items">
                <div class="item-one">
                    <div class="img-zoon">
                        <img src="test.jpg">
                    </div>
                    <div class="index">아이페드 삽니다</div>
                    <div class="bestcost">현재 최고 입찰가:7000p</div>
                    <div class="nowbuycost">즉시구매가:15000p</div>
                <div class="endtime-count">
                    <div class="endtime">종료시간:07월 21일</div>
                    <div class="count">입찰자:5명</div>
                </div>
                </div>
                
                <div class="item-one">
                    <div class="img-zoon">
                        <img src="test.jpg">
                    </div>
                    <div class="index">아이페드 삽니다</div>
                    <div class="bestcost">현재 최고 입찰가:7000p</div>
                    <div class="nowbuycost">즉시구매가:15000p</div>
                <div class="endtime-count">
                    <div class="endtime">종료시간:07월 21일</div>
                    <div class="count">입찰자:5명</div>
                </div>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>