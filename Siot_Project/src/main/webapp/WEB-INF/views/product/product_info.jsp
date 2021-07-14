<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ include file="../include/header.jsp"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-latest.js"></script>

<head>

<meta charset="UTF-8">
<title>Insert title here</title>
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
.modal-content {
   background-color: #fefefe;
   margin: 20% auto;
   border: 1px solid #888;
   border-radius: 10px;
   width: calc(400px-40px);
   padding: 0;
}
</style>
</head>
<body>
   <section id="pageSize">
      <form method="POST" name="form" id="productInfoForm">
         <div id="category">
            <span>${productBean.category}</span>
         </div>
         <div id="whole">
            <div id="leftside">

               <div id="Mainpdtimg">
                  <img src="${productBean.mainimg}" id="img">
               </div>
            </div>
            <div id="rightside">
               <div id="infoWrap">
                  <div id="pdtwithprice">
                     <div>
                        <span>${productBean.name}</span>
                     </div>
                     <div>
                        <span>${productBean.price}원</span>
                     </div>
                  </div>
                  <div id="pdtdetail">
                     <span>${productBean.contents}</span>
                  </div>
                  <div id="all2">
                     <div>
                        <div class="option_title">
                           <p>원산지</p>
                        </div>

                        <div class="option_data">
                           <p>Korea</p>
                        </div>
                     </div>

                     <div>
                        <div class="option_title">
                           <p>구매혜택</p>
                        </div>

                        <div class="option_data">
                           <p>
                              <fmt:parseNumber value="${productBean.price/50}" integerOnly="true" /> 원
                           </p>
                        </div>
                     </div>


                     <div>
                        <div class="option_title">
                           <p>배송비</p>
                        </div>

                        <div class="option_data">
                           <p>4,000원 (250,000원 이상 무료배송)</p>
                        </div>
                     </div>
                  </div>
                  <div id="postmethodwhich">
                     <!-- 배송방법 -->
                     <select class="active" name="selectBox" id="selectBox">
                        <option value="1">택배</option>
                        <option value="0">방문수령</option>
                     </select>
                  </div>
                  <div id="goodWrap">
                     <div class="option_select">
                        <a class="option_title subject">색상*</a>
                        <div id="colorchoosewhynotworking">
                           <div>
                              <div style="display: flex;">
                                 <c:forEach var="i"
                                    items="${productBean.productcolor.split(',') }" begin="0"
                                    end="3" step="1" varStatus="status">
                                    <label style="display: flex;"> 
                                    <input name="pdtColor" type="radio" value="${i}" id="pdtColor">
                                       <span id="colorBox" style="background-color:${i};" class="colorBox"></span>
                                    </label>
                                 </c:forEach>
                              </div>
                           </div>
                        </div>
                     </div>


                     <div class="option_select">
                        <a id="productsizereal" style="margin-bottom: 1px;"
                           class="option_title subject">사이즈*</a>
                        <div>
                           <select class="active" name="pdtSize" id="option_size">
                              <c:forEach var="i"
                                 items="${productBean.productsize.split(',') }" begin="0"
                                 end="3" step="1" varStatus="status">
                                 <option id="pdtSize">${i}</option>
                              </c:forEach>
                           </select>
                        </div>
                     </div>
                     <div class="option_select">
                        <div class="option_title subject">수량</div>
                        <div id="amountBox">
                           <!-- 수량 -->
                           <a id="minusBtn">-</a> <input type="text" name="amount"
                              id="amount" value="1"> <a id="plusBtn">+</a>
                        </div>
                     </div>
                  </div>

                  <div class="parentBtn">
                     <div id="buyrightnow">
                        <input type="submit" class="buyButton"
                           onclick="javascript: form.action='OrderByOnePdt.do?pdtNo=${productBean.no}';"
                           value="구매하기">
                     </div>
                     <div id="buycart">
                        <input type="button" class="buycartButton" onclick="to_ajax()" value="장바구니">
                     </div>
                     <div id="buywishlist">
                        <button class="buywishlistButton" type="button">
                        	<c:choose>
                        		<c:when test="${wishOn==1 }">
                        			<img src="../images/heart1.png" width="20" alt="" id="imga">
                        		</c:when>
                        		<c:otherwise>
                        			<img src="../images/heart0.png" width="20" alt="" id="imga">
                        		</c:otherwise>
                        	</c:choose>
                           
                        </button>
                        <input type="hidden" name="wishOn" id="wishOnOff" value="${wishOn }">
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <div id="shopCartModal" class="modal" style="overflow: hidden;">
            <div class="modal-content"
               style="padding: 0; width: 288px; font-size: 14px; border: none; border-radius: 5px; margin: 20% auto">
               <p style="text-align: center; line-height: 1.5; padding: 55px 15px">
                  선택하신 상품을 장바구니에 담았습니다.</p>
               <div style="display: flex; flex-direction: row; font-size: 13px;">
                  <div
                     style="cursor: pointer; text-align: center; width: 50%; padding: 15px 0; border-top: 1px solid #d9d9d9; border-right: 1px solid #d9d9d9;"
                     id="keepShopping">
                     <span> 계속쇼핑 </span>
                  </div>
                  <div
                     style="cursor: pointer; text-align: center; width: 50%; padding: 0; border-top: 1px solid #d9d9d9;">
                     <input type="hidden" name="pdtNo" value="${productBean.no}">
                     <c:choose>
                        <c:when test="${loggedUserInfo != null}">
                           <input type="hidden" name="idNo" value="${loggedUserInfo.no}">
                           <input type="submit" id="submitShopCart" value="장바구니"
                              onclick="javascript: form.action='ShopCartList.do?idno=${loggedUserInfo.no}';"
                              style="background-color: #fff; cursor: pointer; padding: 15px 0; width: 100%; height: 100%; border: none; border-radius: 0 0 10px 0">
                           <%--                            <a href="InsertShopCart.do?idNo=${loggedUserInfo.no}&pdtNo=${productBean.no}" --%>
                           <!--                               style="width: 100%; height: 100%;">장바구니</a> -->
                        </c:when>
                        <c:otherwise>
                           <input type="hidden" name="idNo" value="0">
                           <input type="submit" id="submitShopCart" value="장바구니"
                              onclick="javascript: form.action='ShopCartList.do?idno=${loggedUserInfo.no}';"
                              style="background-color: #fff; cursor: pointer; padding: 15px 0; width: 100%; height: 100%; border: none; border-radius: 0 0 10px 0">
                           <%--                            <a href="InsertShopCart.do?idNo=0&pdtNo=${productBean.no}" --%>
                           <!--                               style="width: 100%; height: 100%;">장바구니</a> -->
                        </c:otherwise>
                     </c:choose>
                  </div>
               </div>
            </div>
         </div>
      </form>


      <%@ include file="/WEB-INF/views/product/product_detail.jsp"%>
      <%@ include file="/WEB-INF/views/reviewbox/review_list.jsp"%>
      <%@ include file="/WEB-INF/views/reviewbox/review_qna.jsp"%>
      <%@ include file="../include/footer.jsp"%>
   </section>
</body>
<script>
   jQuery(function($) {
      $("body").css("display", "none");
      $("body").fadeIn(1400);
      $("a.transition").click(function(event) {
         event.preventDefault();
         linkLocation = this.href;
         $("body").fadeOut(1400, redirectPage);
      });
      function redirectPage() {
         window.location = linkLocation;
      }
   });
   function to_ajax() {
      var queryString = $("form[id=productInfoForm]").serialize();
      $.ajax({
         type : 'post',
         url : 'InsertShopCart.do',
         data : queryString,
         error : function() {
            alert("옵션을 선택하세요.");
         },
         success : function() {
            $('#shopCartModal').show();
         }
      });
   }
   $(document).ready(function() {
      $("#keepShopping").on("click", function() {
         $('#shopCartModal').hide();
      });
   });

   $(document).ready(function() {
      $("body").on("click", "#plusBtn", function() {
         var amount = $("#amount").val();
         amount = parseInt(amount) + parseInt(1);
         $("#amount").prop("value", amount);
      });
      $("body").on("click", "#minusBtn", function() {
         var amount = $("#amount").val();
         if (amount <= 1) {
            amount = 1;
         } else {
            amount -= 1;
         }

         $("#amount").prop("value", (amount));
      });
   });

   $("body").on("click", ".buywishlistButton", function() {
	  let wishNo = $("#wishOnOff").val();
	  let _idNo = "${loggedUserInfo.no}";
      if (_idNo == null) {
         _idNo = 0;
      }
      let _pdtNo = ${productBean.no};
      let sendData = {
    	         idNo : _idNo,
    	         pdtNo : _pdtNo
    	      };

	  if(wishNo == 1){
		  $("#wishOnOff").prop("value","0");
		  $.ajax({
	         url : "DeleteWish.do",
	         data : sendData,
	         success : function() {
	            document.getElementById("imga").src = "../images/heart0.png";
	         }
	      });
	  }else{
		  $("#wishOnOff").prop("value","1");
		  document.getElementById("imga").src = "../images/heart1.png";
		  $.ajax({
	         url : "InsertWish.do",
	         data : sendData,
	         success : function() {
	            document.getElementById("imga").src = "../images/heart1.png";
	         }
	      });
	  }
   });
   
   $(".colorBox").on("click",function(){
      $(".colorBox").removeClass("on");
       $(this).addClass("on");
   })
   
   
</script>

</html>