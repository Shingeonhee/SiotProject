<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<link rel="stylesheet" href="css/shopCart.css">
<body>
	<section id="pageSize">
		<!-- 장바구니&위시리스트 페이지 -->
		<div id="shopCart">
			<div>
				<h1 id="title">
					<span>장바구니</span> <span class="countBox"> <span
						class="count">${shopCartCount}</span>
					</span>

				</h1>
				<%-- 				<c:when test="${loggedUserInfo!=null }"> --%>
				<!-- 			<form name="orderF" id="orderF" action="ShopCartList.do"> -->
				<div id="shopCartBody">
					<c:choose>
						<c:when test="${shopCartCount!=0 }">
							<table>
								<colgroup>
									<col style="width: 24px">
									<col style="width: 450px">
									<col style="width: 84px">
									<col style="width: 98px">
									<col style="width: 104px">
									<col style="width: 114px">
									<col style="width: 114px">
									<col style="width: 134px">
								</colgroup>
								<thead id="pctThead">
									<tr>
										<th><input type="checkbox" id="allCheckBox"
											checked="checked"></th>
										<th colspan="1" id="itemTh">item</th>
										<th>위시</th>
										<th>수량</th>
										<th>배송수단</th>
										<th>배송비
											<div id="tooltipBox">
												<div id="tooltip" role="tooltip" style="visibility:hidden">
													<div id="tooltip01">
														<p id="tooltip0101">배송비 안내</p>
														<p id="tooltip0102">조건부 무료배송</p>
													</div>
													<hr id="tooltipLine">
													<div id="tooltip02">
														<p>4,000원</p>
														<p>250,000원 이상 구매 시 무료배송</p>
													</div>
													<div id="arrow" data-popper-arrow></div>
												</div>
												<button id="tooltipBtn" type="button">
													<span class="material-icons" id="question">help_outline</span>
												</button>
											</div>
										</th>
										<th id="priceTh">가격</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="pctTbody">
									<c:forEach var="ShopCartBean" items="${shopCartList}" begin="0"
										end="${shopCartList.size()}" step="1" varStatus="status">

										<tr id="cartList">
											<td><input type="checkbox" name="OneCB" id="oneCheckBox"
												value="${ShopCartBean.no}"
												data-price="${ShopCartBean.price*ShopCartBean.amount }" checked="checked"></td>
											<td id="itemBox">
												<!-- 											<img id="pctImg" alt="" src="../images/spring.png">  -->
												<a href="ProductInfo.do?no=${ShopCartBean.pdtNo }"> <img
													id="pctImg" alt="" src="${ShopCartBean.mainImg}">
											</a>
												<div id="pdtTextBox">
													<a href="ProductInfo.do?no=${ShopCartBean.pdtNo }"> <span
														id="pdtText01">${ShopCartBean.pdtName}</span>
													</a>
													<p id="pdtText02">
														- ${ShopCartBean.pdtSize} / ${ShopCartBean.pdtColor} / <span
															id="pdtAmount">${ShopCartBean.amount} 개</span>
													</p>
												</div>
											</td>
											<td>
												<div id="wishBox" data-no="${ShopCartBean.no }">
													<div id="wishOnOffBox${status.index}" data-no="${ShopCartBean.pdtNo}">
														<c:choose>
															<c:when test="${ShopCartBean.wishOn==0 }">
																<div id="wishOnOff${status.index}" data-no="${ShopCartBean.wishOn}">
																	<input type="image" id="wishOff${status.index}"
																		src="../images/heart0.png">
																</div>
															</c:when>
															<c:otherwise>
																<div id="wishOnOff${status.index}" data-no="${ShopCartBean.wishOn}">
																	<input type="image" id="wishOn${status.index}"
																		src="../images/heart1.png">
																</div>
															</c:otherwise>
														</c:choose>
													</div>
												</div>
											</td>
											<td>
												<div id="amountBox">
													<button type="button" id="minusAmount${status.index}"
														data-no="${ShopCartBean.no}">-</button>
													<input type="text" id="amount${status.index}"
														value=${ShopCartBean.amount }>
													<%-- 												<a href="OptionChange.do?no=${ShopCartBean.no}">변경</a> --%>
													<button type="button" id="plusAmount${status.index}"
														data-no="${ShopCartBean.no}">+</button>
													<!-- 												<button type="button" id="amountChange">변경</button> -->
												</div>

											</td>
											<td>
												<div id="deliveryMethodBox">
													<c:choose>
														<c:when test="${ShopCartBean.selectBox==0}">
															<select id="deliveryMethod${status.index}">
																<option value="0" data-no=${ShopCartBean.no }>택배</option>
																<option selected="selected" value="1"
																	data-no=${ShopCartBean.no }>방문수령</option>
															</select>
														</c:when>
														<c:otherwise>
															<select id="deliveryMethod${status.index}">
																<option selected="selected" value="0"
																	data-no=${ShopCartBean.no }>택배</option>
																<option value="1" data-no="${ShopCartBean.no }">방문수령</option>
															</select>
														</c:otherwise>
													</c:choose>
												</div>
											</td>
											<td><c:choose>
													<c:when test="${ShopCartBean.selectBox==0}">
														<p id="selectBoxPrice">무료</p>
													</c:when>
													<c:otherwise>
														<p id="selectBoxPrice">4,000원</p>
													</c:otherwise>
												</c:choose></td>
											<td id="priceTd" data-price="${ShopCartBean.price*ShopCartBean.amount}"><fmt:formatNumber
													pattern="###,###,###" value="${ShopCartBean.price*ShopCartBean.amount}" />원</td>
											<td>
												<a href="OrderByOne.do?no=${ShopCartBean.no}"id="orderPctBtn">주문</a>
												<button id="deletePctBtn" data-no="${ShopCartBean.no}">삭제</button>
											</td>
										</tr>
									</c:forEach>
								</tbody>
								<tbody id="blackTbody">
									<tr>
										<th></th>
									</tr>
								</tbody>
								<tbody id="totalTbody">
									<tr>
										<th colspan="5"></th>
										<th>상품가격</th>
										<td id="allPrice" data-price="${allPrice}"><fmt:formatNumber
												pattern="###,###,###" value="${allPrice}" />원</td>
									</tr>
									<tr>
										<th colspan="5"></th>
										<th>배송비</th>
										<td id="deliveryPrice"><fmt:formatNumber
												pattern="###,###,###" value="${deliveryPrice}" />원</td>
									</tr>
									<tr>
										<th colspan="4"></th>
										<th colspan="2">적립예정 구매감사 적립금</th>
										<td><fmt:formatNumber pattern="###,###,###"
												value="${Math.round(allPrice/50)}" />구매감사적립금</td>
									</tr>
									<tr id="totalPriceTr">
										<th colspan="2">
											<div id="btns">
												<!-- 												<button id="selectDelete">선택상품 삭제</button> -->
												 <button id="selectDelete">선택상품 삭제</button>
												<!-- 											<button>위시리스트 담기</button> -->
											</div>
										</th>
										<th colspan="3"></th>
										<th>결제금액</th>
										<td><span id="totalPrice"> <fmt:formatNumber
													pattern="###,###,###" value="${allPrice+deliveryPrice}" />원
										</span></td>
									</tr>
								</tbody>
							</table>

							<div id="shopCartBtns">
								<a id="keepShopping" href="/">계속 쇼핑하기</a>
								<button type="button" id="OrderAllBtn">주문하기</button>
							</div>
						</c:when>
						<c:otherwise>
							<table>
								<colgroup>
									<col style="width: 24px">
									<col style="width: 450px">
									<col style="width: 84px">
									<col style="width: 98px">
									<col style="width: 104px">
									<col style="width: 114px">
									<col style="width: 114px">
									<col style="width: 134px">
								</colgroup>
								<thead id="pctThead">
									<tr>
										<th><input type="checkbox" id="allCheckBox"
											checked="checked"></th>
										<th colspan="1" id="itemTh">item</th>
										<th>위시</th>
										<th>수량</th>
										<th>배송수단</th>
										<th>배송비
											<div id="tooltipBox">
												<div id="tooltip" role="tooltip">
													<div id="tooltip01">
														<p id="tooltip0101">배송비 안내</p>
														<p id="tooltip0102">조건부 무료배송</p>
													</div>
													<hr id="tooltipLine">
													<div id="tooltip02">
														<p>4,000원</p>
														<p>250,000원 이상 구매 시 무료배송</p>
													</div>
													<div id="arrow" data-popper-arrow></div>
												</div>
												<button id="tooltipBtn" type="button">
													<span class="material-icons" id="question">help_outline</span>
												</button>
											</div>
										</th>
										<th id="priceTh">가격</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="pctTbody">
									<tr id="noCartBox">
										<td colspan="8">
											<div id="noCart">
												<div>
													<img alt="" src="../images/cart.png">
												</div>
												<div>
													<span>장바구니가 비어있습니다.</span>
												</div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							<div id="shopCartBtns">
								<a id="keepShopping" href="/">계속 쇼핑하기</a>
							</div>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		<div id="wishList">
			<%@ include file="../shopCart/wish_list.jsp"%>
<%-- 		<c:choose> --%>
<%-- 			<c:when test="${loggedUserInfo != null }"> --%>
<!-- 				<div> -->
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${ wishList != null }"> --%>
<!-- 							<div> -->
<!-- 								<h2>  -->
<!-- 									<span>위시리스트</span> -->
<%-- 									<a href="WishList.do?idNo=${loggedUserInfo.no }">더보기</a> --%>
<!-- 								</h2> -->
<%-- 								<c:forEach var="wishBean" items="${wishList}" begin="0" end="${wishList.size()}" step="1" varStatus="status"> --%>
<!-- 									<ul> -->
<!-- 										<li> -->
<!-- 											<div> -->
<%-- 												<img src="${wishBean.mainimg }"> --%>
<!-- 											</div> -->
<%-- 											<p>이름 : ${wishBean.name}</p> <span>가격 : ${wishBean.price }원</span> --%>
<!-- 										</li> -->
<!-- 									</ul> -->
<%-- 								</c:forEach> --%>
<!-- 							</div> -->
<%-- 						</c:when> --%>
<%-- 						<c:otherwise> --%>
<!-- 							<div> -->
<!-- 								<h2> -->
<!-- 									<span>위시리스트</span> -->
<%-- 									<a href="WishList.do?idNo=${loggedUserInfo.no }">더보기</a> --%>
<!-- 								</h2> -->
<!-- 								<div> -->
<!-- 									<span>위시리스트가 없습니다.</span> -->
<!-- 								</div> -->
<!-- 							</div> -->
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
<!-- 				</div> -->
<%-- 			</c:when> --%>
<%-- 		</c:choose> --%>
		<!-- 		<div id="amountModal" class="modal" style="overflow: hidden;"> -->
		<!-- 			<div class="modal-content" -->
		<!-- 				style="padding: 0; width: 288px; font-size: 14px; border: none; border-radius: 5px; margin: 20% auto"> -->
		<!-- 				<p style="text-align: center; line-height: 1.5; padding: 55px 15px"> -->
		<!-- 					선택하신 상품을 장바구니에 담았습니다.</p> -->
		<!-- 				<div style="display: flex; flex-direction: row; font-size: 13px;"> -->
		<!-- 					<div style="cursor: pointer; text-align: center; width: 40%; padding: 15px 30px; border-top: 1px solid #d9d9d9; border-right: 1px solid #d9d9d9;" -->
		<!-- 						id="keepShopping"> -->
		<!-- 						<span> 계속쇼핑 </span> -->
		<!-- 					</div> -->
		<!-- 					<div style="cursor: pointer; text-align: center; width: 40%; padding: 15px 30px; border-top: 1px solid #d9d9d9;"> -->
		<%-- 						<input type="hidden" name="pdtNo" value="${productBean.no}"> --%>
		<!-- 					</div> -->
		<!-- 				</div> -->
		<!-- 			</div> -->
		<!-- 		</div> -->
		</div>
	</section>
	<%@ include file="../include/footer.jsp"%>
</body>

<script>
	//시작하자마자 시작
	$(document).ready(function() {
		//툴팁 버튼 온오프
		var tooltip = document.querySelector("#tooltip");
		$("#tooltipBtn").on("click", function() {
			if (tooltip.style.visibility == 'hidden') {
				$("#tooltip").css("visibility", "visible");
			} else {
				$("#tooltip").css("visibility", "hidden");
			}
		});
		$("#tooltip").on("click", function() {
			$("#tooltip").css("visibility", "hidden");
		});

		//위시 하트온오프
		$("[id^='wishOnOffBox']").each(function(index, item) {
			$('#wishOnOff' + index).unbind('click').on("click", function() {
				const _idNo = "${loggedUserInfo.no}";
				let _no = $(this).parent().parent().data("no");
				if(_idNo !=null){
				}else{
					_idNo = 0;
				}
				let _pdtNo = $(this).parent().data("no");
				let wishOn = $(this).data("no");
				
				let wishId = $("#wishOnOff" + index).children().attr('id');
				$.ajax({
					url : "ShopCartChangeWish.do",
			         type : "POST",
			         data :  {
		 		        	no : _no
						 },
			         success : function() {
			         }					
				})
				if (wishOn == 1) {
					$.ajax({
				         url : "DeleteWish.do",
				         type : "POST",
				         data :  {
			 		        	idNo : _idNo,
								pdtNo : _pdtNo
							 },
				         success : function() {
				        	 $("#wishOn" + index).prop("src", "../images/heart0.png");
				        	 $("#wishOn" + index).prop("id", "wishOff" + index);
							 location.reload();
				         }
				      });
					
				} else {
					$.ajax({
		 		         url : "InsertWish.do",
		 		         type : "POST",
		 		         data : {
		 		        	idNo : _idNo,
							pdtNo : _pdtNo
						 },
		 		         success : function() {
		 		        	$("#wishOff" + index).prop("src", "../images/heart1.png");
		 		        	$("#wishOff" + index).prop("id", "wishOn" + index);
		 		        	location.reload();
		 		         }
		 			});
				}
			});
		});

	});


	//하나 지우기
	$("body").on("click", "#deletePctBtn", function() {
		const _parent = $(this).parent().parent();
		const _no = $(this).data("no");
		const sendData = {
			no : _no,
		};
		$.ajax({
			url : "ShopCartDelete.do",
			data : sendData,
			success : function(data) {
				if (data.result > 0) {
					_parent.remove();
				}
				location.reload();
			}
		});
	});
	//선택 지우기
	$("body").on("click", "#selectDelete", function() {
		var _noList = [];
		$("[id='oneCheckBox']:checked").each(function() {
			_noList.push($(this).val());
		});
		if (_noList.length <= 0) {
			alert("삭제 할 상품이 없습니다.");
		}
		$.ajax({
			url : "SeleteDelete.do",
			data : {
				noList : _noList
			},
			success : function(data) {
				alert("삭제되었습니다.");
				location.reload();
			}
		});
	});
	
		
	//체크박스 하나 클릭 //합계 가격 //배송비 //총결제금액
	$("[id='oneCheckBox']").change(function() {
		var _noList = [];
		$("[id='oneCheckBox']:checked").each(function() {
			_noList.push($(this).val());
		});
		$.ajax({
			url : 'GetAllPrice.do',
			type : 'POST',
			data : {
				noList : _noList
			},
			success : function(data) {
				var sendData = data.toLocaleString('ko-KR');
				$("[id='allPrice']").html(sendData + "원");
			},
			error : function() {
				$("[id='allPrice']").html("-");
			}
		});
		$.ajax({
			url : 'GetDeliveryPrice.do',
			type : 'POST',
			data : {
				noList : _noList
			},
			success : function(data) {
				var sendData = data.toLocaleString('ko-KR');
				$("[id='deliveryPrice']").html(sendData + "원");
			},
			error : function() {
				$("[id='deliveryPrice']").html("-");
			}

		});
		$.ajax({
			url : 'GetTotalPrice.do',
			type : 'POST',
			data : {
				noList : _noList
			},
			success : function(data) {
				var sendData = data.toLocaleString('ko-KR');
				$("[id='totalPrice']").html(sendData + "원");
			},
			error : function() {
				$("[id='totalPrice']").html("-");
			}
		});
	});

	//체크박스 전체선택, 해제
	$(document).ready(function() {
		$("#allCheckBox").click(function() {
			if ($("#allCheckBox").prop("checked")) {
				$("input[name=OneCB]").prop("checked", true);
				var _noList = [];
				$("[id='oneCheckBox']:checked").each(function() {
					_noList.push($(this).val());
				});
				$.ajax({
					url : 'GetAllPrice.do',
					type : 'POST',
					data : {
						noList : _noList
					},
					success : function(data) {
						var sendData = data.toLocaleString('ko-KR');
						$("[id='allPrice']").html(sendData + "원");
					},
					error : function() {
						$("[id='allPrice']").html("-");
					}
				});
				$.ajax({
					url : 'GetDeliveryPrice.do',
					type : 'POST',
					data : {
						noList : _noList
					},
					success : function(data) {
						var sendData = data.toLocaleString('ko-KR');
						$("[id='deliveryPrice']").html(sendData + "원");
					},
					error : function() {
						$("[id='deliveryPrice']").html("-");
					}

				});
				$.ajax({
					url : 'GetTotalPrice.do',
					type : 'POST',
					data : {
						noList : _noList
					},
					success : function(data) {
						var sendData = data.toLocaleString('ko-KR');
						$("[id='totalPrice']").html(sendData + "원");
					},
					error : function() {
						$("[id='totalPrice']").html("-");
					}
				});
			} else {
				$("input[name=OneCB]").prop("checked", false);
				$("[id='allPrice']").html("-");
				$("[id='deliveryPrice']").html("-");
				$("[id='totalPrice']").html("-");
			}
		})
	})

	//전체 주문하기
	$("#OrderAllBtn").on("click", function() {
		var _noList = [];
		$("[id='oneCheckBox']:checked").each(function() {
			_noList.push($(this).val());
		});
		if (_noList.length <= 0) {
			alert("주문할 상품이 없습니다.");
		}
		$.ajax({
			url : 'OrderByAll.do',
			type : 'POST',
			data : {
				noList : _noList
			},
			success : function(data) {
				location.href = "PlaceAnOrder.do";
			}
		});
	});
	
	//배달비
	$("[id^=deliveryMethod]").each(
			function(index, item) {
				$("#deliveryMethod" + index).change(
						function() {
							const _no = $(this).children().data("no");
							const _selectBox = $(this).val();
							if ($(this).val("0")) {
								const sendData = {
									no : _no,
									selectBox : _selectBox,
								}
								$.ajax({
									url : 'SelectBoxChange.do',
									type : 'POST',
									data : sendData,
									success : function(data) {
										if (data != null) {
											$("#deliveryMethod").val("1").prop("selected", true);
											$("#selectBoxPrice").html("무료");
											location.reload();
										}
									}
								});
							} else {
								const sendData = {
									no : _no,
									selectBox : _selectBox,
								}
								$.ajax({
										url : 'WishSelectBoxChange.do',
										type : 'POST',
										data : sendData,
										success : function(data) {
											// 				console.log(data);
											if (data > 0) {
												$("#deliveryMethod").val("0").prop( "selected", true);
												$("#selectBoxPrice").html("4,000원");
												location.reload();
											}
										}
									});
							}
						});
			});
	$("[id^='amountBox']").each(function(index, item) {
		$("#plusAmount" + index).on("click", function() {
			var _no = $(this).data("no");
			var _amount = $("#amount" + index).val();
			const sendData = {
				no : _no,
				amount : _amount
			}
			$.ajax({
				url : 'PlusAmount.do',
				type : 'POST',
				data : sendData,
				success : function() {
					location.reload();
				}
			});
		});
		$("#minusAmount" + index).on("click", function() {
			var _no = $(this).data("no");
			var _amount = $("#amount" + index).val();
			if(_no<=1){
				_no=1;
			}
			const sendData = {
				no : _no,
				amount : _amount
			}
			$.ajax({
				url : 'MinusAmount.do',
				type : 'POST',
				data : sendData,
				success : function() {
					location.reload();
				}
			});
		});
	});
	
</script>
</html>