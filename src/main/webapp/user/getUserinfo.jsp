<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


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
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<title>Document</title>
<script src="js/jquery-1.12.4.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<style>
#ftr{
	clear:both;
}
#cntnr{
	clear:both
	}
.userupdate_form{
	width:900px;
	margin : 0 auto;
	/*background:#ccc;*/
	clear:both;
}

#userupdate_title {
     text-align: center;
     font-size: 2em;
	 padding:0 0 20px 0;
	 font-weight:400;
 }
#userForm{
	/*background:pink;*/
	width:850px;
	float:right;
}

 th {
     font-weight: 500;
     text-align: right;
     height: 50px;
     padding : 30px 50px 10px 0;
 }
 td{
 	width: 600px;
 	height: 50px;
    padding: 30px 0 10px 0;
 }

 input option {
     height: 30px;
 }
 .hidden{
 	display : none;
 }
 .hidden_btn{
 	width:400px;
 	display : none;
 	/*float:left;*/
 	margin : 0 auto;
 	text-align:right;
 }	
 #save_btn{
 	float:left;
 	margin:0 -5px 30px 0;
 }
 
#delete_file{
	width :20px;
	margin-left:200px;
}
 /* 파일장css */
 #blah_box{
	width: 200px;
	height: 200px;
	margin: 0 0 20px 60px;
	background-image: url('<%=request.getContextPath()%>/images/UserProfile.png');
	background-size: cover;
}
#blah {
	/*
	border: solid 1px pink;
	width:200px;
	height:200px;
	*/
}
img {
  width: 200px;
  height: 200px;
  border-radius: 50% 50%;
  object-fit: cover;
}
#profile_img_upload{
   width: 0.1px;
	height: 0.1px;
	opacity: 0;
	overflow: hidden;
	position: absolute;
	z-index: -1;
	margin: 0 0 20px 0;
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

.radio1{
    margin: 0px 5px 20px 30px;
}
.radio_a{
    margin: 0px 5px 20px 30px;
}
.radio_b{
    margin: 0px 5px 20px 16px;
}
.radio_c{
    margin: 0px 5px 20px 45px;
}
.nickChk {
	width:80px;
	height:29px;
	background: #367FFF;
	color: #fff;
	font-size:100;
	border: 1px solid transparent;
	border-radius: .25rem;
	border-color:#367FFF;
}
.nickChk:hover {
  cursor: pointer;
  text-decoration: none;
}
#car_num_chk{
	width:80px;
	height:29px;
	background: #367FFF;
	color: #fff;
	font-size:100;
	border: 1px solid transparent;
	border-radius: .25rem;
	border-color:#367FFF;
}
#car_num_chk:hover {
  cursor: pointer;
  text-decoration: none;
}
#user_check_button {
	margin:0 auto;
	font-weight :400;
	width: 50%;
	height: 50px;
	border: 1px solid transparent;
	font-size: 1rem;
	color: #fff;
	border-radius: .25rem;
	background-color: #367FFF;
	border-color: #367FFF;
	text-align:center;
	transition: all 0.5s ease-in-out 0s;
}
#user_check_button:hover {
  cursor: pointer;
  text-decoration: none;
}
.save{
	  width:150px;
	  height:50px;
	  padding:0;
	  display:inline; 
	  border-radius: 4px; 
	  border: 1px solid transparent;
	  background: #367FFF;
	  color: #fff;
	  margin: 5px 2px 10px 0px;
	  transition: all 0.5s ease-in-out 0s;
	  font-size:200;
	  font-weight :400;
}
.save:hover {
  cursor: pointer;
  text-decoration: none;
}

      /*이메일 인증*/ 
#user_check_input_box_false{
	width:295px;
    background-color:#ebebe4;
}
.user_check_input{
	width:293px;
} 
#user_check_input_box_true{
	
    background-color:white;
}
.correct{
    color : green;
}
.incorrect{
    color : red;
}
</style>
<script>
	//엔터시 폼전송 방지
	
	document.addEventListener('keydown', function(event) {
	  if (event.keyCode === 13) {
	    event.preventDefault();
	  };
	}, true);
	
	 $(document).ready(function(){
		 console.log("^^")
		 console.log( $('#blah').attr('src'))
		 carnumchk();
		 
			// 수정버튼 눌렀을때
            $(".user_check_button").click(function(){
            	
            	if ($('#user_password_now').val() == "") {
                    alert("현재 비밀번호를 입력하세요.");
                    return false;
                }
            	
            	else{
                  	$.ajax({
                  		type : "post",
                  		url : "/Where2Park/checkPw.do",
           				data : 
           					//user_password_now : $("#user_password_now").val(),
           					//user_id : $("#user_id").val()
           					$("#delForm").serializeArray(),
           				
           				success : function(data){
           					console.log(data)
           					if(data == 0){
           						alert("비밀번호가 맞지 않습니다.")
           					}else{
           						alert("비밀번호가 맞습니다.");
				                 var cehckBox = $(".user_check_input");        // 
				                 var boxWrap = $(".user_check_input_box");    // 
				                 var radio = $(".radio")
				                 var radio_lo = $(".radio_lo")
				                 var radio_lo1 = $(".radio_lo1")
				                 var radio_lo2 = $(".radio_lo2")
				                 var pwattr = $(".user_check_input_attr");
				                 
				                 cehckBox.attr("disabled",false);
				                 radio.attr("disabled",false);
				                 radio_lo.attr("disabled",false);
				                 radio_lo1.attr("disabled",false);
				                 radio_lo2.attr("disabled",false);
				                 pwattr.attr("disabled",true);
				                 
				                 //boxWrap.attr("id", "user_check_input_box_true")
				                 $("#user_password_now").val('');
				                 
				                 $(".hidden_btn").show();
				                 $(".hidden").show();
				                 $(".show_btn").hide();
				                 
           					}
           				}
                  	})
                }
             });
            
			//이미지삭제
			$("#delete_file").on("click", function(){
				console.log("삭제버튼 누름")
				$('#blah').removeAttr('src');
				console.log( $('#blah').attr('src'))
				
			})
			
			//저장하기 눌렀을때
			$("#save").click(function(event){
				if($('#user_password_new').val() == ""){
					alert("새비밀번호를 입력해주세요");
					return false;
				}else {
                    //비밀번호 유효성 (비밀번호8자리 이상, 숫자포함, )
                    var pw = $("#user_password_new").val();
                    var email = $("#user_email").val();
                    var checkNumber = pw.search(/[0-9]/g);
                    var checkEnglish = pw.search(/[a-z]/ig);
                    if (!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test(pw)) {
                        alert('숫자+영문자+특수문자 조합으로 8자리 이상 사용해야 합니다.');
                        return false;
                    } else if (checkNumber < 0 || checkEnglish < 0) {
                        alert("숫자와 영문자를 혼용하여야 합니다.");
                        return false;
                    } else if (/(\w)\1\1\1/.test(pw)) {
                        alert('같은 문자를 4번 이상 사용하실 수 없습니다.');
                        return false;
                    } else if (pw.search(email) > -1) {
                        alert("비밀번호에 아이디가 포함되었습니다.");
                        return false;
                    } else {
                        console.log("비번통과");
                    }
                    
                }
				if($('#user_passwordChk').val() == ""){
					alert("새비밀번호를 다시 한번  입력해주세요");
					return false;
				}
				if ($('#user_nickname').val() == "") {
                    alert("닉네임을 입력하세요.");
                    return false;
                }
				return true;
				alert("저장이 완료되었습니다.")
				
			})
			
			//비밀번호 확인창
            $(function () {
                $('#user_password_new').keyup(function () {
                    $('#chkNotice').html('');
                });
                $('#user_passwordChk').keyup(function () {

                    if ($('#user_password_new').val() != $('#user_passwordChk').val()) {
                        $('#chkNotice').html('비밀번호 일치하지 않음');
                        $('#chkNotice').css('color', 'red');
                    } else {
                        $('#chkNotice').html('비밀번호 일치함');
                        $('#chkNotice').css('color', 'green');
                    }
                });
            
               });
			
			
		 
	 });
	 
		//이미지보이기
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
		//닉네임 중복검사
        function fn_nickChk(){
        	$.ajax({
        		url : "/Where2Park/nickChk.do",
        		type : "post",
        		dataType : "json",
   				data : {"user_nickname" : $("#user_nickname").val()},
   				success : function(data){
   					if(data == 1){
   						alert("중복된 닉네임 입니다.");
   					}else if(data == 0){
   						alert("사용가능한 닉네임입니다.")
   						$("#nickChk").attr("value" , "Y");
   					}
   				}
        	})
        }
		
		//차 번호 유효성검사
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
		
		// 탈퇴 버튼시 한번더 확인
		function clickleave(user_id){
			var chk = confirm("정말 탈퇴하시겠습니까?")
			if(chk){
				location.href="deleteUser.do?user_id=" + user_id; 
			}
		}
		
		// 저장 버튼시 한번더 확인
		function clickupdate(user_id){
			var chk = confirm("변경사항을 저장 하시겠습니까?")
			if(chk){
				location.href="updateUser.do?user_id=" + user_id; 
			}
		}
		
		
</script>


</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
				
	
	<div id="cntnr">
		<!-- 각자의 파트는 이곳에서부터 작업하실 수 있습니다. -->
		<div class="cntnr-top-margin"></div>

		<div class="userupdate_form">

            <p id="userupdate_title"> 회 원 정 보 수 정</p>
            <form method="post" action="updateUser.do" enctype="multipart/form-data" id="delForm">
                <table id="userForm">
                <!-- 이미지부분 -->
                    <tr>
                        <th></th>
                        <td>
                            <div id="blah_box">
                            	<c:set var="url" value="${user.user_pic}"/>
                            	<c:choose>
                            		<c:when test="${fn:contains(url,'http')}">
	                                	<img id="blah" src="${user.user_pic}" />
                            		</c:when>
                            		<c:when test='${user.user_pic ne null }'>
	                                	<img id="blah" src="images/profile/${user.user_pic}"  />
									</c:when>                            		
                            	</c:choose>
                            <!-- 
                            <input type="button" name="delete_file" id="delete_file" value="삭제버튼" src="images/xbutton.png">
                             -->
                            </div>
                            <input type="file" name="uploadFile_F"  accept="image/*" onchange="readURL(this);" id="profile_img_upload" > 
                            <label for='profile_img_upload'><i class="far fa-file-image">&nbsp;파일 선택</i></label>
                                
                        </td>
                    </tr>
                
                    <tr>
                        <th>
                          	  이메일
                        </th>
                        <td>
                        	<input type="hidden" name="user_id" id="user_id" value="${user.user_id}" > 
                            <input type="text" name="user_email" id="user_email" value="${user.user_email}" class="user_check_input" readonly> 
                        </td>
                    </tr>
                    <tr>
                        <th> 현재 비밀번호 </th>
                        <td> 
	                        <input type="password" size="33" id="user_password_now" name="user_password" class="user_check_input_attr">
                        </td>
                    </tr>
            <tbody class="hidden">
                    <tr>
                        <th> 새 비밀번호 </th>
                        <td> 
                        <!-- 
                        <input type=text name="user_password" class="user_check_input" disabled="disabled"><br/>
                         -->
                        <input type="password" size="33"  id="user_password_new" name="user_password"  class="user_check_input"  disabled="disabled">
                            <p>
					                                연속문자, 이메일이 포함된 비밀번호는 사용불가 <br>
					                                숫자, 영문자, 특수문자 조합 8자리 이상 사용하능
                            </p>
                        </td>
                    </tr>
                    <tr>
                        <th> 새 비밀번호 확인 </th>
                        <td> <input type="password" size="33" id="user_passwordChk" placeholder="비밀번호 입력 확인" class="user_check_input" disabled="disabled">
                            <p id="chkNotice" size="2"></p>

                        </td>
                    </tr>
                    <tr>
                        <th> 닉네임 </th>
                        <td> <input type="text" size="33" name="user_nickname" id="user_nickname" class="user_check_input" disabled="disabled"
                                value="${user.user_nickname}">
                            <button id="nickChk" type="button" class="nickChk" name="nickChk" onclick="fn_nickChk()" value="N">중복확인
                       		</button>
                       		
                       		<!-- 메일 인증번호 
								<div class="user_check_wrap">
									<div class="user_check_input_box" id="user_check_input_box_false">
										<input class="user_check_input" disabled="disabled">
									</div>
									<div class="clearfix"></div>
										<span id="user_check_input_box_warn"></span>

								</div>-->
								
                        </td>
                    </tr>
                    <tr>
                        <th> 휴대폰 </th>
                        <td>
                            <input type="text" name="user_phone" id="user_phone" value="${user.user_phone}" class="user_check_input" disabled="disabled">
                        </td>
                    </tr>
                    <tr>
                        <th>차량 번호</th>
                        <td>
                            <input type="text" id="car_num" name="car_num" value="${user.car_num}" class="user_check_input" disabled="disabled">
                        	<input type="button" value="확인하기" id="car_num_chk">
                        </td>
                    </tr>
                    <tr>
                        <th>차종</th>
                        <td>
                            <input type="radio" name="car_type" id="c1"	value="대형" class="radio"  disabled="disabled" 
							<c:if test="${user.car_type eq '대형'}"> checked </c:if> />
							<label for="c1">대형</label> <input type="radio" 
							name="car_type" id="c2" value="중형" class="radio radio1" disabled="disabled"
							<c:if test="${user.car_type eq '중형'}">checked</c:if> />
							<label for="c2">중형</label> <input type="radio"
							name="car_type" id="c3" value="준중형" class="radio radio1" disabled="disabled"
							<c:if test="${user.car_type eq '준중형'}">checked</c:if> />
							<label for="c3">준중형</label> <input type="radio"
							name="car_type" id="c4" value="경차" class="radio radio1" disabled="disabled"
							<c:if test="${user.car_type eq '경차'}">checked</c:if> />
							<label for="c4">경차</label> <input type="radio"
							name="car_type" id="c5" value="기타" class="radio radio1" disabled="disabled"
							<c:if test="${user.car_type eq '기타'}">checked</c:if> />
							<label for="c5">기타</label> 
                        </td>
                    </tr>
                    <tr>
                        <th>지역</th>
                        <td>
							<input type="radio" name="car_location" id="l1" value="강남구" class="radio_lo" disabled="disabled"
								<c:if test="${user.car_location eq '강남구'}"> checked </c:if> />
                                <label for="l1">강남구</label> 
                            <input type="radio" name="car_location" id="l2" value="강동구" class="radio_lo radio_a" disabled="disabled"
                            <c:if test="${user.car_location eq '강동구'}"> checked </c:if> />
                                <label for="l2">강동구</label> 
                            <input type="radio" name="car_location" id="l3" value="강북구" class="radio_lo radio_a" disabled="disabled"
                            <c:if test="${user.car_location eq '강북구'}"> checked </c:if> /> 
                                <label for="l3">강북구</label> 
                            <input type="radio" name="car_location" id="l4" value="강서구" class="radio_lo radio_a" disabled="disabled"
                            <c:if test="${user.car_location eq '강서구'}"> checked </c:if> />
                                <label for="l4">강서구</label> 
                            <input type="radio" name="car_location" id="l5" value="관악구" class="radio_lo radio_a" disabled="disabled"
                            <c:if test="${user.car_location eq '관악구'}"> checked </c:if> />
                                <label for="l5">관악구</label> <br/>
                            <input type="radio" name="car_location" id="l6" value="광진구" class="radio_lo" disabled="disabled"
                            <c:if test="${user.car_location eq '광진구'}"> checked </c:if> />
                                <label for="l6">광진구</label> 
                            <input type="radio" name="car_location" id="l7" value="구로구" class="radio_lo radio_a" disabled="disabled"
                            <c:if test="${user.car_location eq '구로구'}"> checked </c:if> />
                                <label for="l7">구로구</label> 
                            <input type="radio" name="car_location" id="l8" value="금천구" class="radio_lo radio_a" disabled="disabled"
                            <c:if test="${user.car_location eq '금천구'}"> checked </c:if> /> 
                                <label for="l8">금천구</label>
                            <input type="radio" name="car_location" id="l9" value="노원구" class="radio_lo radio_a" disabled="disabled"
                            <c:if test="${user.car_location eq '노원구'}"> checked </c:if> />
                                <label for="l9">노원구</label> 
                            <input type="radio" name="car_location" id="l10" value="도봉구" class="radio_lo radio_a" disabled="disabled"
                            <c:if test="${user.car_location eq '도봉구'}"> checked </c:if> />
                                <label for="l10">도봉구</label> <br/>
                            <input type="radio" name="car_location" id="l11" value="동대문구" class="radio_lo" disabled="disabled"
                            <c:if test="${user.car_location eq '동대문구'}"> checked </c:if> /> 
                                <label for="l11">동대문구</label>
                            <input type="radio" name="car_location" id="l12" value="동작구" class="radio_lo1 radio_b" disabled="disabled"
                            <c:if test="${user.car_location eq '동작구'}"> checked </c:if> /> 
                                <label for="l12">동작구</label> 
                            <input type="radio" name="car_location" id="l13" value="마포구" class="radio_lo radio_a" disabled="disabled"
                            <c:if test="${user.car_location eq '마포구'}"> checked </c:if> /> 
                                <label for="l13">마포구</label>
                            <input type="radio" name="car_location" id="l14" value="서대문구" class="radio_lo radio_a" disabled="disabled"
                            <c:if test="${user.car_location eq '서대문구'}"> checked </c:if> /> 
                                <label for="l14">서대문구</label>
                            <input type="radio" name="car_location" id="l15" value="서초구" class="radio_lo1 radio_b" disabled="disabled"
                            <c:if test="${user.car_location eq '서초구'}"> checked </c:if> />
                                <label for="l15">서초구</label> <br/>
                            <input type="radio" name="car_location" id="l16" value="성동구" class="radio_lo " disabled="disabled"
                            <c:if test="${user.car_location eq '성동구'}"> checked </c:if> />
                                <label for="l16">성동구</label>
                            <input type="radio" name="car_location" id="l17" value="성북구" class="radio_lo radio_a"  disabled="disabled"
                            <c:if test="${user.car_location eq '성북구'}"> checked </c:if> />
                                <label for="l17">성북구</label> 
                            <input type="radio" name="car_location" id="l18" value="송파구" class="radio_lo radio_a" disabled="disabled"
                            <c:if test="${user.car_location eq '송파구'}"> checked </c:if> />
                                <label for="l18">송파구</label>
                            <input type="radio" name="car_location" id="l19" value="양천구" class="radio_lo radio_a" disabled="disabled"
                            <c:if test="${user.car_location eq '양천구'}"> checked </c:if> />
                                <label for="l19">양천구</label>
                            <input type="radio" name="car_location" id="l20" value="영등포구" class="radio_lo radio_a" disabled="disabled"
                            <c:if test="${user.car_location eq '영등포구'}"> checked </c:if> /> 
                                <label for="l20">영등포구</label> <br/>
                            <input type="radio" name="car_location" id="l21" value="용산구" class="radio_lo " disabled="disabled"
                            <c:if test="${user.car_location eq '용산구'}"> checked </c:if> />
                                <label for="l21">용산구</label>
                            <input type="radio" name="car_location" id="l22" value="은평구" class="radio_lo radio_a" disabled="disabled"
                            <c:if test="${user.car_location eq '은평구'}"> checked </c:if> />
                                <label for="l22">은평구</label>    
                            <input type="radio" name="car_location" id="l23" value="종로구" class="radio_lo radio_a" disabled="disabled"
                            <c:if test="${user.car_location eq '종로구'}"> checked </c:if> />
                                <label for="l24">종로구</label> 
                            <input type="radio" name="car_location" id="l24" value="중구" class="radio_lo radio_a" disabled="disabled"
                            <c:if test="${user.car_location eq '중구'}"> checked </c:if> />
                                <label for="l24">중구</label>
                            <input type="radio" name="car_location" id="l25" value="중량구" class="radio_lo2 radio_c" disabled="disabled"
                            <c:if test="${user.car_location eq '중량구'}"> checked </c:if> />
                                <label for="l25">중량구</label> <br/>
                            <input type="radio" name="car_location" id="l26" value="기타" class="radio_lo " disabled="disabled"
                            <c:if test="${user.car_location eq '기타'}"> checked </c:if> />
                                <label for="l26">기타</label>
                        </td>
                    </tr>
             </tbody>
            		<tr>
            		<th></th>
            		<td>
            		<div class="show_btn">
            		<button id="user_check_button" type="button" class="user_check_button" value="N" >수정하기	</button>
			        <!-- 
			        <input type="button" value="저장하기" onclick="clickupdate(${user.user_id })">
			         -->
            		</div>
            		</td>
            		</tr>
            		
            		
            </table>
            <div class="hidden_btn" id="save_btn">
			        <button type="submit" class="save" id="save" name="save" href="updateUser.do?user_id=${user.user_id }"> 저장하기 </button>
            </div>
            </form>
            
            <form method="post" action="deleteUser.do" >
            	<div class="hidden_btn" id="delete_btn">
            		<input type="button" class="save" value="탈퇴하기" onclick="clickleave(${user.user_id })">
            	</div>
			 </form>


        </div>



		<!-- 각자의 파트는 이곳까지 작업해주시면 되겠습니다. -->
	</div>


	<jsp:include page="../tail.jsp"></jsp:include>
</body>
</html>