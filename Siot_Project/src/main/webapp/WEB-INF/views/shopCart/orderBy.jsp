<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<section id="pageSize">
		<!-- 비회원 주문 눌렀을 때 -->
		<div>
			<form action="PlaceAnOrder.do">

				<div>
					<h2>로그인</h2>
				</div>
				<div>
					<div>
						<span>ID : </span> <input type="email" name="email">
					</div>
					<div>
						<span>PASSWORD : </span> <input type="password" name="password">
					</div>
					<label> <input type="checkBox" value="로그인상태유지"
						name="keepLogin">로그인상태유지
					</label>
				</div>
				<div>
					<a href="UserJoinForm.do">회원가입</a> <a href="">아이디/비밀번호 찾기</a>
				</div>
				<div>
					<input type="submit" value="로그인"> <input type="hidden"
						name="no" value="${no}">
				</div>
			</form>
			<div>
				<span>또는</span>
			</div>
			<div class="orderBox">
				<a href="PlaceAnOrder.do?no=${no}">비회원 주문</a>
			</div>
		</div>
	</section>
</body>
</html>