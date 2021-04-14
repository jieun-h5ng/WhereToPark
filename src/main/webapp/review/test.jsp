<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="../review_list.do" method="post" >
		<input type="text" name="user_id" value="${ReviewVO.user_id}" placeholder="15602" />
		<input id="search-button" type="submit" value="목록 검색하기">
	 </form>
	 <form action="../review_wrt.do?rsv_id=66552" method="post" >
	 <!-- <form action="../review_wrt.do" method="post" > -->
		<input type="text" name="rsv_id" value="${ReviewVO.rsv_id}" placeholder="66552"/>
		<input id="search-button" type="submit" value="리뷰 작성하기">
	 </form>
	  <form action="../update_review_view.do" method="post" >
		<input type="text" name="review_id" value="${ReviewVO.review_id}" placeholder="80003"/>
		<input id="search-button" type="submit" value="수정 페이지 로드">
	 </form>
</body>
</html>