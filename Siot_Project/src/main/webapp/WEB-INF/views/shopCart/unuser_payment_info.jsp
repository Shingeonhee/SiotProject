<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<div id="bg">
<section id="pageSize">
	<div id="unuser_paymentInfo">
			<p class="unuser_title">비회원 주문조회</p>
		<h2>
			<a href="/"> <span
				class="material-icons arrowBack">arrow_back</span>
			</a>
			<span class="paymentNoTitle">주문번호</span> <span class="paymentNoText">
				${paymentBean.paymentNo }</span>
		</h2>
		<div id="paymentInfoL">
			<div id="paymentInfoL1">
				<h3>주문 정보</h3>
				<ul>
					<li>
						<p>주문자</p>
						<div>
							<p>${paymentBean.name}/ ${paymentBean.phone}</p>
						</div>
					</li>
					<li>
						<p>배송 정보</p>
						<div>
							<p>${paymentBean.name}/ ${paymentBean.phone}</p>
							<p>( ${paymentBean.postCode} )${paymentBean.address}</p>
							<p>${paymentBean.subAddress}</p>
						</div>
					</li>
					<li>
						<p>배송 메모</p>
						<div>${paymentBean.shippingMemo }</div>
					</li>
				</ul>
			</div>

			<div id="paymentInfoL2">
				<h3>결제정보</h3>
				<ul>
					<li>
						<p>결제방법</p>
						<div>${paymentBean.paymentMethod }</div>
					</li>
					<li>
						<p>계좌 정보</p>
						<div>국민은행 208401-04-302020 예금주:시옷프로젝트</div>
					</li>
				</ul>
			</div>
		</div>
		<div id="paymentInfoR">
			<h3>상품 정보</h3>
			<c:forEach var="detail" items="${paymentDetailList }" begin="0"
				end="${paymentDetailList.size() }" step="1" varStatus="status">
				<c:forEach var="pdt" items="${payPdtList }" begin="0"
					end="${payPdtList.size() }" step="1" varStatus="status">
					<c:choose>
						<c:when test="${pdt.no == detail.pdtNo}">
							<div id="imgBox">
								<img id="pdtImg" src="${pdt.mainimg }">
								<div id="imgTextBox">
									<p class="pdtName">${pdt.name}</p>
									<p>
										<span>색상:${detail.color }</span> / 사이즈:${detail.pdtSize }
									</p>
									<p>${pdt.price}/ ${detail.amount }</p>
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
				<c:when test="${paymentBean.paymentMethod}.equals('택배')">
					<ul>
						<li><span>상품가격</span> <span><fmt:formatNumber
									pattern="###,###,###" value="${paymentBean.paymentPrice-4000 }" />원</span>
						</li>
						<li><span>배송비</span> <span> 4,000원 </span></li>
						<li><span>구매감사적립금 사용</span> <span>0원</span></li>
					</ul>
				</c:when>
				<c:otherwise>
					<ul>
						<li><span>상품가격</span> <span><fmt:formatNumber
									pattern="###,###,###" value="${paymentBean.paymentPrice }" />원</span>
						</li>
						<li><span>배송비</span> <span> 무료 </span></li>
						<li><span>구매감사적립금 사용</span> <span>0원</span></li>
					</ul>
				</c:otherwise>
			</c:choose>

			<p id="underLine" />
			<ul>
				<li><span>총 결제금액</span> <span class="allPrice"><fmt:formatNumber
							pattern="###,###,###" value="${paymentBean.paymentPrice }" />원</span></li>
			</ul>
		</div>
	</div>
</section>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>