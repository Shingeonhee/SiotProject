<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	
	<div id="productdetail">
	<hr>
		<div class="productdetailWrap">
			<div></div>
		</div>
		<div>
			<div id="info_main_txt">
					<p>시옷프로젝트의 모든 의상은 주문제작 상품입니다.</p>
					<p>신중하게 구매해주시고,</p>
					<p>교환/환불이 불가하니 참고해주세요.</p>
			</div>
		</div>
		 <div id="productdetailsecond">
			<div>
				<div id="pdtsuperdetail">
					<p>${productBean.d_contents}</p>
				</div>
			</div>
		</div> 
	</div>
   
</body>
<style>
.productdetailsecond {
	margin-top: 40px;
}
</style>
</html>