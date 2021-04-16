<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="preconnect" href="https://fonts.gstatic.com">
            <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
                rel="stylesheet">
            <!-- <link href="<%=request.getContextPath()%>/css/bootstrap.css" rel="stylesheet"> -->
            <title>알림창</title>
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    list-style-type: none;
                    text-decoration: none;
                    font-family: 'Noto Sans KR', sans-serif;
                    font-size: 1em;
                    font-weight: 300;
                    color: #000;
                }

                body {
                    width: 100%;
                    height: auto;
                    /* body에 스타일링을 지양해주십시오. */
                }

                #hdr {
                    width: 100%;
                    min-height: 150px;
                    height: auto;
                    box-sizing: border-box;
                    padding: 0 50px 0 40px;
                    box-shadow: 1px 1px 5px rgba(0, 0, 0, 0.1);
                    overflow: hidden;
                }

                #hdr .hdr-logo {
                    width: 150px;
                    height: 150px;
                    background: url("LOGO.png") no-repeat;
                    background-size: cover;
                    float: left;
                }

                #hdr #nav {
                    float: right;
                }

                #hdr #nav ul {
                    float: right;
                }

                #hdr #nav li {
                    float: right;
                    padding: 0px 20px;
                    line-height: 150px;
                }

                #cntnr {
                    clear: both;
                    width: 60%;
                    min-height: 800px;
                    height: auto;
                    margin: 0 auto;
                }


                #ftr {
                    width: 100%;
                    min-height: 200px;
                    height: auto;
                    background: #eee;
                    font-size: 0.8em;
                    line-height: 2em;
                }

                #ftr .wrapper {
                    width: 60%;
                    min-height: 200px;
                    height: auto;
                    margin: 0 auto;
                }

                #ftr .wrapper #ftr-nav {
                    height: 50px;
                }

                #ftr .wrapper #ftr-nav ul {
                    float: left;
                }

                #ftr .wrapper #ftr-nav ul li {
                    padding: 20px 20px 15px 20px;
                    float: left;
                }

                #ftr .wrapper #ftr-nav ul li:first-child {
                    padding: 20px 20px 15px 0px;
                }

                #ftr .wrapper .ftr-arti {
                    clear: both;
                }

                #ftr .wrapper .ftr-arti p {
                    padding: 0 0 10px 0;
                }


                /*알림창 마진*/
                .notice-margin {
                    width: 100%;
                    height: 20px;
                }


                /*알림창 설정*/
                #cntnr .notice {
                    width: 80%;
                    height: 180px;
                    box-sizing: border-box;
                    margin: 10px auto 30px auto;
                    padding: 20px;
                    border: 1px solid #ccc;
                    border-radius: 2px;
                    background-color: rgb(255, 255, 255);
                    box-shadow: 2px 2px rgb(151, 151, 151);
                    cursor: pointer;
                    overflow: hidden;
                }

                #notice-bell {
                    color: rgb(228, 212, 92);
                    font-size: 60px;
                    font-weight: lighter;
                    float: left;
                    margin: 3% 8% 4% 8%;
                }

                #notice-title {
                    float: left;
                    font-size: 1.8em;
                    width: 50%;
                }

                #Btn {
                    width: 20px;
                    height: 20px;
                    float: right;
                    margin: -185px 13% 0 0;
                }

                #deleteBtn {
                    float: right;
                    margin: 10px, 10px, 10px, 10px;
                    height: 15px;
                    width: 15px;

                }

                #notice-date {
                    float: left;
                    width: 50%;
                    font-size: 1em;
                    padding-top: 15px;
                }

                #notice-content {
                    float: left;
                    width: 90%;
                    margin: 0 5% 0 5%;
                    font-size: 1em;
                    padding-top: 10px;
                }

                #notice-pagination {
                    width: 60%;
                    margin: 0 30% 0 30%;
                }

                .pagination {
                    width: 250px;
                    margin: 0 20% 0 20%;
                }

                .pagination {
                    display: -ms-flexbox;
                    display: flex;
                    padding-left: 0;
                    list-style: none;
                }

                .page-link {
                    position: relative;
                    display: block;
                    padding: 0.5rem 0.75rem;
                    margin-left: -1px;
                    line-height: 1.25;
                    color: #2780e3;
                    background-color: #fff;
                    border: 1px solid #dee2e6;
                }

                .page-link:hover {
                    z-index: 2;
                    color: #165ba8;
                    text-decoration: none;
                    background-color: #e9ecef;
                    border-color: #dee2e6;
                }

                .page-link:focus {
                    z-index: 3;
                    outline: 0;
                    box-shadow: 0 0 0 0.2rem rgba(39, 128, 227, 0.25);
                }

                .page-item:first-child .page-link {
                    margin-left: 0;
                }

                .page-item.active .page-link {
                    z-index: 3;
                    color: #fff;
                    background-color: #2780e3;
                    border-color: #2780e3;
                }

                .page-item.disabled .page-link {
                    color: #868e96;
                    pointer-events: none;
                    cursor: auto;
                    background-color: #fff;
                    border-color: #dee2e6;
                }

                .pagination-lg .page-link {
                    padding: 0.75rem 1.5rem;
                    font-size: 1.171875rem;
                    line-height: 1.5;
                }

                .pagination-sm .page-link {
                    padding: 0.25rem 0.5rem;
                    font-size: 0.825rem;
                    line-height: 1.5;
                }


                @page {
                    size: a3;
                }
            </style>
            <script src="js/jquery-1.12.4.min.js"></script>
        </head>

        <body>
            <jsp:include page="header.jsp"></jsp:include>

            <div id="cntnr">
                <div class="notice-margin"></div>
                <!-- 각자의 파트는 이곳에서부터 작업하실 수 있습니다. -->
                <div class="notice-margin"></div>
                <div id="no"></div>
                <!--         <div class="notice-margin"></div> -->
            </div>

            <div id="notice-pagination">
                <ul class="pagination">
                    <li class="page-item">
                        <!-- <li class="page-item disabled"> -->
                        <a class="page-link" onclick="selectNotice(0);">&laquo;</a>
                    </li>
                    <li class="page-item active">
                        <a class="page-link" onclick="selectNotice(1);">1</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" onclick="selectNotice(2);">2</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" onclick="selectNotice(3);">3</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" onclick="selectNotice(4);">4</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" onclick="selectNotice(5);">5</a>
                    </li>
                    <li class="page-item">
                        <a class="page-link" onclick="selectNotice(6);">&raquo;</a>
                    </li>
                </ul>
            </div>
            <div class="notice-margin"></div>
            <jsp:include page="tail.jsp"></jsp:include>
        </body>
        <script src="notice_js.jsp"></script>
        <script src="header_js.jsp"></script>

        </html>