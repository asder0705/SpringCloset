<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
 	  <jsp:include page="/WEB-INF/inc/top.jsp"></jsp:include>
 	   <!-- Contact Section-->
        <section class="page-section" id="contact" style = "margin-top:150px">
            <div class="container">
                <!-- Contact Section Heading-->
                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">로그인</h2>
                <!-- Icon Divider-->
                <div class="divider-custom">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                    <div class="divider-custom-line"></div>
                </div>
                <!-- Contact Section Form-->
                <div class="row justify-content-center">
                    <div class="col-lg-8 col-xl-7">                       
                        <form method="post" action="<c:url value="/loginDo" />">
                            <!-- Name input-->
                            <div class="form-floating mb-3">
                                <input  class="form-control" name="memId" id="memId" type="text" placeholder="아이디 입력 " data-sb-validations="required" />
                                <label for="name">아이디</label>
                                <div class="invalid-feedback" data-sb-feedback="text:required">A ID is required.</div>
                            </div>
                            <!-- Email address input-->
                            <div class="form-floating mb-3">
                                <input class="form-control" name="memPw" id="memPw" type="password" placeholder="비밀번호 입력" data-sb-validations="required" />
                                <label for="email">비밀번호</label>
                                <div class="invalid-feedback" data-sb-feedback="password:required">An email is required.</div>                              
                            </div> 
                                             
                            <!-- Submit Button-->
                            <button class="btn btn-dark btn-xl" id="submitButton" type="submit">로그인</button>
                            <input type="hidden" name="fromURL" value= "${fromURL}"> 
                        </form>
                    </div>
                </div>
            </div>
        </section>
 	 <jsp:include page="/WEB-INF/inc/footer.jsp"></jsp:include>
</body>
</html>