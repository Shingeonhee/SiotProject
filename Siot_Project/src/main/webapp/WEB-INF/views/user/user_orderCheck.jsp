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
							<ul id="paymentNoListBox">
								<c:choose>
									<c:when test="${paymentList.size() > 0 }">
										<c:forEach var="paymentBean" items="${paymentList }" begin="0"
											end="${paymentList.size() }" step="1" varStatus="status">
											<li id="paymentNoList">
												<div style="text-align:left !important">${paymentBean.paymentNo }
													<a href="PaymentInfo.do?paymentNo=${paymentBean.paymentNo }" id="orderChkBtn">주문서</a>
												</div> <c:forEach var="paymentDetailBean"
													items="${paymentDetailList }" begin="0"
													end="${paymentDetailList.size() }" step="1"
													varStatus="status">
													<c:forEach var="productBean" items="${payPdtList }"
														begin="0" end="${payPdtList.size() }" step="1"
														varStatus="status">

														<c:forEach var="detailBean" items="${paymentDetailBean }"
															begin="0" end="${paymentDetailBean.size() }" step="1"
															varStatus="status">
															<c:choose>
																<c:when
																	test="${paymentBean.paymentNo ==detailBean.paymentNo && detailBean.pdtNo == productBean.no}">

																	<ul id="paymentListBox">
																		<li id="paymentList">
																			<div class="leftBox">
																				<img src="${productBean.mainimg }">
																				<div class="txtBox">
																					<span class="pdtName">${productBean.name}</span> <span>색상:${detailBean.color }
																						<span style="background-color:${detailBean.color}"
																						id="colorBox"></span> /사이즈:${detailBean.pdtSize }
																					</span> <span>${productBean.price}원/${detailBean.amount }개
																					</span>
																				</div>
																			</div>
																			<div class="middleBox">
																				<span>주문상태</span>
																			</div>
																			<div class="rightBox">
																				<button>취소상세</button>
																			</div>
																		</li>
																	</ul>


																</c:when>
																<c:otherwise>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</c:forEach>
												</c:forEach>
											</li>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<p class="null">주문 내역이 없습니다.</p>
									</c:otherwise>
								</c:choose>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	   <%@ include file="../user/user_delete.jsp"%>
	<%@ include file="../include/footer.jsp"%>

</body>
<script>
	// 	$("#detailList")
	// 	for(var i=0; i<hashMap.length; i++) {
	// 		var map = hashMap[i];

	// 		for(var key in map ) {
	// 	  	console.log("컬럼 : " + key + " value : " + map[key]);
	// 		}
	// 	}
</script>
<style>
#paymentNoListBox {
	margin-bottom: 30px;
}

#paymentListBox {
	display: flex;
	margin: 10px;
}

#paymentListBox #paymentList {
	display: flex;
}

#paymentPdtNo {
	border: 1px solid #333;
	display: block;
	width: 15px;
	height: 15px;
	text-align: center;
	padding: 5px;
	border-radius: 100px;
}

#colorBox {
	display: block;
	width: 10px;
	height: 10px;
	margin: 5px;
	border: 1px solid #ddd;
	border-radius: 50%;
}
</style>
</html>







