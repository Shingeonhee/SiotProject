<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="main">
	<div id="mainVisual">
		<ul class="list swiper-wrapper">
			<li id="visual01" class="swiper-slide">
				<div class="img">
					<div id="mainTxtWrap">
						<h2>쉬운 한복</h2>
						<h1>시옷프로젝트</h1>
						<a href="ProductInfo.do?no=1">SHOP NOW</a>
					</div>
				</div>
			</li>
			<li id="visual02" class="swiper-slide">
				<div class="img"></div>
			</li>
			<li id="visual03" class="swiper-slide">
				<div class="img"></div>
			</li>
		</ul>
		<div class="pagination">
			<div class="inner"></div>
		</div>
	</div>
</div>
<section id="mainText">
	<div class="txtBox">
		<h2>한복이 생활에서 가까워지기 위해</h2>
		<h5>우리는 그동안 많은 시도를 해왔습니다.</h5>
		<h5>한복자체가 하나의 스타일이 아닙니다.</h5>
		<h5>한복은 문화입니다.</h5>
		<h5>그 안에서 다양한 스타일이 존재하죠.</h5>
		<h5>우리는 보여드리고 싶어요.</h5>
		<strong>한복이 가진 다양한 가능성을,</strong> <span>이젠 당신이 도전할 차례입니다.</span>
	</div>
</section>
<section id="itemSlide" style="margin: 50px 0 200px;">
	<div id="itemSlideBox">
		<ul class="swiper-wrapper">
			<c:forEach var="ProductBean" items="${productList}" begin="0" end="${productList.size()}" step="1" varStatus="status">
				<li id="item${status}" class="swiper-slide" style="padding: 0 10px;">
					<div class="img" style="display: flex; flex-direction: column;">
						<a href="ProductInfo.do?no=${ProductBean.no}" id="imgBox" style="width: 100%; object-fit: cover;"> 
							<img src="${ProductBean.mainimg}" id="productImg" style="width: 100%; height: 780px;">
						</a>
						<div id="txtBox" style="margin-top: 10px;">
							<a href="ProductInfo.do?no=${ProductBean.no}" style="display: flex; flex-direction: column; color: #4f4f4f;">
								<span id="txt01" style="margin-bottom: 5px;">${ProductBean.name}</span>
								<span id="txt02">${ProductBean.price}</span>
							</a>
						</div>
					</div>
				</li>
			</c:forEach>
		</ul>
	</div>
</section>
<section id="video">
	<div style="height: 941px; width: 100%; overflow: hidden;">
		<iframe width="100%"
			src="https://www.youtube.com/embed/r8dYNoM9RQ0?autoplay=1&mute=1&amp&loop=1&controls=0&theme=dark&autohide=0&cc_load_policy=1&modestbranding=1&fs=0&showinfo=0&rel=0&iv_load_policy=3&playlist=r8dYNoM9RQ0"
			style="height: 1070px; background: #fff; bottom: 80px; position: relative;"
			sandbox="allow-forms allow-scripts allow-pointer-lock allow-same-origin allow-top-navigation">
		</iframe>
	</div>
</section>
<section id="designer">
	<div class="designerWrap">
		<div class="designerBox">
			<div class="designerOne">
				<img src="../images/main/CEO.jpg">
				<div class="textWrap">
					<strong>대표/디자이너</strong> <span>CNe choi</span>
				</div>
			</div>
			<p>감성을 담아 디자인하다.</p>
			<p>모든 최상의 영감은 완벽한 자연에서 온다고 확신합니다</p>
		</div>
		<div class="designerBox">
			<div class="designerOne">
				<img src="../images/main/DESIGNER.jpg">
				<div class="textWrap">
					<strong>디자이너/CS</strong> <span>LeeSeul</span>
				</div>
			</div>
			<p>도전하기 쉬운.</p>
			<p>씨네와는 반대로 수수하고 여성스런,도전하기 쉬운 한복을 만듭니다.</p>
		</div>
	</div>
</section>
<section id="youtube">
	<div style="height: 941px; width: 100%; overflow: hidden;">
		<iframe width="100%"
			src="https://www.youtube.com/embed/YDENdq7UIWg?autoplay=1&mute=1&amp&loop=1&controls=0&theme=dark&autohide=0&cc_load_policy=1&modestbranding=1&fs=0&showinfo=0&rel=0&iv_load_policy=3&playlist=YDENdq7UIWg"
			style="height: 1070px; background: #fff; bottom: 80px; position: relative;"
			sandbox="allow-forms allow-scripts allow-pointer-lock allow-same-origin allow-top-navigation">
		</iframe>
	</div>
</section>
<section id="subText">
	<div id="subTextBox">
		<img src="../images/main/leftMark.png">
		<div class="txtBoxSub">
			<h5>우리는 개썅마이웨이를 지향하는 당신을 위해 옷을 만듭니다.</h5>
			<h5>누군가에게 예쁘고 멋지기 위해서가 아닌</h5>
			<strong>스스로가 아름답기를 추구하는 당신을 위해.</strong>
		</div>
		<img src="../images/main/rightMark.png">
	</div>
</section>
<section id="collaboration">
	<ul class="list swiper-wrapper">
		<li id="collabo01" class="swiper-slide">
			<a href="">
				<div class="img">
					<p>collaboration</p>
				</div>
			</a>
		</li>
		<li id="collabo02" class="swiper-slide">
			<div class="img">
				<div class="collaboTxt">
					<p class="collaboTxtP">연예인 협찬</p>
					<a href="" class="collaA">SEE MORE</a>
				</div>
			</div>
		</li>
	</ul>
	<div class="pagination">
		<div class="inner"></div>
	</div>
</section>
<div id="empty00"></div>
<div class="collaboBtn">
	<a href="">collaboration</a>
</div>
<div id="empty01"></div>
<section id="photoContact">
	<ul class="list swiper-wrapper">
		<li id="contact01" class="swiper-slide"><a
			href="https://blog.naver.com/PostThumbnailList.nhn?blogId=c_lee_all&from=postList&categoryNo=38">
				<div class="img">
					<p>my fish girl</p>
				</div>
		</a></li>
		<li id="contact02" class="swiper-slide">
			<div class="img">
				<div id="imgTxtBox">
					<p>유료촬영 문의</p>
					<a href="https://open.kakao.com/o/sbsEk0D">contact</a>
				</div>
			</div>
		</li>
		<li id="contact03" class="swiper-slide"><a
			href="https://blog.naver.com/c_lee_all/221520668866">
				<div class="img"></div>
		</a></li>
	</ul>
	<div class="pagination">
		<div class="inner"></div>
	</div>
</section>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>