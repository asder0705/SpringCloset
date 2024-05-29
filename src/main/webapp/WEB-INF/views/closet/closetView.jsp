<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>jQuery Drag and Drop 예제</title>

<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<meta charset="UTF-8">
<title>내옷장</title>

</head>
<body>
	<jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>
	<h2
		class="page-section-heading text-center text-uppercase text-secondary mb-0">내옷장</h2>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
	<!-- 화면영역  -->

	<!-- 드래그 가능한 이미지 -->

	<%-- <c:forEach items="${closetList }" var="closet">
		<img class="draggable"
			src="<c:url value='/download?imageFileName=${closet.imgPath}' />"
			alt="드래그하세요!"
			style="width: 200px; height: 200px; border: 1px solid black; background-color: #ccc;"> --%>
		<%-- </c:forEach> --%>

	<!--  옷  카드 -->

	<div class="row row-cols-1 row-cols-md-3 g-4" id="result">
		<c:forEach items="${closetList }" var="closet">
			<div class="card" style="width: 18rem;" id="result">
				<img
					src="<c:url value='/download?imageFileName=${closet.imgPath}' />"
					class="card-img-top" alt="...">
				<div class="card-body">
					<div class="accordion" id="accordionExample">
						<div class="accordion-item">
							<h2 class="accordion-header">
								<button class="accordion-button" type="button"
									data-bs-toggle="collapse" data-bs-target="#collapseOne"
									aria-expanded="true" aria-controls="collapseOne">
									<h5 class="card-title" value="${closet.pname}">${closet.pname}</h5>
								</button>
							</h2>
							<div id="collapseOne" class="accordion-collapse collapse show"
								data-bs-parent="#accordionExample">
								<div class="accordion-body">
									<p class="card-text" value="${closet}">${closet.pcode}
										${closet.detailDesc}</p>
									<form action="<c:url value="/closetDel"/>" class="closetForm"
										method="post">
										<input type="hidden" name="closetNo"
											value="${closet.closetNo}">
										<button type="button" class="btn btn-danger me-2"
											onclick="fn_check(this)">삭제</button>
									</form>
								</div>
							</div>
						</div>
						</div>
					</div>
				</div>
		</c:forEach>
	</div>



	<!-- 화면영역 끝 -->

	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
	<script>
		$(function() {
			// 드래그 가능한 이미지로 설정
			$(".draggable").draggable();

			// 드롭 영역 설정
			$("#droppable").droppable(
					{
						drop : function(event, ui) {
							$(this).addClass("ui-state-highlight").find("p")
									.html("드랍됨!");
						}
					});
		});

		function fn_check(obj) {
			if (confirm("정말 이옷을 버리실거에요 ㅠㅠ????")) {
				console.log($(obj).parent());
				$(obj).parent().submit();
			}
		}
	</script>
</body>
</html>
