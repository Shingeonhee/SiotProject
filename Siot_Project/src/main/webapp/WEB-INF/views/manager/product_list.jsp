<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
					<li><a href="ProductList.do" id="productList">상품관리</a></li>
					<li><a href="product_delete.do" id="deleteList">상품제거</a></li>
					<li><a href="ProductAddForm.do" id="addList">상품추가</a></li>
					<li><a href="product_update.do" id="updateList">상품업데이트</a></li>
				</ul>
			</div>
		</div>
	</header>
	
	
	<%@ include file="../include/footer.jsp"%>
	