<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>

.userDeleteModal {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
}

.userDeleteModal .bg {
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.6);
}

.userDeleteModal .modalBox {
	position: absolute;
	background-color: #fff;
	width: 570px;
	height: 263px;
	padding: 20px;
}

.userDeleteModal.hidden {
	display: none;
}

.userDeleteModal .textBox{
	color: #212121;
	font-size: 14px;
	text-align: left;
	margin: 15px 30px; 
}
.userDeleteModal .textBox > div{
	line-height: 2;
	margin-bottom:5px;
}
.userDeleteModal .btnBox > button{
	width:100px;
	
	padding: 10px 20px;
	margin-top:14px;
}
.userDeleteModal .closeBtn{
	border:1px solid #ccc;
	color:#4f4f4f;

}
.userDeleteModal .userDelete{
	border:1px solid #ccc;
	background-color:#4f4f4f;
	color:#fff;
}
.userDeleteModal .userDelete:hover,.userDeleteModal .closeBtn:hover{
	filter: brightness(80%); 
}
</style>
<body>


	<div class="userDeleteModal hidden">
		<div class="bg"></div>
		<div class="modalBox">
			<h2
				style="text-align: center; font-weight: bold; font-size: 24px; margin: 20px;">회원탈퇴</h2>
			<div class="textBox">
				<div>가입된 회원정보가 모두 삭제됩니다.작성하신
					게시물은 삭제되지 않습니다.</div>
				<div>탈퇴 후 같은 계정으로 재가입시에 기존에 가지고
					있던 적립금은 복원되지 않으며,사용 및 다운로드 했던 쿠폰도 사용 불가능합니다.</div>
				<div>회원 탈퇴를 진행하시겠습니까?</div>
			</div>
			<div style="text-align: center;" class="btnBox">
				<button class="closeBtn">취소</button>
				<button class="userDelete">탈퇴하기</button>
			</div>
		</div>
	</div>

	<script>
  const open = () => {
    document.querySelector(".userDeleteModal").classList.remove("hidden");
  }

  const close = () => {
    document.querySelector(".userDeleteModal").classList.add("hidden");
  }

  document.querySelector(".openBtn").addEventListener("click", open);
  document.querySelector(".closeBtn").addEventListener("click", close);
  document.querySelector(".bg").addEventListener("click", close);
   
  $("body").on("click",".userDelete",function(){
	     let _no = "${loggedUserInfo.no}";
	     let sendData = {
	           no:_no
	     };
	     $.ajax({
	        url:"UserDelete.do",
	        data:sendData,
	        success:function(){
	           alert("탈퇴되었습니다.");
	           location.href="index.jsp";
	        }
	     })
	  })
</script>




