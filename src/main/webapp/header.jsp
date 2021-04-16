<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   
   <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/415f6f6023.js" crossorigin="anonymous"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.12.4.min.js"></script>
   <title>어따세워?</title>
    <script src="<%=request.getContextPath()%>/js/jquery-1.12.4.min.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.0/js/bootstrap.min.js"></script>
   <style>
      *{
            margin:0;
            padding:0;
            list-style-type:none;
            text-decoration:none;
            font-family: 'Noto Sans KR', sans-serif;
            font-size:1em;
            font-weight:300;
            color:#000;
        }
        body{
            width:100%;
            height:auto;
            /* body에 스타일링을 지양해주십시오. */
        }
        #hdr{
            width:100%;
            min-height:150px;
            height:auto;
            box-sizing:border-box;
            padding:0 50px 0 40px;
            box-shadow:1px 1px 5px rgba(0, 0, 0, 0.1);
            overflow:hidden;
        }
        #hdr .hdr-logo{
            width:150px;
            height:150px;
            background:url("<%=request.getContextPath()%>/LOGO.png") no-repeat;
            background-size:cover;
            float:left;
        }
        #hdr #nav{
            float:right;
        }
        #hdr #nav ul{
            float:right;
        }
        #hdr #nav ul li{
            float:right;
            padding:0px 20px;
            line-height:150px;
            /* position:relative; */
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
           z-index:500;
           
        }
        #hdr #nav ul #nav-mp ul li{
           clear:both;
           line-height:70px;
           width:140px;
           text-align:center;
        }
        #hdr #nav ul #nav-mp ul li:hover{
           background:#f9f9f9;
        }
        #cntnr{
            clear:both;
            width:60%;
            min-height:800px;
            height:auto;
            margin:0 auto;
        }
        #cntnr .cntnr-top-margin{
            width:100%;
            height:40px;
        }
        #cntnr .article{
            width:100%;
            height:200px;
            border:1px solid #ccc;
            box-sizing:border-box;
            margin:0 0 20px 0;
        }

           /*알림창*/
   .chatModal{
   	  display: none;
   }
   
   .btn-primary{
      position: fixed;
      top : 90%;
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
   .modal-body{position:relative;padding:20px}
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
   </style>
</head>
<body>
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
                 <a href='"+ data.not_url +"' onClick='window.open(this.href, "", "width=350, height=400, status=no, toolbar=no, scrollbars=no, location=no"); return false;'>
                 <button type='button' class='btn btn-default pull-left' id='modalYes' data-dismiss='modal'>YES</button></a>
                 <button type='button' class='btn btn-default pull-left' id='modalNo' data-dismiss='modal'>NO</button>
              </div>
           </div>
        </div>
     </div>
  </div>
</body>
<script src="<%=request.getContextPath()%>/header_js.jsp"></script>
</html>
