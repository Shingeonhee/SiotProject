<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 개수 변경 -->
	<div>
		<h2>옵션 변경</h2>
		<div>
			<img alt="" src="">
			<div>
				<span>${name}</span> <span>${price}</span>
			</div>
		</div>
		<div>
			<h3>${optionName }</h3>
			<div>
				<c:forEach var="productBean" items="${productList}" begin="0"
					end="${productList.size()}" step="1" varStatus="status">
					<select>
						<option value="${optionValue }">
					</select>
				</c:forEach>
			</div>
		</div>
		<div>
			<c:forEach var="productBean" items="${productList}" begin="0"
				end="${productList.size()}" step="1" varStatus="status">
				<div>
					<span>${optionName}</span>
					<div>
						<a href="">-</a> <input type="text" value="${count }"> <a
							href="">+</a>
					</div>
					<span><fmt:formatNumber pattern="###,###,###"
							value="${price}" />원<a href="">(x)</a></span>
				</div>
			</c:forEach>
		</div>
		<div>
			<span>총수량${총수량}개</span> <span><fmt:formatNumber
					pattern="###,###,###" value="${price}" />원</span>
		</div>
		<div>
			<button>취소</button>
			<button>변경</button>
		</div>
	</div>
</body>
</html>