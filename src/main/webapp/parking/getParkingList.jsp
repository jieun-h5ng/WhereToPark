<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>

<!DOCTYPE html>
<html>

<head>
<script src="js/jquery-1.12.4.min.js"></script>
<meta charset="UTF-8">
<title>글목록</title>
<style>
/*마진*/
#cntnr .border-margin {
	width: 100%;
	height: 40px;
}

/*설정*/
img{
	width: 200px;
	height: 150px;
	cursor: pointer;
	
}

#cntnr .border {
	width: 100%;
	height: 170px;
	box-sizing: border-box;
	margin: 0 0 30px 0;
	padding: 10px 10px 10px 10px;
	border:1px solid #ccc;
	/*cursor: pointer;*/
	position: relative;
}
#pic_box{
	width: 200px;
	height: 150px;
	/*background-color : green;*/
	float: left;
	margin : auto 10px auto 5px;
	/*box-sizing: border-box;*/
}
#cntnr #border-info {
	width: 350px;
	height: 150px;
	/*background-color : pink;*/
	float: left;
}

#cntnr .border-btn {
	height: 70px;
	width: 300px;
	/*background-color : yellow;*/
	float: right;
}

#cntnr .border-btn #border-btn-detail {
	/*background-color :#ccc; */
	width: 250px;
	height: 50px;
	text-align: right;
	z-index: 999;
	float: right;
	position: relative;
	
}
#two_btn{
	/*background-color :white; */
	width: 300px;
	height: 100px;
	float: right;
	margin: -20px -30px 0 0;
	z-index:-99;
}

#cntnr .border-btn #border-btn-res {
	clear: both;
	border: solid 1px 367FFF;
	width: 30%;
	height: 35px;
	background-color: #367FFF;
	color: #fff;
	float: left;
	text-align: center;
	border-radius: 5px 5px 5px 5px;
	line-height: 33px;
	margin-top: 10%;
}

#cntnr .border-btn #border-btn-upd {
	border: solid 1px 367FFF;
	width: 30%;
	height: 35px;
	background-color: #367FFF;
	color: white;
	float: left;
	text-align: center;
	border-radius: 5px 5px 5px 5px;
	margin-left: 7%;
	line-height: 33px;
	margin-top: 10%;
}
#cntnr .border-btn #border-btn-ori {
	border: solid 1px 367FFF;
	width: 50%;
	height: 35px;
	background-color: #367FFF;
	color: white;
	float: left;
	text-align: center;
	border-radius: 5px 5px 5px 5px;
	margin-left: 15%;
	line-height: 33px;
	margin-top: 17%;
}

#notice-title {
	font-size: 1.5em;
}
/*
.menu a {
	cursor: pointer;
	text-decoration: none;
}
*/
.menu .hide {
	display: none;
}

ul.hide {
	width: 100%;
	float: right;
	clear: both;
	list-style: none;
}


.menu {
	list-style: none;
	/* float: right; */
}

.menu a {
	text-align: right;
}

.sub_menu {
	background-color: white;
	color: black;
	float: left;
	border: solid 1px #367FFF;
	width: 80px;
	height: 26px;
	border-radius: 3px 3px 3px 3px;
	cursor: pointer;
	margin-left: 5%;
	text-align: center;
	z-index: 9999;
	
}

a {
	text-decoration: none
}

#border-btn-res a:hover {
	cursor: pointer;
}
#border-btn-upd a:hover {
	cursor: pointer;
}
#border-btn-ori a:hover {
	cursor: pointer;
}
/*글자모양*/
#border-title {
	font-weight: 500;
	font-size : 20px;
	
}
#border-type {
	font-weight: 400;
	font-size : 16px;
}
#border-loc{
	font-weight: 450;
	font-size : 18px;
	margin : 10px 0 3px 0;
}

.title-header{
	font-size:2em;
    text-align:center;
    font-weight:400;
    padding:0 0 20px 0;
	
	

}
</style>


<script>

	$(document).ready(function() {
		console.log("ready")
		clickshow();
		
	})
	
	// 내리기 , 삭제 버튼 보이기
	function clickshow() {
		$(".menu>a").click(function() {
			$(this).next("ul").toggleClass("hide");
		})
	}
	
	// 삭제버튼시 한번더 확인, 예약시 삭제불가
	function clickdelete(parking_id){
		$.ajax({
    		url : "/Where2Park/deleteParking.do",
    		type : "post",
    		data : {"parking_id" : parking_id},
			success : function(data){
				console.log(data)
				if(data > 0){
					alert("예약되어 있는 게시글은 삭제 불가능합니다.");
				}else {
					var chk = confirm("정말 삭제하시겠습니까? 삭제시 게시글과 관련된 모든정보가 삭제됩니다.")
					if(chk){
						location.href="updateParking_deleted.do?parking_id=" + parking_id;
					}
				}
			}
    	})
	}
	// 내리기버튼시 한번더 확인
	function clickdown(parking_id){
		var chk = confirm("게시글을 내리시겠습니까?")
		if(chk){
			location.href="updateParking_down.do?parking_id=" + parking_id;
		}
	}
	
</script>

</head>

<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div id="cntnr">
		<div class="border-margin"></div>
		<!-- 
		${userNickName} 님!
		${userId} - 세션에 담겨있는 유져아이디, 
		 -->
		
		
		<div class="title-header">공 유 내 역</div>
		
		<div class="full_box">
		
		<c:forEach var="parking" items="${parkingList}">
			<c:if test="${parking.parking_deleted eq '0'}">
				
				<div class="border">
					<div id="pic_box">
						<a href="searchParkingDetail.do?parking_id=${parking.parking_id }">
							<img src="images/${parking.parking_pic}" id="img"  >
						</a>
					
					</div>
					<div id="border-info">
						<p id="border-title"> ${parking.parking_title}  </p>
						
						<p id="border-loc"> ${parking.parking_location } </p> 
						<p><span id="border-type"> ${parking.parking_type }</span> 주차 </p> 
						<!-- 
						시간 : ${parking.parking_intime } ~ ${parking.parking_outtime } </br>
						 -->
						<c:if test="${parking.parking_type eq '단기'}"> 
							<c:set var = "string1" value = "${parking.parking_intime }"/>
							<c:set var = "string2" value = "${parking.parking_outtime }"/>
							${fn:substring(string1, 0, 16)} ~ ${fn:substring(string2, 11, 16)} 
							<br>
							 ${parking.parking_price }원 (시간당) <br>
						</c:if>
						<c:if test="${parking.parking_type eq '장기'}"> 
							<c:set var = "string3" value = "${parking.parking_intime }"/>
							<c:set var = "string4" value = "${parking.parking_outtime }"/>
							 ${fn:substring(string3, 0, 10)} ~ ${fn:substring(string4, 0, 10)} 
							<br>
							${parking.parking_price }원 (하루) <br>
						</c:if>
						
						
					</div>
					<div class="border-btn">



						<div id="border-btn-detail">
							<li class="menu"><a href="javascript:void(0);">▪▪</a>
								<ul class="hide">
									<li>
										<input type="button" value="글 내리기" class="sub_menu" onclick="clickdown(${parking.parking_id })">
									</li>
									<li>
										<input type="button" value="삭제하기" class="sub_menu" onclick="clickdelete(${parking.parking_id })">
									</li>
								</ul>
							</li>
						</div>


						<div id="two_btn">
							<div id="border-btn-res">
								<a href="#" style=color:white>예약보기</a>
							</div>
							<div id="border-btn-upd">
								<!-- 
								 <a href="getParking.do?parking_id=${parking.parking_id }">수정하기</a>
								 -->
								 <c:choose>
									<c:when test="${parking.parking_type eq '단기'}">
										<a href="shortgetParking.do?parking_id=${parking.parking_id }" style=color:white>수정하기</a>
									</c:when>
									<c:when test="${parking.parking_type eq '장기'}">
										<a href="longgetParking.do?parking_id=${parking.parking_id }" style=color:white>수정하기</a>
									</c:when>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</c:if>
		</c:forEach>
	</div>
		<div class="border-margin"></div>
		<div class="border-margin"></div>
		<div class="border-margin"></div>
		<div class="title-header">내 린 글</div>
		
		<c:forEach var="parking" items="${parkingList}">
			<c:if test="${parking.parking_deleted eq '1'}">
				<div class="border">
					<div id="pic_box">
						<img src="images/${parking.parking_pic}" id="img"  >
					</div>
					<div id="border-info" style=color:gray;>
						<p id="border-title" style=color:gray;> ${parking.parking_title}  </p>
						
						<p id="border-loc" style=color:gray;> ${parking.parking_location } </p> 
						<p><span id="border-type" style=color:gray;> ${parking.parking_type }</span > <span style=color:gray;>주차</span> </p> 
						<!-- 
						시간 : ${parking.parking_intime } ~ ${parking.parking_outtime } </br>
						 -->
						<c:if test="${parking.parking_type eq '단기'}"> 
							<c:set var = "string1" value = "${parking.parking_intime }"/>
							<c:set var = "string2" value = "${parking.parking_outtime }"/>
							${fn:substring(string1, 0, 16)} ~ ${fn:substring(string2, 11, 16)} 
							<br>
							 ${parking.parking_price }원 (시간당) <br>
						</c:if>
						<c:if test="${parking.parking_type eq '장기'}"> 
							<c:set var = "string3" value = "${parking.parking_intime }"/>
							<c:set var = "string4" value = "${parking.parking_outtime }"/>
							 ${fn:substring(string3, 0, 10)} ~ ${fn:substring(string4, 0, 10)} 
							<br>
							${parking.parking_price }원 (하루) <br>
						</c:if>
						
						
					</div>
					<div class="border-btn">
						<div id="border-btn-ori">
						
								<c:choose>
									<c:when test="${parking.parking_type eq '단기'}">
										<a href="shortgetParking.do?parking_id=${parking.parking_id }" style=color:white>다시공유하기</a>
									</c:when>
									<c:when test="${parking.parking_type eq '장기'}">
										<a href="longgetParking.do?parking_id=${parking.parking_id }" style=color:white>다시공유하기</a>
									</c:when>
								</c:choose>
						
							<!-- 
							 <a href="updateParking_ori.do?parking_id=${parking.parking_id }" style=color:white>다시공유하기</a>
							 -->
						</div>

					</div>
				</div>
				</c:if>
		</c:forEach>


		<!-- 각자의 파트는 이곳까지 작업해주시면 되겠습니다. -->
	</div>
	<jsp:include page="../tail.jsp"></jsp:include>
</body>

</html>