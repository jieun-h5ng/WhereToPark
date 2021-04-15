<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    var currentLong;
    var currentLat;

    function getLocation(){
        if(navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position){
                //alert(position.coords.latitude + ' ' + position.coords.longitude);
                currentLat = position.coords.latitude;
                currentLong = position.coords.longitude;
                sendLocation();
            }, function(error){
                console.error(error);
            },{
                enableHighAccuracy : false,
                maximumAge : 0,
                timeout : Infinity
            });
        } else{
            alert('GPS를 지원하지 않습니다');
        }
    }
    
    function sendLocation(){
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function () {
            if (this.readyState === 4 && this.status === 200) {
                var data = xhr.responseText;
                var parseData = JSON.parse(data);
                console.log(parseData[0].parking_id);
                newRecommendation(parseData);
            }
        };
        console.log("MainPage sendLocation 실행중....");
        xhr.open("GET", "mainRecommendation.do?parking_lat=" + currentLat +"&parking_lng=" + currentLong, true);
        xhr.send();
    }
    
    function newRecommendation(parseData){
        const mainRecoBox = document.getElementById("recommendation");
        for (let i = 0; i < parseData.length; i++) {
            if(parseData[i].parking_title.length > 16){
                parseData[i].parking_title = parseData[i].parking_title.substr(0, 16) + "...";
            }
            if(parseData[i].parking_location.length > 14){
                parseData[i].parking_location = parseData[i].parking_location.substr(0, 14) + "...";
            }
            var newDiv = document.createElement("div"); //추천 주차장 담을 큰틀 생성
            newDiv.setAttribute("class", "recommendation-box");
            newDiv.setAttribute("id", "reco"+[i]);
            //newDiv.setAttribute("style", "background-color:yellow");
            newDiv.onclick = function () { location.href = "searchParkingDetail.do?parking_id=" + parseData[i].parking_id; }
            mainRecoBox.appendChild(newDiv);
            var img = document.createElement("div");
            img.innerHTML = "<img class= reco-img src='images/" + parseData[i].parking_pic + "'>";
            newDiv.appendChild(img);//img추가
            var content = document.createElement("div"); //내용담을 틀 생성
            content.setAttribute("class", "reco-content");
            content.innerHTML = "<p class='reco-type'> [ " + parseData[i].parking_type + " ] " + parseData[i].parking_location + "</p>"
                              + "<p class='reco-title'>" + parseData[i].parking_title + "</p>"
                              + "<p class='reco-cartype'>&#128664;" + parseData[i].parking_cartype + "</p>"
                              + "<p class='reco-price'>&#128181;" + parseData[i].parking_price + "</p>"
                              + "<p class='reco-intime'> 주차 시작 시간 : "+ parseData[i].parking_intime.slice(0, 19) + "<br/>"
                                + "주차 마감 시간 : " +  parseData[i].parking_outtime.slice(0, 19)+"</p>";
            newDiv.appendChild(content); //추가
    
        } 
    }