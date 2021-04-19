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
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script>

<title>Document</title>
<script src="../js/jquery-1.12.4.min.js"></script>
<style>
.login_form {
	width: 600px;
	height: 500px;
	margin : 0 auto;
	/*background-color:pink;*/
}
.login_form_input{
	width:300px;
	height: 300px;
	margin : 0 auto;
	/*background-color:red;*/
}


#login_title {
	font-size:2em;
    text-align:center;
    font-weight:400;
    padding:40px 0 20px 0;
}

#login_detail {
	clear:both;
	text-align: center;
}
.email_password_chek{
	padding : 15px 0 13px 0;
}

#user_email {
	width: 300px;
	height: 35px;
	margin-bottom: 5px;
	border-radius: 5px 5px 5px 5px;
	border-color: #ccc;
}


#user_password {
	width: 300px;
	height: 35px;
	border-radius: 5px 5px 5px 5px;
	border-color: #ccc;
}
.email_password{
	margin-bottom: 5px;
}
#kakao{
	padding-bottom: 5px;
}

#btn-login-success {
	width: 300px;
	height: 54px;
	background-color: #367FFF;
	text-align: center;
	border-radius: 5px 5px 5px 5px;
	line-height: 33px;
	margin: 15px 0 10px 0 ;
	color: white;
	border: 1px solid transparent;
	font-weight :400;
}

#login_detail {
	display: inline;
	padding-right: 15px;
}

#btn-login-success:hover {
	cursor: pointer;
}

#anther_login_box {
	/* border: 1px solid black; */
	height: 100px;
	display: inline;
	/* float: left; */
}

.another_login {
	width: 80px;
	height: 80px;
	border: 1px solid red;
	float: left;
	margin: 20px 50px 0px 0px;
}

#login_detail_box {
	margin : 0 auto;
	clear: both;
}

.login_detail {
	float: left;
	margin: 20px 50px 0px 0px;
}
.login_detail_findpw{
	margin: 20px 50px 0px 40px;
}

.login_detail:hover {
	text-decoration: underline;
	cursor: pointer;
}
#btnSubmit{
	display:none;
}


</style>
<script>
	//비번찾기
	//$(function(){
	//	$("#find_pw_btn").clicl(function(){
	//		location.href="find_pw_form.do";
	//	})
	//});
	//이메일가입됬는지 안됬는지 검사
     function login(){
     	$.ajax({
     		url : "/Where2Park/login.do",
     		type : "post",
				success : function(data){
					if(data == 1){
						alert(" 입니다.");
					}else if(data == 0){
						alert("이메일 확인해주세요.")
					}
				}
     	})
     }
	
	 var emailcode = ""; //이메일 확인 문자열 반환 코드
	 $(document).ready(function(){
		    console.log("뭐라도 떠라")
			//로그인 전 유효성검사
			$("#btn-login-success").click(function(event){
				var user_email = $("#user_email").val();  //이메일 입력값
				var regExp = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;

				if($('#user_email').val()== ""){
		            alert('이메일을 입력 하세요');
		            $('#user_email').focus();
		            return false;
		        } else if (!regExp.test(user_email)) {
	                alert('이메일 주소가 유효하지 않습니다');
	                $('#user_email').focus();
	                return false;
		        }else if ($('#user_password').val() == "") {
		             alert("비밀번호를 입력해주세요.");
		             return false;
		        } 
				/*
		        else{
		        	$.ajax({
		        		type : "post",
		        		url : "/Where2Park/login.do",
		        		data :{
		        			user_email : $("#user_email").val()
		        		},
		        		success : function(data){
		        			console.log(data)
		        			var result = Number(data);
		        			if(result == 0){
		        				alert("가입되지 않은 이메일 입니다")
		        			}
		        		}
		        		
		        	})
		        }
				*/
		        return true;
			});
			
		  //쿠키
		  var key = getCookie("key");
		  $("#user_email").val(key); 
		  
		  
		  if($("#user_email").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
		        $("#idSaveCheck").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
		    }
		  
		  $("#idSaveCheck").change(function(){ // 체크박스에 변화가 있다면,
		        if($("#idSaveCheck").is(":checked")){ // ID 저장하기 체크했을 때,
		            setCookie("key", $("#user_email").val(), 7); // 7일 동안 쿠키 보관
		        }else{ // ID 저장하기 체크 해제 시,
		            deleteCookie("key");
		        }
		    });
		  
		  // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
		    $("#user_email").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
		        if($("#idSaveCheck").is(":checked")){ // ID 저장하기를 체크한 상태라면,
		            setCookie("key", $("#user_email").val(), 7); // 7일 동안 쿠키 보관
		        }
		    });
		  
	});
	 
	 function setCookie(cookieName, value, exdays){
		    var exdate = new Date();
		    exdate.setDate(exdate.getDate() + exdays);
		    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
		    document.cookie = cookieName + "=" + cookieValue;
		}
		 
		function deleteCookie(cookieName){
		    var expireDate = new Date();
		    expireDate.setDate(expireDate.getDate() - 1);
		    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
		}
		 
		function getCookie(cookieName) {
		    cookieName = cookieName + '=';
		    var cookieData = document.cookie;
		    var start = cookieData.indexOf(cookieName);
		    var cookieValue = '';
		    if(start != -1){
		        start += cookieName.length;
		        var end = cookieData.indexOf(';', start);
		        if(end == -1)end = cookieData.length;
		        cookieValue = cookieData.substring(start, end);
		    }
		    return unescape(cookieValue);
		}
	 
</script>


</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
				
	
	<div id="cntnr">
		<!-- 각자의 파트는 이곳에서부터 작업하실 수 있습니다. -->
		<div class="cntnr-top-margin"></div>

		<div class="login_form">
			
			<p id="login_title">로 그 인</p>
			<div class="login_form_input">
			
				<form action="../login.do" method="post" id="loginForm" name="loginForm">
					<div class="email_password">
						<input type="text" name="user_email" id="user_email" placeholder="✉ 이메일 주소 " >
					</div>
					<div class="email_password">
						<input type="password" name="user_password" id="user_password"  placeholder="🔒 비밀번호">
					</div>
					<div class="email_password_chek">
						<input type="checkbox"  id="idSaveCheck"> 이메일 저장하기
					</div>
	
					<div id="login_detail_box">

						<div class="login_detail login_detail_findpw">
							<a href="/Where2Park/user/findpw.jsp" class="loginhere-link" id="find_pw_btn">비밀번호 찾기</a>
						</div>
						<div class="login_detail">
							<a href="/Where2Park/user/userJoinForm.jsp" class="loginhere-link" id="join_btn">회원가입</a>
						</div>
					</div>
					
						<div class="login_detail">
							<input type="submit" id="btn-login-success" value="로그인" onclick="login()">
						</div>
				</form>
					
					
					<!-- 카카오 로그인 폼 -->
					<div id="kakao">
						<a href="javascript:kakaoLogin();" >
				       	 	<img src="../images/kakao_login_btn.png" style='height: 51px ; width: 300px;'>
				    	</a>
						<form action="../kakaologin.do" method="post" name="kakao">
						 	<input type="hidden" id="tocken1" name="user_nickname" >
						 	<input type="hidden" id="tocken2" name="user_email" >
						 	<input type="hidden" id="tocken3" name="user_pic" >
						    <input type="submit" id="btnSubmit">	
				    		<!-- 
				    		 <a href="http://developers.kakao.com/logout">카카오로그아웃</a>
				    		 -->
						</form>
					</div>

					<!-- Naver Login Btn --> 
					<div id="naverIdLogin" > 
						<a id="naverIdLogin_loginButton">
					 	<img src="../images/naver_login.jpg" width="300px" height="53px" /> </a> 
					 </div>
			</div>
			

			</div>
		<script>
		//카톡로그인 정보 받아오기
			window.Kakao.init('624e9dbbea013819ce0b54feef1c4496');
			function kakaoLogin(){
				var email;
				var nickname;
				
				window.Kakao.Auth.login({
					//scope:'profile, account_email',
					success:function(authObj){
						console.log(authObj);
						window.Kakao.API.request({
							url:'/v2/user/me',
							success: function(res) {
								console.log(JSON.stringify(res));
								console.log(JSON.stringify(authObj));
			                    console.log(res.id);
			                    console.log("이메일" + res.kakao_account['email']);
			                    email = res.kakao_account['email'];
			                    console.log("닉네임" +res.properties['nickname']);
			                    console.log("이미지 "+res.properties['profile_image']);
			                    console.log(authObj.access_token);

							var request_name = JSON.stringify(res.properties['nickname'])
							var request_email = JSON.stringify(res.kakao_account['email'])
							var request_url = JSON.stringify(res.properties['profile_image'])
								  $('#tocken1').val(request_name);
								  $('#tocken2').val(request_email);
								  $('#tocken3').val(request_url);
								  
								  var value1 = $('input[name=user_nickname]').val();
								  var value2 = $('input[name=user_email]').val();
								  var value3 = $('input[name=user_url]').val();
								   console.log(value1);
								   console.log(value2);
								console.log("카카오 응답 수신")
								$("#btnSubmit").trigger("click");
							
			                  }

						});
					}
				})
				//return "email";
				
			}
				
		</script>
		
		<script type="text/javascript">
		//네이버 로그인
		var naverLogin = new naver.LoginWithNaverId({

			clientId: "MmE1eo62xitrYdUjnQ7c", 
			callbackUrl: "http://localhost:9999/Where2Park/user/userLogin.jsp", 
			isPopup: false, /* callback 페이지가 분리되었을 경우에 callback 페이지에서는 callback처리를 해줄수 있도록 설정합니다. */ 
		});
		/* (3) 네아로 로그인 정보를 초기화하기 위하여 init을 호출 */ 
		naverLogin.init(); 
		/* (4) Callback의 처리. 정상적으로 Callback 처리가 완료될 경우 main page로 redirect(또는 Popup close) */ 
		window.addEventListener('load', function () {
			naverLogin.getLoginStatus(function (status) { 
				if (status) {
					   console.log(naverLogin.accessToken.accessToken)
		               var email = naverLogin.user.getEmail();
					   var profileImage = naverLogin.user.getProfileImage();
					   var name = naverLogin.user.getName();
					   var uniqId = naverLogin.user.getId();

		               if( email == undefined || email == null) {
		                  alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
		                  naverLogin.reprompt(); 
		                  return;
		               alert( email ); // 로그인 한 이메일 ***@naver.com 이 출력된다.
		             }else if( name == undefined || name == null){
		            	alert("회원이름은 필수정보입니다. 정보제공을 동의해주세요."); 
		            	naverLogin.reprompt(); 
		            	return;
		            }else{ 
		            	// 성공 
		            }
		            }             
		             else {
		               console.log("callback 처리에 실패하였습니다.");
		            }
		         });
		      });
		//https://nid.naver.com/oauth2.0/token?grant_type=delete&client_id=MmE1eo62xitrYdUjnQ7c&client_secret=YUyk4D1jbR&access_token=AAAAObmECx0gbr6wRKMYQ1ZF4L-xHue0Jw3KwuFKOj3p79LvOrTz4rsJssclcM7Nn5XuSHnwo-toxA4o_b3I98--fqU&service_provider=NAVER
		

		</script>
		
     
    


		<!-- 각자의 파트는 이곳까지 작업해주시면 되겠습니다. -->
	</div>


	<jsp:include page="../tail.jsp"></jsp:include>
</body>
</html>