<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/header.jsp"%>
<link rel="stylesheet" href="../css/product.css">
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
</script>
<body>
	<section id="pageSize">
		<div id="searchBox">
			<a href=""> <span class="material-icons" id="search">
					search </span>
			</a>
		</div>
		<div id="title">
			<div>
				Unique <span>${productList.size()}</span>
			</div>
		</div>
		<div>
			<div>
				<div id="uniqueBox">
					<c:forEach var="ProductBean" items="${productList}" begin="0"
						end="${productList.size()}" step="1" varStatus="status">
						<div id="productImgBox">
							<div id="hoverBox01">
								<div id="hover01">
									<a href="ProductInfo.do?no=${ProductBean.no}"> <img
										src="${ProductBean.mainimg}" id="productImg">
									</a>
								</div>
							</div>
							<div id="txtBox">
								<div
									style="display: flex; justify-content: center; margin-top: 10px;">
									<c:forEach var="i"
										items="${ProductBean.productcolor.split(',') }" begin="0"
										end="3" step="1" varStatus="status">
										<span
											style="display:block;width:15px;height:15px;border-radius:100px;background-color:${i};border:1px solid #ddd;margin:1px;"></span>
									</c:forEach>
								</div>
								<a href="ProductInfo.do?no=${ProductBean.no}" id="txt01"> <span>${ProductBean.name}</span>
								</a> <span id="txt02">${ProductBean.price}원</span>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</section>
</body>
</html>

<%@ include file="../include/footer.jsp"%>

