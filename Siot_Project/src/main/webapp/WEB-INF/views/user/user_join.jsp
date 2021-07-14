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
<script src="js/jquery-3.6.0.min.js"></script>
<script src="js/join.js" defer></script>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&family=Titillium+Web:wght@200;300;400;600;700&display=swap"
	rel="stylesheet">

</head>
<style>
.userjoin {
	width:100vw;
	margin-left: calc(-50vw + 50%);
	background-color:#f5f6f7;
	padding-left: 750px;
}
input {
	margin:5px;
}
label {
	padding: 0 10px;
}
h2{
	padding-left: 130px;
	font-size:36px;
 	margin:0 20px 20px 0;
/* 	text-align:inherit; */
}
.inputtxt {
	width:375px;
	height:40px;
}
#join {
	background-color:#4f4f4f;
	color:#fff;
	width:385px;
}
#year {
	padding:10px 5px;
}
#ageYear {
	width:105px;
	height:40px;
}
#ageMonth {
	width:105px;
	height:40px;
}
#ageDay {
	width:105px;
	height:40px;
}
#postCode{
	width:105px;
	height:40px;
}
#address{
	width:375px;
	height:40px;
}
#subAddress{
	width:375px;
	height:40px;
}
.postcode {
    width: 100px;
    height: 40px;
    background-color: #4f4f4f;
    border-radius: 10px;   
    transition-duration: 0.1s;
    color: #ccc;
}
.postcode:active {
    margin-left: 5px;
    margin-top: 5px;
    box-shadow: none;
}
</style>

<body>
	<div class="userjoin">
		<h2>Sign In</h2>
		<form action="UserJoin.do" id="joinForm" method="POST"
			enctype="multipart/form-data">
			<table>
				<tbody>
					<tr>
						<td>
							<div id="preview">
								<input type="file" name="multipartProfileImg" id="profileImg" class="inp-img">
							</div>
						</td>
					</tr>

					<tr>
						<td>
							<div>
								<input type="email" name="id" id="id" placeholder="이메일" class="inputtxt">
							</div>
						</td>
					</tr>

					<tr>
						<td>
							<div>
								<input class="inputtxt" type="password" name="password" id="userPassword"
									placeholder="비밀번호">
							</div>

							<div>
								<input class="inputtxt" type="password" name="password-b" id="userPassword-b"
									placeholder="비밀번호 확인">
							</div>
						</td>
					</tr>

					<tr>
						<td>
							<div>
								<label>이름</label><span style="color:red;">*</span>
								<div>
									<input type="text" name="name" id="name" class="inputtxt"
										placeholder="이름을(를)입력하세요">
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
									<input type="text" name="phone" value="" id="userPhone"
										placeholder="연락처" class="inputtxt">
								</div>
							</div>
						</td>
					</tr>

					<tr>
						<td>
							<div class="userAddress">
							  <label class="col-md-2 offset-md-3 col-form-label">
							    주&nbsp;&nbsp;소&nbsp;&nbsp;<span style="color:red;">*</span>
							  </label>
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
												<option value="${i}">${i}</option>
											</c:forEach>
										</select>
										<select name="ageMonth" id="ageMonth" >
											<c:forEach var="i" begin="1" end="12" step="1">
												<option value="${i}">${i}</option>
											</c:forEach>
										</select>
										<select name="ageDay" id="ageDay" >
											<c:forEach var="i" begin="1" end="31" step="1">
												<option value="${i}">${i}</option>
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
							<input type="button" value="가입하기" id="join" class="inputtxt joinbtn">
<!-- 				<input type="submit" value="가입하기" id="join"> -->
			</div>
		</form>
	</div>
<%@ include file="../include/footer.jsp"%>


	 <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>

<script>
function execDaumPostcode() {
    daum.postcode.load(function(){
        new daum.Postcode({
            oncomplete: function(data) {
              $("#postCode").val(data.zonecode);
              $("#address").val(data.roadAddress);
            }
        }).open();
    });
}
		
		
// 		function readInputFile(input) {
// 		    if(input.files && input.files[0]) {
// 		        var reader = new FileReader();
// 		        reader.onload = function (e) {
// 		            $('#preview').html("<img src="+ e.target.result +">");
// 		        }
// 		        reader.readAsDataURL(input.files[0]);
// 		    }
// 		}
		 
// 		$("#profileImg").on('change', function(){
// 		    readInputFile(this);
// 		});

	
		
	</script>
</body>
</html>