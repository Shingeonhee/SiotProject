<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
<section id="pageSize">

	<form >
		<div id="QnaWriteForm" class="qnaInfo">

			<div class="writeBox">
				<div class="boardSummary">
					<div class="left">
						<div id="profileImg">
							<img src="${qnaBean.profileImg} " class="profileImg">
						</div>
						<div id="name">
							<span>${qnaBean.name }</span>
						</div>
					</div>
				</div>
				<div class="editorBox">
					<div id="subject">${qnaBean.subject }</div>
					<div id="infoContents">
						<span>${qnaBean.contents }</span>
					</div>
				</div>
				<div class="replyListBox nano">
					<ul class="replyList nano-content">

					</ul>
				</div>
				<div id="replyForm"></div>
			</div>
		</div>

		<c:choose>
			<c:when test="${loggedUserInfo.no == qnaBean.userNo }">
				<div class="editLink">
					<a href="QnaUpdateForm.do?no=${qnaBean.no}">수정</a> <a
						href="QnaDelete.do?no=${qnaBean.no}">삭제</a>
				</div>
			</c:when>
			<c:when test="${loggedUserInfo.verify == 1}">
				<div class="editLink">
					<a href="QnaList.do">목록</a>
					<a href="QnaDelete.do?no=${qnaBean.no}">삭제</a>
				</div>
			</c:when>
			<c:otherwise>
			</c:otherwise>
		</c:choose>

	</form>
</section>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>

<script>
const _name = "${loggedUserInfo.name}";
const _qnaNo =${qnaBean.no};
console.log(_name);
const verify = ${loggedUserInfo.verify};

$("#replyForm").append(`
		<div class="textAreaBox">
		<textarea name="reply" id="reply" placeholder="댓글을 입력해주세요"></textarea>
		<input type="button" class="btnReply" value="작성">
	</div>
		`);

//댓글달기
$(".btnReply").on("click",function(){
	const _parent = $(this).parents("#replyForm");	
	const sendData = {
				qnaNo:_qnaNo,
				contents:$("#reply").val(),
				name:_name,
			};
		$.ajax({
			url:"QnaReplyWrite.do",
			data:sendData,
			success:function(data){
				console.log("작성");
				   const qnaReplyList = data.qnaReplyList;
				   $(".replyList").html("");
				   $.each(qnaReplyList,function(i,item){
	    	            $(".replyList").append(`
	    	            		<li data-idx=\${item.no} data-no=\${item.qnaNo}>
	    	            			<span  class="replyName">\${item.name}</span>
	    	            			<span>|</span>
	    	            			<span> \${item.contents}</span>
	    	            			\${deleteReply}		
	    	            </li>`)
	    	            _parent.find("#reply").val("");
	    	 })
				
			}
		})
})
let deleteReply;
if(verify == 1){
	deleteReply= "<span class='material-icons btnReplyDelete'>close</span>";
}else{
	deleteReply ="";
}
//댓글모두보여주기
$.ajax({
    	 url:"QnaReplyAll.do",
    	 type:"POST",
    	data:{"qnaNo":_qnaNo},
    	success:function(resultData){
    	        //console.log(_no);
    	            		 
    	   const qnaReplyList = resultData.qnaReplyList;
    	        $.each(qnaReplyList,function(i,item){
    	            $(".replyList").append(`
    	            		<li data-idx=\${item.no} data-no=\${item.qnaNo}>
    	            			<span  class="replyName">\${item.name}</span>
    	            			<span>|</span>
    	            			<span> \${item.contents}</span>
    	            			\${deleteReply}		
    	            </li>`)
    	 })
    }
});

$("body").on("click",".btnReplyDelete",function(){
	//관리자만댓글삭제가능
	
	//confirm창 띄우기
	let result = confirm("삭제하시겠습니까?");
		if(result){
		const _parent = $(this).parents();
 		const _no =  _parent.data("idx");
 		const qnaNo =  _parent.data("no");
			$.ajax({
				url:"QnaReplyDelete.do",
				data:{
					"no":_no,
					"qnaNo":qnaNo
				},
				success:function(data){
					const qnaReplyList = data.qnaReplyList;
					
   				$(".replyList").html("");
   				
   				if(data.result>0){
   				 $.each(qnaReplyList,function(i,item){
					  $(".replyList").append(`<li data-idx=\${item.no} data-no=\${item.qnaNo}>
							  <span class="replyName">\${item.name}</span>
							  <span>|</span>
            					 <span> \${item.contents}</span>
							
							  <span class="material-icons btnReplyDelete">
		     					close
			            		</span>
 							</li>
							`);
   						})
   					}
				}
			})
		    alert("삭제되었습니다.");
		    
		}else{
		    alert("취소하였습니다.");
		}
})
    		
</script>
