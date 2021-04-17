<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	*{
		margin:0;
		padding:0;
		text-decoration:none;
		list-style:0;
		color:#000;
	}
	body{
		width:100%;
		height:auto;
		/* body에 스타일링 금지 */
	}
	#error-main{
		margin: 0 10% 0 10%;
		width : 80%;
		height : 500px;
		background-image: url("<%=request.getContextPath()%>/images/error.png");
		background-size: 1800px 1000px; /*창크기에 따라 같이 움직이게 해주는 속성(여백없음), contain은 여백있이 */
		background-position: center center;
	}
</style>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div id="error-main">
	</div>
	<jsp:include page="../tail.jsp"></jsp:include>
</body>
</html>