<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/include/manage_header.jsp"%>
<div class="formBox" id="list" style="margin:0 auto;width:1000px;">
	<h2>회원목록</h2>
	<table>
		<colgroup>
			<col style="width: 50px">
			<col style="width: 50px">
			<col style="width: 200px">
			<col style="width: 100px">
			<col style="width: 50px">
			<col style="width: 200px">
			<col style="width: 350px">
		</colgroup>
		<thead>
			<tr>
				<th>프로필</th>
				<th>NO</th>
				<th>ID</th>
				<th>이름</th>
				<th>성별</th>
				<th>PHONE</th>
				<th>주소</th>
			</tr>
		</thead>
		<tbody class="userList">
			<c:forEach var="userBean" items="${userList }">
				<tr>
					<td><img src="${userBean.profileImg}" class="profileImg"></td>
					<td>${userBean.no}</td>
					<td><a href="UserInfo.do?no=${userBean.no}">${userBean.id}</a></td>
					<td>${userBean.name}</td>
					<td>${userBean.gender}</td>
					<td>${userBean.phone}</td>
					<td>${userBean.address}</td>
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
					<a href="MemberList.do?clickedPage=${ i}" class="clicked">${i }</a>
				</c:when>

				<c:otherwise>
					<a href="MemberList.do?clickedPage=${ i}">${i }</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${endPage<paginationTotal }">
			<a href="MemberList.do?clickedPage=${startPage + pageGroup}"> <span
				class="material-icons">chevron_right</span>
			</a>
		</c:if>
	</div>
</div>



<%@ include file="/WEB-INF/views/include/footer.jsp"%>
<script>
	
</script>