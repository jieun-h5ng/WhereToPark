<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
       <meta http-equiv="X-UA-Compatible" content="IE=edge">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <link rel="preconnect" href="https://fonts.gstatic.com">
   
       <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
       <script src="https://kit.fontawesome.com/415f6f6023.js" crossorigin="anonymous"></script>
       <script type="text/javascript" src="js/jquery-1.12.4.min.js"></script>
   
       <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/My-page-wish-list.css">
      
      <meta charset="UTF-8">
      <title>어따세워? 찜한 주차장 목록</title>
   </head>
   <body>
         <div id="cntnr">
            <!-- 각자의 파트는 이곳에서부터 작업하실 수 있습니다. -->
            <div class="cntnr-top-margin"></div>
            <c:forEach var="wishList" items="${wishList}" varStatus="wishListStatus">
               <div class="MpArm-arti wish-arti" id="MpArmArtiNo${wishListStatus.index} no${wishList.wish_id}" value="${wishListStatus.index}">
                  <div class="wish-place-pic" style="
                  background:url('<%=request.getContextPath()%>/images/${wishList.parkingVO.parking_pic}') no-repeat;
                  background-size:cover;">
                     <%-- ${wishList.parkingVO.parking_pic} --%>
                     <form class="form-heart">
                        <input type="hidden" name="prking_id" value="${wishList.parking_id}" id=hdprknid${wishListStatus.index}></input>
                        <input type="checkbox" name="wish_id" value="${wishList.wish_id}" id="chckheart"/>
                        <label for="chckheart" class="heartLabel" onclick="deleteAjaxfront(${wishListStatus.index}, hdprknid${wishListStatus.index})"><i class="fas fa-heart"></i></label>
                        <%-- <label for="chckheart" class="heartLabel" onclick="deleteAjaxfront(${wishListStatus.index}, hdprknid)"><i class="fas fa-heart"></i></label> --%>
                        <!-- <label for="chckheart" class="heartLabel"><i class="fas fa-heart"></i></label> -->
                     </form>
                  </div>
                  <div class="wish-place-text-info">
                     <%-- <p>
                        ${wishListStatus.current} | ${wishListStatus.index}</br>
                        | user_id=${wishList.user_id} | parking_id=${wishList.parkingVO.parking_id} | wish_id=${wishList.wish_id}
                     </p> --%>
                     <p>
                         ${wishList.parkingVO.parking_location}
                     </p>
                     <p class="wish-place-title">
                         ${wishList.parkingVO.parking_title}
                     </p>
                  </div>
               </div>
            </c:forEach>
            <!-- 각자의 파트는 이곳까지 작업해주시면 되겠습니다. -->
         </div>
      <div class="cntnr-top-margin"></div>
      <jsp:include page="../tail.jsp"></jsp:include>
      <!-- <script>
         window.onload=function(){
            var artiText = document.getElementByClass('wish-placee-text-info');
            /* var indexNum = ${wishListStatus}; */
            var indexNum = document.getElementByName('index_num').value;
            artiText[indexNum]
         }
      </script> -->
      <script>
         var iconHeart = document.getElementsByClassName('fa-heart');
         
         function deleteAjaxfront(num, hdprknid){
            console.log(num + "num");
            var no = num;
            var wishId = $('#chckheart').val();   // = wish_id
            var userId = ${userId};
            var parkingId = hdprknid.value;
            
            console.log(wishId);
            console.log(userId);
            
            if(confirm("찜 목록에서 삭제하시겠습니까?")){
               var xhr = new XMLHttpRequest();
               xhr.onreadystatechange = function(){
                  if(xhr.readyState === 4 && xhr.status === 200){
                     var artiWish = document.getElementsByClassName('wish-arti');
                     console.log(artiWish);
                     artiWish[no].setAttribute("style", "display:none;");
                     console.log([no]);
                  }
               }
               xhr.open('GET', 'delete_wish.do?parking_id='+parkingId+'&user_id='+userId);
               xhr.send(wishId);
            }
         }
      </script>
      <script>
         $(document).ready(function(){
            var index = ${wishListStatus.index};
            var article1 = $('.MpArm-arti');
            var article2 = $('.wish-arti');
            console.log(index);
            
            var getArti1Height = article1.outerHeight();
            var getArti2Height = article2.outerHeight();
            
            if(getArti1Height >= getArti2Height){
               article2.css('min-height', getArti1Height);
            }
            if(getArti2Height >= getArti1Height){
               article1.css('min-height', getArti2Height);
            }
         });
      </script>
   </body>
</html>