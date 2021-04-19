<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
<fmt:formatDate var="rsvInDt" value="${rsvInfo.rsv_intime}" pattern="YYYY-MM-dd-HH-mm-ss"/>
<fmt:formatDate var="rsvOutDt" value="${rsvInfo.rsv_outtime}" pattern="YYYY-MM-dd-HH-mm-ss"/>
<form id = "form" method = "post" action="insertRsv.do">
<input type = "hidden" name = "parker_id" value = "${rsvInfo.parker_id}">
<input type = "hidden" name = "parking_id" value = "${rsvInfo.parking_id}" >
<input type = "hidden" name = "rsv_price" value = "${rsvInfo.rsv_price}" >
<input type = "hidden" name = "rsv_intime" id = "rsvIn" value = "${rsvInDt}">
<input type = "hidden" name = "rsv_outtime" id = "rsvOut" value = "${rsvOutDt}">
<script>
const str1 = $("#rsvIn").val();
const str2 = $("#rsvOut").val();
const strArr1 = str1.split('-');
const strArr2 = str2.split('-');
const date1 = new Date(strArr1[0], strArr1[1]-1, strArr1[2],strArr1[3],strArr1[4],strArr1[5]);
const date2 = new Date(strArr2[0], strArr2[1]-1, strArr2[2],strArr2[3],strArr2[4],strArr2[5]);
$("#rsvIn").attr("value",date1);
$("#rsvOut").attr("value",date2);

</script>
</form>

    <script>
    $(function(){
    	connect(); // 알림보내기위한 소켓 연결
       // var IMP = window.IMP; // 생략가능
        IMP.init('imp71028650'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;
        
        IMP.request_pay({
            pg : 'kakaopay',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : '어따세워 주차장 이용',
            amount : ${rsvInfo.rsv_price}
            //m_redirect_url : 'http://www.naver.com'
        }, function(rsp) {
            if ( rsp.success ) {
                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                jQuery.ajax({
                    url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        imp_uid : rsp.imp_uid
                        //기타 필요한 데이터가 있으면 추가 전달
                    }
                }).done(function(data) {
                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                    if ( everythings_fine ) {
                        msg = '결제가 완료되었습니다.';
                        msg += '\n고유ID : ' + rsp.imp_uid;
                        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                        msg += '\결제 금액 : ' + rsp.paid_amount;
                        msg += '카드 승인번호 : ' + rsp.apply_num;
                        
                        alert(msg);
                             // 만약 다른 주소로 전송 할 경우
                    } else {
                        //[3] 아직 제대로 결제가 되지 않았습니다.
                        //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                    }
                });
                //성공시 이동할 페이지
                 //document.getElementById("form").submit();
                send();
                $('#form').submit();

            } else {
                msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                //실패시 이동할 페이지
                location.href="<%=request.getContextPath()%>/searchParkingDetail.do?parking_id="+${rsvInfo.parking_id};
                alert(msg);
            }
        });
    });


    function noticeReservation(){
        notType="reservation";
        rsvId = 0;
        noticeParkingId = "${parkingId}";
        noticeUser = "${rsvInfo.parkingVO.owner_id}";
        notMessage = "\"" + "${parkingInfo.parking_title}" + "\"" + "글에 새로운 예약이 등록되었습니다."
        notUrl = "getRsvList_subscribe.do?parking_id=" + noticeParkingId;  //예약건 모아보는 페이지로 이동
    }

    function connect() {
        ws = new WebSocket("ws://localhost:9999/Where2Park/notice.do");
        noticeReservation();
        ws.onopen = onOpen;
        ws.onclose = onClose;
    }
    

    function disconnect() {
    onClose();
    }

    function send() {
    	console.log("======>알림보내는중!!");
        insertNotice();
        ws.send(JSON.stringify({ user_id: noticeUser, not_type: notType, rsv_id: rsvId, not_message: notMessage, not_url : notUrl }));
    }

    function onOpen() {
        console.log("======>Open Notification!!");
        var userId = "${userId}";
        ws.send(JSON.stringify({ user_id: userId, not_type: "test", not_message: " ,,, 알림 실험중.....!" }));
    }

    function onClose() {
        console.log("======>Close Notification!!");
        connect();
        console.log("======>Re-connection Notification")
    }

    function insertNotice() {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
                var data = xhr.responseText;
                console.log(data);
            }
        };
        console.log(rsvId + " : insertNotice ajax 실행중...");
        xhr.open("POST", "insertNotice.do", true);
        xhr.setRequestHeader("Content-type", "application/json");
        
        var jData = JSON.stringify({user_id:noticeUser, parking_id:noticeParkingId, rsv_id:rsvId, not_type:notType, not_message:notMessage, not_url:notUrl});
        console.log(notType);
        xhr.send(jData);
    }

    </script>
 
 
</body>
</html>
