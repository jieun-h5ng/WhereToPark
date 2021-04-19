
    
			function rating(){
				var rateLabel = document.getElementsByClassName("starLabel");
				var change = document.getElementsByClassName("fa-star");
				
				for(let i=0; i<rateLabel.length; i++){
					rateLabel[i].onclick = function(){
						for(let j=0; j<=i; j++){
							change[j].setAttribute("style", "color:#e4c61c;");
						}
						for(let k=i+1; k<rateLabel.length; k++){
							change[k].setAttribute("style", "color:#ccc;");
						}
					}
				}
			}
			function checkWrt(v){
				var ratingScore = v.review_rating.value;
				var content = v.review_content.value;
				
				if(ratingScore.trim()==''){
					alert("별점을 선택해주세요.");
					return false;
				}
				if(content.trim()==''){
					alert("리뷰를 작성해주세요.");
					return false;
				}
				send();
				v.submit();
			}
			function fnSubmit(){
				if(confirm("새 리뷰가 작성되었습니다.")){
					return true;
				}
				return false;
			}