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
<title>비밀번호 찾기</title>
<script src="../js/jquery-1.12.4.min.js"></script>

<style>
	#px_box_out{
		margin : 100px auto;
		width:600px;
		height:300px;
		border:1px solid #ccc;
	}
	h3{
		text-align:center;
		font-size:1.8em;
		margin:20px 0px;
		font-weight:400;
		
	}
	
	.pw_btn{
	  width:150px;
	  height:40px;
	  padding:0;
	  display:inline; 
	  border-radius: 4px; 
	  background: #367FFF;
	  color: #fff;
	  margin-top: 20px;
	  transition: all 0.5s ease-in-out 0s;
	  font-weight :400;
	  border: 1px solid transparent;
	}
	.pw_btn:hover {
	  cursor: pointer;
	  text-decoration: none;
	}
	.pw_btn_01{
		float:right;
	}
	.pw_box{
		margin : 50px auto 0 auto;
		width : 355px;
		height : 200px;
		/*border: 1px solid #ccc;*/
		
		
	}
	.pw_center{
		
	}
	#user_email{
		width:100%;
		height:33px;
		border-radius: 5px 5px 5px 5px;
		border: 2px solid;
		
	}
</style>
<script>

$(document).ready(function(){
	
		//비번찾기창
		$(function(){
			$("#findBtn").click(function(){
				var user_email = $("#user_email").val();  //이메일 입력값
				var regExp = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;

		        if( !$('#user_email').val() ){
		            alert('이메일주소를 입력 해 주세요');
		            $('#user_email').focus();
		            return false;
		        } else if (!regExp.test(user_email)) {
		                alert('이메일 주소가 유효하지 않습니다');
		                $('#user_email').focus();
		                return false;
		        } else{
				
				$.ajax({
					type : "POST",
					url : "/Where2Park/findPw.do",
					data : {
						user_email : $("#user_email").val()
					},
					success : function(data) {
						if(data == 1){
							console.log(data)
							alert("임시 비밀번호를 전송했습니다");
						}else if(data ==0){
							alert("가입되지 않은 이메일 주소입니다");
							console.log(data)
						}
					},
				})
		        }
				
			});
		})
		
})
</script>


</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
				
	
	<div id="cntnr">
		<!-- 각자의 파트는 이곳에서부터 작업하실 수 있습니다. -->
		<div class="cntnr-top-margin"></div>
		
		<div id="px_box_out">
			<div class="pw_box">
				<div class="pw_title">
					<h3>비밀번호 찾기</h3>
				</div>
				<div>
					<p>
						<input type="text" id="user_email" name="user_email" placeholder="회원가입한 이메일주소를 입력하세요">
					</p>
					<p class="pw_center">
						<button type="button" id="findBtn" class="pw_btn" >찾기</button>
						<button type="button" class="pw_btn pw_btn_01" >
						<a href="/Where2Park/user/userLogin.jsp" style= color:white >
						로그인으로</a></button>
					</p>
				</div>
			</div>
		</div>




		<!-- 각자의 파트는 이곳까지 작업해주시면 되겠습니다. -->
	</div>


	<jsp:include page="../tail.jsp"></jsp:include>
</body>
</html>