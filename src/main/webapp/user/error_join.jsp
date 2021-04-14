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
<title>비로그인시</title>
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
		font-size:1.2em;
		margin:15px 0px;
		font-weight:300;
		
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
		
	}
</style>
<script>

$(document).ready(function(){
	
		
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
					<h3>가입되지 않은 이메일 입니다. </h3>
					<h3>회원가입 후 이용해 주세요. </h3>
				</div>
				<div>
					<p class="pw_center">
						<button type="button" id="findBtn" class="pw_btn" ><a href="/Where2Park/user/userJoinForm.jsp" class="pw_btn">회원가입</a></button>
						<button type="button" onclick="history.go(-1);" class="pw_btn pw_btn_01" >뒤로가기</button>
					</p>
				</div>
			</div>
		</div>




		<!-- 각자의 파트는 이곳까지 작업해주시면 되겠습니다. -->
	</div>


	<jsp:include page="../tail.jsp"></jsp:include>
</body>
</html>