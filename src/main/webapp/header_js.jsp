<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
var ws;
var userId = "${userId}";
var rsvId = "${rsvId}";
var noticeUser;
var noticeParkingId;
var noticeParkingTitle;
var notType;
var notUrl;
var notMessage;
var sendMessage; //소켓으로 전달하는 Message
var getIndex;
var getArray = new Array();

window.onload = function () {
   var now = window.location.href;
   if(now.includes("index") || now.includes("login.do")){
       getLocation();
   }
    console.log(userId);
    if (userId != null && userId != 0 && userId != "") {
        connect();
        sortUrl();
    }
}


function sortUrl(){  //접속해있는 url에따라서 각각 알림의 타입과 내용을 설정
    var now = window.location.href;
    console.log("알림 : " + now);
    if(now.includes("review_wrt")){
        rating();
        noticeParkingId = selectUserNotice();
        notType = "review";
        notMessage = noticeParkingTitle  + "글에 새로운 리뷰가 등록되었습니다.";
        sendMessage = " [ " + noticeParkingId + "] "+ noticeParkingTitle + "예약건에 관한 리뷰가 등록되었습니다";
        notUrl = "searchParkingDetail.do?parking_id=" + noticeParkingId; //리뷰볼 수 있는 글페이지로 이동
        console.log(notUrl+ "**");
    }else if(now.includes("notice")){
        selectNotice(1);
    }
    
}

function getRsvDelete(rsvId, noticeParkingId, noticeUser, parkingTitle){
    this.rsvId = rsvId.value;
    this.noticeParkingId = noticeParkingId.value;
    this.noticeUser = noticeUser.value;
    this.noticeParkingTitle = parkingTitle.value;
    notType="cancel";
    notMessage = this.noticeParkingTitle + "에 등록된 예약이 취소되었습니다.";
    sendMessage = " [ " +this.noticeParkingId + " ] " + this.noticeParkingTitle+"에 등록된 예약이 취소되었습니다.";
    notUrl = "getRsvList.do";  //예약건 모아보는 페이지로 이동
    console.log("getRsvDelete : " + this.rsvId, this.noticeParkingId, this.noticeUser);
    //insertNotice();
    //ws.send(JSON.stringify({ user_id: this.noticeUser, not_type: notType, rsv_id: this.rsvId, not_message: sendMessage, not_url : notUrl }));
    send();
}

function connect() {
    ws = new WebSocket("ws://localhost:9999/Where2Park/notice.do");
    ws.onopen = onOpen;
    ws.onclose = onClose;
    ws.onmessage = onMessage;
}

function disconnect() {
    onClose();
}

function send() {
    insertNotice();
    ws.send(JSON.stringify({ user_id: noticeUser, not_type: notType, rsv_id: rsvId, not_message: sendMessage, not_url : notUrl }));
}

function onOpen() {
    console.log("======>Open Notification!!");
    ws.send(JSON.stringify({ user_id: userId, not_type: "test", not_message: " ,,, 알림 실험중.....!" }));
}

function onMessage(e) {
    var data = JSON.parse(e.data);
    console.log(data);
    
    if(data.not_url.includes("chatroom")){
        chatNoticeModal(data);
    }else{
        if(confirm(data.not_message+" 해당 페이지로 이동하시겠습니까?")){
            location.href=data.not_url;
        }else{
        selectNotice(1);
        } 
   }
   
}

function chatNoticeModal(data){
    const modal = document.getElementsByClassName("chatModal");
    modal[0].setAttribute("style", "display : block");
    
    const content = document.getElementsByClassName("modal-body");
    content[0].innerHTML = data.not_message;
    
    const modalYes = document.getElementById("modalYes");
    modalYes.onclick = function (){
		window.open(data.not_url, '', 'width=350, height=400, status=no, toolbar=no, scrollbars=no, location=no');   	
    }
    
    const modalNo = document.getElementById("modalNo");
    modalNo.onclick = function (){
    	modal[0].setAttribute("style", "display : none");
    }
}

function onClose() {
    console.log("======>Close Notification!!");
    connect();
    console.log("======>Re-connection Notification")
}


function insertNotice() {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            var data = xhr.responseText;
            console.log(data);
        }
    };
    console.log(rsvId + " : insertNotice ajax 실행중...");
    xhr.open("POST", "insertNotice.do", true);
    xhr.setRequestHeader("Content-type", "application/json");
    
    var jData = JSON.stringify({user_id:noticeUser, parking_id:noticeParkingId, rsv_id:rsvId, not_type:notType, not_message:notMessage, not_url:notUrl});
    console.log(notType);
    xhr.send(jData);
}

function selectUserNotice() {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            var data = xhr.responseText;
            var parseData = JSON.parse(data);
            noticeUser = parseData.user_id;
            noticeParkingId = parseData.parking_id;
            noticeParkingTitle = parseData.parkingVO.parking_title;
            console.log(parseData);
            console.log(noticeParkingId+ "**" + noticeParkingTitle);
        }
    };
    console.log(rsvId + " : selectUserNotice ajax 실행중....");
    xhr.open("GET", "selectNoticeUser.do?rsv_id=" + rsvId, false); //ajax는 비동기식 통신으로는 값을 전달하지 못하기때문에 동기식으로 설정
    xhr.send();
    return noticeParkingId;
}