<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<link rel="stylesheet" href="../css/product.css">
<link rel="stylesheet" href="../css/layout.css">

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
<link rel="stylesheet" href="css/product.css">

<script src="js/jquery-3.5.1.min.js"></script>
<script src="js/splitting.min.js"></script>
<script src="js/swiper.min.js"></script>
<script src="js/gsap/gsap.min.js"></script>
<script src="js/js.cookie.min.js"></script>
<script src="js/common.js" defer></script>

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
					<li><a href="ProductDailyManage.do" class="depth01">DAILY</a></li>
					<li><a href="ProductUniqueManage.do" class="depth01">UNIQUE</a>
					</li>
					<li><a href="ProductWeddingManage.do" class="depth01">WEDDING</a>
					</li>
					<li><a href="ProductGoodbyeitemManage.do" class="depth01">GOOD
							BYE ITEM</a></li>
					<li><a href="ProductAddForm.do">상품추가</a></li>
				</ul>
				<a href="Manage.do" id="admin">관리자 페이지</a>
			</div>
		</div>
		
		
		
	</header>
	
	
	<section id="pageSize">
			<div id="searchBox">
			<a href="">
				<span class="material-icons" id="search"> search </span>
			</a>
		</div>
	<div>
		<div id="mainname">Unique</div>
	</div>
	<div>
		<div>
			<div id="uniqueBox">
				<c:forEach var="ProductBean" items="${productList}" begin="0"
					end="${productList.size()}" step="1" varStatus="status">
					<div id="productImgBox">
						<div id="hoverBox01">
							<div id="hover01">
								<a href="ManageProductInfo.do?no=${ProductBean.no}"> <img
									src="${ProductBean.mainimg}" id="productImg"></a>
							</div>
						</div>
						<div id="txtBox">
						<a href="ProductInfo.do?no=${ProductBean.no}" id="txt01"> 
						<span>${ProductBean.name}</span>
						</a> 
						<span id="txt02">${ProductBean.price}</span>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	</section>
</body>
</html>

<style>
#mainname {
  font-size: 15px;
  margin-top: 40px;
  padding-bottom: 15px;
}

</style>

<%@ include file="../include/footer.jsp"%>



