<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
      <jsp:include page="../header.jsp"></jsp:include>
         <div id="cntnr">
            <!-- 각자의 파트는 이곳에서부터 작업하실 수 있습니다. -->
            <div class="cntnr-top-margin"></div>
            <c:forEach var="wishList" items="${wishList}" varStatus="wishListStatus">
               <div class="MpArm-arti" id="MpArmArtiNo${wishListStatus.index} no${wishList.wish_id}" value="${wishListStatus.index}">
                  <form>
                     <input type="checkbox" name="wish_id" value="${wishList.wish_id}" id="chckheart"/>
                     <label for="chckheart" class="heartLabel" onclick="deleteAjax(${wishList.wish_id})"><i class="fas fa-heart"></i></label>
                     <!-- <label for="chckheart" class="heartLabel"><i class="fas fa-heart"></i></label> -->
                  </form>
                  <p>
                     ${wishListStatus.current} | ${wishListStatus.index}</br>
                     | user_id=${wishList.user_id} | parking_id=${wishList.parkingVO.parking_id} | wish_id=${wishList.wish_id}
                  </p>
                  <p>
                      ${wishList.parkingVO.parking_location}
                  </p>
                  <p>
                      ${wishList.parkingVO.parking_title}
                  </p>
               </div>
            </c:forEach>
            <!-- 각자의 파트는 이곳까지 작업해주시면 되겠습니다. -->
         </div>
      <jsp:include page="../tail.jsp"></jsp:include>
      <script>
         /* 삭제는 각 클릭 시 마다 먹지만 스타일이 적용 안됨 */
         var wishId = $('#chckheart').val();   // = wish_id
         
         function deleteAjax(w){
            
            if(confirm("찜 목록에서 삭제하시겠습니까?")){
               
               var xhr = new XMLHttpRequest();
               xhr.open('GET', 'delete_wish.do?wish_id='+w);
               xhr.onreadystatechange = function(){
                  
                  if(xhr.readyState === 4 && xhr.status === 200){
                     
                     console.log(w);
                     var artiId = '#no'+w;
                     var indexNum = ('.MpArm-arti').val();
                     
                     console.log(artiId);
                     document.querySelector('.fa-heart').style.color = '#cccccc';
                     $(artiId).children('.fa-heart').css('color', '#cccccc');
                     $(artiId).remove();
                  }
               }
               xhr.send();
            }
         };
      </script>
      <!-- <script>
         /* 삭제는 각 클릭 시 마다 먹지만 스타일이 적용 안됨 */
         var wishId = $('#chckheart').val();   // = wish_id
         
         function deleteAjax(w){
            if(confirm("찜 목록에서 삭제하시겠습니까?")){
               var $this = $(this);
               var $form = $this.parent();
               var $MpArmArti = $form.parent();
               var artiId = $MpArmArti.attr('id');
               var hval = $('input').val(); // = wish_id
               var artiNo = '#no'+hval;
               var indexNum = $MpArmArti.val();
               
               var xhr = new XMLHttpRequest();
               xhr.open('GET', 'delete_wish.do?wish_id='+w);
               xhr.onreadystatechange = function(){
                  if(xhr.readyState === 4 && xhr.status === 200){
                     console.log(artiNo);
                     console.log(indexNum);
                     $(artiNo).children('.fa-heart').css('color', '#cccccc');
                     /* $(artiNo).remove(); */
                  }
               }
               xhr.send();
            }
         };
      </script> -->
      <!-- <script>
         /* 스타일은 되지만 각 클릭시 마다 삭제가 안됨 */
         var wishId = $('#chckheart').val();   // = wish_id
         
         document.querySelector('.heartLabel').addEventListener('click', function(event){
            if(confirm("찜 목록에서 삭제하시겠습니까?")){
               var $this = $(this);
               var $form = $this.parent();
               var $MpArmArti = $form.parent();
               var artiId = $MpArmArti.attr('id');
               var hval = $('input').val(); // = wish_id
               var artiNo = '#no'+hval;
               
               var xhr = new XMLHttpRequest();
               xhr.open('GET', 'delete_wish.do?wish_id='+wishId);
               xhr.onreadystatechange = function(){
                  if(xhr.readyState === 4 && xhr.status === 200){
                     document.querySelector('.fa-heart').style.color = '#cccccc';
                     
                     console.log(artiId);
                     console.log(hval);
                     console.log(artiNo);
                     console.log('#no'+hval);
                     $MpArmArti.remove();
                  }
               }
               xhr.send();
            }
         });
      </script> -->
   </body>
</html>