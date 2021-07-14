<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport"
   content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>SIOT</title>
<link
   href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Titillium+Web:wght@200;300;400;600;700&display=swap"
   rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
   rel="stylesheet">
<link rel="stylesheet" href="css/swiper.css">
<link rel="stylesheet" href="css/splitting.css">
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/layout.css">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/product.css">
 <script src="https://kit.fontawesome.com/42fd459ca7.js" crossorigin="anonymous"></script>
 <script src="https://code.iconify.design/1/1.0.7/iconify.min.js"></script>
<script src="js/jquery-3.5.1.min.js"></script>
<script src="js/splitting.min.js"></script>
<script src="js/swiper.min.js"></script>
<script src="js/gsap/gsap.min.js"></script>
<script src="js/js.cookie.min.js"></script>
<script src="js/common.js" defer></script>
<script src="js/main.js" defer></script>

</head>

<body>

   <header id="header">
      <div id="logoBox">
         <div id="emptyBox"></div>
         <h1 id="logo">
            <a href="/"> <img src="images/layout/logo.png" width="46"
               alt="시옷프로젝트">
            </a>
         </h1>
         <div id="logoTxtBox">
            <span id="logoTxt">SIOT PROJECT</span>
         </div>
      </div>
      <nav id="gnb">
         <div class="emptyLeftBox"></div>
         <ul class="list">
            <li><a href="ProductDailyList.do" class="depth01">DAILY</a> <%@ include
                  file="/WEB-INF/views/include/gnb01.jsp"%>

            </li>
            <li><a href="ProductUniqueList.do" class="depth01">UNIQUE</a> <%@ include
                  file="/WEB-INF/views/include/gnb02.jsp"%>
            </li>
            <li><a href="ProductWeddingList.do" class="depth01">WEDDING</a>
               <%@ include file="/WEB-INF/views/include/gnb03.jsp"%>
            </li>
            <li><a href="ProductGoodbyeitemList.do" class="depth01">GOOD
                  BYE ITEM</a> <%@ include file="/WEB-INF/views/include/gnb04.jsp"%>
            </li>
         </ul>
         <div class="utilMenu">

            <%--                <c:if test="${loggedManager!=null }"> --%>
            <!--                    <a href="Manager.do">관리자 페이지</a> -->
            <%--                </c:if> --%>

            <c:choose>
               <c:when test="${loggedUserInfo!=null }">
                  <c:choose>
                     <c:when test="${loggedUserInfo.verify==1 }">
                        <img src="images/layout/logo.png" width="36" alt="시옷프로젝트" style="height:36px;  border:1px solid #ccc; border-radius: 50%; transform: translateY(40%);">
                        <a href="Manage.do">관리자 페이지</a>
                        <a href="UserLogout.do" class="login">로그아웃</a>
                     </c:when>
                     <c:otherwise>
                        <div id="myImg">
                           <img src="${loggedUserInfo.profileImg }" class="myImg">
                        </div>
                        <a href="OrderCheck.do?idNo=${loggedUserInfo.no }">마이페이지</a>
                        <a href="UserLogout.do" class="login">로그아웃</a>
                        <a href="ShopCartList.do?idNo=${loggedUserInfo.no }"
                           class="cart">장바구니</a>
                     </c:otherwise>
                  </c:choose>
               </c:when>
               <c:otherwise>
                  <a href="UserLoginForm.do" class="login">로그인</a>
                  <a href="UserSubJoin.do" class="join">회원가입</a>
                  <a href="ShopCartList.do?idNo=0" class="cart">장바구니</a>
               </c:otherwise>
            </c:choose>
         </div>
      </nav>
   </header>
   <!-- header end-->