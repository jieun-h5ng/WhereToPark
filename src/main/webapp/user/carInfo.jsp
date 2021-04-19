<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<title>자동차 정보 입력하기</title>
<script src="../js/jquery-1.12.4.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<style>
	#user_form{
            width: 100%;
            /* border: 1px solid black; */
            padding: 5% 5% 5% 5%;
        }
        h3{
        	text-align:center;
        	font-size:15px;
        	font-weight: 300;
        }
        #name{
        	font-weight: 500;
        	font-size:18px;
        }
        #carInfo_text_box{
       		width:600px;
        	margin:0 auto;
        }
        #carInfo_title_box{
            font-size:2em;
		    text-align:center;
		    font-weight:400;
		    padding:0 0 10px 0;
            
        }
        #cartype{
            margin-top: 80px;
            /* border: red solid 1px; */
            height: 150px;
        }
        #carnum{
            /* border: yellow solid 1px; */
            height: 150px;
        }
        #location{
            /* border: green solid 1px; */
            height: 350px;
        }
        #carinfo_A{
        	margin:0 auto;
        }
        .text_title{
            font-weight: bolder;
            /* color: black; */
            font-size: 20px;
            margin-bottom: 3%;
        }
        .radio{
            margin: 0% 1% 0% 7%;
        }
        .radio_lo{
            margin: 0% 1% 2% 7%;
        }
        .radio_lo1{
            margin: 0% 1% 2% 4.6%;
        }
        .radio_lo2{
            margin: 0% 1% 2% 8.7%;
        }
       
        #carinfo-btn{
        	width:250px;
        	margin: 0 auto;
        }
        #car_num_chk{
			width:80px;
			height:31px;
			background: #367FFF;
			border-radius: 4px;
			color: #fff;
			font-size:100;
			border: 1px solid transparent;
		}
		#car_num_chk:hover {
		  cursor: pointer;
		  text-decoration: none;
		}
		#submit{
			  width:250px;
			  height:40px;
			  padding:0;
			  display:inline; 
			  border-radius: .25rem;
			  background-color: #367FFF;
			  color: #fff;
			  margin:0 auto;
			  transition: all 0.5s ease-in-out 0s;
			  border: 1px solid transparent;
			  font-size:200;
			  text-align:center;
			  font-weight :400;
		}
		#submit:hover {
		  cursor: pointer;
		  text-decoration: none;
		}
	
</style>
<script>
	
	$(document).ready(function () {
	    console.log("??")
	    carnumchk();
	 });
	function carnumchk(){
		$("#car_num_chk").click(function(){
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
	            alert("차량번호가 형식이 맞지 않습니다.")
	            console.log(num)
	        }
	        
	    });
	}
	

</script>


</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
				
	
	<div id="cntnr">
		<!-- 각자의 파트는 이곳에서부터 작업하실 수 있습니다. -->
		<div class="cntnr-top-margin"></div>

		<div id="user_form">
            
            <div id="carInfo_title_box">
                <p id="carInfo_title"> 추가 정보</p>
            </div>
            
            <form action="insertCatInfo.do" method="post" name="carinfo" >
                <div id="carInfo_text_box">
	                <h3>
                   		어따세워 이용시 필요한 부가정보입니다.
                   		<span id="name">${user.user_nickname}</span> 님 추가정보 입력사항입니다.
    	            </h3>
                   		
                   		<input type="hidden"  name="user_id" value="${user.user_id}">
                   		 
                    <div id="cartype" class="carInfo_text">
                        <div class="text_title">
                          	  차종
                        </div>
                        <div id = "carinfo_A">
                        <input type="radio" name="car_type" id="c1" value="대형"  class="radio"> 
                            <label for="c1">대형</label> 
                        <input type="radio" name="car_type" id="c2" value="중형" class="radio"> 
                            <label for="c2">중형</label> 
                        <input type="radio" name="car_type" id="c3" value="준중형" class="radio"> 
                            <label for="c3">준중형</label>
                        <input type="radio" name="car_type" id="c4" value="경차" class="radio">
                            <label for="c4">경차</label>
                        <input type="radio" name="car_type" id="c5" value="기타" class="radio">
                            <label for="c5">기타</label>    
                        </div>
                    </div>

                    <div id="carnum" class="carInfo_text">
                        <div class="text_title">
                          	  차량 번호
                        </div>
                        <div>
                            <input type="text" id="car_num" name="car_num" placeholder="'11가 1234' , '123나 4567'">
                            <input type="button" value="확인하기" id="car_num_chk">

                        </div>
                    </div>
                    <div id="location" class="carInfo_text">
                        <div class="text_title">
                          	  지역 (이용지역을 선택해 주세요. 최대 1개 선택 가능)
                        </div>
                        <div>
                            <input type="radio" name="car_location" id="l1" value="강남구" class="radio_lo"> 
                                <label for="l1">강남구</label> 
                            <input type="radio" name="car_location" id="l2" value="강동구" class="radio_lo"> 
                                <label for="l2">강동구</label> 
                            <input type="radio" name="car_location" id="l3" value="강북구" class="radio_lo"> 
                                <label for="l3">강북구</label> 
                            <input type="radio" name="car_location" id="l4" value="강서구" class="radio_lo"> 
                                <label for="l4">강서구</label> 
                            <input type="radio" name="car_location" id="l5" value="관악구" class="radio_lo"> 
                                <label for="l5">관악구</label> <br/>
                            <input type="radio" name="car_location" id="l6" value="광진구" class="radio_lo"> 
                                <label for="l6">광진구</label> 
                            <input type="radio" name="car_location" id="l7" value="구로구" class="radio_lo"> 
                                <label for="l7">구로구</label> 
                            <input type="radio" name="car_location" id="l8" value="금천구" class="radio_lo"> 
                                <label for="l8">금천구</label>
                            <input type="radio" name="car_location" id="l9" value="노원구" class="radio_lo"> 
                                <label for="l9">노원구</label> 
                            <input type="radio" name="car_location" id="l10" value="도봉구" class="radio_lo"> 
                                <label for="l10">도봉구</label> <br/>
                            <input type="radio" name="car_location" id="l11" value="동대문구" class="radio_lo"> 
                                <label for="l11">동대문구</label>
                            <input type="radio" name="car_location" id="l12" value="동작구" class="radio_lo1" > 
                                <label for="l12">동작구</label> 
                            <input type="radio" name="car_location" id="l13" value="마포구" class="radio_lo"> 
                                <label for="l13">마포구</label>
                            <input type="radio" name="car_location" id="l14" value="서대문구" class="radio_lo"> 
                                <label for="l14">서대문구</label>
                            <input type="radio" name="car_location" id="l15" value="서초구" class="radio_lo1"> 
                                <label for="l15">서초구</label> <br/>
                            <input type="radio" name="car_location" id="l16" value="성동구" class="radio_lo"> 
                                <label for="l16">성동구</label>
                            <input type="radio" name="car_location" id="l17" value="성북구" class="radio_lo" > 
                                <label for="l17">성북구</label> 
                            <input type="radio" name="car_location" id="l18" value="송파구" class="radio_lo"> 
                                <label for="l18">송파구</label>
                            <input type="radio" name="car_location" id="l19" value="양천구" class="radio_lo"> 
                                <label for="l19">양천구</label>
                            <input type="radio" name="car_location" id="l20" value="영등포구" class="radio_lo"> 
                                <label for="l20">영등포구</label> <br/>
                            <input type="radio" name="car_location" id="l21" value="용산구" class="radio_lo"> 
                                <label for="l21">용산구</label>
                            <input type="radio" name="car_location" id="l22" value="은평구" class="radio_lo"> 
                                <label for="l22">은평구</label>    
                            <input type="radio" name="car_location" id="l23" value="종로구" class="radio_lo" > 
                                <label for="l24">종로구</label> 
                            <input type="radio" name="car_location" id="l24" value="중구" class="radio_lo"> 
                                <label for="l24">중구</label>
                            <input type="radio" name="car_location" id="l25" value="중량구" class="radio_lo2"> 
                                <label for="l25">중량구</label> <br/>
                            <input type="radio" name="car_location" id="l26" value="기타" class="radio_lo"> 
                                <label for="l26">기타</label>
                        </div>


                    </div>

                    <div class="carInfo_text">
                        <div id="carinfo-btn">
                            <input type="submit" value="입력하기" id="submit">
                        </div>
                    </div>
                    
                </div>

            </form>


        </div>




		<!-- 각자의 파트는 이곳까지 작업해주시면 되겠습니다. -->
	</div>


	<jsp:include page="../tail.jsp"></jsp:include>
</body>
</html>