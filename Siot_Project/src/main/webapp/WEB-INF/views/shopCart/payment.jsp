<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<link rel="stylesheet" href="css/shopCart.css">
<body>
	<div id="paymentBoxBoxBox">
		<div id="paymentBoxBox">
			<div id="paymentBox">
				<div id="paymentHeader">
					<h3>주문완료</h3>
					<p>
						<span>아래 계좌정보로 입금해주시면 <br> 결제 완료처리가 됩니다
						</span>
					</p>
				</div>
				<div id="paymentBody">
					<table>
						<tbody>
							<tr id="paymentTr01">
								<th id="paymentTh">입금계좌 안내</th>
								<td id="paymentTd01"><span>국민은행</span> <br> <span>208401-04-302020</span>
									<br> <span>시옷프로젝트</span> <br> <span
									id="paymentPrice"> <fmt:formatNumber
											pattern="###,###,###" value="${totalPrice}" />원
								</span></td>
							</tr>
							<tr id="paymentTr">
								<th id="paymentTh">주문번호</th>
								<td id="paymentTd"><span id="dateNumber">${paymentNo}</span>
							</tr>
							<tr id="paymentTr">
								<th id="paymentTh">배송지</th>
								<td id="paymentTd"><span>${name}</span> <br> <span>${phone}</span>
									<br> <span>${address}</span> <br> <span>${subAddress}</span>
							</tr>
							<tr id="paymentTr">
								<th id="paymentTh">배송방법</th>
								<td id="paymentTd">${selectBox }</td>
							</tr>
							<c:choose>
								<c:when test="${deliveryMemo!='null' }">
									<c:choose>
										<c:when test="${deliveryMemo.equals('custom') }">
											<tr id="paymentTr">
												<th id="paymentTh">배송메모</th>
												<td id="paymentTd">${customMemo }</td>
											</tr>
										</c:when>
										<c:otherwise>
											<tr id="paymentTr">
												<th id="paymentTh">배송메모</th>
												<td id="paymentTd">${deliveryMemo }</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</c:when>
							</c:choose>
						</tbody>
					</table>
					<div id="paymentFooter">
						<a href="/"> 홈으로 </a>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../include/footer.jsp"%>
	</div>
</body>
<style>
#h1 {
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 100px;
	height: 500px;
}
</style>
</html>