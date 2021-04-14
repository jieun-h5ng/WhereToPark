<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ include file="../header.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" type="text/css" href="css/selectParkingStyleSheet.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
        rel="stylesheet">
    <title>주차장 상세 페이지</title>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>

<body>
    <div id="cntnr">
        <!-- 각자의 파트는 이곳에서부터 작업하실 수 있습니다. -->
        <div class="cntnr-top-margin"></div>
        <div class="segment pk-pic"
            style="background-image: url(https://t1.daumcdn.net/liveboard/ziptoss/355ea8e39d074021a8aaf2482d5ab93d.JPG);">

        </div>
        <div class="segment pk-content">
            <div class="pk-info">
                <h1>(삼각지역 도보 4분) ${p_detail.parking_title}</h1>
                <hr>
                <p>위치 정보 : 서울시 용산구 갈월동 241-1 ${p_detail.parking_location}</p>
                <p>주차 가능 차종 : ${p_detail.parking_cartype}</p>
                <p>체크인 오후 12시 부터, 체크 아웃은 꼭 오전 10시 이전에 해주셔야합니다 (주인이 출근해요!)<br />가로 폭은 넓은데 앞뒤 공간이 넓지 않아요. 대형은 주차시 주의
                    요망합니다. ${p_detail.parking_content}</p>


            </div>
            <div class="segment pk-condition">
               <c:forEach var="rsv" items="${booked}">
               <p><fmt:formatDate var="rsvInDt" value="${rsv.rsvVO.rsv_intime}"
							pattern="YYYY-MM-dd HH:mm:ss"/>
						${rsvInDt} - <fmt:formatDate var="rsvOutDt" value="${rsv.rsvVO.rsv_outtime}"
							pattern="YYYY-MM-dd HH:mm:ss"/>${rsvOutDt}</p>
                </c:forEach>
                <div class="pk-price" style="font-size: larger; font-weight: 500;">
                   ${p_detail.parking_price}<span style="font-size: small; font-weight: 300;"> 원/시간</span>
                </div>
                <div class="pk-pickday">

                    <input type="button" value="시작날짜" id="sdate" />
                    <input type="button" value="종료날짜" id="edate" />
                    <script>
//disabledDays에 rsv, parking 조인해서 예약된 날짜 보면 되겠네
                        var disabledDays = ['2021-3-29', '2021-3-30', '2021-3-15'];

                        function disableAllTheseDays(date) {
                            var m = date.getMonth() + 1;
                            var d = date.getDate();
                            var y = date.getFullYear();
                            for (i = 0; i < disabledDays.length; i++) {
                                if ($.inArray(y + '-' + m + '-' + d, disabledDays) != -1) {
                                    return [false];
                                }
                            }
                            return [true];
                        }

                        $.datepicker.regional['ko'] = {
                            dateFormat: 'yy-mm-dd',
                            prevText: '< prev',
                            nextText: 'next >',
                            monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                            monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                            dayNames: ['일', '월', '화', '수', '목', '금', '토'],
                            dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
                            dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
                            showMonthAfterYear: true,
                            changeMonth: false,
                            changeYear: false,
                            yearSuffix: ' - ',
                            minDate: "0d",
                            maxDate: "+1m",
                            beforeShowDay: disableAllTheseDays,
                        }
                        $.datepicker.setDefaults($.datepicker.regional['ko']);

                        $('#edate').datepicker();
                        if ($("#sdate").val() == "") {
                            $('#edate').datepicker("option", "minDate", "0d");
                        } else
                            $('#edate').datepicker("option", "minDate", $("#sdate").val());
                        $('#edate').datepicker("option", "onClose", function (selectedDate) {
                            $("#sdate").datepicker("option", "maxDate", selectedDate);
                        });

                        $("#sdate").datepicker();
                        $('#sdate').datepicker("option", "maxDate", $("#edate").val());
                        $('#sdate').datepicker("option", "onClose", function (selectedDate) {
                            $("#edate").datepicker("option", "minDate", selectedDate);
                        });

                    </script>
                </div>
                <div class="pk-total-price">
                    ${p_detail.parking_price} 원 X 0 시간 = <span style="font-size: larger; font-weight: 500;"> 00,000원</span>
                </div>
                <div class="pk-btn">
                    <button type="submit" id="pk-book-btn">주차 예약하기</button>
                </div>
            </div>


        </div>
        <div class="segment pk-location">
            <h1 class="pk-subject"> 위치</h1>
            <div class="search-map">
                <div id="map" style="width:100%;height:100%;"></div>

                <script type="text/javascript"
                    src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=8bc49bed18e50dd654165896729f2ea4"></script>
                <script>
                    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                        mapOption = {
                            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                            level: 3 // 지도의 확대 레벨
                        };

                    var map = new kakao.maps.Map(mapContainer, mapOption);

                    // 마커가 표시될 위치입니다 
                    var markerPosition = new kakao.maps.LatLng(33.450701, 126.570667);

                    // 마커를 생성합니다
                    var marker = new kakao.maps.Marker({
                        position: markerPosition
                    });

                    // 마커가 지도 위에 표시되도록 설정합니다
                    marker.setMap(map);

                    var iwContent = '<div style="padding:5px;">Hello World! <br><a href="https://map.kakao.com/link/map/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/Hello World!,33.450701,126.570667" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
                        iwPosition = new kakao.maps.LatLng(33.450701, 126.570667); //인포윈도우 표시 위치입니다

                    // 인포윈도우를 생성합니다
                    var infowindow = new kakao.maps.InfoWindow({
                        position: iwPosition,
                        content: iwContent
                    });

                    // 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
                    infowindow.open(map, marker); 
                </script>
            </div>


        </div>
        <div class="segment pk-review">
            <h1 class="pk-subject"> 후기</h1>
            <table id="rv-table" width=100%>
                <thead>
                    <tr>
                        <th style="text-align: right;">별점 ⭐⭐⭐⭐ <span style="font-size: 25pt; font-weight: 500;">3.9</span></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <table class ="rv-indiv">
                                <tr>
                                    <td class='rv-pic'><img src="images/UserProfile.png"/></td>
                                    <td>
                                        닉네임<br>
                                        방문날짜
                                    </td>
                                <tr>
                                    <td colspan="2">후기</td>
                                </tr>
                        </td>
                    </tr>

            </table>
            </td>
            </tr>
            <tr>
                <td>
                    <table class ="rv-indiv">
                        <tr>
                            <td class='rv-pic'><img src="images/UserProfile.png"/></td>
                            <td>
                                닉네임<br>
                                방문날짜
                            </td>
                        <tr>
                            <td colspan="2">후기</td>
                        </tr>
                </td>
            </tr>

            </table>
            </td>
            </tr>
            <tr>
                <td>
                    <table class ="rv-indiv">
                        <tr>
                            <td class='rv-pic'><img src="images/UserProfile.png"/></td>
                            <td>
                                닉네임<br>
                                방문날짜
                            </td>
                        <tr>
                            <td colspan="2">후기</td>
                        </tr>
                </td>
            </tr>

            </table>
            </td>
            </tr>
            </tbody>
            </table>
            <nav>
                <ul class="paging">
                  <li><a href="#"><span aria-hidden="true">«</span><span class="sr-only">Previous</span></a></li>
                  <li><a href="#">1</a></li>
                  <li><a href="#">2</a></li>
                  <li><a href="#">3</a></li>
                  <li><a href="#">4</a></li>
                  <li><a href="#">5</a></li>
                  <li><a href="#"><span aria-hidden="true">»</span><span class="sr-only">Next</span></a></li>
                </ul>
              </nav>
        </div>
        <div class="segment pk-recommendation">
            <h1 class="pk-subject"> 이 주차장도 추천해요 !</h1>
        </div>
        <!-- 각자의 파트는 이곳까지 작업해주시면 되겠습니다. -->
    </div>
    <div id="ftr">
        <div class="wrapper">
            <div id="ftr-nav">
                <ul>
                    <li><a href="#">이용약관</a></li>
                    <li><a href="#">회사소개</a></li>
                    <li><a href="#">개인정보 처리방침</a></li>
                    <li><a href="#">위치기반 서비스 이용약관</a></li>
                    <li><a href="#">안심운영정책</a></li>
                </ul>
            </div>
            <div class="ftr-arti">
                <p>｜ 상호 : ㈜어따세워 ｜ 대표 : 문상환 ｜ 사업자등록번호 : 210-42-10003<br> ｜ 주소 : 서울특별시 마포구 신수동 63-14 거구장 지층 비트캠프 신촌센터
                    5호<br> ｜ 전화 : 02-3486-9600 ｜ 팩스 : 02-6007-1245 ｜ 통신판매업 신고번호 : 제 서초-00098호</p>
                <p>Copyright © 어따세워. All Rights Reserved.</p>
            </div>
        </div>
    </div>
</body>
<%@ include file="../tail.jsp" %>
</html>