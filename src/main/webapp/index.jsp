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

<link rel="shortcut icon" href="<%=request.getContextPath()%>/favicon.ico">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<script src="https://kit.fontawesome.com/415f6f6023.js" crossorigin="anonymous"></script>
<title>어따세워?</title>
<script src="js/jquery-1.12.4.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
<style>
   @import url(http://www.justinaguilar.com/animations/css/animations.css);
   .blinking{ -webkit-animation:blink 1s ease-in-out infinite alternate; -moz-animation:blink 1.5s ease-in-out infinite alternate; animation:blink 1.5s ease-in-out infinite alternate; } @-webkit-keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} } @-moz-keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} } @keyframes blink{ 0% {opacity:0;} 100% {opacity:1;} }
   
   * {
      margin: 0;
      padding: 0;
      list-style-type: none;
      text-decoration: none;
      font-family: 'Noto Sans KR', sans-serif;
      font-size: 1em;
      font-weight: 300;
      color: #000;
   }
   
   body {
      width: 100%;
      height: auto;
      /* body에 스타일링을 지양해주십시오. */
      z-index:10;
   }
   
   #hdr {
      width: 100%;
      min-height: 150px;
      height: auto;
      box-sizing: border-box;
      padding: 0 50px 0 40px;
      box-shadow: 1px 1px 5px rgba(0, 0, 0, 0.1);
      overflow: hidden;
   }
   
   #hdr .hdr-logo {
      width: 150px;
      height: 150px;
      background: url("LOGO.png") no-repeat;
      background-size: cover;
      float: left;
   }
   
   #hdr #nav {
      float: right;
   }
   
   #hdr #nav ul {
      float: right;
   }
   
   #hdr #nav li {
      float: right;
      padding: 0px 20px;
      line-height: 150px;
   }
   
   #hdr>#nav>ul>li>a{
       transition: all .3s ease;
       font-weight:400;
       font-size:1.1em;
   }
   #hdr>#nav>ul>li:hover>a{
   	color:#367fff;
   }
   #hdr #nav ul #nav-mp{
                  
   }
   #hdr #nav ul #nav-mp ul{
      display:none;
      background:#ffffff;
      box-shadow:1px 1px 5px rgba(0, 0, 0, 0.1);
   }
   #hdr #nav ul #nav-mp:hover ul{
      display:block;
      position:absolute;
      /* z-index:10; */
      
   }
   #hdr #nav ul #nav-mp ul li{
	   font-size:0.95em;
      clear:both;
      line-height:70px;
      width:140px;
      text-align:center;
      transition: all .3s ease;
   }
   #hdr #nav ul #nav-mp ul li:hover{
      background:#e9e9e9;
   }
   #cntnr {
      clear: both;
      width: 60%;
      min-height: 600px;
      height: auto;
      margin: 0 auto;
   }
   
   #cntnr .cntnr-top-margin {
      width: 100%;
      height: 40px;
   }
   
   #ftr {
      width: 100%;
      min-height: 200px;
      height: auto;
      background: #eee;
      font-size: 0.8em;
      line-height: 2em;
   }
   
   #ftr .wrapper {
      width: 60%;
      min-height: 200px;
      height: auto;
      margin: 0 auto;
   }
   
   #ftr .wrapper #ftr-nav {
      height: 50px;
   }
   
   #ftr .wrapper #ftr-nav ul {
      float: left;
   }
   
   #ftr .wrapper #ftr-nav ul li {
      padding: 20px 20px 15px 20px;
      float: left;
   }
   
   #ftr .wrapper #ftr-nav ul li:first-child {
      padding: 20px 20px 15px 0px;
   }
   
   #ftr .wrapper .ftr-arti {
      clear: both;
   }
   
   #ftr .wrapper .ftr-arti p {
      padding: 0 0 10px 0;
   }
   
   /* main-margin 공백*/
   .main-margin {
      height: 50px;
   }
   
   /* MainPage 검색창 부분*/
   .main-search {
      background-color: #367FFF;
      height: 400px;
      padding: 40px 20% 190px 20%;
      box-sizing: border-box;
   }


   .main-wrapper {
      width: 100%;
      height: 100px;
      /* margin-left: 5%; */
   }

   #main-wrapper-back{
      width: 95%;
      height: 38px;
      background-color: white;
      margin : -72px 0 0 18px;
   }

   .search-text{
      font-size: 16px;
      color: whitesmoke;
      font-weight: 500;
      margin : 0 0 0 20px;
   }

   .search-type {
      float: left;
      /* width: 29%; */
      width: 30%;
      /*  margin: 0 5px 0 5px;*/
      font-size:14px;
   }
   
   .search-type .main-input-box {
      height: 26px;
      width: 95%;
      margin: 5px 0 0 20px;
      border: 5px solid white;
      border-radius: 0px;
      cursor: pointer;
   }
   
   #search-button {
      width: 36px;
      height: 36px;
      margin: -36px 20px 0 200px;
      float: right;
      -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
      border-radius: 0px;
      border : 0 ;
      cursor: pointer;
      background-image: url("<%=request.getContextPath()%>/images/searchIcon.png");
      background-color: white;
      background-repeat: no-repeat;
      background-size: 35px;
   }
   
   /*추천 알고리즘*/
   #cntnr #recommendation {
      width: 100%;
      /* height: 350px; */
      max-height: 350px;
      /*border: 1px solid #ccc;*/
      box-sizing: border-box;
      margin: 0 0 20px 0;
      position: relative;
      z-index: 997;
   }
   
   #recommendation-title {
      font-size: 1.5em;
      font-weight: bold;
      text-align: center;
   }
   
   .recommendation-box {
      width: 30%;
      min-height: 240px;
      height: 350px;
      border: 1px solid #ccc;
      box-shadow: 1px 1px 1px rgba(0, 0, 0, 0.1);
      margin: 0 5% 0 0;
      float: left;
      box-sizing: border-box;
      border-radius: 2px;
      cursor: pointer;
      /* position : absolute; */
   }
   
   .reco-img{
      /* background-color:blue; */
      width: 100%;   
      height: 200px;
      border-radius: 2px;
   }

   .recommendation-box:last-child {
      margin: 0;
   }
   
   .reco-content{
      margin: 0 2% 0 2% ;
   }
   .reco-type{
      font-size: 13px;
      font-weight: bold;
   }
   .reco-title{
      font-weight: bold;
      font-size: 15px;
      border-bottom: 1px solid #ccc;
      padding: 5px 0 5px 0;
   }
   .reco-cartype{
      font-size: 15px;
      font-weight: 400;
      padding: 5px 0 0 0;
   }
   .reco-price{
      font-size: 15px;
      font-weight: 400;
      padding: 5px 0 0 0;
   }
   .reco-intime{
      font-size: 12px;
      padding-top: 2px;
   }
   
   /*알림창*/
   .chatModal{
   	  display: none;
   }
   
   .btn-primary{
      position: fixed;
      top : 78%;
      right : 0px;
   }
   
   .new-chat {
      color: white;
      width: 110px;
      height : 35px;
      background-color: #428bca;
      padding: 10px 0 0 10px;
      border-radius: 10px;
   }
   .fa-comment-dots {
      color: white;
   }
   #modal-title {
      font-size: 20px;
      font-weight: 500;
   }
   #chatNoticeMessage{
      width: 50%;
      font-size: 18px;
   }
   #chatNoticeMessage .fa-envelope-square{
      font-size: 20px;
      color: #428bca;
   }
   .btn-default {
      -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        border: 1px solid #333;
        color: white;
        box-shadow: 1px 1px 1px rgba(0, 0, 0, 0.1);
        width : 50px;
        height : 35px;
        margin: 0 12px 0 0;
   }

   /*부트스트랩 뜯은 부분*/
   .modal-header-primary { color:#fff; padding:9px 15px; border-bottom:1px solid #eee; background-color: #428bca; -webkit-border-top-left-radius: 5px; -webkit-border-top-right-radius: 5px; -moz-border-radius-topleft: 5px; -moz-border-radius-topright: 5px; border-top-left-radius: 5px; border-top-right-radius: 5px; }

   .btn-primary {color:#fff; background-color:#428bca; border-color:#357ebd;}
   .btn-primary:hover,.btn-primary:focus,.btn-primary:active,.btn-primary.active,.open .dropdown-toggle.btn-primary{color:#fff;background-color:#3276b1;border-color:#285e8e}
   .btn-primary:active,.btn-primary.active,.open .dropdown-toggle.btn-primary{background-image:none}
   .btn-primary.disabled,.btn-primary[disabled],fieldset[disabled] .btn-primary,.btn-primary.disabled:hover,.btn-primary[disabled]:hover,fieldset[disabled] .btn-primary:hover,.btn-primary.disabled:focus,.btn-primary[disabled]:focus,fieldset[disabled] .btn-primary:focus,.btn-primary.disabled:active,.btn-primary[disabled]:active,fieldset[disabled] .btn-primary:active,.btn-primary.disabled.active,.btn-primary[disabled].active,fieldset[disabled] .btn-primary.active{background-color:#428bca;border-color:#357ebd}
   .btn-primary .badge{color:#428bca;background-color:#fff}
   .text-primary{color:#428bca}
   a.text-primary:hover{color:#3071a9}.text-success{color:#3c763d}
   a.bg-primary:hover{background-color:#3071a9}

   .label-primary{background-color:#428bca}
   .label-primary[href]:hover,.label-primary[href]:focus{background-color:#3071a9}

   .well{min-height:20px;padding:19px;margin-bottom:20px;background-color:#f5f5f5;border:1px solid #e3e3e3;border-radius:4px;-webkit-box-shadow:inset 0 1px 1px rgba(0,0,0,.05);box-shadow:inset 0 1px 1px rgba(0,0,0,.05)}
   .well blockquote{border-color:#ddd;border-color:rgba(0,0,0,.15)}
   .well-lg{padding:24px;border-radius:6px}
   .well-sm{padding:9px;border-radius:3px}
   .close{float:right;font-size:21px;font-weight:700;line-height:1;color:#000;text-shadow:0 1px 0 #fff;opacity:.2;filter:alpha(opacity=20)}

   .modal-open{overflow:hidden}
   .modal{display:none;overflow:auto;overflow-y:scroll;position:fixed;top:0;right:0;bottom:0;left:0;z-index:1050;-webkit-overflow-scrolling:touch;outline:0}
   .modal.fade .modal-dialog{-webkit-transform:translate(0,-25%);-ms-transform:translate(0,-25%);transform:translate(0,-25%);-webkit-transition:-webkit-transform .3s ease-out;-moz-transition:-moz-transform .3s ease-out;-o-transition:-o-transform .3s ease-out;transition:transform .3s ease-out}
   .modal.in .modal-dialog{-webkit-transform:translate(0,0);-ms-transform:translate(0,0);transform:translate(0,0)}
   .modal-dialog{position:relative;width:auto;margin:10px}
   .modal-content{position:relative;background-color:#fff;border:1px solid #999;border:1px solid rgba(0,0,0,.2);border-radius:6px;-webkit-box-shadow:0 3px 9px rgba(0,0,0,.5);box-shadow:0 3px 9px rgba(0,0,0,.5);background-clip:padding-box;outline:0}
   .modal-backdrop{position:fixed;top:0;right:0;bottom:0;left:0;z-index:1040;background-color:#000}
   .modal-backdrop.fade{opacity:0;filter:alpha(opacity=0)}
   .modal-backdrop.in{opacity:.5;filter:alpha(opacity=50)}
   .modal-header{padding:15px;border-bottom:1px solid #e5e5e5;min-height:16.428571429px}
   .modal-header .close{margin-top:-2px}
   .modal-title{margin:0;line-height:1.428571429}
   .modal-body{position:relative;padding:20px;}
   .modal-footer{margin-top:15px;padding:19px 20px 20px;text-align:right;border-top:1px solid #e5e5e5}
   .modal-footer .btn+.btn{margin-left:5px;margin-bottom:0}
   .modal-footer .btn-group .btn+.btn{margin-left:-1px}
   .modal-footer .btn-block+.btn-block{margin-left:0}
   @media (min-width:768px){.modal-dialog{width:600px;margin:30px auto}
   .modal-content{-webkit-box-shadow:0 5px 15px rgba(0,0,0,.5);box-shadow:0 5px 15px rgba(0,0,0,.5)}
   .modal-sm{width:300px}.modal-lg{width:900px}}
   .tooltip{position:absolute;z-index:1030;display:block;visibility:visible;font-size:12px;line-height:1.4;opacity:0;filter:alpha(opacity=0)}.tooltip.in{opacity:.9;filter:alpha(opacity=90)}.tooltip.top{margin-top:-3px;padding:5px 0}
   .tooltip.right{margin-left:3px;padding:0 5px}

   .btn-default{color:#333;background-color:#fff;border-color:#ccc}
   .btn-default:hover,.btn-default:focus,.btn-default:active,.btn-default.active,.open .dropdown-toggle.btn-default{color:#333;background-color:#ebebeb;border-color:#adadad}
   .btn-default:active,.btn-default.active,.open .dropdown-toggle.btn-default{background-image:none}
   .btn-default.disabled,.btn-default[disabled],fieldset[disabled] .btn-default,.btn-default.disabled:hover,.btn-default[disabled]:hover,fieldset[disabled] .btn-default:hover,.btn-default.disabled:focus,.btn-default[disabled]:focus,fieldset[disabled] .btn-default:focus,.btn-default.disabled:active,.btn-default[disabled]:active,fieldset[disabled] .btn-default:active,.btn-default.disabled.active,.btn-default[disabled].active,fieldset[disabled] .btn-default.active{background-color:#fff;border-color:#ccc}
   .btn-default .badge{color:#fff;background-color:#333}
   .btn-primary{color:#fff;background-color:#428bca;border-color:#357ebd; border-radius:8px; margin: 0 5px 0 0;}
   .btn-primary:hover,.btn-primary:focus,.btn-primary:active,.btn-primary.active,.open .dropdown-toggle.btn-primary{color:#fff;background-color:#3276b1;border-color:#285e8e}
   .btn-primary:active,.btn-primary.active,.open .dropdown-toggle.btn-primary{background-image:none}
   .btn-primary.disabled,.btn-primary[disabled],fieldset[disabled] .btn-primary,.btn-primary.disabled:hover,.btn-primary[disabled]:hover,fieldset[disabled] .btn-primary:hover,.btn-primary.disabled:focus,.btn-primary[disabled]:focus,fieldset[disabled] .btn-primary:focus,.btn-primary.disabled:active,.btn-primary[disabled]:active,fieldset[disabled] .btn-primary:active,.btn-primary.disabled.active,.btn-primary[disabled].active,fieldset[disabled] .btn-primary.active{background-color:#428bca;border-color:#357ebd}
   .btn-primary .badge{color:#428bca;background-color:#fff}
   #weather{
	    margin: 0 auto;
	    text-align: center;
	    color: #fff;
	    font-size: 1.2em;
	    padding: 40px;
   }
   .material-icons{
   		vertical-align: sub;
   }
   .aaa{
	   	display:inline;
	   	vertical-align: sub;
   }
   img{
   		width: 60px;
    	vertical-align: bottom
   }
   .image_back{
   		margin-bottom:10px;
   		
   }
   
   #chatbot{
   		width:100px;
   		height:100px;
	    /*background-color:pink;*/
	    position: fixed;
	    top: 86%; 
	    bottom: 80%;
	    right: 0px;
   }
	    
    @keyframes bot {
	    0%{margin-top: 0px;}
	    10%{margin-top: 2.5px;}
	    20%{margin-top: 5px;}
	    30%{margin-top: 7.5px;}
	    40%{margin-top: 10px;}
	    50%{margin-top: 12.5px;}
	    60%{margin-top: 10px;}
	    70%{margin-top: 7.5px;}
	    80%{margin-top: 5px;}
	    90%{margin-top: 2.5px;}
	    100% {margin-top: 0px;}
    }
   #bot{
   		width:100px;
   		/*z-index:99999;*/
   		position: fixed;
	    top: 85%; 
	    /*bottom: 80%;*/
	    right: 0px;
	    animation:bot 3s linear infinite alternate; 
	    pointer-events: none;
   }
   #ppp{
   		text-align: center;
	    font-size: 11px;
	    line-height: 80%;
	    margin-bottom: -10px;
   }
</style>
<script src="js/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
		$(document).ready(function(){
			reqWeather();
			
			function reqWeather(){
				$.ajax({
					url : "http://localhost:5000/query/WEATHER",
					type : "POST",
					success : function(data){
						console.log(data);
						var json_obj = JSON.parse(data);
						console.log(json_obj);
						console.log("지역: " + json_obj.local);
						console.log("온도: " + json_obj.temp);
						console.log("설명: " + json_obj.text);
						
						
						
						$('#weather_address').html(json_obj.local);
						$('#weather_temp').html(json_obj.temp);
						//$('#weather_text').html(json_obj.text);
						
						var desc = json_obj.text;
						
						if(desc.indexOf('맑음') !== -1){
							$('#weather_img').attr('src', './images/sun.png');
						}else if(desc.indexOf('구름많음') !== -1){
							$('#weather_img').attr('src', './images/cloudy-1.png');
						}else if(desc.indexOf('흐림') !== -1){
							$('#weather_img').attr('src', './images/cloudy_02.png');
						}else if(desc.indexOf('흐리고 비') !== -1){
							$('#weather_img').attr('src', './images/rainy_01.png');
						}else if(desc.indexOf('비') !== -1){
							$('#weather_img').attr('src', './images/rainy_02.png');
						}
					}
				});
			}
			
			//5분마다 호출
			setInterval(reqWeather, 1000*10*30);
			
			
		})
	
</script>
</head>
<body>
 		<a href="http://127.0.0.1:52273/" onClick="window.open(this.href, '_blank', 'width=500, height=430, left=900px, top=300px'); return false;" id="chatbot">
		   	<p id = "ppp">말을 걸어보세요</p>
		   	<img src="images/chatbot.png" id="bot">
   		</a>
   			
   <div id="hdr">
   		
        <a href="<%=request.getContextPath()%>/index.jsp"><div class="hdr-logo"></div></a>
        	
        <div id="nav">
            <ul>
                <c:if test="${empty sessionScope.userId or empty sessionScope.userNickName }">
                   <li><a href="<%=request.getContextPath()%>/user/userLogin.jsp">로그인 · 회원가입</a></li>
                </c:if>
            <c:if test="${!empty sessionScope.userId or !empty sessionScope.userNickName }">
                   <li id="nav-mp"><a href="#">마이페이지 /${userNickName} 님 환영합니다</a>
                  <ul>
                     <li><a href="<%=request.getContextPath()%>/logout.do">로그아웃</a></li>
                     <li><a href="<%=request.getContextPath()%>/noticeView.do">알람</a></li>
                     <li><a href="<%=request.getContextPath()%>/getRsvList.do?parker_id=${userId}">예약 내역</a></li>
                     <li><a href="<%=request.getContextPath()%>/getParkingList.do">공유 내역</a></li>
                     <li><a href="<%=request.getContextPath()%>/review_list.do?review_id=${userId}">리뷰 관리</a></li>
                     <li><a href="<%=request.getContextPath()%>/wish_list.do?user_id=${userId}">찜한 주차장</a></li>
                     <li><a href="<%=request.getContextPath()%>/getUserinfo.do">회원 정보 관리</a></li>
                  </ul>
                   </li>
                </c:if>
                <li><a href="<%=request.getContextPath()%>/parking/selectParkingType.jsp">내 주차장 공유하기</a></li>
                <li><a href="<%=request.getContextPath()%>/searchParkingList.do">장기주차</a></li>
                <li><a href="<%=request.getContextPath()%>/searchShortParkingList.do">단기주차</a></li>
            </ul>
        </div>
    </div>
   <div class="main-margin">
   -		
   			</div>
   
   <div class="main-search">
   			<div id="weather">
   				<span id='weather_text'></span>
				<div class="image_back">
        			<span id='weather_temp' style="font-size:50px; color:#fff;">   </span> 
        					<img id='weather_img' src="">
        					 
        			 <br/>
        		</div>
        		<span id='weather_address' style="font-size:1.2em; color:#fff;">  </span>
   				
   				
  			 <!-- 날씨 크롤링 
       		<c:if test="${text == '맑음'}">
        		<div class="image_back">
        			<span style="font-size:50px; color:#fff;"> ${temp}  </span> 
        					<img src="images/sun.png">
        			 <br/>
        		</div>
                 	 ${address}  
                  
             </c:if>-->
                 
                 
   			</div>
   			
      <div class="main-wrapper">

         <form action="getSearchParkingList.do" method="post">
            <div class="search-type">
               <span class="search-text">장소 검색</span><input class="main-input-box" type="text" name="parking_location"
                  value="${parkingVO.parking_location}" />
            </div>
            <div class="search-type">
               <span class="search-text">대여 시각</span><input class="main-input-box" type="datetime-local" class="calender"
                  name="parking_intime" value="${parkingVO.parking_intime}" />
            </div>
            <div class="search-type">
               <span class="search-text">반납 시각</span><input class="main-input-box" type="datetime-local" class="calender"
                  name="parking_outtime" value="${parkingVO.parking_outtime}" />
            </div>
            <input id="search-button" type="submit" value="">
         </form>
      </div>
      <div id="main-wrapper-back">
      </div>
   </div>
   <div class="main-margin"></div>
   <div id="cntnr">
      <!-- 각자의 파트는 이곳에서부터 작업하실 수 있습니다. -->
      <div class="cntnr-top-margin"></div>
      <p id="recommendation-title">🚙 가까운 주차장 추천 🚙</p>
      <div class="main-margin"></div>   
      <div id="recommendation">
      </div>
      <div class="chatModal">
         <a class='btn btn-primary' href='#primary' data-toggle='modal'>
            <h4 class='new-chat blinking'>
               <i class='far fa-comment-dots blinking'></i>  NEW CHAT
            </h4>
         </a>
         <div class='modal fade' id='primary' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>
            <div class='modal-dialog'>
               <div class='modal-content'>
                  <div class='modal-header modal-header-primary'>
                     <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>×</button>
                     <h1 id='modal-title'><i class='far fa-comment-dots'>  CHATTING</i></h1>
                  </div>
               <div class='modal-body'>상담하기로 이동하시겠습니까?</div>
               <div class='modal-footer'>
                  <button type='button' class='btn btn-default pull-left' id='modalYes' data-dismiss='modal'>YES</button></a>
                  <button type='button' class='btn btn-default pull-left' id='modalNo' data-dismiss='modal'>NO</button>
               </div>
            </div>
         </div>
      </div>
   </div>
   </div>
   <div id="ftr">
      <div class="wrapper">
         <div id="ftr-nav">
            <ul>
               <li><a href="#">이용약관</a></li>
               <li><a href="#">회사소개</a></li>
               <li><a href="#">개인정보 처리방침</a></li>
               <li><a href="#">위치기반 서비스 이용약관</a></li>
               <li><a href="#">안심운영정책</a></li>
            </ul>
         </div>
         <div class="ftr-arti">
            <p>
               ｜ 상호 : ㈜어따세워 ｜ 대표 : 문상환 ｜ 사업자등록번호 : 210-42-10003<br> ｜ 주소 :
               서울특별시 마포구 신수동 63-14 거구장 지층 비트캠프 신촌센터 5호<br> ｜ 전화 :
               02-3486-9600 ｜ 팩스 : 02-6007-1245 ｜ 통신판매업 신고번호 : 제 서초-00098호
            </p>
            <p>Copyright © 어따세워. All Rights Reserved.</p>
         </div>
      </div>
   </div>
</body>
<script src="header_js.jsp"></script>
<script src="index_js.jsp"></script>
</html>