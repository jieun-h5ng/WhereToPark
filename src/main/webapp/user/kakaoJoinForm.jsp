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
<script src="js/jquery-1.12.4.min.js"></script>
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
		margin:0 30px 30px 20px;
		width: 200px;
		height: 200px;
		}
		#blah {
		width:200px;
		height:200px;
		z-index: 999;
		border-radius: 50% 50%;
        
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
        

        $(document).ready(function () {
        	console.log("??")

			
            //submit 전 유효성검사 부분
            $('#save').click(function (event) {
                var pw = $('#user_password').val();
                var chepw = $('#user_passwordChk').val();
				var nickChk = $('#nickChk').val();
                
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
			<form method="post" action="insertkakaoUser.do" enctype="multipart/form-data">
			
				<table id="userForm">
					<input type="hidden" size="33" name="user_password"
							id="user_password" value="0000">
					
					<tr>
						<th></th>
						<td>
							<div id="blah_box">
								<img id="blah" alt="기본이미지" src="${user.user_pic}"/>
							</div>
							 
						<input type="hidden" name="user_pic"   value="${user.user_pic}"/>
						<!-- 
						<input type="file" name="uploadFile_F" accept="image/*" onchange="readURL(this);" id='profile_img_upload' value="${user.user_pic}"/>
							 
						<label for='profile_img_upload'><i class="far fa-file-image"/>&nbsp;파일 선택</label>
						 -->
						</td>
					</tr>
					
					<tr>
						<th>*이메일</th>
						<td>
						<input class="mailinput" type="text" name="user_email" id="user_email" value=${user.user_email} readonly size='33'>
						</td>
					
					
					<tr>
						<th>*닉네임</th>
						<td><input type="text" size="33" name="user_nickname"
							id="user_nickname" value=${user.user_nickname} readonly>
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