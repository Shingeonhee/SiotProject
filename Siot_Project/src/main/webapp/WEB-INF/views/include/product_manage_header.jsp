<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>SIOT</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Titillium+Web:wght@200;300;400;600;700&display=swap"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/swiper.css">
<link rel="stylesheet" href="css/splitting.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/layout.css">
<link rel="stylesheet" href="css/manager_product.css">
<script src="js/jquery-3.5.1.min.js"></script>
<script src="js/splitting.min.js"></script>
<script src="js/swiper.min.js"></script>
<script src="js/gsap/gsap.min.js"></script>
<script src="js/js.cookie.min.js"></script>
<script src="js/common.js" defer></script>
</head>
<body>
	<div id="manageBody">
		<div id="managergnb">
			<ul class="list">
				<li><a href="ProductDailyManage.do" class="depth01">DAILY</a></li>
				<li><a href="ProductUniqueManage.do" class="depth01">UNIQUE</a>
				</li>
				<li><a href="ProductWeddingManage.do" class="depth01">WEDDING</a>
				</li>
				<li><a href="ProductGoodbyeitemManage.do" class="depth01">GOOD BYE ITEM</a></li>
				<li><a href="ProductAddForm.do">상품추가</a></li>
			</ul>
			<a href="Manage.do" id="admin">관리자 페이지</a>
		</div>
	</div>
</body>
</html>