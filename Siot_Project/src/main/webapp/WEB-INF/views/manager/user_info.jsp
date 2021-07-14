<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/include/manage_header.jsp"%>
<link rel="stylesheet" href="css/layout.css">
<div class="formBox" id="list" >
	<h2>회원정보</h2>
	<form action="MemberUpdate.do" method="POST">
		<div class="profileImgBox">
			<img src="${userBean.profileImg }" class="profileImg">
		</div>
		<table class="userInfo">
			<colgroup>
				<col style="width: 150px">
				<col style="width: 850px">
			</colgroup>
			<tbody>
				<tr>
					<th>ID</th>
					<td>${userBean.id }</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>${userBean.name}</td>
				</tr>
				<tr>
					<th>성별</th>
					<td>${userBean.gender}</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td>${userBean.phone }</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>${userBean.address }${userBean.subAddress }</td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td>${userBean.ageYear }년${userBean.ageMonth }월
						${userBean.ageDay }일</td>
				</tr>
			</tbody>
		</table>
		<div class="btns">
			<a href="UserUpdateForm.do?no=${userBean.no }">회원 수정</a> <a
				href="UserDeleteForm.do?no=${userBean.no }">회원 탈퇴</a>
		</div>
	</form>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>

