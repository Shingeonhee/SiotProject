<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>SIOT</title>
<link rel="shortcut icon" href="../images/layout/logo.png" type="image/x=icon">
<link rel="stylesheet" href="css/reset.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Titillium+Web:wght@200;300;400;600;700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="css/swiper.css">
<link rel="stylesheet" href="css/splitting.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/layout.css">
<link rel="stylesheet" href="css/main.css">
<script src="js/jquery-3.5.1.min.js"></script>
<script src="js/splitting.min.js"></script>
<script src="js/swiper.min.js"></script>
<script src="js/gsap/gsap.min.js"></script>
<script src="js/js.cookie.min.js"></script>
<script src="js/common.js" defer></script>
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
		<div id="manageBody">
			<div id="managergnb">
				<ul class="list">
					<li><a href="ProductManage.do" id="productManage">상품관리</a></li>
					<li><a href="AllQnaList.do" id="AllQnaList">Q&amp;A</a></li>
					<li><a href="PaymentList.do" id="orderList">주문관리</a></li>
					<li><a href="UserList.do" id="userList">회원관리</a></li>
				</ul>
				<a href="Manage.do" id="admin">관리자 페이지</a>
			</div>
		</div>
	</header>