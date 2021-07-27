<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
    <!--예약하기 달력 관련 링크-->
    <!-- jquery UI 링크 -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <!-- jquery UI CDN -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <!-- 언어 별 CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.9.2/i18n/jquery.ui.datepicker-ko.min.js"></script>
    <!-- Date 라이브러리 -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
    <!--------------//////////////////////////////------------->
</head>
<body>
 <h2>글쓰기</h2>
    <!--글쓰기 폼 선택 버튼-->
    
    <div id="selectForm">
        <button id="sale">판매</button>
        <button id="trade">경매</button>
        <button id="community">커뮤니티</button>
    </div>

    <div id="communityForm">
        <p><input type="text" name="title" value="" placeholder="제목을 입력해주세요" /></p>
        <p class="imgFileUpload">
            <img src="images/plus.png" class="imgFileBtn" alt="plus" width="100px"/>
            <input type="file" name="imgFile" style="display:none";/></p>
        <p><textarea name="content" rows="3" cols="40" placeholder="내용입력"></textarea></p>
        <p id="commuCategory">카테고리 선택(필수선택) &nbsp;&nbsp;&nbsp;
            <select name="saleCat">
                <option value="">카테고리 선택</option>
                <option value="purchSub">구매대행</option>
                <option value="neighb">동네이야기</option>
                <option value="together">같이해요</option>
                <option value="boast">자랑해요</option>
                <option value="share">공유해요</option>
                <option value="talk">잡담해요</option>
                <option value="adver">홍보해요</option>
            </select>
        </p>    
    </div>

    <div id="saleForm">
        <p><input type="text" name="price" value="" placeholder="가격 입력(숫자입력)" />&nbsp;Point</p>
        <p>거래방식(필수선택) &nbsp;&nbsp;&nbsp;<button>택배</button>&nbsp;<button>직거래</button>&nbsp;<button>상의 후 결정</button></p>
        <p id="category">카테고리 선택(필수선택) &nbsp;&nbsp;&nbsp;
            <select name="saleCat">
                <option value="">카테고리 선택</option>
                <option value="fashion">패션의류</option>
                <option value="beauty">뷰티잡화</option>
                <option value="furniture">가구생활</option>
                <option value="hobby">취미컬렉션</option>
                <option value="computer">컴퓨터</option>
                <option value="sport">스포츠레져</option>
                <option value="cartool">자동차공구</option>
                <option value="houseapp">생활가전</option>
                <option value="furniture">도서기타</option>
                <option value="etc">기타</option>
            </select>
        </p>
        <p>공개범위&nbsp;&nbsp;&nbsp;
            <input type="radio" name="disclosure" value="all">전체공개
            <input type="radio" name="disclosure" value="follow">팔로우한정
        </p>
    </div>
    <!--경매선택시 하단부분-->
    <div id="tradeForm">
        <p>경매시간 설정</p>
        <p>현재시간 ~ 종료시간<input type="text" name="nowDate" value="" readonly></p>
        
        
        <!--예약 경매 버튼 클릭시-->
        <button id="reservBtn">예약경매하기</button>
        <div id="reservForm">
        <p><input type="text" id="from" placeholder="시작시간" style="width:80px;" readonly>
            <select name="startAP">
                <option value="am">AM</option>
                <option value="PM">PM</option>
            </select>
            <select name="revStartHour">
                <option value="1">1시</option> 
                <option value="2">2시</option> 
                <option value="3">3시</option> 
                <option value="4">4시</option> 
                <option value="5">5시</option> 
                <option value="6">6시</option> 
                <option value="7">7시</option> 
                <option value="8">8시</option> 
                <option value="9">9시</option> 
                <option value="10">10시</option> 
                <option value="11">11시</option> 
                <option value="12">12시</option> 
            </select> 
            <select name="revStartMin">
                <option value="00">00분</option> 
                <option value="10">10분</option> 
                <option value="20">20분</option> 
                <option value="30">30분</option> 
                <option value="40">40분</option> 
                <option value="50">50분</option> 
            </select>
            ~ 
            <input type="text" id="to" placeholder="종료시간" style="width:80px;" readonly>
            <select name="revEndAP">
                <option value="am">AM</option>
                <option value="PM">PM</option>
            </select>
            <select name="revEndHour">
                <option value="1">1시</option> 
                <option value="2">2시</option> 
                <option value="3">3시</option> 
                <option value="4">4시</option> 
                <option value="5">5시</option> 
                <option value="6">6시</option> 
                <option value="7">7시</option> 
                <option value="8">8시</option> 
                <option value="9">9시</option> 
                <option value="10">10시</option> 
                <option value="11">11시</option> 
                <option value="12">12시</option> 
            </select>
            <select name="revEndMin">
                <option value="00">00분</option> 
                <option value="10">10분</option> 
                <option value="20">20분</option> 
                <option value="30">30분</option> 
                <option value="40">40분</option> 
                <option value="50">50분</option>  
            </select>
            </p>
        <!--아래에 선택 일자 표시-->
        <!--<p><input type="text" id="alternateFrom" size="30"> ~ <input type="text" id="alternateTo" size="30"></p>-->
        </div>
        <p>시작가격&nbsp;<input type="text" name="startPrice" value="" placeholder="시작가격 입력(숫자입력)" />&nbsp;Point </p>
        <p>즉결가격&nbsp;<input type="text" name="promptPrice" value="" placeholder="즉결가격 입력(숫자입력)" />&nbsp;Point</p>
    </div>

    <div id="twoButton">
        <button>등록</button>
        <button>취소</button>
    </div>
</body>
<script>
    //현재시간 불러오기 (향후 삭제)
    function getCurrentDate() {
        var date = new Date();
        var year = date.getFullYear().toString();

        var month = date.getMonth() + 1;
        month = month < 10 ? '0' + month.toString() : month.toString();

        var day = date.getDate();
        day = day < 10 ? '0' + day.toString() : day.toString();
        /*
        var hour = date.getHours();
        hour = hour < 10 ? '0' + hour.toString() : hour.toString();

        var minites = date.getMinutes();
        minites = minites < 10 ? '0' + minites.toString() : minites.toString();

        var seconds = date.getSeconds();
        seconds = seconds < 10 ? '0' + seconds.toString() : seconds.toString();
        */
        return year + "/" + month + "/" + day;
    }
    var nowDate = getCurrentDate();
    $('input[name=nowDate]').attr('value', nowDate);
    /////////////////////////////

    //예약하기 버튼 클릭시 달력불러오기
   $(function () {
        var option = {
            // datepicker 애니메이션 타입
            // option 종류 : "show" , "slideDown", "fadeIn", "blind", "bounce", "clip", "drop", "fold", "slide"
            showAnim: "slideDown",
            // 해당 월의 다른 월의 날짜가 보이는 여부, 예를 들면 10월이면 전후에 9월 마지막과 11월의 시작 일이 보이는 여부입니다. 즉, 달력이 꽉 차 보이게 하는 것
            showOtherMonths: true,
            // 선택 여부 (showOtherMonths 옵션과 같이 일치시키지 않으면 에러가 발생합니다.)
            selectOtherMonths: true,
            // 달력 밑에 오늘과 닫기 버튼이 보인다.
            showButtonPanel: true,
            // 년 월이 셀렉트 박스로 표현 되어서 선택할 수 있다.
            changeMonth: true,
            changeYear: true,
            // 한번에 보이는 개월 수
            numberOfMonths: 2,
            // 데이터 포멧
            dateFormat: "yy-mm-dd",
            // 텍스트 박스 옆의 달력 포시
            showOn: "button",
            //이미지 타입인지 버튼 타입인지 설정
            buttonImageOnly: true,
            // 이미지 경로
            buttonImage: "https://jqueryui.com/resources/demos/datepicker/images/calendar.gif",
            // 버튼 타입이면 버튼 값
            buttonText: "Select date",
            // alt 데이터 포멧
            altFormat: "DD, d MM, yy",
            // 선택 가능한 날짜(수 형식) - 현재 기준 -20일
            minDate: 0,
            // 선택 가능한 최대 날짜(문자 형식) - 현재 기준 +1월 +20일
            maxDate: "+1M",
            // 주 표시
            showWeek: true
        };
        var optionFrom = option;
        optionFrom.altField = "#alternateFrom";
        var dateFormat = "mm/dd/yy";
        // 시작일이 선택이 되면 종료일은 시작일 보다 앞을 선택할 수 없다.
        var from = $("#from")
            .datepicker(optionFrom)
            .on("change", function () {
                to.datepicker("option", "minDate", getDate(this));
            });
        var optionTo = option;
        optionTo.altField = "#alternateTo";
        // 종료일이 선택이 되면 시작일은 시작일 보다 앞을 선택할 수 없다.
        var to = $("#to")
            .datepicker(optionTo)
            .on("change", function () {
                from.datepicker("option", "maxDate", getDate(this));
            });
        function getDate(element) {
            return moment(element.value).toDate();
        }

        //초기상태 - 판매폼만 보이는 상태
        //경매하단부분 숨겨져있음
        $("#saleForm").show();
        $("#communityForm").show();
        $("#tradeForm").hide();
        $("#reservForm").hide();
        $("#commuCategory").hide();
        
        //경매버튼클릭시
        $("#trade").click(function(){
            $("#tradeForm").show();
            $("#reservForm").hide();
            $("#commuCategory").hide();
        });

        //커뮤니티버튼 클릭시
        $("#community").click(function(){
            $("#tradeForm").hide();
            $("#saleForm").hide();
            $("#reservForm").hide();
            $("#commuCategory").show();
        });

        //판매버튼 클릭시
        $("#sale").click(function(){
            $("#tradeForm").hide();
            $("#saleForm").show();
            $("#reservForm").hide();
            $("#commuCategory").hide();
        });
        
        //경매폼에서 예약경매하기 버튼 클릭시
        $("#reservBtn").click(function(){
            $("#reservForm").toggle();
        })
    });






    
</script>
</html>