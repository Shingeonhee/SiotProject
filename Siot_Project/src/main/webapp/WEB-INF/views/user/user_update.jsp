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
<link rel="stylesheet" href="css/join.css">
<script src="js/jquery-3.6.0.min.js"></script>
</head>
<style>
.postcode {
    width: 100px;
    height: 40px;
    background-color: #4f4f4f;
    border-radius: 10px;   
    transition-duration: 0.1s;
    color: #ccc;
    cursor:pointer;
}
.postcode:active {
    margin-left: 5px;
    margin-top: 5px;
    box-shadow: none;
}
#joinForm {
	display:inline-block;
	text-align: left;
}
.formBox{
	padding:50px 0 150px;
}
#joinForm {
	display:inline-block;
	text-align: left;
	
}

.formBox img {
	width:100px;
	height:100px;
	margin-left:200px;
	border-radius: 50%;
    margin-bottom: 20px;
}
.inputtxt {
	width:318px;
	height:40px;
}
#year {
	padding:10px 0;
	margin-left:100px;
}
#ageYear {
	width:106px;
	height:40px;
}
#ageMonth {
	width:106px;
	height:40px;
}
#ageDay {
	width:106px;
	height:40px;
}
#postCode{
	width:318px;
	height:40px;
}
#address{
	width:318px;
	height:40px;
}
#subAddress{
	width:318px;
	height:40px;
}
#join {
	width:326px;
	height:40px;
	background-color: #4f4f4f;
	color:#ccc;
	cursor:pointer;
}
input{
        margin-left: 100px;
}
label {
	margin-left:100px;
} 
</style>
<body>
	<div class="formBox">
		<h2 style="margin-right:280px;">정보 수정</h2>
		<form action="UserUpdate.do" id="joinForm" method="POST"
			enctype="multipart/form-data">
			<table>
				<tbody>
				<c:choose>
					<c:when test="${loggedUserInfo.profileImg==null}">
						<img src="plusdddddddd/userProject/default.png">
					</c:when>
					<c:otherwise>
						<img src="${loggedUserInfo.profileImg}">
					</c:otherwise>
				</c:choose>
					<tr>
						<td>
							<div>
								<input type="email" class="inputtxt" name="id" id="id" value="${loggedUserInfo.id}" readonly>
							</div>
						</td>
					</tr>

					<tr>
						<td>
							<div>
								<input type="password" name="password" id="userPassword"
									class="inputtxt" placeholder="기존비밀번호입력">
							</div>
							
<!-- 							<div> -->
<!-- 								<input type="password" name="password-a" id="userPassword-a" -->
<!-- 									placeholder="비밀번호를변경하는경우입력하세요"> -->
<!-- 							</div> -->

<!-- 							<div> -->
<!-- 								<input type="password" name="password-b" id="userPassword-b" -->
<!-- 									placeholder="비밀번호 확인"> -->
<!-- 							</div> -->
						</td>
					</tr>

					<tr>
						<td>
							<div>
								<label>이름</label><span style="color:red;">*</span>
								<div>
									<input type="text" name="name" id="name" class="inputtxt"
										value="${loggedUserInfo.name}">
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td>
							<div>
								<label>성별</label>
								<div>
									<input type="radio" name="gender" id="남자" checked="checked" value="M"><span>남자</span>
								</div>
								<div>
									<input type="radio" name="gender" id="여자" value="F"><span>여자</span>
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td>
							<div>
								<label>연락처</label><span style="color:red;">*</span>
								<div>
									<input type="text" class="inputtxt" name="phone" value="${loggedUserInfo.phone}" id="userPhone">
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td>
							<div class="userAddress">
							  <label class="col-md-2 offset-md-3 col-form-label">
							    주&nbsp;&nbsp;소&nbsp;&nbsp; 
							  </label><span style="color:red;">*</span>
							  <div class="col-md-2">
							    <input type="text" class="postCode" name="postCode" id="postCode" placeholder="우편번호" readonly />
							    <button type="button" class="postcode" onclick="execDaumPostcode()">우편번호 찾기</button>
							  </div>
							  <div class="col-md-4 offset-md-5">
							    <input
							      type="text"
							      class="address"
							      name="address"
							      id="address"
							      placeholder="도로명 주소"
							      readonly
							    />
							  </div>
							  <div class="col-md-4 offset-md-5">
							    <input
							      type="text"
							      id="subAddress"
							      class="subAddress"
							      name="subAddress"
							      placeholder="상세 주소"
							      required
							    />
							  </div>
							</div>
						</td>
					</tr>

					<tr>
						<td>
							<div>
								<label>생년월일</label>
								<div>
									<div id="year">
										<select name="ageYear" id="ageYear">
											<c:forEach var="i" begin="1990" end="2021" step="1">
												<option value="${loggedUserInfo.ageYear}">${i}</option>
											</c:forEach>
										</select>
										<select name="ageMonth" id="ageMonth" >
											<c:forEach var="i" begin="1" end="12" step="1">
												<option value="${loggedUserInfo.ageMonth}">${i}</option>
											</c:forEach>
										</select>
										<select name="ageDay" id="ageDay" >
											<c:forEach var="i" begin="1" end="31" step="1">
												<option value="${loggedUserInfo.ageDay}">${i}</option>
											</c:forEach>
										</select>
									</div>
								</div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="btns">
				<input type="hidden" name="no" value="${userBean.no}"> <input
					type="submit" value="수정" id="join"> 
			</div>
		</form>
	</div>
<%@ include file="../include/footer.jsp"%>


		 <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>

<script>
/** 우편번호 찾기 */
function execDaumPostcode() {
    daum.postcode.load(function(){
        new daum.Postcode({
            oncomplete: function(data) {
              // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
              $("#postCode").val(data.zonecode);
              $("#address").val(data.roadAddress);
            }
        }).open();
    });
}
		
	 	</script>
</body>
</html>

