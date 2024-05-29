<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>코디</title>

</head>
<head>
  <meta charset="UTF-8">
  <title>CodePen - 3D Carousel (v2)</title>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.3.2/html2canvas.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    crossorigin="anonymous"></script>
  <style>
  
    #closet {
      overflow: hidden;
      background-color: rgba(213, 222, 232, 0.6);
    }

    #closet,
    .box {
      position: absolute;
      user-select: none;
      overflow: hidden;
    }

    /* .drag {
      height: 50%;
    }
    .select {
      opacity: 0.1;
    } */

    .drag {
    display: flex; /* flexbox 레이아웃 적용 */
    height: 500px;
  }
  #droppable_left, #droppable {
    flex: 1; /* flexbox 아이템으로 만들어 각각 공간을 동일하게 차지하도록 함 */
  }
  #droppable {
    position: relative; /* 절대 위치 대신 상대 위치 사용 */
    width: 100%; /* 부모 (flex 아이템)의 전체 너비를 사용 */
    height: 500px; /* 높이 설정 */
    border: 2px dashed #ccc; /* 시각적 구분을 위한 스타일 */
  }
  #droppable_left {
    width: 100%; /* flex 아이템의 전체 너비를 사용 */
    height: 500px; /* 높이 설정 */
  }
  </style>
</head>
<body>
	<jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>
	
<h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">코디</h2>

  <!-- partial:index.partial.html -->
  <div class="container-fulid">
    <div class="row">
      <div class="col-6">
        <div id="closet">
          <p id="msg" style="margin-left: 35%; margin-top: 200px;">마우스를 올리세요</p>
        </div>
      </div>
      <div class="col-6 drag" id="drag" style="height: 500px;">
        <div id="droppable_left">
          <!-- 드롭된 이미지들이 여기에 추가됩니다 -->
        </div>
        <div id="droppable">
          <!-- 드롭된 이미지들이 여기에 추가됩니다 -->
          저장을 누르면 코디가 저장됩니다.
        </div>
      </div>
    </div>
    <div class="row pt-5">
      <button class="btn btn-primary" id="btn"> 저장</button>
    </div>
  </div>
  <!-- partial -->
  <script src='https://cdnjs.cloudflare.com/ajax/libs/gsap/3.4.1/gsap.min.js'></script>
  <script>
    const n = 30;
    // 컨테이너 위치 및 크기 설정
    const container = document.getElementById('closet');
    gsap.set(container, {
      perspective: 800,
      position: 'absolute', // 필요에 따라 조정
      left: '0%', // 화면의 왼쪽 절반에 위치
      top: '0%',
      width: '40%', // 화면 너비의 50%를 사용
      height: '50%', // 전체 높이 사용
      margin: '5%',
    borderRadius: 20
      // ,opacity:0.7
    });
    var arr =[]; 
    '<c:forEach items="${closetList }" var="closet" >'
    	arr.push('${closet.imgPath}');
    '</c:forEach>'
   for (let i = 0; i < arr.length; i++) {
      let b = document.createElement('img');
      b.src = "<c:url value='/download?imageFileName="+arr[i]+"' />";

      b.classList.add('box');
      container.appendChild(b); // 변경: 'document' 대신 'container' 사용

      gsap.set(b, {
        left: '50%',
        top: '50%',
        x: '-50%',
        y: '-50%',
        z: 600,
        width: 150,
        height: 400,
        borderRadius: 20,
        opacity: 0.6,
        background: () => 'hsl(' + (i / n * 360) + ',100%,50%)'
      });

      gsap.fromTo(b, {
        scaleY: 0,
        zIndex: () => (i < n / 2) ? -i : i,
        rotationY: 90 + i / n * 206.5,
        transformOrigin: "50% 50% -1060%"
      }, {
        scaleY: 1,
        duration: 1,
        delay: 1 - 0.5 * (i / n),
        ease: 'elastic'
      });
      // 이미지 불투명하게
      b.onmouseenter = (e) => { gsap.to(b, { duration: 0.3, rotationX: -10, y: '-130%', ease: 'back.out(6)', opacity: 1 }); }
     // 마우스가 벗어났을 때의 투명도를 원래대로
      b.onmouseleave = (e) => { gsap.to(b, { duration: 0.4, rotationX: 0, y: '-50%', opacity: 0.6 }); }
      b.onclick = (e) => {

        if (confirm(b.src + " 옷 선택?")) {

          let make_img = document.createElement('img');
          make_img.src = b.src;
          make_img.style.width = "100px";
          make_img.style.height = "200px";
          make_img.style.position = "relative";
          make_img.classList.add('draggable');
          b.remove();
          $('#drag').prepend(make_img);
          // 여기에 draggable() 함수를 추가
          $(make_img).draggable({
            containment: "parent"
          });
        }
      }
    }

    window.onmousemove = (e) => {
      const rect = container.getBoundingClientRect();
      const mouseXRelative = (e.clientX - rect.left) / rect.width; // 컨테이너 내 상대적 위치 계산

      if (mouseXRelative >= 0 && mouseXRelative <= 1) { // 컨테이너 내에서만 반응
        gsap.to('.box', {
          duration: 0.6,
          rotationY: (i) => 45 + i / n * 206.5 + 90 * mouseXRelative
        });
      }
    };







    $(function () {
      $("#closet").mouseover(function () {
        $("#msg").hide();
      })
      $(".draggable").draggable({
        containment: "parent"
      });
      $("#droppable").droppable({
        drop: function (event, ui) {
          // 드롭된 아이템의 복사본을 생성합니다.
          var droppedItem = $(ui.draggable).clone();

          // 드롭 위치를 `droppable` 영역 내 상대 위치로 계산합니다.
          // 이는 드롭 영역의 상단 왼쪽 모서리를 (0, 0)으로 하는 좌표계에서의 위치입니다.
          var droppableOffset = $(this).offset();
          var mouseX = event.clientX;
          var mouseY = event.clientY;
          var relativeX = mouseX - droppableOffset.left - 20;
          var relativeY = mouseY - droppableOffset.top - 20;

          // 복사본 아이템을 `droppable` 영역에 추가하고, 정확한 드롭 위치에 배치합니다.
          droppedItem.css({
            position: 'absolute',
            left: relativeX,
            top: relativeY
          }).appendTo($(this));

          // 원본 드래그 아이템을 삭제합니다.
          $(ui.draggable).remove();

          // 필요에 따라 추가적인 스타일이나 로직을 구현할 수 있습니다.
          // 예: 드롭된 아이템을 다시 드래그 가능하게 만들기
          droppedItem.draggable({
            containment: "parent"
          });
        }
      });

      $('#btn').on('click', function () {
        html2canvas($("#droppable")[0], { useCORS: true }).then(function (canvas) {
          saveAsImage(canvas);
        });


      });
    });

    function saveAsImage(canvas) {
      console.log(canvas);
      var image = canvas.toDataURL("image/png").replace("image/png", "image/octet-stream");
      var link = $('<a/>', {
        'download': 'captured-image.png',
        'href': image,
        'style': 'display:none;'
      }).appendTo('body');
      link[0].click();
      link.remove();
    }
  </script>


</html>
