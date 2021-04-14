<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<title>Insert title here</title>
<script src="../js/jquery-1.12.4.min.js"></script>
<style>
		#ftr{
			clear:both;
		}
		#cntnr{
			clear:both
			}
		#user_form{
			width:800px;
			margin : 0 auto;
			/*background:#ccc;*/
			clear:both;
		}
 		#userJoin_title {
 			font-size:2em;
		    text-align:center;
		    font-weight:400;
		    padding:0 0 20px 0;
        }
		#userForm{
			/*background:red;*/
			width:700px;
			float:right;
			
		}
        th {
            font-weight: 500;
            text-align: right;
            height: 50px;
            padding : 30px 50px 10px 0;
        }
        td{
        	height: 50px;
           	padding: 30px 0 10px 0;
        }

        input option {
            height: 30px;
        }

        .userJoin-btn {
            width: 100px;
            height: 32px;
        }

        
        #image_container {
        	margin:0 auto;
            border: solid 1px black;
            width: 250px;
            height: 250px;
            z-index: 999;
            text-align:right;
        }

        img {
            width: 200px;
            height: 200px;
            border-radius: 50% 50%;
        }
        /*이메일 인증*/ 
		#mail_check_input_box_false{
			width:295px;
		    background-color:#ebebe4;
		    
		}
		.mail_check_input{
			width:293px;
		} 
		#mail_check_input_box_true{
			
		    background-color:white;
		}
		.correct{
		    color : green;
		}
		.incorrect{
		    color : red;
		}
		
		/*파일창 css*/
		#blah_box{
			/*border: solid 1px black;*/
			/*right:130px;*/
			margin:0 30px 30px 40px;
			width: 200px;
			height: 200px;
		}
		#blah {
			width:200px;
			height:200px;
			z-index: 999;
		}
		#profile_img_upload{
	    width: 0.1px;
		height: 0.1px;
		opacity: 0;
		overflow: hidden;
		position: absolute;
		z-index: -1;
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
		/*
		input{
		 height:30px;
		}
		*/
		.nickChk {
			width:80px;
			height:29px;
			background: #367FFF;
			border-radius: 4px;
			color: #fff;
			font-size:100;
			border: 1px solid transparent;
		}
		.nickChk:hover {
		  cursor: pointer;
		  text-decoration: none;
		}
		.mail_check_button{
			width:100px;
			height:29px;
			background: #367FFF;
			border-radius: 4px;
			color: #fff;
			font-size:100;
			border: 1px solid transparent;
		}
		.mail_check_button:hover {
		  cursor: pointer;
		  text-decoration: none;
		}
		.userJoin-btn{
			  width:150px;
			  height:40px;
			  padding:0;
			  display:inline; 
			  border-radius: 4px; 
			  background: #367FFF;
			  color: #fff;
			  margin: 5px 0 50px 0px;
			  transition: all 0.5s ease-in-out 0s;
			  font-size:200;
			  border: 1px solid transparent;
		}
		.userJoin-btn:hover {
		  cursor: pointer;
		  text-decoration: none;
		}
		.pw_btn_01{
			margin : 0 0 0 50px;
		}
		.radio {
			margin: 0px 0px 15px 20px;
		}
		

</style>

<script>
		var code = ""; //이메일 전송 인증번호 저장위한 코드
        //이메일 합치기
        function email() {
            //이메일 선택하는 함수
            $(function () {
                $('#selectEmail').on("change", function () {
                    if ($('selectEmail').val() == 'directly') {
                        $('#directly').val('');
                        $('#text_email_02').attr("disabled", false);
                        $('#text_email_02').val("");
                        $('#text_email_02').focus();
                    } else {
                        $('#text_email_02').val($('#selectEmail').val());
                    }
                    if (document.getElementById("text_email_02").value && document.getElementById("text_email_01").value) {
                        document.getElementById('user_email').value = (document.getElementById('text_email_01').value) + "@" + (document.getElementById('text_email_02').value);
                    }
                });
                if (document.getElementById("text_email_02").value && document.getElementById("text_email_01").value) {
                    document.getElementById('user_email').value = (document.getElementById('text_email_01').value) + "@" + (document.getElementById('text_email_02').value);
                }
            });
        }


        //전화번호 합치기
        function call() {
            if (document.getElementById("phone01").value && document.getElementById("phone02").value && document.getElementById("phone03").value) {
                document.getElementById('user_phone').value = (document.getElementById('phone01').value) + "-" + (document.getElementById('phone02').value) + "-" + (document.getElementById('phone03').value);
            }
        }

        //이미지 보이기
        function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $('#blah').attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    	}
		}
        
      	//닉네임 중복검사
        function fn_nickChk(){
        	$.ajax({
        		url : "/Where2Park/nickChk.do",
        		type : "post",
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


        $(document).ready(function () {
            //비밀번호 확인창
            $(function () {
                $('#user_password').keyup(function () {
                    $('#chkNotice').html('');
                });
                $('#user_passwordChk').keyup(function () {

                    if ($('#user_password').val() != $('#user_passwordChk').val()) {
                        $('#chkNotice').html('비밀번호 일치하지 않음');
                        $('#chkNotice').css('color', 'red');
                    } else {
                        $('#chkNotice').html('비밀번호 일치함');
                        $('#chkNotice').css('color', 'green');
                    }
                });
            
               });
            
            // 이메일 인증
            $(".mail_check_button").click(function(){
                 var email = $("#user_email").val();  //이메일 입력값
                 var cehckBox = $(".mail_check_input");        // 인증번호 입력란
                 var boxWrap = $(".mail_check_input_box");    // 인증번호 입력란 박스
                 if ($('#user_email').val() == "") {
                     alert("이메일을 입력하세요.");
                     return false;
                 }else{
	                  $.ajax({
	                      type : "get",
	                      url : "/Where2Park/mailCheck.do?email=" + email ,
	                      success:function(data){
	                    	  console.log("data :" + data);
	                    	  cehckBox.attr("disabled",false);
	                    	  boxWrap.attr("id", "mail_check_input_box_true")
	                    	  alert("이메일을 확인해 주세요.");
	                    	  code = data;
	                      }	  
	                  });
                 }
             });
            
            //인증번호 비교
            $(".mail_check_input").blur(function(){
    			var inputCode = $(".mail_check_input").val();		//입력코드
    			var checkResult = $("#mail_check_input_box_warn")	//비교결과
    
    			if(inputCode == code){                            // 일치할 경우
    		        checkResult.html("인증번호가 일치합니다.");
    		        checkResult.attr("class", "correct");
    		        $("#mail_check_button").attr("value" , "Y");
    		        console.log($("#mail_check_button"))
    		    } else {                                            // 일치하지 않을 경우
    		        checkResult.html("인증번호를 다시 확인해주세요.");
    		        checkResult.attr("class", "incorrect");
    		    }  

			});


			
            //submit 전 유효성검사 부분
            $('#save').click(function (event) {
                var pw = $('#user_password').val();
                var chepw = $('#user_passwordChk').val();
				var nickChk = $('#nickChk').val();
                
                if ($('#user_email').val() == "") {
                    alert("이메일을 입력하세요.");
                    return false;
                }
                
                if ($('#mail_check_button').val() == "N") {
                    alert("이메일 인증을 하세요");
                    return false;
                }
                
                if ($('#user_password').val() == "") {
                    alert("비밀번호를 입력하세요.");
                    return false;

                } else {
                	
                    //비밀번호 유효성 (비밀번호8자리 이상, 숫자포함, )
                    var pw = $("#user_password").val();
                    var email = $("#text_email_01").val();
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

                if ($('#user_passwordChk').val() == "") {
                    alert("비밀번호를 다시 한 번 입력하세요.");
                    return false;
                }
                if ($('#user_nickname').val() == "") {
                    alert("닉네임을 입력하세요.");
                    
                    return false;
                }
                if ($('#nickChk').val() == "N") {
                    alert("닉네임 중복 체크를 하세요!");
                    console.log($('#nickChk').val());
                    return false;
                }
                if ($('#phone01').val() == "") {
                    alert("휴대폰 첫번째 번호를 입력하세요.");
                    return false;
                }
                if ($('#phone02').val() == "") {
                    alert("휴대폰 가운데 번호를 입력하세요.");
                    return false;
                }
                if ($('#phone03').val() == "") {
                    alert("휴대폰 마지막 번호를 입력하세요.");
                    return false;
                }
               
                if (pw != chepw) {
                    alert("비밀번호를 확인하세요.");
                    return false;
                }
                return true;
            });
			

        })
        
        //전화번호 입력 자동 포커스이동
		$(function() {
	    $(".phone").keyup (function () {
	        var charLimit = $(this).attr("maxlength");
	        if (this.value.length >= charLimit) {
	            $(this).next('.phone').focus();
	            return false;
	        }
	    });
		});
            
</script>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div id="cntnr">
		<!-- 각자의 파트는 이곳에서부터 작업하실 수 있습니다. -->

		<div class="cntnr-top-margin"></div>


		<div id="user_form" >

			<p id="userJoin_title">회 원 가 입</p>
			<form method="post" action="../insertUser.do" enctype="multipart/form-data">
			
				<table id="userForm" >
					<tr>
						<th></th>
						<td>
							<div id="blah_box">
							<img id="blah" alt="기본이미지" src="../images/UserProfile.png"/>
							</div>
							 
						<input type="file" name="uploadFile_F" accept="image/*" onchange="readURL(this);" id='profile_img_upload'/>
							 
						<label for='profile_img_upload'><i class="far fa-file-image"/>&nbsp;파일 선택</label>
						</td>
						<td>
						 <!--
						<input type="text" name="parking_pic">
						   -->
						
						 
						</td>
					</tr>
					
					<tr>
						<th>*이메일</th>
						 
						
						<td><input type="text" name="text_email_01" id="text_email_01" onkeyup='email()' placeholder="이메일 입력" 
							size="7"> @ <input type="text" name="text_email_02" id="text_email_02" onkeyup='email()' placeholder="이메일을 선택하세요."
							size="15"> 
							<select name="selectEmail" id="selectEmail"  >
								<option value="naver.com">naver.com</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="gmail.com">gmail.com</option>
								<option value="" id="directly" selected>직접 입력하기</option>
							</select> 
								<input class="mailinput" type="hidden" name="user_email" id="user_email">
									<button id="mail_check_button" type="button" class="mail_check_button" value="N">이메일 인증
									</button>
								</td>
								</tr>
								<tr>
								<th>인증번호 확인</th>
								<td>
								 
								<!-- 메일 인증번호 -->
								<div class="mail_check_wrap">
									<div class="mail_check_input_box" id="mail_check_input_box_false">
										<input class="mail_check_input" disabled="disabled">
									</div>
									<div class="clearfix"></div>
										<span id="mail_check_input_box_warn"></span>

								</div>
								</td>
					</tr>
					 
					
					<tr>
						<th>*비밀번호<p>
								 <br> 
							</p></th>
						<td><input type="password" size="33" name="user_password"
							id="user_password" placeholder="비밀번호 입력">
							<p>
								연속문자, 이메일이 포함된 비밀번호는 사용불가 <br> 숫자, 영문자, 특수문자 조합 8자리 이상 사용하능
							</p></td>
					</tr>
					<tr>
						<th>*비밀번호 확인</th>
						<td><input type="password" size="33" id="user_passwordChk"
							placeholder="비밀번호 입력 확인">
							<p id="chkNotice" size="2"></p></td>
					</tr>
					<tr>
						<th>*닉네임</th>
						<td><input type="text" size="33" name="user_nickname"
							id="user_nickname" placeholder="닉네임 중복검사를 해주세요" >
							<button id="nickChk" type="button" class="nickChk" name="nickChk" onclick="fn_nickChk()" value="N">중복확인 
							</button>
							</td>
					</tr>
					<tr>
						<th>*휴대폰</th>
						<td><input type="radio" name="phone"  /> KT <input
							type="radio" name="phone" class="radio"/> SKT <input type="radio"
							name="phone" class="radio"/> LGU+ <input type="radio" name="phone" class="radio"/> 알뜰폰 <br />
							<input type="text" name="phone01" id="phone01" size="7" onkeyup='call()' class='phone' maxlength='3' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">  - 
							<input type="text" name="phone02" id="phone02" size="7" onkeyup='call()' class='phone' maxlength='4' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">  - 
							<input type="text" name="phone03" id="phone03" size="7" onkeyup='call()' class='phone' maxlength='4' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">

						</td>
					</tr>
					<tr>
						<th></th>
						<td><input type="hidden" name="user_phone" id="user_phone">
							</td>
					</tr>
					<tr>
					<th></th>
					<td>
						<button  type="submit" class="userJoin-btn"
							id="save" name="save" href="insertCatInfo.do?user_nickname=${user.user_nickname}">가입하기
							</button>
						<button type="reset" class="userJoin-btn pw_btn_01">다시쓰기</button>
					</td>
					</tr>			

				</table>
			</form>


		</div>


		<!-- 각자의 파트는 이곳까지 작업해주시면 되겠습니다. -->
	</div>
	<jsp:include page="../tail.jsp"></jsp:include>
</body>
</html>