<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.gstatic.com">

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/415f6f6023.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>

    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/My-page-review.css">

	<meta charset="UTF-8">
	<title>어따세워? 리뷰작성</title>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div id="cntnr">
    	<div class="cntnr-top-margin"></div>
    	<p class="mp-title">리뷰 쓰기</p>
    	<!-- 각자의 파트는 이곳에서부터 작업하실 수 있습니다. -->
     	<form class="MpReview-arti" action="insert_review.do" method="post" onsubmit="return fnSubmit()">
     		<!-- rsv_id 값을 제대로 받았는지 확인하기 위해 임시로 넣은 input -->
     		<input name="rsv_id" value="${review.rsvVO.rsv_id}"/>
        	<p class="mp-rev-p-info mp-rev-date">이용시간&nbsp;&nbsp;:&nbsp;
				<fmt:formatDate value="${review.rsvVO.rsv_intime}" type="both" dateStyle="full"/>&nbsp;&nbsp;-&nbsp;
				<fmt:formatDate value="${review.rsvVO.rsv_outtime}" type="both" dateStyle="full"/><br>
			</p>
        	<p class="mp-rev-p-info mp-rev-p-title">${review.parkingVO.parking_title}</p>
         	<p class="mp-rev-p-info mp-rev-star-rate" date-rate="${review.review_rating}">평점&nbsp;&nbsp;${review.review_rating}
            	<input type="radio" name="review_rating" value="1" class="rtng" <c:if test="${review.review_rating eq '1'}">checked</c:if> id="rtng1" title="1"><label for="rtng1" class="starLabel"><i class="fas fa-star"></i></label>
            	<input type="radio" name="review_rating" value="2" class="rtng" <c:if test="${review.review_rating eq '2'}">checked</c:if> id="rtng2" title="2"><label for="rtng2" class="starLabel"><i class="fas fa-star"></i></label>
            	<input type="radio" name="review_rating" value="3" class="rtng" <c:if test="${review.review_rating eq '3'}">checked</c:if> id="rtng3" title="3"><label for="rtng3" class="starLabel"><i class="fas fa-star"></i></label>
            	<input type="radio" name="review_rating" value="4" class="rtng" <c:if test="${review.review_rating eq '4'}">checked</c:if> id="rtng4" title="4"><label for="rtng4" class="starLabel"><i class="fas fa-star"></i></label>
            	<input type="radio" name="review_rating" value="5" class="rtng" <c:if test="${review.review_rating eq '5'}">checked</c:if> id="rtng5" title="5"><label for="rtng5" class="starLabel"><i class="fas fa-star"></i></label>
        	</p>
        	<textarea name="review_content" value="${review.review_content}" id="" cols="60" rows="10" class="rev-ta" placeholder="부적절한 내용의 게시 혹은 올바르지 못한 내용 기재 시 해당 게시물은 사전경고 없이 삭제될 수 있습니다.&#13;&#10;이용하신 주차공간에 대한 소감을 남겨주세요."></textarea>
        	<!-- <input type="submit" name="" class="rev-btn" value="등록하기"> -->
        	<input type="button" name="" class="rev-btn" value="등록하기" onclick="checkWrt(this.form)">
    	</form>
    	<!-- 각자의 파트는 이곳까지 작업해주시면 되겠습니다. -->
   	</div>
	<jsp:include page="../tail.jsp"></jsp:include>
	
	<!-- <script>
		window.onload = function(){
			rating();
		}
		function rating(){
			var rateLabel = document.getElementsByClassName("starLabel");
			var change = document.getElementsByClassName("fa-star");
			
			for(let i=0; i<rateLabel.length; i++){
				rateLabel[i].onclick = function(){
					for(let j=0; j<=i; j++){
						change[j].setAttribute("style", "color:#e4c61c;");
					}
					for(let k=i+1; k<rateLabel.length; k++){
						change[k].setAttribute("style", "color:#ccc;");
					}
				}
			}
		}
	</script>
	<script>
		function checkWrt(v){
			var ratingScore = v.review_rating.value;
			var content = v.review_content.value;
			
			if(ratingScore.trim()==''){
				alert("별점을 선택해주세요.");
				return false;
			}
			if(content.trim()==''){
				alert("리뷰를 작성해주세요.");
				return false;
			}
			send
			v.submit();
		}
	</script>
	<script>
		function fnSubmit(){
			if(confirm("새 리뷰가 작성되었습니다.")){
				return true;
			}
			return false;
		}
	</script> -->
</body>
<script src="header_js.jsp"></script>
<script src="<%=request.getContextPath()%>/js/review_wrt_js.jsp"></script>
</html>