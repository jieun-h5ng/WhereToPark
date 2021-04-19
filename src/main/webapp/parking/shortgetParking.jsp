<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=8bc49bed18e50dd654165896729f2ea4&libraries=services"></script>
	
<title>Document</title>
<style>
#ftr{
	clear:both;
}
#cntnr{
	clear:both
}
*{
	margin : 0;
	padding : 0;
}
#cntnr .gp_title {
	width: 100%;
	height: 80px;
	/*border: 1px solid #ccc;*/
	box-sizing: border-box;
	margin: 0 0 10px 0;
	text-align: center;
	font-size: 2em;
}

#gp_content {
	clear:both;
	width: 800px;
	/*border: 1px solid #ccc;*/
	box-sizing: border-box;
	margin: 0 auto 20px auto;
	text-align: center;
	min-height: 1200px;
	height:auto;
}
#coordXY{
		display : none;
	}


/* 여기부터 */
table.update {
	width:800px;
	border-collapse: separate;
	border-spacing: 1px;
	text-align: left;
	line-height: 1.5;
	/*background-color:#ccc;*/
	/* border-top: 1px solid #ccc; */
	margin: 20px auto;
}


table.update th {
	width: 120px;
	padding: 30px 20px 20px 10px;
	font-weight: 500;
	vertical-align: top;
	text-align: right;
	/*background: #eeeeee;*/
}

table.update td {
	width: 679px;
	padding: 30px 0px 10px 20px;
	vertical-align: top;
	/* border-bottom: 1px solid #ccc; */
}

.btn_submit {
	margin:0 auto;
	width: 100%;
	height: 50px;
	color: #fff;
	border-radius: 4px;
	background-color: #367FFF;
	border-color: #367FFF;
	text-align:center;
	transition: all 0.5s ease-in-out 0s;
	border: 1px solid transparent;
}
.btn_submit:hover {
  cursor: pointer;
  text-decoration: none;
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
#blah_box{
	/*border: solid 1px black;*/
	width: 100%;
}
#blah {
	width:100%;
	height:auto;
	z-index: 999;
	
}
#title_box {
	width: 100%;
	height: 30px;
	font-size: 15px;
}

.radio {
	margin: 0px 0px 0px 20px;
}
/*위치검색하기*/
#search{
		width:100%;
		margin : 50px 0px 20px 0px;
}
#search_type_box{
	/*border: 1px solid #ccc;*/
	width:800px;
	margin:0px auto 20px auto;
	background-color:blue;
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
	    border-radius: 0.1rem;
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
	#map_container {
		margin : 0 auto;
		border: solid 1px black;
		width: 70%;
		height: 350px;
	}
</style>
<script src="js/jquery-1.12.4.min.js"></script>
<script>
	$(document).ready(function(){
		console.log( $('#blah').attr('src'))
		
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
	         if ($('#location').val() == "") {
	             alert("주소를 다시 검색해주세요.");
	             return false;
	         } 
	         if ($('#parking_location').val() == "") {
	             alert("주소를 다시 검색해주세요.");
	             return false;
	         } 
	         if ($('#parking_price').val() == "") {
	             alert("가격을 등록해 주세요.");
	             return false;
	         }
	         if ($('#parking_intime').val() == "") {
	             alert("시작날짜를 다시 등록해주세요.");
	             return false;
	         }
	         if ($('#parking_outtime').val() == "") {
	             alert("종료날짜를 다시 등록해주세요.");
	             return false;
	         }
	         if ($("input[name=parking_cartype]:radio:checked").length < 1) {
	             alert("차종을 선택해주세요.");
	             return false;
	         }
	         
	         if ($("#profile_img_upload").val() == "") {
	             alert("사진을 등록해주세요.");
	             return false;
	         }
	         
	         if ($('#parking_content').val() == "") {
	             alert("내용을 등록해주세요");
	             return false;
	         }
	         return true;
	     });
		
		
	})

	//이미지qhdlrl
	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $('#blah').attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	        console.log( $('#blah').attr('src'))
	    }
	}
	
	
	//엔터시 폼전송 방지
	document.addEventListener('keydown', function(event) {
	  if (event.keyCode === 13) {
	    event.preventDefault();
	  };
	}, true);
		
	//금액 콤마표시
	/*var rgx1 = /\D/g;  // /[^0-9]/g 와 같은 표현
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
	}*/
</script>
</head>

<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div id="cntnr">
		<!-- 각자의 파트는 이곳에서부터 작업하실 수 있습니다. -->

		<div class="cntnr-top-margin"></div>
		<div class="gp_title">
		<h2>단기 주차장 수정하기</h2>
		</div>
		<div id="map_container">
		<div id="map" style="width:100%; height:350px;"></div>
		</div>
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
		<form action="updateParking.do" method="post" enctype="multipart/form-data">
			<div id="gp_content">
						<input type="hidden" name="parking_type"
							value="${parking.parking_type}">
							<input type="hidden" name="owner_id"
								value="${parking.owner_id }">
							<input type="hidden" name="parking_id"
								value="${parking.parking_id }">
							<input type="hidden" name="parking_deleted"
								value="${parking.parking_deleted }">
							<input type="hidden" name="parking_location" id="parking_location" value="${parking.parking_location}">
							<input type="hidden" id="x_value" name="parking_lat" value="${parking.parking_lat }">
							<input type="hidden" id="y_value" name="parking_lng" value="${parking.parking_lng }">

				<table class="update">
					<tr>
						<th>제목</th>
						<td><input type="text" name="parking_title"
							value="${parking.parking_title}" id="title_box"/></td>
					</tr>

					<tr>
						<th>가격</th>
						<td>
						<input type="text" class="parking_price" id="parking_price" name="parking_price"  onchange="getNumber(this);" onkeyup="getNumber(this);" style="text-align:right;" size=4 value="${parking.parking_price }"> 원</td>
						
					</tr>
					<tr>
						<th>시작 날짜</th>
						<td><input type="datetime-local" name="parking_intime" id="parking_intime"
							value="${parking.parking_intime }"></td>
					</tr>
					<tr>
						<th>종료 날짜</th>
						<td><input type="datetime-local" name="parking_outtime" id="parking_outtime"
							value="${parking.parking_outtime }"></td>
					</tr>
					<tr>
						<th>차종</th>
						<td><input type="radio" name="parking_cartype" id="c1"
							value="대형" 
							<c:if test="${parking.parking_cartype eq '대형'}"> checked </c:if> />
							<label for="c1">대형</label> <input type="radio"
							name="parking_cartype" id="c2" value="중형" class="radio"
							<c:if test="${parking.parking_cartype eq '중형'}">checked</c:if> />
							<label for="c2">중형</label> <input type="radio"
							name="parking_cartype" id="c3" value="준중형" class="radio"
							<c:if test="${parking.parking_cartype eq '준중형'}">checked</c:if> />
							<label for="c3">준중형</label> <input type="radio"
							name="parking_cartype" id="c4" value="경차" class="radio"
							<c:if test="${parking.parking_cartype eq '경차'}">checked</c:if> />
							<label for="c4">경차</label> <input type="radio"
							name="parking_cartype" id="c5" value="기타" class="radio"
							<c:if test="${parking.parking_cartype eq '기타'}">checked</c:if> />
							<label for="c5">기타</label> </td>
					</tr>
					<tr>
						<th>사진
						</th>
						<td>
						 	 <div id="delete_file" >
						 	 </div>
							<input type="file" name="uploadFile"  accept="image/*" onchange="readURL(this);" id="profile_img_upload" > 
								<label for='profile_img_upload'><i class="far fa-file-image">&nbsp;파일 선택</i></label>
								<div id="blah_box">
									<img id="blah" src="images/${parking.parking_pic}" alt="기본이미지" onerror="this.parentNode.style.display='none'"/>
								</div>
						  
						 
						 
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea id="parking_content" name="parking_content" rows="7" cols="80">${parking.parking_content}</textarea>
						</td>
					</tr>
					<tr>
						<th></th>
						<td><input type="submit" class="btn_submit" value="수정하기" id="save">
						</td>

					</tr>
				</table>
			</div>
		</form>


	</div>
	<!-- 각자의 파트는 이곳까지 작업해주시면 되겠습니다. -->
	<jsp:include page="../tail.jsp"></jsp:include>
</body>

</html>