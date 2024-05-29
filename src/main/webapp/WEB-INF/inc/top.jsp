<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<head> 
  <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!--         <script src="http://code.jquery.com/jquery-3.7.1.js"></script> -->
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <!-- Simple line icons-->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/simple-line-icons/2.5.5/css/simple-line-icons.min.css" rel="stylesheet" />
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body id="page-top">
    
    <div class="container-fulid" style="background-color:#597285; height:10%; font-size:30px; padding-top:1rem;padding-left:1rem;"  > My'Closet </div>
        <!-- Navigation-->
        <a class="menu-toggle rounded" href="#"><i class="fas fa-bars"></i></a>
        <nav id="sidebar-wrapper">
            <ul class="sidebar-nav">
                <li class="sidebar-brand"><a href="#page-top">메뉴</a></li>
                <li class="sidebar-nav-item"><a href="<c:url value="/" />">메인화면</a></li>
                
                 <c:if test="${sessionScope.login ==null }">
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" 
                href="<c:url  value="/registView" />">회원가입</a></li>
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" 
                href="<c:url value="/loginView" />">로그인</a></li>
                 </c:if>
                   <c:if test="${sessionScope.login !=null }">             
                <li class="sidebar-nav-item"><a class="nav-link py-3 px-0 px-lg-3 rounded" 
                href="<c:url value="/closetView" />">내옷장</a></li>
                <li class="sidebar-nav-item"><a class="nav-link py-3 px-0 px-lg-3 rounded" 
                href="<c:url value="/closetupView" />">내옷장 추가하기</a></li>
                <li class="sidebar-nav-item"><a class="nav-link py-3 px-0 px-lg-3 rounded" 
                href="<c:url value="/closetfindView" />">옷 찾기</a></li>
                <li class="sidebar-nav-item"><a class="nav-link py-3 px-0 px-lg-3 rounded"
                href="<c:url value="/codyView" />">옷 코디하기</a></li> 
                <li class="sidebar-nav-item"><a class="nav-link py-3 px-0 px-lg-3 rounded"
                href="<c:url value="/boardView" />">회원 게시판</a></li> 
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" 
                href="<c:url value="/mypageView" />">${sessionScope.login.memId} 님 </a></li>
                   <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" 
                   href="<c:url value="/logoutDo" />">로그아웃</a></li> 
                </c:if>  
            </ul>
            
        </nav>