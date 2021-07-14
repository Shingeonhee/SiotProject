<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../include/header.jsp"%>
<link rel="stylesheet" href="css/product.css">
<body>
	<div>
		<div>
			<c:forEach var="ProductBean" items="${productManageList }" begin="0"
				end="${productManageList.size()}" step="1" varStatus="status">
				<table id="productTable">
					<colgroup>
						<col style="width: 50px">
						<col style="width: 300px">
						<col style="width: 150px">
						<col style="width: 200px">
					</colgroup>
					<thead id="productThead">
						<tr id="productTheadTr">
							<th>No</th>
							<th>Image</th>
							<th>Name</th>
							<th>Price</th>
						</tr>
					</thead>
					<tbody id="productTbody">
						<tr id="productTbodyTr">
							<td>${ProductBean.no}</td>
							<td><img src="${ProductBean.mainimg}"></td>
							<td>${ProductBean.name}</td>
							<td>${ProductBean.price}</td>
						</tr>
					</tbody>
				</table>
			</c:forEach>
		</div>
	</div>



</body>
</html>
