<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<title>주차장 올리기</title>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=8bc49bed18e50dd654165896729f2ea4&libraries=services"></script>

<!-- 데이트피커 -->
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="css/jquery.timepicker.min.css">

<style>
	*{
		margin : 0;
		padding : 0;
	}
	h2 {
		/*font-weight: 500;*/
	}

	#cntnr .isp_title {
		width: 100%;
		height: 80px;
		/*border: 1px solid #ccc;*/
		box-sizing: border-box;
		margin: 0 0 10px 0;
		text-align: center;
		font-size: 2em;
		padding:0 0 20px 0;
	}
	#cntnr .isp_content {
		width: 800px;
		height: auto;
		min-height: 850px;
		/*border: 1px solid #ccc;*/
		box-sizing: border-box;
		margin: 0 auto 20px auto;
		text-align: center;
		/*background-color:#eee;*/
	}
	#search{
		width:100%;
		margin : 50px 0px 20px 0px;
	}
	#search_type{
		width: 122px;
		font-weight: 500;
		float: left;
		line-hight:2.4em;
		text-align:right;
		/*background-color:red;*/
		box-sizing:border-box;
	}
	#location{
		float:right;
		width:639px;
		height:32px;
		/*padding: 0px 0px 0px 10px;*/
		margin: 0px 0px 0px 9px;
		box-sizing:border-box;
		
	}
	#search_type_box{
		/*border: 1px solid #ccc;*/
		width:800px;
		margin:0px auto 20px auto;
		background-color:blue;
	}
	/* 여기부터 */
	table.info {
		width:800px;
		border-collapse: separate;
		border-spacing: 1px;
		text-align: left;
		line-height: 1.5em;
		/*background-color:#ccc;*/
		/* border-top: 1px solid #ccc; */
		margin: 20px auto;
	}
	
	table.info th {
		width: 120px;
		padding: 30px 20px 10px 10px;
		font-weight: 500;
		vertical-align: top;
		text-align: right;
		/* border-bottom: 1px solid #ccc; */
		/*background: #efefef;*/
	}

	table.info td {
		width: 679px;
		padding: 30px 0px 10px 20px;
		vertical-align: top;
		/* border-bottom: 1px solid #ccc; */
	}
	#sub-btn{
		text-align: center;
	}
	.btn_submit {
		margin:0 auto;
		width: 100%;
		height: 50px;
		color: #fff;
		border-radius: 4px;
		border: 1px solid transparent;
		background-color: #367FFF;
		border-color: #367FFF;
		text-align:center;
		transition: all 0.5s ease-in-out 0s;
	}
	.btn_submit:hover {
	  cursor: pointer;
	  text-decoration: none;
	}
	#blah_box{
		/*border: solid 1px black;*/
		width: 100%;
	}
	#blah {
		width:100%;
		height:auto;
		z-index: 999;
	}

	#map_container {
		margin : 0 auto;
		border: solid 1px black;
		width: 70%;
		height: 350px;
	}

	#title_box {
		width: 100%;
		height: 30px;
		font-size: 15px;
	}
	.radio {
		margin: 0px 0px 0px 20px;
	}
	#parking_content{
		overflow-y: scroll;
		width:100%;
	}
	/*파일창 css*/
	#profile_img_upload{
	/*
	    width: 0.1px;
		height: 0.1px;
		opacity: 0;
		overflow: hidden;
		position: absolute;
		z-index: -1;
		*/
		display:none;
		
		
	}
	
	#profile_img_upload + label {
	    border: 1px solid #d9e1e8;
	    background-color: #fff;
	    color: blue;
	    border-radius: 0.4rem;
	    padding: 8px 17px 8px 17px;
	    font-weight: 500;
	    font-size: 15px;
	    box-shadow: 1px 2px 3px 0px #f2f2f2;
	    outline: none;
	    position: absolute;
	}
	
	#profile_img_upload:focus + label,
	#profile_img_upload + label:hover {
	    cursor: pointer;
	}
	#coordXY{
		display : none;
	}
	#delete_file{
	width :22px;
	height:22px;
	/*border:1px solid black;*/
	background-image: url('<%=request.getContextPath()%>/images/xbutton.png');
	background-size : cover;
	float:right;
	margin:0 0 30px 0;
	
	
	}
	
	#delete_file:hover {
	  cursor: pointer;
	}
	
	/*
	input[type=number] {
    height: 30px;
	}
	
	input[type=number]:hover::-webkit-inner-spin-button {  
	    width: 50px;
	    height: 50px;
	}
	*/
	/*도로명주소*/
	
</style>
<script>
		
	//이미지 출력
	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $('#blah').attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
	
	//엔터시 폼전송 방지
	
	document.addEventListener('keydown', function(event) {
	  if (event.keyCode === 13) {
	    event.preventDefault();
	  };
	}, true);
	
		
	//금액 콤마표시
	/*
	var rgx1 = /\D/g;  // /[^0-9]/g 와 같은 표현
	var rgx2 = /(\d+)(\d{3})/; 
	
	function getNumber(obj){
	     var num01;
	     var num02;
	     num01 = obj.value;
	     num02 = num01.replace(rgx1,"");
	     num01 = setComma(num02);
	     obj.value =  num01;
	}
	
	function setComma(inNum){
	     var outNum;
	     outNum = inNum; 
	     while (rgx2.test(outNum)) {
	          outNum = outNum.replace(rgx2, '$1' + ',' + '$2');
	      }
	     return outNum;
	}
	*/
	$(document).ready(function(){
		console.log("글등록 진행")
		
		//이미지삭제
		$("#delete_file").on("click", function(){
			console.log("삭제버튼 누름")
			$('#blah').removeAttr('src');
			console.log( $('#blah').attr('src'))
			
		})
		
		//submit 전 유효성검사 부분
	     $('#save').on("click", function() {
	
	         if ($('#title_box').val() == "") {
	             alert("제목을 입력하세요.");
	             return false;
	         }
	         if ($('#parking_location').val() == "") {
	             alert("주소를 등록해주세요.");
	             return false;
	         } 
	         if ($('#parking_price').val() == "") {
	             alert("가격을 등록해 주세요.");
	             return false;
	         }
	         if ($('#parking_intime').val() == "") {
	             alert("시작날짜를 등록해주세요.");
	             return false;
	         }
	         if ($('#parking_outtime').val() == "") {
	             alert("종료날짜를 등록해주세요.");
	             return false;
	         }
	         if ($("input[name=parking_cartype]:radio:checked").length < 1) {
	             alert("차종을 선택해주세요.");
	             return false;
	         }
	         if ($('#profile_img_upload').val() == "") {
	             alert("사진을 등록해주세요.");
	             return false;
	         }
	         if ($('#parking_content').val() == "") {
	             alert("내용을 등록해주세요");
	             return false;
	         }
	         return true;
	     });
	
	    //좌표값
	    /*
	 	$(function(){
	 		var coordXY = $("#coordXY").html();
	 		console.log(coordXY);
	 	})	
	 	*/
		
	})
	
	/*
	var today = new Date();
	var dd = today.getDate();
	var mm = today.getMonth() + 1; //January is 0!
	var yyyy = today.getFullYear();
	if (dd < 10) {
	  dd = '0' + dd;
	}
	if (mm < 10) {
	  mm = '0' + mm;
	}
	var today = mm + '/' + dd + '/' + yyyy;
	document.getElementById('parking_outtime').value = today;
	*/
	
	
</script>

</head>

<body>
	<jsp:include page="header.jsp"></jsp:include>
	
	<div id="cntnr">

		<!-- 각자의 파트는 이곳에서부터 작업하실 수 있습니다. -->

	<div class="cntnr-top-margin"></div>
	<div class="isp_title">
		<h2> 단기 주차장 내놓기</h2>
	</div>
		<div id="map_container">
		<div id="map" style="width:100%;height:350px;"></div></div>
	<div id="search">
		<div id="coordXY"></div>
		<div id="search_type_box">
			<p id="search_type">위치 검색하기</p>
			<input type="text" id="location" onkeydown='loc()' placeholder="주소를 검색해 주세요.">
		</div>
	</div>
	
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
       mapOption = {
           center: new kakao.maps.LatLng(37.56682, 126.9786522), // 지도의 중심좌표
           level: 3 // 지도의 확대 레벨
       };  
   
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
   
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
   
	function loc() {
	var isMarker = false;
      	 if(event.keyCode == 13){
      		 console.log("엔터값 입력")
      		 isMarker = true;
      	 }

          document.getElementById('parking_location').value = (document.getElementById('location').value );
          
          var loc1 = (document.getElementById('parking_location').value);
          
          // 주소로 좌표를 검색합니다
          geocoder.addressSearch(loc1, function(result, status) {
       
          // 정상적으로 검색이 완료됐으면 
          var coordXY   = document.getElementById("coordXY");
          var x,y= "";
	          if (status === kakao.maps.services.Status.OK) {
	     
	          var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	       		y = result[0].x;
	       		x = result[0].y;
		       	 if(isMarker){
		       		//console.log("엔터값 입력")
		                // 결과값으로 받은 위치를 마커로 표시합니다
			          var marker = new kakao.maps.Marker({
			              map: map,
			              position: coords
			          });
		       	 }
		          // 인포윈도우로 장소에 대한 설명을 표시합니다
		          var infowindow = new kakao.maps.InfoWindow({
		              content: '<div style="width:150px;text-align:center;padding:6px 0;">여기어때</div>'
		          });
		          infowindow.open(map, marker);
		          infowindow.close(map, marker);
		          // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		          map.setCenter(coords);
		          coordXY.innerText = "X좌표 : " + x + "Y좌표 : " + y;
		          $("#x_value").attr("value",x);
		          $("#y_value").attr("value",y);
	          } 
       
	      });
     }
</script>
		<form action="insertParking.do" method="post" enctype="multipart/form-data">
			

			<div class="isp_content">
				<input type="hidden" id="x_value" name="parking_lat" >
				<input type="hidden" id="y_value" name="parking_lng" >
				<input type="hidden" name="parking_type" value="단기"> 
				<input type="hidden" name="parking_deleted" value="0"> 
				<input type="hidden" class="owner_id" name="owner_id" id="owner_id" value="${userId}">
				<input type="hidden" name="parking_location" id="parking_location">

				<table class="info">
					<tr>
						<th>제목</th>
						<td><input type="text" class="parking_title" placeholder="ex)서강대역 도보 1분 다양한 차종 주차 가능합니다~!"
								name="parking_title" maxlength="80" id="title_box"></td>
					</tr>
					<tr>
						<th>가격</th>
						<td>
						<!-- 
						<input type="number" class="parking_price" name="parking_price" maxlength="50" 
						max="20000" min="1000" step="1000" onChange = "qtyChanged();">원</td>
						 -->
						<input type="text" class="parking_price" id="parking_price" name="parking_price" onchange="getNumber(this);" onkeyup="this.value=this.value.replace(/[^0-9]/g,'');" style="text-align:right;" size=4> 원</td>
					</tr>
					<tr>
						<th>시작 날짜</th>
						<td>
						<!-- 
						<input type="button" value="2021-04-15" id="sdate"  > 
						<input type="button" value="주차시간" class="hasTimepicker" id="sTime" />
						 -->
						<input type="datetime-local" value="시작날짜"  name="parking_intime" id="parking_intime" value = "2021-04-15T09:00" /> 
						</td>
					</tr>
						
					<tr>
						<th>종료 날짜</th>
						<td>
						<!-- 
						<input type="button" value="종료날짜" id="edate" name="parking_outtime"/>
						 -->
						<input type="datetime-local" value="종료날짜"  name="parking_outtime" id="parking_outtime"/>
						
					</tr>
					
					<tr>
						<th>차종</th>
						<td><input type="radio" name="parking_cartype" id="c1" value="대형"> <label
								for="c1">대형</label> <input type="radio" name="parking_cartype" id="c2" value="중형"
								class="radio"> <label for="c2">중형</label> <input type="radio" name="parking_cartype"
								id="c3" value="준중형" class="radio"> <label for="c3">준중형</label> <input type="radio"
								name="parking_cartype" id="c4" value="경차" class="radio"> <label for="c4">경차</label>
							<input type="radio" name="parking_cartype" id="c5" value="기타" class="radio"> <label
								for="c5">기타</label>
						</td>
					</tr>
					<tr>
						<th>사진</th>
						<td>
						<div id="delete_file" >
						 	 </div>
						
						<input type="file" name="uploadFile" accept="image/*" onchange="readURL(this);" id='profile_img_upload'/>
						<label for='profile_img_upload'><i class="far fa-file-image">&nbsp;파일 선택</i></label>
							<div id="blah_box">
							<img id="blah" alt="기본이미지" onerror="this.parentNode.style.display='none'"/>
							</div>
						 
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td><textarea id="parking_content" name="parking_content" rows="7" cols="80" ></textarea>
						</td>
					</tr>

					<tr>
						<th></th>
						<td id="sub-btn">
							<input type="submit" class="btn_submit" value="등록하기" id="save" name="save" >
						
						</td>
					</tr>
					
				</table>
			</div>
			
		</form>
		<script>

		</script>
		<!-- 각자의 파트는 이곳까지 작업해주시면 되겠습니다. -->
	</div>
	<jsp:include page="tail.jsp"></jsp:include>
</body>

</html>