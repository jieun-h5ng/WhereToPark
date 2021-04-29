<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ page import="java.util.List"%>
<%@ page import="com.where2park.biz.reservation.RsvVO"%>
<%@ page import="com.where2park.biz.reservation.impl.RsvDAOMybatis"%>
<%@ include file = "../header.jsp" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="css/My-page-reservation-detail.css">
    <title>Reservation DAO Test Page</title>

</head>

<body>
    <div id="cntnr">
        <div class="cntnr-top-margin"></div>
        <p class="mp-title">예약 보기</p>
        <div class="MpRsv-arti">
        <form action="updateRsv.do" method="post">
            <input name="rsv_id" type="hidden" value="${rsv.rsv_id}" />
             <input name="parker_id" type="hidden" value="${rsv.parker_id}" />
        <div class="rsv-detail"><a href="searchParkingDetail.do?parking_id=${rsv.parkingVO.parking_id}">  
         <div class="rsv_pic"><img src="images/${rsv.parkingVO.parking_pic}"/></div></a>
        <table id="rsv_info" border="0" cellpadding="10" cellspacing="10">
             
                <tr>
                    <!-- <td>파킹보드 제목</td> -->
                    <td align="left"><span style="font-weight:bold; font-size:16pt;">${rsv.parkingVO.parking_title}</span></td>
                </tr>
                <tr>
                    <!-- <td width="70">날짜</td> -->
                   <td align="left">대여일시: <fmt:formatDate var="rsvInDt" value="${rsv.rsv_intime}" pattern="YYYY-MM-dd HH:mm"/>${rsvInDt}</td>
                </tr>
                <tr>
                    <!-- <td>시간</td> -->
                    <td align="left">반납일시: <fmt:formatDate var="rsvOutDt" value="${rsv.rsv_outtime}" pattern="YYYY-MM-dd HH:mm"/>${rsvOutDt}</td>
                </tr>
           
  <c:choose>
  <c:when test="${'장기' eq rsv.parkingVO.parking_type}">
   <fmt:parseNumber value="${rsv.rsv_intime.time / (1000*60*60*24)}" integerOnly="true" var="strDate"/>
 <fmt:parseNumber value="${rsv.rsv_outtime.time / (1000*60*60*24)}" integerOnly="true" var="endDate"/>
                <tr>
                    <!-- <td>시간당 주차 요금</td> -->
                    <td align="left">1박 주차요금: ${rsv.parkingVO.parking_price} 원</td>
                </tr>`
                <tr>
                    <!-- <td>이용 시간</td> -->
                    <td align="left">이용기간: ${endDate-strDate} 일</td>
                </tr>
  </c:when>
    <c:when test="${'단기' eq rsv.parkingVO.parking_type}">
     <fmt:parseNumber value="${(rsv.rsv_intime.time / (1000*60))/60}" integerOnly="true" var="strDate"/>
 <fmt:parseNumber value="${(rsv.rsv_outtime.time / (1000*60))/60}" integerOnly="true" var="endDate"/>
                <tr>
                    <!-- <td>시간당 주차 요금</td> -->
                    <td align="left">시간 당 주차요금: ${rsv.parkingVO.parking_price} 원</td>
                </tr>
                <tr>
                    <!-- <td>이용 시간</td> -->
                    <td align="left">이용시간: ${endDate-strDate} 시간</td>
                </tr>
  </c:when>
  </c:choose>
                <tr>
                    <!-- <td>결제 금액</td> -->
                    <td align="left">총 예약 요금: ${rsv.rsv_price} 원</td>
                </tr>

            </table> 
            </div>
<div id="optional-info">
<details>
    <summary><h1>▶ 이용자 및 차량정보</h1></summary>

    <h2>닉네임</h2>
    <input class="rsv-info" type="text" readonly value="${rsv.userVO.user_nickname}"><br>
    <h2>전화번호</h2>
    <input class="rsv-info" type="text" value="${rsv.userVO.user_phone}"><br>
    <h2>차종</h2>
    <input class="rsv-info radio" type="radio" name="car_type" id="c1" value="대형 " <c:if test="${rsv.userVO.car_type eq '대형'}"> checked </c:if> /> <label for="c1">대형</label> 
    <input class="rsv-info radio" type="radio" name="car_type" id="c2" value="중형 " <c:if test="${rsv.userVO.car_type eq '중형'}"> checked </c:if> /> <label for="c2">중형</label> 
    <input class="rsv-info radio" type="radio" name="car_type" id="c3" value="준중형" <c:if test="${rsv.userVO.car_type eq '준중형'}"> checked </c:if> /> <label for="c3">준중형</label> 
    <input class="rsv-info radio" type="radio" name="car_type" id="c4" value="경차   " <c:if test="${rsv.userVO.car_type eq '경차'}"> checked </c:if> /> <label for="c4">경차</label> 
    <input class="rsv-info radio" type="radio" name="car_type" id="c5" value="기타   " <c:if test="${rsv.userVO.car_type eq '기타'}"> checked </c:if> /> <label for="c5">기타</label>
    
    <h2>차번호</h2>
    <input class="rsv-info" type="text" id = "car_num" name = "car_num" value="${rsv.userVO.car_num}" placeholder="띄어쓰기 없이 입력하세요" onchange="carnumchk()"><br>

</details>
</div>

<script>
<c:if test = "${rsv.parkingVO.owner_id eq userId}">
  var inputs = document.getElementsByClassName("rsv-info");
  for(var i =0; i<inputs.length; i++){
    //   예약자인 경우에만 정보 수정 가능
      inputs[i].disabled = true;
  }
  </c:if>

   function carnumchk(){
      
           var num= $("#car_num").val();
           //console.log(num);
           var pattern1 = /\d{2}[가-힣ㄱ-ㅎㅏ-ㅣ\x20]\d{4}$/g  // 12저1234
           var pattern2 = /\d{3}[가-힣ㄱ-ㅎㅏ-ㅣ\x20]\d{4}$/g  // 123저1234
           //var pattern2 = /[가-힣ㄱ-ㅎㅏ-ㅣ\x20]{2}\d{2}[가-힣ㄱ-ㅎㅏ-ㅣ\x20]\d{4}/g; // 서울12치1233
   
           if (pattern1.test(num) || pattern2.test(num)) {
               alert(num + "차량번호 형식이 맞습니다")
               console.log(num)
           }
           else if(!pattern1.test(num) || pattern2.test(num)) {
               alert("차량번호 형식이 맞지 않습니다.")
               console.log(num)
           }
         
   }
</script>

<div id="btns">
    <input class="rsv_btn" type="submit" value="예약자 정보 수정하기" />  <input class="rsv_btn" type="button" value = "예약 내역으로 돌아가기" onclick="location.href='getRsvList.do'"><!--예약업데이트가 아니라 회원정보가 업뎃되는거아님?-->
</div>
        </form>
        </div>

        <!-- 
        <a href="deletersv.do?id=${rsv.rsv_id}">예약 취소</a>&nbsp;&nbsp;&nbsp;
        <a href="javascript:history.back();">예약 내역으로 돌아가기</a>
        <a href="getRsvList.do">예약 내역으로 돌아가기</a>
         -->
    </div>
    <hr>

</body>
<%@ include file = "../tail.jsp" %>
</html>