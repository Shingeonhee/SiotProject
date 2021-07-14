<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/include/manage_header.jsp"%>
<div class="formBox" id="list">
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
					<td><input type="text" value="${userBean.phone}"></td>
					<td><input type="text" value="${userBean.address}"></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="btns">
		<a href="UserUpdateForm.do?no=${userBean.no }">회원 수정</a>
	</div>
</div>


<%@ include file="/WEB-INF/views/include/footer.jsp"%>
<script>
	
</script>