<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp"%>
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
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/My-page-review-list.css">
	
	<meta charset="UTF-8">
	<title>어따세워? 내가 쓴 리뷰 목록</title>
</head>
<body>
	<div id="cntnr">
        <div class="cntnr-top-margin"></div>
        <p class="mp-title">리뷰 관리</p>
        <!-- 각자의 파트는 이곳에서부터 작업하실 수 있습니다. -->
        <c:forEach var="review" items="${reviewList}">
        	<div class="MpRvL-arti">
        	
	            <div class="mp-rvl-first-flr">
	                <div class="mp-rvl-info">
	                	<form class="mp-rvl-form" action="../review_list.do">
		                	<!-- user_id 값을 제대로 받았는지 확인하기 위해 임시로 넣은 input -->
		                	<input type="hidden" class="key-rv-id" name="user_id" value="${review.user_id}"/>
		                    <p class="mp-rvl-p mp-rvl-title">
								<!-- 광장시장 근처 개인 주차공간 -->
								${review.parkingVO.parking_title}
							</p>
							<p class="mp-rvl-p mp-rvl-address">
		                    	<!-- 서울특별시 동작구 흑석동 184-19 -->
								${review.parkingVO.parking_location}
		                    </p>
		                    <p class="mp-rvl-p mp-rvl-date">
		                    	<strong>이용시간</strong><br>
								<fmt:formatDate value="${review.rsvVO.rsv_intime}" type="both" dateStyle="full"/> 부터<br>
								<fmt:formatDate value="${review.rsvVO.rsv_outtime}" type="both" dateStyle="full"/> 까지<br>
		                    </p>
							<p class="mp-rvl-p mp-rvl-rate" data-rate="${review.review_rating}">별점&nbsp;&nbsp;
								<input type="radio" name="review_rating" value="1" class="rtng" <c:if test="${review.review_rating eq '1'}">checked</c:if> id="rtng1" title="1"><label for="rtng1" class="starLabel"><i class="fas fa-star"></i></label>
				            	<input type="radio" name="review_rating" value="2" class="rtng" <c:if test="${review.review_rating eq '2'}">checked</c:if> id="rtng2" title="2"><label for="rtng2" class="starLabel"><i class="fas fa-star"></i></label>
				            	<input type="radio" name="review_rating" value="3" class="rtng" <c:if test="${review.review_rating eq '3'}">checked</c:if> id="rtng3" title="3"><label for="rtng3" class="starLabel"><i class="fas fa-star"></i></label>
				            	<input type="radio" name="review_rating" value="4" class="rtng" <c:if test="${review.review_rating eq '4'}">checked</c:if> id="rtng4" title="4"><label for="rtng4" class="starLabel"><i class="fas fa-star"></i></label>
				            	<input type="radio" name="review_rating" value="5" class="rtng" <c:if test="${review.review_rating eq '5'}">checked</c:if> id="rtng5" title="5"><label for="rtng5" class="starLabel"><i class="fas fa-star"></i></label>
							</p>
						</form>
					</div>
					<div class="mp-rvl-btns">
						<div class="mp-rvl-btn mp-rvl-btn-dlt"><a href="delete_review.do?review_id=${review.review_id}&${review.user_id}">삭제하기</a></div>
						<div class="mp-rvl-btn mp-rvl-btn-mdf"><a href="update_review_view.do?review_id=${review.review_id}">수정하기</a></div>
					</div>
					
				</div>   
				<div class="mp-rvl-cont">
					${review.review_content}
				</div>
			</div>
		</c:forEach>	

		<!-- 
		<div class="MpRsv-arti">2</div>
		<div class="MpRsv-arti">3</div>
		<div class="MpRsv-arti">4</div>
		 -->
		<!-- 각자의 파트는 이곳까지 작업해주시면 되겠습니다. -->
	</div>
	<jsp:include page="../tail.jsp"></jsp:include>
	<script>
		$(document).ready(function(){
			var rating = $('.mp-rvl-rate');
			
			rating.each(function(){
				var targetScore = $(this).attr('data-rate');
				console.log(targetScore);
				
				$(this).find('input:nth-child(-n+' + targetScore*2 +') + label i').css({color:"#e4c61c"});
				$(this).find('input:nth-child(n+' + targetScore*2 +') + label i').css({color:"#ccc"});
			});
		});
	</script>
	<script>
		function fnSubmit(){
			if(confirm("리뷰가 삭제되었습니다.")){
				return true;
			}
			return false;
		}
	</script>
</body>
</html>