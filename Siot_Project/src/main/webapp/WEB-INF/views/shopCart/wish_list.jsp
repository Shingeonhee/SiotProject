<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="css/shopCart.css">
<body>
	<section id="pageSize">
		<div id="cartWishList">
			<c:choose>
				<c:when test="${loggedUserInfo != null }">
					<div>
						<c:choose>
							<c:when test="${ wishList != null }">
								<div id="wishListBox">
									<h2>
										위시리스트 <a href="WishList.do?idNo=${loggedUserInfo.no }">더보기</a>
									</h2>
									<ul id="wishList"style="display: flex; width:1280px;overflow: hidden">
										<c:forEach var="wishBean" items="${wishList}" begin="0"
											end="${wishList.size()}" step="1" varStatus="status">
											<li style="padding:0 10px;">
												<div>
													<div id="imgBox">
														<div id="imgHover">
															<span id="icons" class="material-icons" data-no="${wishBean.no}">cancel</span>
															<a href="ProductInfo.do?no=${wishBean.no}">
																<img src="${wishBean.mainimg}" style="width:234px;height:350px;">
															</a>
														</div>
													</div>
													<div style="text-align: center; padding:25px 0; font-size: 14px;line-height:1.6;">
														<p style="font-weight:600;">${wishBean.name}</p>
														<span>${wishBean.price}원</span>
													</div>
												</div></li>
										</c:forEach>
									</ul>
								</div>
							</c:when>
							<c:otherwise>
								<div>
									<h2>
										위시리스트 <a href="WishList.do?idNo=${loggedUserInfo.no }">더보기</a>
									</h2>
									<div>
										<span>위시리스트가 없습니다.</span>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</c:when>
			</c:choose>
		</div>
	</section>
</body>
<script>
	$("body").on("click", "#icons", function() {
		let _idNo = "${loggedUserInfo.no}";
		let _pdtNo = $(this).data("no");
		if(_idNo !=null){
		}else{
			_idNo = 0;
		}
		let sendData = {
			idNo : _idNo,
			pdtNo : _pdtNo
		};
		$.ajax({
			url : "DeleteWish.do",
			type : "POST",
			data : sendData,
			success : function() {
				console.log("삭 ㅡ 제");
				location.reload();
			}
		})
	});
</script>