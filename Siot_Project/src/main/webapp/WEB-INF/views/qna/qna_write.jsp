<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>QNA</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/layout.css">
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"
	rel="stylesheet">
<link href="summernote/summernote.min.css" rel="stylesheet">

<script src="js/jquery-3.6.0.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="summernote/summernote.min.js"></script>

</head>

<body style="margin: 0 auto;">

	<form method="POST" action="QnaWrite.do" id="QnaWriteForm"
		enctype="multipart/form-data">
		<div class="writeHeader">
			<div class="writerHeaderInner">
				<span>Q&amp;A</span>
				<div class="writeBtn">
					<a href="#" onClick="history.back();" id="cancel">취소</a>
					 <input type="submit" value="작성"
						id="write">
				</div>
			</div>
		</div>
		<div class="writeBox">
			<div class="boardSummary">
				<div class="left">
					<div id="profileImg">
						<img src="${loggedUserInfo.profileImg}" class="profileImg">
					</div>

					<div id="name">
						<span>${loggedUserInfo.name}</span>
					</div>
				</div>
				<div class="right">
					<span class="material-icons lock" > lock_open </span>
				</div>
			</div>
			<div class="editorBox">
				<input type="text" id="subject" name="subject" placeholder="제목">
				<textarea name="contents" id="summernote"></textarea>
			</div>
		</div>
	</form>
	<script>
		$(document).ready(function() {
			$("#summernote").summernote({
				height : 350,
				callbacks : {
					onImageUpload : function(files, editor, welEditable) {
						console.log("이미지가 업로드 되면 콜백이 실행됩니다.");
						sendImgFile(files[0], this);
					}
				}
			});
			function sendImgFile(file, editor) {
				data = new FormData();
				data.append("file", file);
				$.ajax({
					data : data,
					type : "POST",
					url : "QnaSummerNoteImageUpload.do",
					cache : false,
					contentType : false,
					processData : false,
					dataType : "json",
					success : function(data) {
						console.log(data);
						$(editor).summernote("editor.insertImage", data.url);
					}
				});
			}
		});
		const lock = document.querySelector(".lock");
		
		lock.addEventListener("click",function(){
			lock.classList.toggle("active");
			//$(".lock").text("lock");
			$(".lock").html($(".lock").html() == 'lock' ? 'lock_open' : 'lock');
			let boardLock = $(".lock").text();
			$(".lock").val(boardLock);
			console.log(boardLock);
		})
	</script>

</body>

</html>