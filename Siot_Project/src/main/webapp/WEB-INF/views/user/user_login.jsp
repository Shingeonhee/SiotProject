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
<link rel="stylesheet" href="css/join.css">
<script src="js/jquery-3.6.0.min.js"></script>
<style>
.modal {
	display: none; /* Hidden by default */
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

/* Modal Content/Box */
.unuser-modal-content {
	width: 320px;
	height:200px;
	background-color: #fefefe;
	margin: 11% auto; /* 15% from the top and centered */
	padding: 32px 24px 24px;
	border: 1px solid #888;
}
</style>

</head>
<body>
	<section id="login">
		<div id="mainLogin">
			<div class="empty01"></div>
			<div class="userlogin">
				<h2>Login</h2>
				<form action="UserLogin.do" id="joinForm" method="POST">

					<input type="email" name="id" id="id" placeholder="이메일"
						class="loginus"> <input type="password" name="password"
						id="userPassword" placeholder="비밀번호" class="loginus">
					<div class="checkBox">
						<label>
							<input type="checkBox" name="login-check" id="login-check">
							<span>로그인상태유지</span>
						</label>
					</div>
					<div class="btns">
						<input type="button" value="로그인" id="join">
						<!-- 				<input type="submit" value="로그인" id="join"> -->
					</div>
				</form>

				<div class="findBox">
					<a href="UserJoinForm.do">회원가입</a> 
					<a href="" id="find">아이디 · 비밀번호 찾기</a>
				</div>
				<p>또는</p>

				<div>
					<!-- 			<a href="" id="unuser">비회원 주문배송 조회</a> -->
					<input type="button" value="비회원 주문배송 조회" id="unuser">
				</div>
			</div>
			<div class="empty02"></div>
			<div id="unuser_modal" class="modal">

				<!-- Modal content -->
				<div class="unuser-modal-content">
				</div>
			</div>
		</div>
	</section>
	<%@ include file="../include/footer.jsp"%>

	<script>
		$("#joinForm #join").on("click", function() {
			if ($("#id").val().length <= 0) {
				alert("이메일을 정확히 입력하세요");
				$("#id").focus();
				return;
			} else if ($("#userPassword").val().length <= 0) {
				alert("비밀번호를 입력하세요");
				$("#userPassword").focus();
				return;
			} else {
				$("#joinForm").submit();
			}
		});

		$("#unuser").on("click", function() {
	          $('#unuser_modal').show();
	          $(".unuser-modal-content").append(`
	                      <div class="closeModal" style="float: right; cursor: pointer;">
	                            <span class="material-icons">
	                           close
	                          </span>
	                        </div>
	                        <h2>비회원 주문조회</h2>
	                        <form action="UnuserPaymentInfo.do" >
	                           <div class="blockBox">
	                              <div class="inputBox">
	                                 <input type="text" placeholder="주문번호" id="unOrderNum" name="unOrderNum">
	                                 <input type="text" placeholder="연락처" id="unPhoneNum">
	                              </div>
	                              <div class="loginBtn">
	                                 <button id="unuser_view">로그인</button>
	                              <div>
	                           </div>
	                        </form>
	                        
	                       `)
	                    $("body").on("click",".closeModal",function(){
	                         $('#unuser_modal').hide();
	                       $(".unuser-modal-content").html("");
	                    });                       
	                     
	      })
// $("body").on("click","#unuser_view",function(){
// 	var sendData = {
// 			paymentNo : $("#unOrderNum").val(),
// 			phone : $("#unPhoneNum").val(),
// 	}
// 	$.ajax({
// 		url:"UnuserOrderView.do",
// 		data:sendData,
// 		success:function(){
			
// 		}
// 	}) 
	
// })
		 
		
		 
</script>


</body>
</html>







