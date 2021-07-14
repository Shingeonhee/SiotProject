<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/include/manage_header.jsp"%>
<section style="margin:0 auto;width:1280px;">
	<div class="formBox" id="list">
		<h2>주문관리</h2>
		<div>
			<table>
				<colgroup>
					<col style="width: 50px">
					<col style="width: 50px">
					<col style="width: 50px">
					<col style="width: 100px">
					<col style="width: 100px">
					<col style="width: 100px">
					<col style="width: 280px">
					<col style="width: 100px">
					<col style="width: 200px">
					<col style="width: 100px">
					<col style="width: 100px">
				</colgroup>
				<thead>
					<tr>
						<th>No</th>
						<th>주문번호</th>
						<th>ID</th>
						<th>수령인</th>
						<th>전화번호</th>
						<th>우편번호</th>
						<th>주소</th>
						<th>서브주소</th>
						<th>배송메모</th>
						<th>가격</th>
						<th>수령방법</th>
					</tr>
				</thead>
				<tbody class="orderList">
					<c:forEach var="paymentBean" items="${paymentList }" begin="0"
						end="${paymentList.size() }" step="1" varStatus="status">
						<tr>
							<td>${status.index }</td>
							<td>
								<a href="PaymentInfo.do?paymentNo=${paymentBean.paymentNo}">${paymentBean.paymentNo}</a>
							</td>
							<td>
								<a href="UserInfo.do?no=${paymentBean.idNo}">
									${paymentBean.idNo}
								</a>
							</td>
							<td>${paymentBean.name}</td>
							<td>${paymentBean.phone}</td>
							<td>${paymentBean.postCode}</td>
							<td>${paymentBean.address}</td>
							<td>${paymentBean.subAddress}</td>
							<td>${paymentBean.shippingMemo}</td>
							<td>${paymentBean.paymentPrice}</td>
							<td>${paymentBean.paymentMethod}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="pagination">
				<c:if test="${startPage > pageGroup }">
					<a href="MemberList.do?clickedPage=${startPage - pageGroup}"> <span
						class="material-icons">chevron_left</span>
					</a>
				</c:if>
				<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1"
					varStatus="status">
					<c:choose>
						<c:when test="${currentPage==i }">
							<a href="PaymentList.do?clickedPage=${ i}" class="clicked">${i }</a>
						</c:when>

						<c:otherwise>
							<a href="PaymentList.do?clickedPage=${ i}">${i }</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${endPage<paginationTotal }">
					<a href="PaymentList.do?clickedPage=${startPage + pageGroup}">
						<span class="material-icons">chevron_right</span>
					</a>
				</c:if>
			</div>
		</div>
	</div>
</section>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>