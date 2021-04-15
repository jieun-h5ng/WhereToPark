	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ page import="java.util.List" %>
	<%@ page import="com.where2park.biz.parking.ParkingVO" %>
	<%@ page import="com.where2park.biz.parking.impl.ParkingDAOMybatis" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
	<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
	<%@include file='../header.jsp' %>
	<!DOCTYPE html>
	<html lang="en">

	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="css/SearchParkingStyleSheet.css" rel="stylesheet" type="text/css" >
		<link
			href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
			rel="stylesheet">
		<title>단기주차 검색하기</title>
		<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
		<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<link rel="stylesheet" href="css/jquery.timepicker.min.css">
		
	</head>
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
	<body>
		<div id="cntnr" style="width: 100%;">
			<div class="search-bar">
				<div class="search-condition">
					<input type="text" placeholder="검색어를 입력해주세요" id="keyword" />
					<button type="button" id="search-btn">검색</button>

				<script type="text/javascript"
					src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=8bc49bed18e50dd654165896729f2ea4"></script>
					<script>
					var a_positions = [];
					var isfirst = true;
					var markers=[];
					var infowindows=[];
						$(document).on('click', '#search-btn', function (e) {
								isfirst = false;
							var form = {
								area: $("#district").val(),
								keyword: $("#keyword").val(),
								sdate: $("#sdateVal").val(),
								stime: $("#sTimeVal").val(),
								price: $("#slider").val(),
								area: $("#district").val()
							};
							$.ajax({
								type: "post",
								url: "searchShortParkingList.do",
								dataType: "json",
								contentType: "application/x-www-form-urlencoded; charset=UTF-8",
								data: form,
								async: false,
								success: function (result) {
									//var SP_list = JSON.parse(result);
									console.log(result);
									var obj = result.title;
									var list = $(".search-result-list");
									list.empty();
									
									obj.forEach(element => {
										var txt = "<a href='searchParkingDetail_short.do?parking_id=" + element.parking_id + "'><table class='parking-lot' border='1'>"

										txt += "<tr><td><img id='pkpic'src='images/" + element.parking_pic + "'/></td></tr>"
										+ "<tr><td>" + element.parking_title + "</td></tr>"
										+ "<tr><td>" + element.parking_location + "</td></tr>"	
										+ "<tr><td> " + element.parking_type + "</td></tr>"
										+ "<tr><td>예약시작: " + element.parking_intime + "</td></tr>"
										+ "<tr><td>1시간 " + element.parking_price + "원</td></tr>";
										list.append(txt);
										
									});
									//지도 갱신
									markers.forEach(element => { //마커지우기
										element.setMap(null);
									});
									infowindows.forEach(element => { //인포윈도우 지우기
										element.setMap(null);
									});
									a_positions.length=0; // 이전 검색결과 배열 초기화
									
									if(obj!=null)
										{var locPosition = new kakao.maps.LatLng(obj[0].parking_lat, obj[0].parking_lng);}
									else{ var locPosition = new kakao.maps.LatLng(33.450701, 126.570667)}

									obj.forEach(element => {
										
										var place = {content :'<div>'+ element.parking_title+'<div>', latlng: new kakao.maps.LatLng(element.parking_lat,element.parking_lng)};
										a_positions.push(place);
										
									});
									displayMarker(locPosition, a_positions);
									
								}
							});
						});

					</script>

				</div>
				<div class="search-condition">
					<select id="district" name="area">
					<option value="">전체지역</option>
						<option value="강남">강남구</option>
						<option value="강동구">강동구</option>
						<option value="강서">강서구</option>
						<option value="강북">강북구</option>
						<option value="관악">관악구</option>
						<option value="강서">광진구</option>
						<option value="구로">구로구</option>
						<option value="금천">금천구</option>
						<option value="노원">노원구</option>
						<option value="도봉">도봉구</option>
						<option value="동대문">동대문구</option>
						<option value="동작">동작구</option>
						<option value="마포">마포구</option>
						<option value="서대문">서대문구</option>
						<option value="서초">서초구</option>
						<option value="성동구">성동구</option>
						<option value="성북">성북구</option>
						<option value="송파">송파구</option>
						<option value="양천">양천구</option>
						<option value="영등포">영등포구</option>
						<option value="용산">용산구</option>
						<option value="은평">은평구</option>
						<option value="종로">종로구</option>
						<option value="중구">중구</option>
						<option value="중랑">중랑구</option>
					</select>
				</div>
				<div class="search-condition">
					<input type="hidden" id="sdateVal" name="sdate" />
					<input type="button" value="주차날짜" id="sdate" />
					<input type="button" value="주차시간" class="hasTimepicker" id="sTime" />
					<input type="hidden" value="" name="stime" id = "sTimeVal"/>
					<script>
						$("#sdate").datepicker(
							{
								dateFormat: 'yy-mm-dd',
								prevText: '< prev',
								nextText: 'next >',
								monthNames: ['1월', '2월', '3월', '4월',
									'5월', '6월', '7월', '8월', '9월',
									'10월', '11월', '12월'],
								monthNamesShort: ['1월', '2월', '3월',
									'4월', '5월', '6월', '7월', '8월',
									'9월', '10월', '11월', '12월'],
								dayNames: ['일', '월', '화', '수', '목',
									'금', '토'],
								dayNamesShort: ['일', '월', '화', '수',
									'목', '금', '토'],
								dayNamesMin: ['일', '월', '화', '수',
									'목', '금', '토'],
								showMonthAfterYear: true,
								changeYear: false,
								yearSuffix: ' - ',
								minDate: "0d",
								maxDate: "+1m",
								onclick: function () {
									var sdate = $(this).val
								}
							});
						$('#sdate').datepicker("setDate", "today");
						$('#sdate').datepicker("option", "onClose", function (selectedDate) {
							$("#sdateVal").attr("value", selectedDate);
						});

						$("#sTime").timepicker({
							
							    timeFormat: 'HH:mm',
							    interval: 60,
							    minTime: '0',
							    maxTime: '23:00',
							    defaultTime: '11',
							    startTime: '11:00',
							    dynamic: false,
							    dropdown: true,
							    scrollbar: true,
							    zindex: 9
							    
						
						});
						$('#sTime').timepicker("option", "change", function () {
							var t = $("#sTime").val();
							var ptime = t+":00";
							$("#sTimeVal").attr("value", ptime);
						});

					</script>
				</div>
				<div class="search-condition">
					<input type="range" name="price" id="slider" min="500" max="10000"
						step="100" /> 시간 당 <span id="won"></span> 원
					<script>
						$("#won").html(document.getElementById("slider").value);
						$("#slider").click(function () {
							let price = document.getElementById("slider").value;
							$("#won").html(price);
						});
					</script>
				</div>
				<div class="search-condition">
					정렬 <select name="align">
						<option value="distance">거리순</option>
						<option value="review">리뷰많은순</option>
						<option value="score">별점순</option>
					</select>
				</div>
			</div>
			<div class="search-result">
				<div class="search-result-list">
					<c:forEach var="parking" items="${SP_List}" varStatus="wishListStatus">

                     <table class="parking-lot" border="1">
                        <tr>
                           <td><a href="searchParkingDetail.do?parking_id=${parking.parking_id}"><img id='pkpic' src='images/${parking.parking_pic}'/></a></td>
                        </tr>
                     
                        <tr>
                           <td><a href="searchParkingDetail.do?parking_id=${parking.parking_id}">${parking.parking_title}</a></td>
                        </tr>
                        <tr>
                           <td><a href="searchParkingDetail.do?parking_id=${parking.parking_id}">${parking.parking_location}</a></td>
                        </tr>
                           <tr>
                           <td><a href="searchParkingDetail.do?parking_id=${parking.parking_id}">${parking.parking_type}</a></td>
                        </tr>
                        <tr>
                           <td><a href="searchParkingDetail.do?parking_id=${parking.parking_id}">예약가능: ${parking.parking_intime}</a></td>
                        </tr>
                        <tr>
                           <td><a href="searchParkingDetail.do?parking_id=${parking.parking_id}">1시간 ${parking.parking_price} 원</a></td>
                        </tr>
                        <!-- 찜 기능 작업중에 있습니다 -->
                        <tr>
                           
                              <td>
                                 <form>
                                    <input type="checkbox" name="parking_id" value="${parking.parking_id}" id=parkingWish${wishListStatus.index}></input>
                                    <label for="chckheart" class="heartLabel" onclick="wishList(${wishListStatus.index}, parkingWish${wishListStatus.index} );"><i class="fas fa-heart"></i></label>
                                 </form>
                              </td>
                        </tr>
                     </table>
                  
               </c:forEach>
               <script>
                  var cnt = 0;
                  //insert WishList
                  function wishList (num, parkingWish){
                     var parkingId = parkingWish.value;
                     
                     if(cnt == 0){
                        console.log("찜될 주차장 : " + parkingId);
                        var xhr = new XMLHttpRequest();
                        xhr.onreadystatechange = function(){
                           if(xhr.readyState === 4 && xhr.status === 200){
                              var heart = document.getElementsByClassName("fa-heart");
                              heart[num].setAttribute("style", "color : red;");
                              cnt++;
                              console.log("찜될 주차장  cnt: " + cnt);
                           }
                        }
                        xhr.open('GET', 'insert_wish.do?parking_id='+parkingId);
                        xhr.send(parkingId);
                     }
                     
                     if(cnt == 1){
                        var xhr = new XMLHttpRequest();
                        console.log("찜삭제될 주차장 : " + parkingId);
                        xhr.onreadystatechange = function(){
                           if(xhr.readyState === 4 && xhr.status === 200){
                              var heart = document.getElementsByClassName("fa-heart");
                                 heart[num].setAttribute("style", "color : black;");
                                 cnt--;
                                 console.log("찜삭제된 주차장  cnt: " + cnt);
                              }
                           }
                           xhr.open('GET', 'delete_wish.do?parking_id='+parkingId);
                           xhr.send(parkingId);
                     } 
                  }
                  
               </script>
               <!-- 여기까지 찜 기능 작업중에 있습니다 -->
				</div>

			</div>
			<div class="search-map">
				<div id="map" style="width: 100%; height: 100%;"></div>

				<script>
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
						mapOption = {
							center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
							level: 9 // 지도의 확대 레벨 
						};

					var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

					// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
					if (navigator.geolocation) {

						// GeoLocation을 이용해서 접속 위치를 얻어옵니다
						navigator.geolocation.getCurrentPosition(function (position) {

							var lat = position.coords.latitude, // 위도
								lon = position.coords.longitude; // 경도

							var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
								message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다

							// 마커와 인포윈도우를 표시합니다
							displayMarker(locPosition, message);

						});

					} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

						var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),
							message = 'geolocation을 사용할수 없어요..'

						displayMarker(locPosition, message);
					}

					// 지도에 마커와 인포윈도우를 표시하는 함수입니다
					function displayMarker(locPosition, a_positions) {
						imageSrc = "<%=request.getContextPath()%>/LOGO.png", // 마커이미지의 주소입니다    
							imageSize = new kakao.maps.Size(64, 64), // 마커이미지의 크기입니다
							imageOption = { offset: new kakao.maps.Point(27, 69) }; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

						// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
						var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);
						
						// 초기화면에서 마커를 표시
						
						 positions = [
						 <c:forEach var="parking" items="${SP_List}">
						 	{
						 		content: '<div>${parking.parking_title}</div>',
					 		latlng: new kakao.maps.LatLng(${parking.parking_lat}, ${parking.parking_lng})
						 	},
						 	</c:forEach>
						 ];
						
						if(isfirst){
							a_positions=positions;}
						
						for (var i = 0; i < a_positions.length; i++) {
							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
								map: map, // 마커를 표시할 지도
								position: a_positions[i].latlng, // 마커의 위치
								image: markerImage
							});
							
							markers.push(marker);

							// 인포윈도우를 생성합니다
							var infowindow = new kakao.maps.InfoWindow({
								content: a_positions[i].content,
								removable:false
							});
							
							infowindows.push(infowindow);

							// 인포윈도우를 마커위에 표시합니다 
							infowindow.open(map, marker);

							// 지도 중심좌표를 접속위치로 변경합니다
							map.setCenter(locPosition);
						}
					}
				</script>
			</div>
		</div>

	</body>
	<%@include file='../tail.jsp' %>

	</html>