<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../css/layout.css">
<%@ include file="/WEB-INF/views/include/manage_header.jsp"%>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
#whole {
	width: 100%;
	height: 1000px;
}

#leftside {
	width: 300px;
	float: left;
	box-sizing: border-box;
	margin-left: 100px;
}

#category {
	margin-top: 20px;
	font-size: 18px;
}

#Mainpdtimg {
	overflow: hidden;
	display: flex;
	align-items: baseline;
	justify-content: center;
	width: 600px;
	height: 750px;
	margin-top: 20px;
	position: relative;
}
#Mainpdtimg img{
	object-fit: cover;
	width:100%;
}

#rightside {
	width: 500px;
	float: right;
	box-sizing: border-box;
	margin-top: 40px;
	margin-right: 30px;
}

#pdtwithprice {
	
}

#productname {
	font-size: 22px !important;
}

#productprice {
	margin-top: 25px;
}

#productprice:after {
	content: "";
	display: block;
	width: 510px;
	border-bottom: 1px solid #bcbcbc;
	margin: 20px auto;
}

#pdtdetail {
	margin-top: 40px;
	text-align: center;
	font-size: 17px;
}

#pdtsuperdetail {
	margin-top: 20px;
	text-align: center;
	font-size: 17px;
}

.parent {
	width: 90%;
	margin: 10px auto;
	display:flex;
	justify-content: space-between;
	
}

.buyrightnowButton {
	background-color: #4f4f4f;
	border: 14px solid #4f4f4f;
	display: inline-block;
	cursor: pointer;
	color: #ffffff;
	font-family: Arial;
	display:block;
	width: 140px;
	height: 45px;
	font-size: 15px;
	box-sizing: border-box;
	text-align: center;
}

.buycartButton {
	border: 1px solid #4f4f4f;
	display: inline-block;	
	width: 140px;
	height: 45px;
	box-sizing: border-box;
	line-height: 42px;
	text-align: center;
	/* border : 14px solid transparent; */
}

.buywishlistButton {
	border: 1px solid #4f4f4f;
	display: inline-block;	
	width: 140px;
	height: 45px;
	box-sizing: border-box;
	line-height: 42px;
	text-align: center;
	/*  border : 10px solid transparent; */
}

#deleteButton {
	background-color: #c74545;
	border-radius: 28px;
	display: inline-block;
	cursor: pointer;
	margin-top: 64px;
	margin-left: 272px;
	color: #ffffff;
	font-family: Arial;
	font-size: 20px;
	font-weight: bold;
	padding: 17px 31px;
	text-decoration: none;
}

#deleteButton:hover {
	background-color: #bd2a2a;
}

#deleteButton:active {
	position: relative;
	top: 1px;
}

#fixButton {
	background-color: #007aff;
	border-radius: 28px;
	display: inline-block;
	cursor: pointer;
	color: #ffffff;
	font-family: Arial;
	font-size: 20px;
	font-weight: bold;
	padding: 17px 31px;
	text-decoration: none;
}

#fixButton:hover {
	background-color: #bd2a2a;
}

#deleteButton:active {
	position: relative;
	top: 1px;
}

#origin1 {
	float: left;
	margin-right: 10px;
	clear: both;
}

#origin2 {
	margin-left: 70px;
}

#buyeffort1 {
	float: left;
	margin-right: 10px;
	clear: both;
}

#buyeffort2 {
	margin-left: 70px;
}

#postprice1 {
	float: left;
	margin-right: 10px;
	clear: both;
}

#postprice2 {
	margin-left: 70px;
}

#all2 {
	margin-top: 50px;
	margin-bottom: 50px;
}
</style>
</head>
<body>

	<section id="pageSize">


		<div id="whole">
			<!-- ?????? ?????? -->

			<div id="leftside">
				<!-- ???????????? -->

				<div id="category">
					<!-- ???????????? -->
					<span>${productBean.category}</span>

				</div>

				<div id="Mainpdtimg">
					<!-- ???????????? ????????? -->
					<img src="${productBean.mainimg}">

				</div>


			</div>
			<div id="rightside">
				<!-- ????????? ?????? -->
				<div id="pdtwithprice">

					<!-- ????????? -->
					<div id="productname">
						<span>${productBean.name}</span>
					</div>

					<!-- ???????????? -->
					<div id="productprice">
						<span>${productBean.price}</span>
					</div>
				</div>


				<div>
					<div id="pdtdetail">
						<!-- ?????? ???????????? -->
						<span>${productBean.contents}</span>
					</div>


				</div>


				<div id="all2">
					<div>
						<div id="origin1">
							<!-- ????????? 1 (title) -->
							<p>?????????</p>
						</div>

						<div id="origin2">
							<!-- ????????? 2 (substance) -->
							<p>Korea</p>
						</div>
					</div>

					<div>
						<div id="buyeffort1">
							<!-- ???????????? 1 (title) -->
							<p>????????????</p>
						</div>

						<div id="buyeffort2">
							<!-- ???????????? 2 (substance) -->
							<p>1,780 ????????????????????? ????????????</p>
						</div>
					</div>
					
					<div>
						<div id="postprice1">
							<!-- ???????????? 1 (title)-->
							<p>?????????</p>
						</div>

						<div id="postprice2">
							<!-- ???????????? 2 (substance)-->
							<p>4,000??? (250,000??? ?????? ????????????)</p>
						</div>
					</div>
				</div>
				<div id="goodWrap">
                     <div class="option_select">
                        <a class="option_title subject">??????*</a>
                        <div id="colorchoosewhynotworking">
                           <div>
                              <div style="display: flex;">
                                 <c:forEach var="i"
                                    items="${productBean.productcolor.split(',') }" begin="0"
                                    end="3" step="1" varStatus="status">
                                    <label style="display: flex;"> 
                                    <input name="pdtColor" type="radio" value="${i}" id="pdtColor">
                                       <span id="colorBox" style="background-color:${i};" class="colorBox"></span>
                                    </label>
                                 </c:forEach>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div class="option_select">
                        <a id="productsizereal" style="margin-bottom: 1px;"
                           class="option_title subject">?????????*</a>
                        <div>
                           <select class="active" name="pdtSize" id="option_size">
                              <c:forEach var="i"
                                 items="${productBean.productsize.split(',') }" begin="0"
                                 end="3" step="1" varStatus="status">
                                 <option id="pdtSize">${i}</option>
                              </c:forEach>
                           </select>
                        </div>
                     </div>
                     <div class="option_select">
                        <div class="option_title subject">??????</div>
                        <div id="amountBox">
                           <!-- ?????? -->
                           <a id="minusBtn">-</a> <input type="text" name="amount"
                              id="amount" value="1"> <a id="plusBtn">+</a>
                        </div>
                     </div>
                  </div>
				<div id="postmethodwhich">
					<!-- ???????????? -->
					<select class="active" name="selectBox">
						<option id="selectBox0">??????</option>
						<option id="selectBox1">????????????</option>
					</select>
				</div>


				<div id="colorchoose">
					<!-- ?????? -->
				</div>
				<div id="addwidth">
					<!-- ????????? -->
				</div>
				<div id="addheight">
					<!-- ???????????? -->
				</div>

				<div class="parent">
					<!-- ???????????? -->

					<div id="buyrightnow">
						<!-- ???????????? -->
						<a href="#" class="buyrightnowButton">????????????</a>

					</div>


					<div id="buycart">
						<!-- ???????????? -->
						<a href="#" class="buycartButton">????????????</a>

					</div>


					<div id="buywishlist">
						<!-- ??????????????? -->
						<a href="#" class="buywishlistButton">???????????????</a>

					</div>


				</div>

				<div>
					<div>

						<a href="ProductDelete.do?no=${productBean.no} "
							onclick="if(!confirm('??????????????? ???????????? ????????????. \n ????????? ??????????????????????????')){return false;}"
							id="deleteButton"> ?????? </a> <a
							href="ProductUpdateForm.do?no=${productBean.no}" id="fixButton">
							?????? </a>


					</div>
				</div>

			</div>
		</div>

		<%@ include file="/WEB-INF/views/manager/manage_product_detail.jsp"%>
		<%@ include file="/WEB-INF/views/reviewbox/review_list.jsp"%>
		<%@ include file="/WEB-INF/views/reviewbox/review_qna.jsp"%>
		<%@ include file="../include/footer.jsp"%>

	</section>




</body>
</html>