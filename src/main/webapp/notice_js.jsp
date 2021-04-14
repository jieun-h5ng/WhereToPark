<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
var userId = "${userId}";
var Btn;
var cnt = 0;
var page = 0;
var noticeCnt = 0;
var pageBtn = document.getElementsByClassName("page-item");
var pageBtnNum = document.getElementsByClassName("page-link");

window.onload = function () {
    //selectNotice(1, 0);
}

function deleteDIV(notice, delBtn) {
    var parent = delBtn.parentNode;
    parent.removeChild(notice);
    parent.removeChild(delBtn);
}

function newNotice(parseData) {
    for (let i = 0; i < parseData.length; i++) {
        var date = new Date(parseData[i].not_datetime);
        var datetime = date.getFullYear() + "-" + (date.getMonth()+1) + "-" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes();
        var newDiv = document.createElement("div"); //notice담을 큰틀 생성
        //newDiv.innerHTML = "<i class='far fa-bell' id='notice-bell'></i>";
        newDiv.setAttribute("class", "notice");
        newDiv.setAttribute("id", "notice"+[i]);
        newDiv.onclick = function () { location.href = parseData[i].not_url; }
        document.getElementById("cntnr").appendChild(newDiv);
        var content = document.createElement("notice-content"); //내용담을 틀 생성
        content.innerHTML = "<i class='far fa-bell' id='notice-bell'></i>"+"<p id='notice-title'>" + parseData[i].not_type + "</p>"
            + "<p id='notice-date'>" + datetime + "</p>" + "<br/><br/>"
            + "<p id='notice-content'> [ " + parseData[i].parking_id + " ] " + parseData[i].not_message + "</p><br/><br/>";
        newDiv.appendChild(content); //추가
        Btn = document.createElement("div") //삭제버튼 생성 (ajax deleteNotice기능과 동적생성된 요소 삭제까지...)
        Btn.setAttribute("id", "Btn");
        Btn.innerHTML = "<img id='deleteBtn' src='images/xbutton.png' onclick='deleteNotice(" + parseData[i].not_id + ");'/>" + "<br/><br/>";
        document.getElementById("cntnr").appendChild(Btn);
        //var ctn = document.getElementById("cntnr");
        //동적으로 생성된 알림창을 삭제하기위한 메소드  
        
        Btn.onclick = function () {
            deleteDIV(this.previousSibling, this);
        }
    }
}

function noBtnEvent(){  //div no로 클릭이벤트를 발생시켜서 no아래에 있는 div들을 삭제해줌 (notice를 지워줌)
    var no = document.getElementById("no");
    var cntnr = document.getElementById("cntnr");
    var num = cntnr.childElementCount
    console.log("num : " + num);
    if(num > 0){ //cntnr의 자식이 0보다 많으면no의 다음 div부터 차례대로 지워줌 
    no.onclick = function(){
        for(i = 0; i < num ; i++){
            deleteNoticeView(this.nextSibling);
            }
        num = 0;    
        }
    no.click();  //클릭이벤트 자동 발생
    }
}

function deleteNoticeView(nextNo){
    var parent = no.parentNode;
    parent.removeChild(nextNo);
}

function selectNotice(index) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            console.log("selectNoitce!!");
            var data = xhr.responseText;
            if(data != null){
            var parseData = JSON.parse(data);
            console.log(parseData);
            noBtnEvent(); //원래있던 notice 삭제 
            newNotice(parseData); //notice 목록 동적으로 생성
            if(parseData.length > 0){
            updateNoticeReadDate(); // 현재 출력된 알림목록 읽었다고 업데이트
                }
            }
        }
    };
   
    //버튼 추가
    if(index==6){
        page++;
        console.log("1.현재인덱스" + page);
            if((parseInt(page/5) > 0 )&&( page % 5 == 1)){
                for(i = 1; i < pageBtn.length-1; i++){
                    pageBtnNum[i].innerText = parseInt(pageBtnNum[i].innerText) + 5;
                }
            
            }
    }else if(index == 0){
        page--;
        if(page == 0){
        page = 1;
        }
        console.log("2.현재인덱스" + page);
        if((parseInt(page/5) > 0 )&&( page % 5 == 0)){
            for(i = 1; i < pageBtn.length-1; i++){
                pageBtnNum[i].innerText = parseInt(pageBtnNum[i].innerText) - 5;
            }
        }
    }else{
        page = parseInt(pageBtnNum[index].innerText);
        console.log("3.현재 인덱스 : " + page);
    }

   //버튼색
    for(i = 0; i < pageBtn.length ; i++){
        pageBtn[i].setAttribute("class", "page-item");
    }
    
    if((index==0 || index==6)&& page > 0){
        if(page % 5 == 0){
         pageBtn[5].setAttribute("class", "page-item active");
        }else{
           pageBtn[page % 5].setAttribute("class", "page-item active");
        }
    }else{
        pageBtn[index].setAttribute("class", "page-item active");
    }
    
    //내용불러올 번호
    if(index == 0){ 
       noticeCnt -= 4;
    }else if(index == 6){
       noticeCnt += 4;
    }else{
       noticeCnt = page*4-4;
    }
    
    if(noticeCnt < 0){
        noticeCnt = 0
    }
    console.log("********noticeCnt : "  +noticeCnt);
    xhr.open("GET", "selectNotice.do?user_id=" + userId +"&pageNum=" + noticeCnt, true);
    xhr.send();
}

function deleteNotice(notId) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            console.log("deleteNoitce!!");
            selectNotice(page);
        }
    };
    xhr.open("GET", "deleteNotice.do?not_id=" + notId, true);
    xhr.send();
}