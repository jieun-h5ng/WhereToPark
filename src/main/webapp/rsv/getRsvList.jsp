<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.where2park.biz.reservation.RsvVO"%>
<%@ page import="com.where2park.biz.reservation.impl.RsvDAOMybatis"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.gstatic.com">

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/415f6f6023.js" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>


<link rel="stylesheet" type="text/css" href="css/My-page-reservation.css">

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/My-page-reservation.css">

<title>어따세워: 예약 내역</title>
<style>
#noRsv{
      background-image: url('<%=request.getContextPath()%>/images/error-bg.png');
      margin: 0 10% 0 10%;
       width : 80%;
       height : 500px;
       background-size: 1800px 1000px; /*창크기에 따라 같이 움직이게 해주는 속성(여백없음), contain은 여백있이 */
       background-position: center center;
   }
#noRsv_text{
text-align: center;
    font-size: 22px;
    font-weight: 400;
    opacity: 0.7;
    padding-top: 400px;
      
   }
</style>
</head>

<body>
   <div id="cntnr">
      <div class="cntnr-top-margin"></div>
      <p class="mp-title">예약 내역</p>
      <!-- 각자의 파트는 이곳에서부터 작업하실 수 있습니다. -->
      <c:if test="${RsvList[0].parkingVO.parking_title eq null}">
  
            <div id = noRsv>
               <p id="noRsv_text">예약한 주차장이 없습니다. 주차장을 예약해주세요🙂</p>
               </div>

      </c:if>
      <c:forEach var="rsv" items="${RsvList}" varStatus="status">
         <div class="MpRsv-arti">
            <a href="getRsv.do?rsv_id=${rsv.rsv_id}">
               <div class="mp-rsv-info">
                  <p class="mp-rsv-p mp-rsv-title">
                     ${rsv.parkingVO.parking_title}
                  </p>
                  <p class="mp-rsv-p mp-rsv-address">
                     ${rsv.parkingVO.parking_location}
                  </p>
                  
                  <p class="mp-rsv-p mp-rsv-date">
                     <fmt:formatDate var="rsvInDt" value="${rsv.rsv_intime}" pattern="MM월 dd일  HH시 mm분  " />
                     ${rsvInDt} <span style="color: blue;">대여</span>
                  </p>
                  <p class="mp-rsv-p mp-rsv-time">
                     <fmt:formatDate var="rsvOutDt" value="${rsv.rsv_outtime}" pattern="MM월 dd일  HH시 mm분 " />
                     ${rsvOutDt} <span style="color: red;">반납</span>
                  </p>
               <span style="font-size:smaller;">${rsv.parkingVO.parking_location}</span></p>
              
<fmt:formatDate var="checkInDt" value="${rsv.rsv_intime}" pattern="yyyy-MM-dd"/>
            </div></a>
            <!--알림보내기위해서 값 전달-->
            <input type="hidden" id=nRsvId${status.index} value="${rsv.rsv_id}" />
            <input type="hidden" id =nParkingId${status.index} value="${rsv.parkingVO.parking_id}" />
            <input type="hidden" id =nParkingTitle${status.index} value="${rsv.parkingVO.parking_title}" />
            <input type="hidden" id =nNoticeUserId${status.index} value="${rsv.parkingVO.owner_id}" />
            <div class="mp-rsv-btns">
<c:choose>
<c:when test="${rsv.rsv_states eq 0 }">
               <a href="javascript:beforeDelete('${checkInDt}',${rsv.rsv_id},nRsvId${status.index}, nParkingId${status.index}, nNoticeUserId${status.index}, nParkingTitle${status.index})">
               <div class="mp-rsv-btn mp-rsv-btn-cancle">예약 취소하기</div></a>
               <div class="mp-rsv-btn mp-rsv-btn-chat">
               <a href="chatroom.do?rsv_id=${rsv.rsv_id}&parker_id=${rsv.parker_id}" onClick="window.open(this.href, '', 'width=350, height=400, status=no, toolbar=no, scrollbars=no, location=no'); return false;">
                  상담하기&nbsp;<span style="background-color: #367FFF; border-radius: 50%; font-size: 0.92em; color: white; padding: 0 2px 4px 2px; box-shadow: 1px 1px 1px rgba(0, 0, 0, 0.5);" id="chatCnt">&nbsp;&nbsp;${noRead[status.index]}&nbsp;&nbsp;</span></a>
               </div>
   </c:when>
   <c:when test="${rsv.rsv_states eq 1 }">
               <div class="mp-rsv-btn mp-rsv-btn-cancle">예약 진행중</div>
               <div class="mp-rsv-btn mp-rsv-btn-chat">
               <a href="chatroom.do?rsv_id=${rsv.rsv_id}&parker_id=${rsv.parker_id}" onClick="window.open(this.href, '', 'width=350, height=400'); return false;">
                  상담하기&nbsp;<span style="background-color: #367FFF; border-radius: 50%; font-size: 0.92em; color: white; padding: 0 2px 4px 2px; box-shadow: 1px 1px 1px rgba(0, 0, 0, 0.5);" id="chatCnt">&nbsp;&nbsp;${noRead[status.index]}&nbsp;&nbsp;</span></a>
               </div>
   </c:when>
      <c:when test="${rsv.rsv_states eq 2 && rsv.parkingVO.owner_id ne userId}">
               <a href="review_wrt.do?rsv_id=${rsv.rsv_id}"><div class="mp-rsv-btn mp-rsv-btn-wrtreivew">
               리뷰 쓰기
               </div></a>
   </c:when>
   <c:otherwise><div class="mp-rsv-btn mp-rsv-btn-wrtreivew" style="width:270px">이용완료된 예약입니다</div></c:otherwise>   
</c:choose>

            </div>
         </div>
         
      </c:forEach>
     <script>

     function beforeDelete(date,id,nRsvId,nParkingId,nNoticeUserId,nParkingTitle){
     var result = confirm("예약을 취소하시겠습니까?");
     if(result){// 예
        var d_day = new Date(date);
        var today =new Date();
     var gap = d_day.getTime()-today.getTime();
     var min = gap/1000/60;
     
        if(min <= 60){
           alert("예약 1 시간 전부터는 취소가 불가능합니다");
           return false;
       }
        //날짜 확인
        else{
           getRsvDelete(nRsvId,nParkingId,nNoticeUserId,nParkingTitle);
           console.log("된다고");
           location.href="deleteRsv.do?rsv_id="+id;
           
        }
         
     }else{//아니오
         return false;
     }
     }
     </script>

   </div>
</body>
<script src="header_js.jsp"></script>
<%@ include file="../tail.jsp"%>
</html>