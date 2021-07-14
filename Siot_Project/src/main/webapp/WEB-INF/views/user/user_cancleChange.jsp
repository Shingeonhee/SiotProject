<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시옷프로젝트</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Titillium+Web:wght@200;300;400;600;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/layout.css">
<script src="js/jquery-3.6.0.min.js"></script>
</head>
<style>
</style>
<body>
	<section id="myPage">
		<div class="myPage">
			<div class="myBox">
				<div class="boxMargin">
					<div class="myPageList">
						<ul>
							<li><a href="OrderCheck.do?idNo=${loggedUserInfo.no}"><span>주문
										조회</span></a></li>
							<li><a
								href="WishList.do?idNo=${loggedUserInfo.no}"><span>위시
										리스트</span></a></li>
							<li class="on"><a href="CancleChange.do" ><span>취소/교환/반품</span></a></li>
							<li><a href="Saving.do"><span>구매감사적립금</span></a></li>
							<li><a href="Inquire.do?no=${loggedUserInfo.no}"><span>1:1문의</span></a></li>
							<li><a href="UserUpdateForm.do?no=${loggedUserInfo.no}"><span>정보
										수정</span></a></li>
							<li><button class="openBtn" data-no="${loggedUserInfo.no}">회원탈퇴</button></li>
						</ul>
					</div>
					<div id="rightbody">
						<div class="subbody">
							<div class="fullbody">
								<div class="leftSub">
									<c:choose>
										<c:when test="${loggedUserInfo.profileImg==null}">
											<img src="images/default.png">
										</c:when>
										<c:otherwise>
											<img src="${loggedUserInfo.profileImg}">
										</c:otherwise>
									</c:choose>
								</div>
								<div class="leftContents">
									<span>${loggedUserInfo.name}님 안녕하세요.</span><br>
									<p>누적구매금액: 0원</p>
								</div>
								<div class="rightSub">
									<a href="Saving.do">구매감사적립금<br>
										<span>0</span>
									</a>
								</div>
								<div class="rightSub">
									<a href="">쿠폰 <br>
										<span>0</span>
									</a>
								</div>
							</div>
						</div>
						<div class="rightTxt">
							<p class="null">취소 내역이 없습니다.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<%@ include file="../user/user_delete.jsp"%>
	<%@ include file="../include/footer.jsp"%>
</body>
</html>







