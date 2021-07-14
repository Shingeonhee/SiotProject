<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/include/manage_header.jsp"%>

<section id="pageSize">
<div id="QnaWriteForm" class="qnaInfo">
   
   <div class="writeBox">
      <div class="boardSummary">
         <div id="pdt" style="padding-bottom:20px;">
            <span style="font-size:20px;">상품명:${productQnaBean.productName} </span>
         </div>
         <div class="left">
            
            <div id="profileImg">
               <img src="${profileImg} " class="profileImg">
            </div>
            
            <div id="name">
               <span>${productQnaBean.name }</span>
            </div>
         </div>
      </div>
      <div class="editorBox">
         <div id="subject">
            ${productQnaBean.subject }
         </div>
         <div id="infoContents">
            <span>${productQnaBean.contents }</span>
            
         </div>
         <div class="replyListBox nano">
               <ul class="replyList nano-content">

               </ul>
            </div>
         <div id="replyForm"></div>
      </div>
   </div>
   
   
   
</div>
   <c:choose>
         <c:when test="${loggedUserInfo.no == productQnaBean.userNo }">
            <div class="editLink">
               <a href="ProductQnaUpdateForm.do?no=${productQnaBean.no}">수정</a> <a
                  href="ProductQnaDelete.do?no=${productQnaBean.no}">삭제</a>
            </div>
         </c:when>
         <c:when test="${loggedUserInfo.verify == 1}">
            <div class="editLink">
               <a href="ProductQnaList.do">목록</a>
               <a href="ProductQnaDelete.do?no=${productQnaBean.no}">삭제</a>
            </div>
         </c:when>
         <c:otherwise>
         </c:otherwise>
      </c:choose>

</section>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>

<script>

const _name = "${loggedUserInfo.name}";
const _qnaNo =${productQnaBean.no};
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
      console.log(sendData);
      $.ajax({
         url:"PdtQnaReplyWrite.do",
         data:sendData,
         success:function(data){
            
               const pdtQnaReplyList = data.pdtQnaReplyList;
               $(".replyList").html("");
               $.each(pdtQnaReplyList,function(i,item){
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
        url:"PdtQnaReplyAll.do",
        type:"POST",
       data:{"qnaNo":_qnaNo},
       success:function(resultData){
               //console.log(_no);
                          
          const pdtQnaReplyList = resultData.pdtQnaReplyList;
               $.each(pdtQnaReplyList,function(i,item){
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
            url:"VPdtQnaReplyDelete.do",
            data:{
               "no":_no,
               "qnaNo":qnaNo
            },
			success:function(data){
               const pdtQnaReplyList = data.pdtQnaReplyList;
               
               $(".replyList").html("");
               
		if(data.result>0){
			$.each(pdtQnaReplyList,function(i,item){
				$(".replyList").append(`<li data-idx=\${item.no} data-no=\${item.qnaNo}>
                       <span class="replyName">\${item.name}</span>
                       <span>|</span>
                            <span> \${item.contents}</span>
                     
                            \${deleteReply}   
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
       
///////관리자 pdtqna삭제
	$("body").on("click","#pdtQnaDelete",function(e){
        e.preventDefault();
      })
 	$("body").on("click","#pdtQnaDelete",function(){
	    let result = confirm("삭제하시겠습니까?");
	    if(result){
	       $.ajax({
	          url:"VPdtQnaDelete.do",
	          data:{
	             "no":pdtQnaNo,
	          },
	          success:function(data){
	             if(data.result>0){
	             alert('삭제되었습니다.');
	             history.back();
	             }
	          }
	       })
	    }else{
	        alert("취소하였습니다.");
	    }
      })

</script>