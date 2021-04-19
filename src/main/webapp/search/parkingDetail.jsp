<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.gstatic.com">
<script src="https://kit.fontawesome.com/415f6f6023.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css"
	href="css/ParkingDetailStyleSheet.css">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<title>주차장 상세 페이지</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
#cntnr {
	width: 80%;
}

.hasTimepicker{
text-align: center;
	width: 100px;
    height: 35px;
    margin: 3px;
    color: #367fff;
    border: 1px solid #b1ceff;
    border-radius: 4px;
    background-color: white;
    box-shadow: 1px 1px 3px #ddd;
    cursor: pointer;
}

</style>
</head>

<body>
	<div id="cntnr">
		<!-- 각자의 파트는 이곳에서부터 작업하실 수 있습니다. -->
		<div class="cntnr-top-margin"></div>
		<div class="title segment"><input type="hidden" name="parking_title"
							value="${p_detail.parking_title}" />
						<button type="button" id="cartype" disbled>${p_detail.parking_cartype}</button>
						<h1 style="font-size:2em; font-weight:500;display:inline">${p_detail.parking_title}</h1>
						<p><span id="inOut"></span><button type="button" id="type" disbled>${p_detail.parking_type}</button></p>
				  <script>
                  var ind = "${p_detail.parking_intime}";
                  var outd = "${p_detail.parking_outtime}";
                  ind = ind.substr(0,10);
                  outd = outd.substr(0,10);
                  $("#inOut").text(ind+" ㅡ "+outd);
                  </script>
		</div>
		<div class="segment pk-pic"
			style="background-image: url(./images/${p_detail.parking_pic});">

		</div>
		<form method="post" action="kakaopay.do">
			<div class="description">
				<div class="segment pk-content">
					<input type="hidden" name="parking_id"
						value="${p_detail.parking_id}"> <input type="hidden"
						name="parker_id" value="${userId}">
					<!-- 문제 부분 -->
					<div class="pk-info">
					<h1>${p_detail.parking_title}</h1>
						<hr>
						<p>위치: ${p_detail.parking_location}</p>
						<p>주차가능: ${p_detail.parking_cartype}</p>
						<p>${p_detail.parking_content}</p>

					</div>
					<div class="segment pk-condition">

						<div class="pk-price" style="font-size: larger; font-weight: 500;">
							${p_detail.parking_price}<span
								style="font-size: small; font-weight: 300;"> 원/일</span>
						</div>
						<div class="pk-pickday">
							<input type="text" class='hasTimepicker' id="sdate" onchange="call()" readonly/>
							<input type="text" class='hasTimepicker' id="edate" onchange="call()" readonly/>

							<input type="hidden" name="rsv_intime" value="" id="hidden_sdate" />
							<input type="hidden" name="rsv_outtime" value="" id="hidden_edate" />
							
							<!-- 오너 아이디 - 은지 -->
							<input type="hidden" name="parkingVO.owner_id" value="${p_detail.owner_id}"/>

							<script>
			var today = new Date();
			var inDate = "${p_detail.parking_intime}";
			inDate = inDate.substr(0,10)
			var outDate = "${p_detail.parking_outtime}";
			if(today > new Date(inDate)){
				 var min = today;
			}else{
             var min = inDate;
             }
                 var max = outDate.substr(0,10);
                 
                        function disableAllTheseDays(date) {
                            var dateRange = [];
                            var dateString = jQuery.datepicker.formatDate('yy-mm-dd', date);
 
 // jstl을 이용 서버에서 처리
<c:forEach var="rsv" items="${booked}">
<fmt:formatDate var="rsvInDt" value="${rsv.rsvVO.rsv_intime}" pattern="YYYY-MM-dd"/>
<fmt:formatDate var="rsvOutDt" value="${rsv.rsvVO.rsv_outtime}" pattern="YYYY-MM-dd"/>
                            var startdate = "${rsvInDt}";
                            var enddate = "${rsvOutDt}";

                            for (var d = new Date(startdate); d <= new Date(enddate); d.setDate(d.getDate() + 1)) {
                                dateRange.push($.datepicker.formatDate('yy-mm-dd', d));
                            }
</c:forEach>
                            return [dateRange.indexOf(dateString) == -1];
                       

                        }
                        $("#sdate").datepicker({
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
                            minDate: min,
                            maxDate: max
                       <c:if test="${rsvInDt ne null}">
                            ,beforeShowDay: disableAllTheseDays
                       </c:if>
                        });
                        $("#edate").datepicker({
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
                            minDate: min,
                            maxDate: max
                       <c:if test="${rsvInDt ne null}">
                            ,beforeShowDay: disableAllTheseDays
                       </c:if>
                        });
                        

               		  $('#edate').datepicker("option", "onClose", function (selectedDate) {
                        	if(selectedDate.length==10)
                            $("#sdate").datepicker("option", "maxDate", selectedDate);
                        	else
                        		$("#sdate").datepicker("option", "maxDate", max);
                        	
                        	
                        });
                        $('#sdate').datepicker("option", "onClose", function (selectedDate) {
                        	if(selectedDate.length==10)
                                $("#edate").datepicker("option", "minDate", selectedDate);
                            else
                                $("#edate").datepicker("option", "minDate", min);
                        	
                        });
                        $("#sdate").val("시작날짜");
                        $("#edate").val("종료날짜");
                        
                 
                        function call(){
                            var sdd = document.getElementById("sdate").value;
                            var edd = document.getElementById("edate").value;
                          
                            //예약날짜 유효성 검사
                            if(sdd !="시작날짜" && edd !="종료날짜"){
                            	  var ar1 = sdd.split('-');
                                  var ar2 = edd.split('-');
                                  var da1 = new Date(ar1[0], ar1[1], ar1[2]);
                                  var da2 = new Date(ar2[0], ar2[1], ar2[2]);
                                  var dif = da2 - da1;
                                
                                var cDay = 24 * 60 * 60 * 1000;// 시 * 분 * 초 * 밀리세컨
                                var cMonth = cDay * 30;// 월 만듬
                                var cYear = cMonth * 12; // 년 만듬
                                var days = parseInt(dif/cDay);
                                
                                if(days ==0){ 
                               	 alert("최소 1일 이상 예약해주세요");
                               	 var totalPrice = 0;

                                }else{
                            
                                var totalPrice = ${p_detail.parking_price} * days;
                            }

                            }else{
                            
                            	var totalPrice=0;
                            	var days = 0;
                            }
                            $("#days").text(days);
                            $('#won').text(totalPrice);
                            $('#hidden_price').attr('value',totalPrice)
                            sdd = new Date(sdd);
                            edd = new Date(edd);
                            $('#hidden_sdate').attr('value',sdd);
                            $('#hidden_edate').attr('value',edd);
                            }
                        $(document).ready(function(){
                        	$("#pk-book-btn").on("click", function() {
                        		if(  $("#sdate").val()=="시작날짜" ||
                                $("#edate").val()=="종료날짜"){
                        			alert("날짜를 선택해주세요");
                        			return false;
                        		}
                        		if($("#won").text()=="0"){
                        			alert("유효하지 않은 입력입니다. 날짜를 다시 선택해주세요");
                        			return false;
                        		}
                        		
                        	});
                        });
                    </script>
						</div>
						<div class="pk-total-price">

							${p_detail.parking_price} 원 X <span id="days">0</span> 일 = <span
								id="won" value="" style="font-size: larger; font-weight: 500;">
								0</span>원 <input type="hidden" id="hidden_price" name="rsv_price" />
</div>
						<div class="pk-btn">
							<c:choose>
							<c:when test="${empty sessionScope.userId}">
									<input type="button" value="주차장 예약하기" id="pk-book-btn"
										onclick="alert('로그인이 필요한 기능입니다.');location.href='<%=request.getContextPath()%>/user/userLogin.jsp' " />
								</c:when>
								<c:when test="${!empty sessionScope.userId and p_detail.owner_id ne userId}">
									<input type="submit" value="주차장 예약하기" id="pk-book-btn" onclick=""/>
								</c:when>
								<c:when test="${!empty sessionScope.userId and p_detail.owner_id eq userId}">
									<input type="button" value="주차장 예약하기" id="pk-book-btn"
										onclick="alert('자기 자신의 주차장은 예약할 수 없습니다');location.href='#';" />
								</c:when>

							</c:choose>
							<!-- parking의 owner_id 가 세션user와 동일한 경우 예외처리 -->
						</div>
						<!-- 문제 부분 -->
					</div>
				</div>
		</form>

		<div class="segment pk-location">
			<h1 class="pk-subject">위치</h1>
			<div class="search-map">
				<div id="map" style="width: 100%; height: 100%;"></div>

				<script type="text/javascript"
					src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=8bc49bed18e50dd654165896729f2ea4"></script>
				<script>
                    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
                        mapOption = {
                            center: new kakao.maps.LatLng(${p_detail.parking_lat}, ${p_detail.parking_lng}), // 지도의 중심좌표
                            level: 3 // 지도의 확대 레벨
                        };

                    var map = new kakao.maps.Map(mapContainer, mapOption);

                    // 마커가 표시될 위치입니다 
                    var markerPosition = new kakao.maps.LatLng(${p_detail.parking_lat}, ${p_detail.parking_lng});

                    // 마커를 생성합니다
                    var marker = new kakao.maps.Marker({
                        position: markerPosition
                    });

                    // 마커가 지도 위에 표시되도록 설정합니다
                    marker.setMap(map);

                    var iwContent = '<div style="padding:5px;">${p_detail.parking_location}<br><a href="https://map.kakao.com/link/map/${p_detail.parking_location},${p_detail.parking_lat},${p_detail.parking_lng}" style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/${p_detail.parking_location},${p_detail.parking_lat},${p_detail.parking_lng}" style="color:blue" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
                        iwPosition = new kakao.maps.LatLng(${p_detail.parking_lat}, ${p_detail.parking_lng}); //인포윈도우 표시 위치입니다

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
			<h1 class="pk-subject">후기</h1>
			<c:choose>
         <c:when test="${totalReview[0].avrg eq null}">
         <div id="noRsv">
         	<p id="noRsv_text">주차장의 첫 번째 후기를 남겨주세요😎</p>
         </div>
         </c:when>
         <c:when test="${totalReview[0].avrg ne null}">
         <table id="rv-table" width=100%>
            <thead>
            
            
               <tr>
                  <th style="text-align: right;">별점 <span
                     style="font-size: 25pt; font-weight: 500;">${totalReview[0].avrg}</span></th>
               </tr>
            </thead>
            <tbody id="review-by-page">
               <c:forEach var="review" items="${p_reviews}" varStatus="i">
                  <tr>
                     <td>
                        <table class="rv-indiv">
                           <tr>
                              <td class='rv-pic'><img
                                 src="images/profile/${p_reviews[i.index].userVO.user_pic}" /></td>
                              <fmt:formatDate var="reviewDt"
                                 value="${p_reviews[i.index].review_date}"
                                 pattern="YYYY년  MM월 dd일" />
                              <td>${p_reviews[i.index].userVO.user_nickname}<br>${reviewDt}
                              </td>
                           <tr>
                              <td colspan="2">
                                 <p class="mp-rvl-p mp-rvl-rate"
                                    data-rate="${p_reviews[i.index].review_rating}">
                                    <input type="radio" name="review_rating" value="1"
                                       class="rtng"
                                       <c:if test="${p_reviews[i.index].review_rating eq '1'}">checked</c:if>
                                       id="rtng1" title="1"><label for="rtng1"
                                       class="starLabel"><i class="fas fa-star"></i></label> <input
                                       type="radio" name="review_rating" value="2" class="rtng"
                                       <c:if test="${p_reviews[i.index].review_rating eq '2'}">checked</c:if>
                                       id="rtng2" title="2"><label for="rtng2"
                                       class="starLabel"><i class="fas fa-star"></i></label> <input
                                       type="radio" name="review_rating" value="3" class="rtng"
                                       <c:if test="${p_reviews[i.index].review_rating eq '3'}">checked</c:if>
                                       id="rtng3" title="3"><label for="rtng3"
                                       class="starLabel"><i class="fas fa-star"></i></label> <input
                                       type="radio" name="review_rating" value="4" class="rtng"
                                       <c:if test="${p_reviews[i.index].review_rating eq '4'}">checked</c:if>
                                       id="rtng4" title="4"><label for="rtng4"
                                       class="starLabel"><i class="fas fa-star"></i></label> <input
                                       type="radio" name="review_rating" value="5" class="rtng"
                                       <c:if test="${p_reviews[i.index].review_rating eq '5'}">checked</c:if>
                                       id="rtng5" title="5"><label for="rtng5"
                                       class="starLabel"><i class="fas fa-star"></i></label>
                                 </p> <script>
                                    $(document).ready(function(){
                                       var rating = $('.mp-rvl-rate');
                                       
                                       rating.each(function(){
                                          var targetScore = $(this).attr('data-rate');
                                          console.log(targetScore);
                                          
                                          $(this).find('input:nth-child(-n+' + targetScore*2 +') + label i').css({color:"#e4c61c"});
                                          $(this).find('input:nth-child(n+' + targetScore*2 +') + label i').css({color:"#ccc"});
                                       });
                                    });
                                 </script> <br> ${p_reviews[i.index].review_content}
                              </td>

                           </tr>
                           </td>
                           </tr>
                        </table>
                     </td>
                  </tr>
               </c:forEach>
            </tbody>
         </table>
         </c:when>
         </c:choose>
			<script>
            $(document).ready(function(){
               paging(${totalReview[0].total},1);

            });

           function paging(totalData, currentPage){
               const dataPerPage = 3;  //한번에 표시할 리뷰 수 
               const pageCount = 5; //표시할 버튼 개수

               const totalPage = Math.ceil(totalData/ dataPerPage); //총페이지
               const pageGroup = Math.ceil(currentPage / pageCount); //페이지 그룹
               console.log ("totalPage: "+totalPage+", pageGroup:"+pageGroup)

               let last = pageGroup * pageCount; //화면에 보여질 마지막 페이지
               if(last > totalPage)
                  last = totalPage;
               let first = last - (pageCount-1);
               const next = last +1;
               const prev = first -1;
               
               if(totalPage <1) {
                  first = last;
               }
               const pages = $("#pages");
               pages.empty();
               if(first > 5){
                  pages.append("<li class='pagination-item'>"+"<a onclick='GetTarget("+prev+");' style='margin-left: 2px'>prev</a></li>")
               }
               for(var j = first; j<=last; j++){
                  if(currentPage ===(j)){
                     pages.append("<li class ='pagination-item'>"+ "<a class='active' onclick='GetTarget("+ j +");' style='margin-left: 2px'>" +j+"</a></li>");
                     
                  }else if (j > 0){
                     pages.append("<li class='pagination-item'>"+"<a onclick='GetTarget("+ j +");' style='margin-left:2px'>"+ j + "</a></li>");

                  }
               }
               if (next> 5 && next < totalPage){
                  pages.append("<li class='pagination-item'>"+"<a onclick='GetTarget("+ next + ")' style='margin-left: 2px'>next</a></li>");
               }
           }

           function GetTarget(page){
           $.ajax({
              type: "post",
              url:"searchParkingDetail.do",
              dataType: "json", //리뷰가 와야하니까
              contentType: "application/x-www-form-urlencoded; charset=UTF-8",
              data: { "page": page,
                      "parking_id": ${p_detail.parking_id}
            },
              success: function (result) {
                 list=$("#review-by-page");
                 list.empty();
                 console.log(result);
                 var obj = result.p_reviews;
                 obj.forEach(element =>{
               var date = new Date(element.review_date);
               var yy, mm, dd;
               yy= date.getFullYear();
               mm = date.getMonth()+1;
               dd = date.getDate();
                 var txt = '<tr><td><table class="rv-indiv">';

                  txt+=  '<tr><td class="rv-pic"><img src="images/profile/'+element.userVO.user_pic+'" /></td>';
                  txt+= '<td>'+element.userVO.user_nickname+'<br>'+yy+'년 '+mm+'월 '+dd+'일</td>';
                  txt+= '<tr><td colspan="2">'+element.review_rating+"<br>"+element.review_content+'</td></tr>';
                  txt+='</td> </tr></table> </td></tr>';


                  list.append(txt);
                  
               });
                
              }
           });
       }
         </script>
			<input type="hidden" name="page" id="pageNum" value="1" />
			<nav>
				<ul class="paging" id="pages">
					<!-- <li><a href="#"><span aria-hidden="true">«</span><span
                     class="sr-only">Previous</span></a></li>      
               <li><a href="#">1</a></li>
               <li><a href="#">2</a></li>
               <li><a href="#">3</a></li>
               <li><a href="#">4</a></li>
               <li><a href="#">5</a></li>
               <li><a href="#"><span aria-hidden="true">»</span><span
                     class="sr-only">Next</span></a></li> -->
				</ul>
			</nav>
		</div>
			<div class="segment pk-recommendation">
		<h1 class="pk-subject">이 주차장도 추천해요 !</h1>
		<div id="recommendation">
		<c:forEach items="${recomm}" var= "rcm">
			<a href="searchParkingDetail.do?parking_id=${rcm.parking_id}">
			<table class="recommendation-box">
			<tr>
               <td><img class='reco-img' src='images/${rcm.parking_pic}'/></td>
            </tr>
            <tr>
               <td id="recommendation-title" class="reco-title">${rcm.parking_title}</td>
            </tr>
            <tr>
               <td class="reco-type">${rcm.parking_location}</td>
            </tr>
               <tr>
               <td class="reco-type">${rcm.parking_type} | ${rcm.parking_cartype} | 1일 ${rcm.parking_price} 원</td>
            </tr>
            <tr>
               <td class="reco-intime"> ${rcm.parking_intime}</td>
            </tr>
           <tr>
               <td class="reco-intime"> ${rcm.parking_outtime}</td>
            </tr>


            <!-- 찜 기능 작업중에 있습니다 -->
           </table></a>
		</c:forEach>
      </div>
      
		
	</div>
	<!-- 각자의 파트는 이곳까지 작업해주시면 되겠습니다. -->
	</div>

	</div>
</body>
<script src="header_js.jsp"></script>
<script src="index_js.jsp"></script>
<%@ include file="../tail.jsp"%>
</html>