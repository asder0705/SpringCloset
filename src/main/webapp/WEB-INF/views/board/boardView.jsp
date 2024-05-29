<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body id="page-top">
	<!-- 모든 페이지 상단에 들어가는 부분 -->
	<jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>
	<section class="page-section" id="contact">
		<div class="container" style="margin-top: 100px">
			<table class="table table-hover">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>날짜</th>
					</tr>
				</thead>
				<tbody>
					<!-- 데이터의 수만큼 반복되는 부분 -->
					<c:forEach items="${boardList}" var="board">
						<tr>
							<td>${board.boardNo}</td>
							<td><a
								href="<c:url value="boardDetailView?boardNo=${board.boardNo}"/>">
									${board.boardTitle} </a></td>
							<td>${board.memNm}</td>
							<td>${board.boardDate}</td>

						</tr>
					</c:forEach>
				</tbody>
			</table>
			<a href="<c:url value="boardWriteView" />">
				<button type="button" class="btn btn-primary">글쓰기</button>
			</a>
		</div>
	</section>
	<%-- <table>
		<tr>
			<th>대분류</th>
			<td><select id="mainSel">
					<option value="">--선택하세요</option>
					<c:forEach items="${comList}" var="code">
						<option value="${code.commCd}">${code.commNm}</option>
					</c:forEach>
			</select></td>
			<th>중분류</th>
			<td><select id="subSel">
					<option value="">--선택하세요--</option>
			</select></td>
		</tr>
	</table> --%>
	
	<jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
</body>
</html>