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
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/layout.css">
<script src="js/jquery-3.6.0.min.js"></script>
</head>
<body>
   <section id="myPage">
      <div class="myPage">
         <div class="myBox">
            <div class="boxMargin">
               <div class="myPageList">
                  <ul>
                     <li><a href="OrderCheck.do?idNo=${loggedUserInfo.no}"><span>주문
                              조회</span></a></li>
                     <li><a href="WishList.do?idNo=${loggedUserInfo.no}" id="wish"><span>위시
                              리스트</span></a></li>
                     <li><a href="CancleChange.do"><span>취소/교환/반품</span></a></li>
                     <li><a href="Saving.do"><span>구매감사적립금</span></a></li>
                     <li><a href="Inquire.do?no=${loggedUserInfo.no}"><span>1:1문의</span></a></li>
                     <li><a href="UserUpdateForm.do?no=${loggedUserInfo.no}"><span>정보
                              수정</span></a></li>
                     <li><button class="openBtn" data-no="${loggedUserInfo.no}">회원탈퇴</button></li>
                  </ul>
               </div>
               <div id="rightbody">
                  <div class="subbody">
                     <div class="fullbody">
                        <div class="leftSub">
                           <c:choose>
                              <c:when test="${loggedUserInfo.profileImg==null}">
                                 <img src="images/default.png">
                              </c:when>
                              <c:otherwise>
                                 <img src="${loggedUserInfo.profileImg}">
                              </c:otherwise>
                           </c:choose>
                        </div>
                        <div class="leftContents">
                           <span>${loggedUserInfo.name}님 안녕하세요.</span><br>
                           <p>누적구매금액: 0원</p>
                        </div>
                        <div class="rightSub">
                           <a href="Saving.do">구매감사적립금<br> <span>0</span>
                           </a>
                        </div>
                        <div class="rightSub">
                           <a href="">쿠폰 <br> <span>0</span>
                           </a>
                        </div>
                     </div>
                  </div>
                  <div>
                     <div class="rightTxt">
	                     <div id="wishCountBox">
	                        <span style="font-size: 18px;">위시리스트</span>
	                        <span id="wishCount">${wishCount}</span>
	                     </div>
                        <div>
                           <ul style="display: flex; flex-wrap:wrap; width:1000px;">
                              <c:choose>
                                 <c:when test="${wishList.size()==0}">
                                    <p style="color: rgba(33,33,33,0.4);
					                    font-size: 15px;
					                    padding: 70px 0 150px;
					                    text-align: center;
					                    font-size: 18px;">
					                    위시리스트가 없습니다.</p>
                                 </c:when>
                                 <c:otherwise>
                                    <c:forEach var="wishBean" items="${wishList}" begin="0"
                                       end="${wishList.size()}" step="1" varStatus="status">

                                       <li id="imgBox" style="margin:10px 10px 10px 0;">
                                          <div>
                                             <div id="imgHover">
                                             	<span id="icons" class="material-icons" data-no="${wishBean.no}">cancel</span>
                                             	<img src="${wishBean.mainimg}" id="pdtInfo">
                                             </div>
                                             <div style="text-align: center; padding-top: 10px; font-size: 14px;">
                                                <p style="padding-bottom: 10px;font-weight: bold;">${wishBean.name}</p>
                                                <span>${wishBean.price}원</span>
                                             </div>
                                          </div>
                                       </li>

                                    </c:forEach>
                                 </c:otherwise>
                              </c:choose>
                           </ul>
                        </div>
                     </div>

                  </div>
               </div>
            </div>
         </div>
      </div>

   </section>
	<%@ include file="../user/user_delete.jsp"%>
   <%@ include file="../include/footer.jsp"%>
	
	<script>
		$("body").on("click","#icons",function(){
			let _idNo = ${loggedUserInfo.no};
			let _pdtNo = $(this).data("no");
			$.ajax({
				url:"DeleteWish.do",
				data:{
					idNo:_idNo,
					pdtNo:_pdtNo
					},
				success:function(data){
					if(data.result>0){
						_no.remove();
					}
					location.reload();
				}
			})
		});

		$(function(){
		    $("#wish").on("click").css({
		       "border-bottom":"2px solid #333",
		       "padding-bottom":"5px",
		       "width":"70px"
		    });
		 });
 
 </script>
</html>






