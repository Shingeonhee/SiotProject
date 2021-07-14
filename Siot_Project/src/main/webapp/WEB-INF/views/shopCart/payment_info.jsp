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
<link rel="stylesheet" href="css/join.css">
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
							<li class="on"><a
								href="OrderCheck.do?idNo=${loggedUserInfo.no}"><span>주문
										조회</span></a></li>
							<li><a href="WishList.do?idNo=${loggedUserInfo.no}"><span>위시
										리스트</span></a></li>
							<li><a href="CancleChange.do"><span>취소/교환/반품</span></a></li>
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
									<a href="Saving.do">구매감사적립금<br> <span>0</span>
									</a>
								</div>
								<div class="rightSub">
									<a href="">쿠폰 <br> <span>0</span>
									</a>
								</div>
							</div>

						</div>
						<div class="rightTxt">
							<div id="paymentInfo">
								<h2>
									<a href="OrderCheck.do?idNo=${paymentBean.idNo}">
										<span class="material-icons arrowBack">arrow_back</span>
									</a> 
									<span class="paymentNoTitle">주문번호</span>
									<span class="paymentNoText"> ${paymentBean.paymentNo }</span>
								</h2>
								<div id="paymentInfoL">
									<div id="paymentInfoL1">
										<h3>주문 정보</h3>
										<ul>
											<li>
												<p>주문자</p>
												<div>
													<p>${userBean.name} / ${userBean.phone }</p>
													<p>${userBean.id }</p>
												</div>
											</li>
											<li>
												<p>배송 정보</p>
												<div>
													<p>${paymentBean.name} / ${paymentBean.phone}</p>
													<p>( ${paymentBean.postCode} )${paymentBean.address}</p>
													<p>${paymentBean.subAddress}</p>
												</div>
											</li>
											<li>
												<p>배송 메모</p>
												<div>
													${paymentBean.shippingMemo }
												</div>
											</li>
										</ul>
									</div>
									
									<div id="paymentInfoL2">
										<h3>결제정보</h3>
										<ul>
											<li>
												<p>결제방법</p>
												<div>
													${paymentBean.paymentMethod }
												</div>
											</li>
											<li>
												<p>계좌 정보</p>
												<div>
													국민은행 208401-04-302020 예금주:시옷프로젝트
												</div>
											</li>
										</ul>
									</div>
								</div>
								<div id="paymentInfoR">
									<h3>상품 정보</h3>
									<c:forEach var="detail" items="${paymentDetailList }" begin="0" end="${paymentDetailList.size() }" step="1" varStatus="status">
										<c:forEach var="pdt" items="${payPdtList }" begin="0" end="${payPdtList.size() }" step="1" varStatus="status">
											<c:choose>
												<c:when test="${pdt.no == detail.pdtNo}">
													<div id="imgBox">
														<img id="pdtImg" src="${pdt.mainimg }">
														<div id="imgTextBox">
															<p class="pdtName">${pdt.name}</p>
															<p><span>색상:${detail.color }</span> / 사이즈:${detail.pdtSize }</p>
															<p>${pdt.price}원 / ${detail.amount }</p>
														</div>
													</div>
													<p id="underLine" />
												</c:when>
												<c:otherwise>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:forEach>
									<p id="underLine" />
									<c:choose>
										<c:when test="${paymentBean.paymentMethod.equals('택배')}">
											<ul>
												<li>
													<span>상품가격</span>
													<span><fmt:formatNumber pattern="###,###,###" value="${paymentBean.paymentPrice-4000 }" />원</span>
												</li>
												<li>
													<span>배송비</span>
													<span>
														4,000원
													</span>
												</li>
												<li>
													<span>구매감사적립금 사용</span>
													<span>0원</span>
												</li>
											</ul>
										</c:when>
										<c:otherwise>
											<ul>
												<li>
													<span>상품가격</span>
													<span><fmt:formatNumber pattern="###,###,###" value="${paymentBean.paymentPrice }" />원</span>
												</li>
												<li>
													<span>배송비</span>
													<span>
														무료
													</span>
												</li>
												<li>
													<span>구매감사적립금 사용</span>
													<span>0원</span>
												</li>
											</ul>
										</c:otherwise>
									</c:choose>
									
									<p id="underLine" />
									<ul>
										<li>
											<span>총 결제금액</span>
											<span class="allPrice"><fmt:formatNumber pattern="###,###,###" value="${paymentBean.paymentPrice }" />원</span>
										</li>
									</ul>
<!-- 									<p id="underLine" /> -->
<!-- 									<ul> -->
<!-- 										<li> -->
<!-- 											<span>취소/반품 상품 금액합계</span> -->
<%-- 											<span><fmt:formatNumber pattern="###,###,###" value="${paymentBean.paymentPrice }" />원</span> --%>
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<span>취소 배송비 합계</span> -->
<!-- 											<span> -->
<%-- 												<c:choose> --%>
<%-- 													<c:when test="${paymentBean.paymentMethod.equlas('택배')}"> --%>
<!-- 														4,000원 -->
<%-- 													</c:when> --%>
<%-- 													<c:otherwise> --%>
<!-- 														무료 -->
<%-- 													</c:otherwise> --%>
<%-- 												</c:choose> --%>
<!-- 											</span> -->
<!-- 										</li> -->
<!-- 										<li> -->
<!-- 											<span>구매감사적립금 할인 차감</span> -->
<!-- 											<span>0원</span> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 									<p id="underLine" /> -->
<!-- 									<ul> -->
<!-- 										<li> -->
<!-- 											<span>환불금액</span> -->
<!-- 											<span>219,000원</span> -->
<!-- 										</li> -->
<!-- 									</ul> -->
<!-- 									<p id="underLine" /> -->
<!-- 									<ul> -->
<!-- 										<li> -->
<!-- 											<span>환불 구매감사적립금 합계</span> -->
<!-- 											<span>0원</span> -->
<!-- 										</li> -->
<!-- 									</ul> -->
								</div>
							</div>
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