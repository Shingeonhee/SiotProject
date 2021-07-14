<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/layout.css">
<script src="https://code.jquery.com/jquery-latest.js"></script>
<style>
/* The Modal (background) */
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
.modal-content {
	width: calc(800px - 40px);
	background-color: #fefefe;
	margin: 15% auto; /* 15% from the top and centered */
	padding: 20px;
	border: 1px solid #888;
}

#pdtQnaDeleteModal {
	text-align: center
}

.pdtqna-delete-modal-content {
	width: 462px;
	background-color: #fefefe;
	margin: 15% auto; /* 15% from the top and centered */
	border: 1px solid #888;
	border-radius: 4px;
	height: 150px
}

.pdt-delete-modal-content {
	width: 462px;
	background-color: #fefefe;
	margin: 15% auto; /* 15% from the top and centered */
	border: 1px solid #888;
	border-radius: 4px;
	height: 150px
}

#qnaReplyDelete {
	text-align: center
}

.replyList>li>span {
	padding-right: 15px;
}

.replyList {
	padding: 24px;
}

.btnReplyDelete {
	cursor: pointer;
}
</style>
<section id="pageSize">
	<div id="qna">
		<h2>Q&amp;A</h2>
		<div class="qnaBtn">
			<p>구매하시려는 상품에 대해 궁금한 점이 있으면 문의주세요.</p>
			<input type="button" value="상품문의" class="qnaBtn1"> <input
				type="button" value="1:1문의" class="qnaBtn2">

		</div>
		<div class="qnaWrap">
			<table>
				<colgroup>
					<col style="width: 130px">
					<col style="width: 770px">
					<col style="width: 190px">
					<col style="width: 190px">
				</colgroup>
				<thead>
					<tr>
						<th>상태</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody class="qnaList">

				</tbody>
			</table>
			<div class="qnaReply"></div>
		</div>
	</div>

	<div id="myModal" class="modal">

		<!-- Modal content -->
		<div class="modal-content">

			<div class="reply"></div>
			<div id="pdtQnaDeleteModal" class="modal">

				<!-- Modal content -->
				<div class="pdtqna-delete-modal-content"></div>
			</div>
			<div id="qnaReplyDelete" class="modal">

				<!-- Modal content -->
				<div class="pdt-delete-modal-content"></div>
			</div>
		</div>
	</div>

</section>
</body>
<script>
const _no =${productBean.no};
let info = ""; 
let _count = 0;
let verify ="${sessionScope.loggedUserInfo.verify}";
//console.log(verify);
$.ajax({
    url:"ExQna.do",
    data:{"no":_no},
    success:function(data){
       const productQnaList = data.productQnaList;
       //console.log(productQnaList);
       $.each(productQnaList,function(i,item){
    	   //console.log(productQnaList);
    	   let now = new Date(item.pdtQnaDate);
    	   let month = now.getMonth() + 1;
           let day = now.getDate();
           let hour = now.getHours();
           let minute = now.getMinutes();
           
           month = month >= 10 ? month : '0' + month;
           day = day >= 10 ? day : '0' + day;
           hour = hour >= 10 ? hour : '0' + hour;
           minute = minute >= 10 ? minute : '0' + minute;

           let date = now.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute ;
           //console.log(item.status);
           let _qnaNo = item.no;
           //console.log(item.no);
           
           
           /////////상품댓글확인
     	   $.ajax({
     		   url:"PdtReplyCheck.do",
     		   data:{"qnaNo":_qnaNo},
     		   success:function(data){
     			   _count = data.count;
     			   let answer;
     			   if(_count==0){
     				   answer = "<span>답변대기</span>"
     			   } else {
     				  answer = "<span>답변완료</span>"
     			   }
    	   $(".qnaList").append(`
	                	<tr>
    	   					<c:set var="tempCount" value="${0}" />
		    				<td class="status">
		    					\${answer}
							</td>
							
		    				<td id="subject" data-no = "\${item.no}" >\${item.subject}</td>
		    				<td>\${item.name}</td>
	    					<td>
		    					\${date}

	    					</td>
	    				</tr>
		    			
	             		<div id="replyForm" >
	             			<div class="textAreaBox">
	             				<textarea name="reply" id="reply" placeholder="댓글을 입력해주세요"></textarea>
	             			</div>
	             			<div class="btns">
	             				<button class="btnReply">작성</button>
	             			</div>
		             		<div>
		             			<button class="btnClose"><span class="material-icons"> expand_more</span></button>
		                	</div>
	             		</div>
          `)
     		  }
     	   })
       });
       //제목클릭하면 qna info보여주기
    	   $("body").on("click","#subject",function(){
    	   const _no = $(this).data("no");
			let dbUserNo = productQnaList.userNo;
    	   
    	   let UserNo = "${sessionScope.loggedUserInfo.no}"
    	   $.ajax({
    		   url:"OneProductQnaInfo.do",
    		   type : 'POST',
    		   data:{"no":_no,
    			   },
    		   success:function(data){
    			 info = data;
    			 let image = info.profileImg;
    			 //console.log(image);
    			 let infonow = new Date(info.productQnaBean.pdtQnaDate);
    	    	   let month = infonow.getMonth() + 1;
    	           let day = infonow.getDate();
    	           let hour = infonow.getHours();
    	           let minute = infonow.getMinutes();
    	           
    	           month = month >= 10 ? month : '0' + month;
    	           day = day >= 10 ? day : '0' + day;
    	           hour = hour >= 10 ? hour : '0' + hour;
    	           minute = minute >= 10 ? minute : '0' + minute;

    	           let infoDate = infonow.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute ;
    	           let editLink ;
    			 $('#myModal').show();
    			 
    			 
    			 
    			 ////////로그인 로그아웃여부체크 no같을때 수정삭제 보여주기
    			 if(${sessionScope.loggedUserInfo.no == null}){
    					//console.log("로그아웃상태");
    					editLink="";
    				}
    			 if(${sessionScope.loggedUserInfo.no!=null}){
    				 //console.log("로그인상태");
    					if(UserNo== info.productQnaBean.userNo || verify == 1){
    						//console.log("작성자같음");
    						editLink ="<a href='ProductQnaUpdateForm.do?no="+info.productQnaBean.no+"'>수정</a><a href='#' id='pdtQnaDelete' >삭제</a>"
    					}else{
    						//console.log("작성자다름");
    						editLink="";
        					
    					}
    			    			 
    				}
    			 $(".modal-content").append(`
			    			<div id="modalForm" data-no="\${_no}" data-idx="\${info.productQnaBean.productNo}">
			    					   
			 		  	    	<div class="top">
			 		  	 			<div id="infoProfileImg">
			 		  	 				<img src="\${image}" class="infoProfileImg">
			 		  	 			</div>
			 		  	 			<div id="topTxt">
			 		  	 				<p id="infoSubject">\${info.productQnaBean.subject}</p>
			 		  	 				<div id="topSub">
			 		  	 					<span id="infoName">\${info.productQnaBean.name}</span>
			 		  	 					<span id="infoDate">\${infoDate}</span>
			 		  	 				</div>
			 		  	 			</div>
			 		  	 		</div>
			 		  	 		<div class="contents">
			 		  	 			<p id="contents">\${info.productQnaBean.contents}</p>
			 		  	 		</div>
				 		  	 	<div class="replyListBox nano">
					        		<ul class="replyList nano-content">
					        			
					        		</ul>
				        		</div>
				 		  	 	<div id="replyForm" style="border:1px solid #ccc;">
					     			<div class="textAreaBox">
					     				<textarea name="reply" id="reply" placeholder="댓글을 입력해주세요"></textarea>
					     				<button class="btnReply">작성</button>
					     			</div>
				     			</div>
				     			<div id="editDelete">
				     				\${editLink}
				     			</div>
				     			
			 		  	 		<div class="closeModal">
					 		  	 	<span class="material-icons ">
										close
					        		</span>
			 		  			</div>
			 		  	    </div>	 `)
    			  
    			  
    			   
    			   ///////////////상풍qnaInfo 모달 닫기
    			   $("body").on("click",".closeModal",function(){
        		  	   $('#myModal').hide();
        		  	 $(".modal-content").html("");
        		   });
    			 
    			 
    			 ////////상품qna댓글 모두보여주기
    			   $.ajax({
    	            	  url:"PdtQnaReplyAll.do",
    	            	  type:"POST",
    	            	  data:{"qnaNo":_no},
    	            	  success:function(resultData){
    	            		  //console.log(_no);
    	            		 // console.log(resultData);
    	            		 
    	            		  const pdtQnaReplyList = resultData.pdtQnaReplyList;
    	            		  $.each(pdtQnaReplyList,function(i,item){
    	            			  $(".replyList").append(`
    	            				<li data-idx=\${item.no} data-no=\${item.qnaNo}>
    	            					<span  class="replyName">\${item.name}</span>
    	            					<span>|</span>
    	            					<span> \${item.contents}</span>
    	            					
    									 <span class="material-icons btnReplyDelete">
    				     					close
    					            	</span>
    	            			  	</li>`)
    	            		  })
    	            	  }
    	              })
    		   }
    		   
    	   });
    	   //댓글 end
    	   
    	   
       });
       
       
       ///////////////상품qna댓글 클릭
   	   $("body").on("click",".btnReply",function(){
		  // console.log("크ㄹ릭");
			const _parent = $(this).parents("#modalForm");
			const _name = "${loggedUserInfo.name}";
			const replyTxt = _parent.find("#reply").val();
			const idx = _parent.data("no");
			const replyList  = _parent.find(".replyList");
			const sendData = {
				qnaNo:idx,
				contents:replyTxt,
				name:_name,
			};
			//console.log(sendData);
			if(${loggedUserInfo==null}){
				
				alert("로그인후 작성 가능합니다.");
				location.href="UserLoginForm.do";
				
				
			}else{
				
			//////////////상품QNA댓글달기
			$.ajax({
				url:"PdtQnaReplyWrite.do",
				type:"POST",
				data:sendData,
				success:function(resultData){
					
						  const pdtQnaReplyList = resultData.pdtQnaReplyList;
						  _parent.find(".replyList").html("");
							_parent.find("#reply").val("");
						  
						  if(resultData.result==1){
						  $.each(pdtQnaReplyList,function(i,item){
							  $(".replyList").append(`
									  <li data-idx=\${item.no} data-no=\${item.qnaNo}>
										  <span  class="replyName">\${item.name}</span>
										  <span>|</span>
	 	            					 <span> \${item.contents}</span>
										
										  <span class="material-icons btnReplyDelete">
					     					close
						            		</span>
							
            							</li>
						`);
							  _parent.find("#reply").val("");
						  })
						  }
				},
				error:function(error){
					console.log(error);
				}
			})
			} // 로그인안하면 pdtqnareply 못함else끝
		});
       
       
       /////////댓글삭제버튼클릭
     	$("body").on("click",".btnReplyDelete",function(){
     		//console.log("댓글삭제버튼클릭");
     		  if(${loggedUserInfo==null}){
	       			alert("로그인후 삭제 가능합니다.");
	       			  location.href="UserLoginForm.do";
	       			  
	       			  //////////관리자 댓글삭제
	       		  }else if( verify == 1){
	       			let result = confirm("삭제하시겠습니까?");
	       			if(result){
	       				const _parent = $(this).parents();
		         		const _no =  _parent.data("idx");
		         		const qnaNo =  _parent.data("no");
	       				$.ajax({
	       					url:"VPdtQnaReplyDelete.do?no="+_no,
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
	       			
	       			/////입력한 비밀번호 맞을때 pdtqnareply 삭제
	       		  }else{
	       			const _parent = $(this).parents();
	         		const _no =  _parent.data("idx");
	         		const qnaNo =  _parent.data("no");
	       		
	    
	         		////댓글삭제 모달보여주기
	       			 $('#qnaReplyDelete').show();
	       			 $(".pdt-delete-modal-content").append(`
		       			<div id="deleteReplyForm" data-no="\${_no}">		
	       					 <div class="closePdtReplyDeleteModal" style="float:right;">
				     		  	 	<span class="material-icons btnReplyDelete">
				    					close
				    				<span>
			    				</div>
		       					 <p style="padding-top: 50px;">비밀번호를 입력하세요</p>
		       					 <input type="password" name="password" id="password" style="outline:none;">
		       					<input type="submit" value="삭제" id="qnaDeleteBtn">
		       			<div>			
	       			 `);
	       			
	       			 
	       			 //비밀번호입력후 댓글삭제버튼
	       			$("body").on("click","#qnaDeleteBtn",function(){
	       			
	         		const _password = $(".pdt-delete-modal-content").find("#password").val();
	         		
	         		const sendData = {
	        				qnaNo:qnaNo,
	        				no:$("#deleteReplyForm").data("no"),
	        				password: _password,	
	         		};
	           		$.ajax({
	           			url:"PdtReplyDelete.do",
	           			type:"POST",
	           			data:sendData,
	           			success:function(data){
	           				//console.log(data);
	           				const pdtQnaReplyList = data.pdtQnaReplyList;
	           				$(".replyList").html("");
	           				
	           				if(data.result>0){
	           				 $.each(pdtQnaReplyList,function(i,item){
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
	           				},
	           			})
	           			
	           			
	           		 $('#qnaReplyDelete').hide();
	           		$(".pdt-delete-modal-content").html("");
	       			});
	       			//replyDeleteBtn클릭
	       		  }//else문
       				
       				$("body").on("click",".closePdtReplyDeleteModal",function(){
         		  	   $('#qnaReplyDelete').hide();
         		  	$(".pdt-delete-modal-content").html("");
         		   });
     		 
    		})//btndelete클릭
}
})
 $("body").on("click","#pdtQnaDelete",function(e){
       			e.preventDefault();
       		 })
 $("body").on("click","#pdtQnaDelete",function(){
	 				let pdtNo = $(this).parents("#modalForm").data("idx");
					 let pdtQnaNo = $(this).parents("#modalForm").data("no");
		       		  //console.log(pdtQnaNo);
		       		  if(${loggedUserInfo==null}){
		       			alert("로그인후 삭제 가능합니다.");
		       			  location.href="UserLoginForm.do";
		       		  
		       			  ////관리자삭제
		       		  }else if(verify==1){
		       			let result = confirm("삭제하시겠습니까?");
		       			if(result){
		       				$.ajax({
		       					url:"VPdtQnaDelete.do",
		       					data:{
		       						"no":pdtQnaNo,
		       						"pdtNo":pdtNo
		       					},
		       					success:function(){
		       						alert('삭제되었습니다.');
			           				location.href="ProductInfo.do?no="+pdtNo;
		       					}
		       				})
		       			}else{
		       			    alert("취소하였습니다.");
		       			}
		       			  
		       			  
		       			
		       			  ////일반삭제  
		       		  }else{
		       			 $('#pdtQnaDeleteModal').show();
		       			 $(".pdtqna-delete-modal-content").append(`
		       					 <form method="POST" action="PdtQnaDelete.do" >
			       					<div class="closePdtDeleteModal" style="float:right;">
					     		  	 	<span class="material-icons">
					    					close
					    				<span>
				    				</div>
			       					 <p style="padding-top: 50px;">비밀번호를 입력하세요</p>
			       					 <input type="password" name="password" style="outline:none;">
			       					<input type="submit" value="삭제" id="pdtQnaDeleteBtn">
			       					<input type="hidden" value="\${pdtQnaNo}" name="no" >
			       					<input type="hidden" value="\${pdtNo}" name="pdtNo" >
			       				</form>
		    					
		       			 `);
		       			$("body").on("click",".closePdtDeleteModal",function(){
		        		  	   $('#pdtQnaDeleteModal').hide();
		        		  	 $(".pdtqna-delete-modal-content").html("");
		        		   });
		       		  }
					
				 })
 $(".qnaBtn1").on("click",function(){
	 <c:choose>
		<c:when test="${loggedUserInfo==null}">
			alert("로그인후 작성 가능합니다.");
			location.href="UserLoginForm.do";
		</c:when>
		<c:otherwise>
			location.href="ProductQna.do?no=${productBean.no}";
		</c:otherwise>
	</c:choose>
});
$(".qnaBtn2").on("click",function(){
	<c:choose>
		<c:when test="${loggedUserInfo==null}">
			alert("로그인후 작성 가능합니다.");
			location.href="UserLoginForm.do";
		</c:when>
			<c:otherwise>
			location.href="Qna.do";
		</c:otherwise>
	</c:choose>
}) 
</script>
