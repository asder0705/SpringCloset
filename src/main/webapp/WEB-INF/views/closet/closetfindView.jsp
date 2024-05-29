<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Image Classification</title>


<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style>
.regist_wrapper {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	width: 400px;
	height: 300px;
	border: 1px solid #ebeaec;
	box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.3);
	margin: auto;
	margin-top: 20px;
	border-radius: 16px;
	padding: 24px;
	text-align: center;
}

.image-preview-container {
	position: relative;
	display: inline-block; /* 캔버스와 텍스트 오버레이를 위한 컨테이너 */
}

.image-preview {
	max-width: 100%; /* 화면 너비에 맞게 최대 너비 설정 */
	border: 1px solid #ccc; /* 테두리 추가 */
	box-shadow: 0 2px 4px rgba(0, 0, 0, .1); /* 그림자 효과 추가 */
	margin-top: 20px; /* 상단 여백 추가 */
}

#overlay {
	position: absolute;
	top: 0;
	left: 0;
	color: blue;
	background-color: rgba(255, 255, 255, 0.5); /* 텍스트 배경을 약간 투명하게 */
	visibility: hidden; /* 기본적으로 숨김 */
	pointer-events: none; /* 마우스 이벤트가 뒤의 캔버스로 통과하도록 */
	font-size: 14px;
	font-family: Arial;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>
	<div class="container-fulid">
		<div class="row pt-4">
			<div class="col-1"></div>
			<div class="col-5">
				<h1>이미지 분류</h1>
				<form id="uploadForm" enctype="multipart/form-data">
					<input type="file" name="image" onchange="previewImage(this)">
					<input type="button" value="분류하기" onclick="uploadImage()">
				</form>
				<br>
				<div class="image-preview-container">
					<canvas id="canvas" class="image-preview"></canvas>
					<div id="overlay"></div>
				</div>
			</div>
			<div class="col-5">
				<!--  	form -->
				<form action="<c:url value="/plusFind" />" method="post">
				<div class="regist_wrapper">
					<div class="row">
						<div class="col">
							<label for="inputEmail4" class="form-label pname">상품 이름</label> <input
							name="pname"	type="text" class="form-control pname" id="inputEmail4" value="${item.pname }">
						</div>
						<div class="col">
							<label for="inputPassword4" class="form-label ptypeName">카테고리</label> <input
							 name="ptypeName"	type="text" class="form-control ptypeName" id="inputPassword4" value="${item.ptypeName }">
						</div>
					</div>
					<div class="row">
						<div class="col">
							<label for="inputAddress" class="form-label">색상</label>
							<select name="cgroupCode">
								<c:forEach items="${cgroup }" var="item">
									<option value="${item.cgroupCode }">${item.cgroupName}</option>
								</c:forEach> 
							</select>
							


						</div>
					
						<div class="col">
							<label for="inputCity" class="form-label imgPath">이미지 경로</label> <input
							name="imgPath"	type="text" class="form-control imgPath" id="inputCity" value="${item.imgPath }">
						</div>
					</div>				
					<div class="row pt-4">
						<div class="col">
							<button type="submit" class="btn btn-primary">저장하기</button>
						</div>
					</div>
				</div>
				</form>
			</div>


			<div class="col-1"></div>
		</div>
		<div class="row pt-4">
			<div class="col-1"></div>
			<div class="col-10">
				<div id="result" class="row row-cols-1 row-cols-md-5 g-4"></div>
			</div>
			<div class="col-1"></div>
		</div>

	</div>
	<script>
    
        function previewImage(input){
        	
            let file = input.files[0];
            let reader = new FileReader();
            reader.onload = function(e){
                let img = new Image();
                img.onload = function(){
                    let canvas = document.getElementById("canvas");
                    canvas.width = img.width; // 이미지의 너비로 캔버스 크기 조정
                    canvas.height = img.height; // 이미지의 높이로 캔버스 크기 조정
                    let ctx = canvas.getContext("2d");
                    ctx.drawImage(img, 0, 0);
                    canvas.style.display = "block";
                };
                img.src = e.target.result;
            };
            reader.readAsDataURL(file);
        }

        function uploadImage(){
            let formData = new FormData($("#uploadForm")[0]);
            $.ajax({
                type: "POST",
                url: "http://192.168.0.30:5000/upload_image",
                
                data: formData,
                contentType: false,
                processData: false,
                success: function(res){
                    drawBoundingBoxes(res);
                }
            });
        }

        function drawBoundingBoxes(data){
            let canvas = document.getElementById("canvas");
            let ctx = canvas.getContext("2d");
            let overlay = document.getElementById("overlay");

            // 클릭 이벤트 리스너 추가
            canvas.addEventListener('click', function(e) {
                data.forEach(item => {
                    const [x1, y1] = item.bounding_box[0];
                    const [x2, y2] = item.bounding_box[2];
                    if (e.offsetX >= x1 && e.offsetX <= x2 && e.offsetY >= y1 && e.offsetY <= y2) {
                        // 클릭한 바운딩 박스의 텍스트를 알림으로 표시
                        q = prompt("맞나요? 아니면 살짝 수정해주세요",item.text);
                        fn_search(q);


                    }
                });
            });
            canvas.addEventListener('mousemove', function(e) {
                let displayText = false;
                data.forEach(item => {
                    const [x1, y1] = item.bounding_box[0];
                    const [x2, y2] = item.bounding_box[2];
                    if (e.offsetX >= x1 && e.offsetX <= x2 && e.offsetY >= y1 && e.offsetY <= y2) {
                        overlay.style.left = `${e.offsetX + 10}px`;
                        overlay.style.top = `${e.offsetY + 10}px`;
                        overlay.textContent = item.text;
                        overlay.style.visibility = 'visible';
                        displayText = true;
                    }
                });
                if (!displayText) {
                    overlay.style.visibility = 'hidden';
                }
            });

            data.forEach(item => {
                const [x1, y1] = item.bounding_box[0];
                const [x2, y2] = item.bounding_box[2];
                ctx.strokeStyle = 'red';
                ctx.lineWidth = 2;
                ctx.strokeRect(x1, y1, x2 - x1, y2 - y1);
            });
        }
        function fn_search(query){
             $.ajax({
                type: "POST",
                url: "http://192.168.0.30:5000/search",
                
                data :JSON.stringify({q:query}),
                dataType : 'json',
                success: function(res){
                    console.log(res);
                    if(res.items.length == 0){
                    	let flag = confirm("정보가 없어요 찾아올까요?!");
                    	console.log(flag);
                    }else{
	                    $(res.items).each(function(i, v){
	                        console.log(v.image);
	                        
	                        let str ="";
	                        
	                        str +='<span class="card" style="width: 18rem ;">';
		                	str +='<img src='+v.image+' width="200px">';
		                	str +='<span class="card-body">';
		                	str +='<h5 class="card-title">'+v.title+'</h5>';
		                	str +='<p class="card-text">상세정보<br> 브랜드: '+v.brand+' 카테고리: '+v.category3
		                											+'<br>이미지 경로: '+v.image+'</p>';
		                			           
		                	str +='</div>';    
		                	str +='<button class="submit_btn" onclick="addEventHandler(this)" data-value="'+v.title +'" data-value1="'+v.category3+'" data-value2="'+v.image+'">저장</button>'
		                	str +='</span>';  
	                        
	                      
	                				
		                	$("#result").append(str);
	                    });
                    	
                    }
                },
				error:function(e){
					console.log(e);
				}
            });
        }
        function addEventHandler(obj) { 
        	    let data = $(obj).attr('data-value');
        	    let data1 = $(obj).attr('data-value1');
        	    let data2 = $(obj).attr('data-value2');
        	    
         	    console.log(data);
         	    console.log(data1);
         	    console.log(data2);
        	    
        	    data = data.replace('<b>', '');
        	    data = data.replace('</b>', '');
        	    console.log("b: " + data);
        	    $('#inputEmail4').val(data);
        	    $('#inputPassword4').val(data1);
        	    $('#inputCity').val(data2);
        	    
        	    /*
        	    var regex = /카테고리:(.*)/;
        	    var match = data.match(regex);
        	    if (match) {
        	        var afterWorld = match[1]; // 매치된 그룹 1 (괄호로 묶인 부분)에 해당하는 문자열
        	        console.log(afterWorld); // 출력: ", this is a sample string."
        	    }
 */        	    
        }
    </script>

	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
</body>
</html>
