<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>
<link rel="stylesheet" href="css/shopCart.css">
<body>
	<section id="pageSize">
		<div id="placeAnOrder">
			<div id="orderHeader">
				<h1>결제하기</h1>
			</div>
			<form action="Payment.do" method="POST">
				<div id="allBody">
					<div id="leftBody">
						<div id="pctBoxBox">
							<h3>주문 상품 정보</h3>
							<c:choose>
								<c:when test="${loggedUserInfo!=null}">
									<input type="hidden" name="idNo" value="${loggedUserInfo.no}">
								</c:when>
								<c:otherwise>
									<input type="hidden" name="idNo" value="0">
								</c:otherwise>
							</c:choose>
							<c:forEach var="ShopCartBean" items="${shopCartList}" begin="0"
								end="${shopCartList.size()}" step="1" varStatus="status">
								<div id="pctBox" data-no="${ShopCartBean.pdtNo}"
									data-idx="${ShopCartBean.no} ">
									<img alt="" src="${ShopCartBean.mainImg }">
									<div id="pct">
										<p class="name">${ShopCartBean.pdtName }</p>
										<p class="option">
											- <span id="pdtColor">${ShopCartBean.pdtColor}</span> / <span
												id="pdtSize">${ShopCartBean.pdtSize }</span> / <span
												id="amount">${ShopCartBean.amount}개</span>
										</p>
										<p class="price">
											<fmt:formatNumber pattern="###,###,###" value="${ShopCartBean.price*ShopCartBean.amount}" /> 원
										</p>
									</div>
								</div>
							</c:forEach>
						</div>
						<div>
							<h3>주문자 정보</h3>
							<input class="input1" type="text" id="name1" placeholder="이름"
								value="${loggedUserInfo.name}"> <input class="input1"
								type="text" id="phone1" placeholder="연락처"
								value="${loggedUserInfo.phone}"> <input class="input2"
								type="email" name="email" placeholder="이메일(선택)" value="">
						</div>
						<div>
							<h3>배송 정보</h3>
							<div>
								<div>
									<label id="sameOrderer"> <input type="checkBox"
										id="sameCB" value="1" checked> <span>주문자 정보와 동일</span>
									</label>
								</div>
								<input type="text" class="input1" id="name2" name="name"
									placeholder="수령인" value="${loggedUserInfo.name}"> <input
									type="text" class="input1" id="phone2" name="phone"
									placeholder="연락처" value="${loggedUserInfo.phone}"> <input
									type="text" name="postCode" id="sample3_postcode"
									placeholder="우편번호" value="${loggedUserInfo.postCode}">
								<input type="button" onclick="sample3_execDaumPostcode()"
									id="findAddress" data-no="${loggedUserInfo.no }" value="주소찾기">
								<input type="text" name="address" class="input2"
									id="sample3_address" placeholder="주소" name="address"
									id="address" value="${loggedUserInfo.address}"> <input
									type="text" name="subAddress" class="input2"
									id="sample3_detailAddress" placeholder="상세주소"
									value="${loggedUserInfo.subAddress}">
								<div id="wrap"
									style="display: none; border: 1px solid; width: 500px; height: 300px; margin: 5px 0; position: relative">
									<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
										id="btnFoldWrap"
										style="cursor: pointer; position: absolute; right: 0px; top: -1px; z-index: 1"
										onclick="foldDaumPostcode()" alt="접기 버튼">
								</div>
							</div>
							<!-- 							<div> -->
							<!-- 								<label> <input type="checkBox" name="" value=""> -->
							<!-- 									<span>배송지 목록에 추가</span> -->
							<!-- 								</label> -->
							<!-- 							</div> -->

							<div id="dMemoBox">
								<p>배송메모</p>
								<select class="input2" name="deliveryMemo" id="deliveryMemo">
									<option value="null">배송메모를 선택해 주세요.</option>
									<option value="배송 전에 미리 연락 바랍니다.">배송 전에 미리 연락 바랍니다.</option>
									<option value="부재시 경비실에 맡겨주세요.">부재시 경비실에 맡겨주세요.</option>
									<option value="부재시 전화나 문자를 남겨주세요.">부재시 전화나 문자를 남겨주세요.</option>
									<option id="custom" value="custom">직접입력</option>
								</select>
								<div id="customMemo" style="display: none">
									<input type="text" class="input2" name="customMemo"
										placeholder="배송메모를 입력해 주세요.(최대 20자)" maxlength='20'>
								</div>
							</div>
						</div>
						<div id="reservesBox">
							<h3>구매감사적립금</h3>
							<div id="reserves">
								<p>구매감사적립금</p>
								<input class="input2" type="text" name="" placeholder="0"
									value="0"> <span id="allUsing">전액사용</span>
								<p>보우 구매감사적립금 0 적립금</p>
								<p>30,000원 이상 구매시 사용 가능</p>
							</div>
						</div>
					</div>
					<div id="rightBody">
						<!-- 		결제 -->
						<div id="rBody">
							<div id="sticky">
								<div>
									<h3>최종 결제금액</h3>
									<div id="totalPriceBox">
										<div class="TPB">
											<span>상품가격</span> <span id="val"> <fmt:formatNumber
													pattern="###,###,###" value="${allPrice}" />원 <input
												type="hidden" name="price" value="${allPrice}">
											</span>
										</div>
										<div class="TPB">
											<span>배송비</span> <span id="val"> +<fmt:formatNumber
													pattern="###,###,###" value="${deliveryPrice}" />원 <c:choose>
													<c:when test="${deliveryPrice != null}">
														<input type="hidden" name="selectBox"
															value="${deliveryPrice}">
													</c:when>
													<c:otherwise>
														<input type="hidden" name="selectBox" value="0">
													</c:otherwise>
												</c:choose>

											</span>
										</div>
										<div class="TPB" id="TPBTotal">
											<span>총 결제금액(${count}개)</span> <span id="totalVal"> <fmt:formatNumber
													pattern="###,###,###" value="${allPrice+deliveryPrice}" />원
												<input type="hidden" name="totalPrice"
												value="${allPrice+deliveryPrice}">
											</span>
										</div>
										<div class="TPB" id="TPBReserves">
											<span id="val"> <fmt:formatNumber
													pattern="###,###,###" value="${allPrice/50}" /> 구매감사적립금
												적립예정
											</span>
										</div>
									</div>
								</div>

								<div>
									<div>
										<h3>결제방법</h3>
										<div id="paymentMethod">
											<label> <input type="radio" name="payment" id="card"
												value="card" checked>신용카드
											</label> <label> <input type="radio" name="payment" id="cash"
												value="cash">무통장입금
											</label>
										</div>
										<div id="cashBox" style="display: none">
											<div>
												<select name="cash_idx" id="cash_idx">
													<option value="0">국민은행 208401-04-302020 시옷프로젝트</option>
												</select> <input id="input3" type="text" name="depositorName"
													placeholder="입금자명(수령인 이름으로 입금해 주세요.)" style="width: 288px;"
													readonly>
											</div>
											<div id="cashReceiptsRequest">
												<label> <input type="checkBox" name="cashReceipts"
													value=""> <span>현금영수증 신청</span>
												</label>
											</div>
										</div>
										<div id="cashBoxOn" style="display: none">
											<div id="cashOnBox">
												<div id="cashOn">
													<label> <input type="radio" name="cashBoxOn"
														class="income" value="income">소득공제용
													</label> <label> <input type="radio" name="cashBoxOn"
														class="expenditure" value="expenditure">지출증빙용
													</label>
												</div>
												<div id="cashOn">
													<input type="text" id="income" name="cashPhone"
														placeholder="휴대전화번호 입력"> <input type="hidden"
														id="expenditure" name="cashPhone" placeholder="사업자번호 입력">
												</div>
											</div>
										</div>
									</div>
								</div>
								<div>
									<div>
										<!-- 							<div> -->
										<!-- 								<h3>주문 상품 정보</h3> -->
										<!-- 							</div> -->
										<div id="agreeBox">
											<label id="allAgree"> <input type="checkBox"
												name="allCheckBox" id="allCheckBox" value="전체 동의"> <span>전체
													동의</span>
											</label>
											<div>
												<div>
													<span id="agreeBefore">ㄴ</span> <label id="agree">
														<input type="checkBox" name="agreeOneCB"
														value="getCurrentDate()"> <span>개인정보 수집 및
															이용 동의 <a>약관보기</a>
													</span>
													</label>
												</div>
												<!-- 									<div> -->
												<!-- 										 <label id="agree"> -->
												<!-- 										 		<input type="checkBox" name="OneCB" value=""> -->
												<!-- 												<span>구매조건 확인 및 결제진행에 동의</span> -->
												<!-- 										</label> -->
												<!-- 									</div> -->
											</div>
										</div>
									</div>
									<div id="paymentBtn">
										<input type="hidden" id="dateNumber" name="paymentNo">
										<input type="submit" id="paymentSubmit" value="결제하기">
										<!-- 										<button>결제하기</button> -->
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
	</section>
	<%@ include file="../include/footer.jsp"%>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		// 우편번호 찾기 찾기 화면을 넣을 element
		var element_wrap = document.getElementById('wrap');

		function foldDaumPostcode() {
			// iframe을 넣은 element를 안보이게 한다.
			element_wrap.style.display = 'none';
		}

		function sample3_execDaumPostcode() {
			// 현재 scroll 위치를 저장해놓는다.
			var currentScroll = Math.max(document.body.scrollTop,
					document.documentElement.scrollTop);
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 각 주소의 노출 규칙에 따라 주소를 조합한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var addr = ''; // 주소 변수
							var extraAddr = ''; // 참고항목 변수

							//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
							if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
								addr = data.roadAddress;
							} else { // 사용자가 지번 주소를 선택했을 경우(J)
								addr = data.jibunAddress;
							}

							// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
							if (data.userSelectedType === 'R') {
								// 법정동명이 있을 경우 추가한다. (법정리는 제외)
								// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								// 건물명이 있고, 공동주택일 경우 추가한다.
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('sample3_postcode').value = data.zonecode;
							document.getElementById("sample3_address").value = addr;
							// 커서를 상세주소 필드로 이동한다.
							document.getElementById("sample3_detailAddress")
									.focus();

							// iframe을 넣은 element를 안보이게 한다.
							// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
							element_wrap.style.display = 'none';

							// 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
							document.body.scrollTop = currentScroll;
						},
						// 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
						onresize : function(size) {
							element_wrap.style.height = size.height + 'px';
						},
						width : '100%',
						height : '100%'
					}).embed(element_wrap);

			// iframe을 넣은 element를 보이게 한다.
			element_wrap.style.display = 'block';
		}

		$(document).ready(function() {
			$("#allCheckBox").click(function() {
				if ($("#allCheckBox").prop("checked")) {
					$("input[name=agreeOneCB]").prop("checked", true);
					$("input[id=dateNumber]").prop("value", getCurrentDate());
				} else {
					$("input[name=agreeOneCB]").prop("checked", false);
					$("input[id=dateNumber]").prop("value", "");
				}
			});
		});
		// 		$(document).ready(function() {
		// 			$("#deliveryMemo").on("change",function(){
		// 				$(this).val("custom").
		// 			})
		// 		}
		$(function() {
			$(document).on("change", "select[name=deliveryMemo]", function() {
				if ($(this).val() == 'custom') {
					$("#customMemo").css("display", "block");
				} else {
					$("#customMemo").css("display", "none");
				}

			});
		});

		// 		$(document).ready(function() {
		// 			$("#cashBox").click(function() {
		// 				if ($("#cashBox").prop("checked",true)) {
		// 					$("#cashBoxOn").css("display", "block");
		// 				} 
		// 			});
		// 			$("#cardBox").click(function() {	
		// 				if ($("#cardBox").prop("checked",true)) {
		// 					$("#cashBoxOn").css("display", "none");
		// 				}
		// 			});
		// 		})

		$(function() {
			$(document).on("change", "input[name='payment']", function() {
				if ($(this).val() == 'cash') {
					$("#cashBox").css("display", "block");
				} else {
					$("#cashBox").css("display", "none");
				}
			});
		});

		$(function() {
			$(document).on("change", "input[name='cashReceipts']", function() {
				if ($("input[name='cashReceipts']").prop("checked")) {
					$("#cashBoxOn").css("display", "block");
				} else {
					$("#cashBoxOn").css("display", "none");
				}

			});
		});

		$(function() {
			$(document).on("change", "input[name='cashBoxOn']", function() {
				if ($(this).val() == 'expenditure') {
					$("input[id='income']").prop("type", "hidden");
					$("input[id='expenditure']").prop("type", "text");
				} else {
					$("input[id='income']").prop("type", "text");
					$("input[id='expenditure']").prop("type", "hidden");
				}
			});
		});

		function getCurrentDate() {
			var date = new Date();
			var year = date.getFullYear().toString();

			var month = date.getMonth() + 1;
			month = month < 10 ? '0' + month.toString() : month.toString();

			var day = date.getDate();
			day = day < 10 ? '0' + day.toString() : day.toString();

			var hour = date.getHours();
			hour = hour < 10 ? '0' + hour.toString() : hour.toString();

			var minites = date.getMinutes();
			minites = minites < 10 ? '0' + minites.toString() : minites
					.toString();

			var seconds = date.getSeconds();
			seconds = seconds < 10 ? '0' + seconds.toString() : seconds
					.toString();

			return year + month + day + hour + minites + seconds;
		}

		$("input[name=agreeOneCB]").on("click", function() {
			console.log("chekckckck");
			var now = new Date();

			$("input[id=dateNumber]").prop("value", getCurrentDate());
		});

		$("#paymentBtn")
				.on(
						"click",
						function() {
							if ($("input[id='name1']").val().length <= 0) {
								alert("주문자 이름을 입력하세요");
								$("input[id=name1]").focus();
								return false;
							} else if ($("input[id='phone1']").val().length <= 0) {
								alert("주문자 연락처를 입력하세요");
								$("input[name='phone']").focus();
								return false;
							} else if ($("input[id='name2']").val().length <= 0) {
								alert("수령인 이름을 입력하세요");
								$("input[name=name]").focus();
								return false;
							} else if ($("input[id='phone2']").val().length <= 0) {
								alert("수령인 연락처를 입력하세요");
								$("input[name='phone']").focus();
								return false;
							} else if ($("input[id='sample3_postcode']").val().length <= 0) {
								alert("우편번호를 입력하세요");
								$("input[id='sample3_postcode']").focus();
								return false;
							} else if ($("input[id='sample3_address']").val().length <= 0) {
								alert("주소를 입력하세요");
								$("input[id='sample3_address']").focus();
								return false;
							} else if ($("input[id='sample3_detailAddress']")
									.val().length <= 0) {
								alert("상세주소를 입력하세요");
								$("input[id='sample3_detailAddress']").focus();
								return false;
							} else if ($("#deliveryMemo").val() == "null") {
								alert("배송 메모를 선택해주세요.");
								return false;
							} else if ($("input[name='agreeOneCB']").prop(
									"checked")) {
								// 				location.href = "Payment.do";
								console.log($("input[id=dateNumber]").val())
								return true;
							} else {
								alert("개인정보 수집 및 이용 동의를 하셔야 주문이 가능합니다.");
								return false;
							}
						});
		$(document).ready(
				function() {
					$("#sameCB").on(
							"click",
							function() {
								let sameCBval = $("#sameCB").val();
								console.log("samCBval==" + sameCBval);
								if (sameCBval == 1) {
									$("#sameCB").prop("value", "0");
									$("input[id='name2']").prop("value", "");
									$("input[id='phone2']").prop("value", "");
									$("input[name='postCode']").prop("value",
											"");
									$("input[name='address']")
											.prop("value", "");
									$("input[name='subAddress']").prop("value",
											"");
								} else {
									$("#sameCB").prop("value", "1");
									$("input[id='name2']").prop("value",
											"${loggedUserInfo.name}");
									$("input[id='phone2']").prop("value",
											"${loggedUserInfo.phone}");
									$("input[name='postCode']").prop("value",
											"${loggedUserInfo.postCode}");
									$("input[name='address']").prop("value",
											"${loggedUserInfo.address}");
									$("input[name='subAddress']").prop("value",
											"${loggedUserInfo.subAddress}");
								}
							})
				})

	      ///////////////////////////////////////////DetailInfo
	    $("body").on("click","#paymentSubmit",function(){
			 var paymentNo = $("#dateNumber").val();
			 $.ajax({
			   url:"PaymentDetail.do",
			   data:{"paymentNo":paymentNo},
			   success:function(result){
			   }
			})
			
			let _idNo = "${loggedUserInfo.no}";
			var _noList = [];
			$("[id='pctBox']").each(function() {
				_noList.push($(this).data("no"));
			});
			$.ajax({
				url : "PaymentShopCartDelete.do",
				data : {
					idNo : _idNo,
					noList : _noList
				},
				success : function(data) {
				}
			});
	    });
	</script>
</body>
</html>