<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/views/include/manage_header.jsp"%>

<section id="pageSize">
	<div class="formBox" id="list">
		<h2>상품 Q&amp;A LIST</h2>
		<table>
			<colgroup>
				<col style="width: 150px">
			<col style="width: 750px">
			<col style="width: 200px">
			</colgroup>
			<thead>
				<tr>
					<th>상태</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody class="productQnaList">
				<c:forEach var="productQnaBean" items="${productQnaList }" begin="0"
					end="${productQnaList.size() }" step="1" varStatus="status">
					<tr>
						<td  class="status${status.index }"></td>
						<td><a href="ProductQnaInfo.do?no=${productQnaBean.no}">${productQnaBean.subject}</a></td>
						<td>${productQnaBean.name}</td>
						<td><fmt:formatDate value="${productQnaBean.pdtQnaDate}" pattern="yyyy-MM-dd HH:ss"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="pagination">
			<c:if test="${startPage > pageGroup }">
				<a href="MemberList.do?clickedPage=${startPage - pageGroup}"> <span
					class="material-icons">chevron_left</span>
				</a>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1"
				varStatus="status">
				<c:choose>
					<c:when test="${currentPage==i }">
						<a href="MemberList.do?clickedPage=${ i}" class="clicked">${i }</a>
					</c:when>

					<c:otherwise>
						<a href="MemberList.do?clickedPage=${ i}">${i }</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${endPage<paginationTotal }">
				<a href="MemberList.do?clickedPage=${startPage + pageGroup}"> <span
					class="material-icons">chevron_right</span>
				</a>
			</c:if>
		</div>
	</div>
	</section>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
<script>
//console.log("zzzz");
	<c:forEach var="productQnaBean" items="${productQnaList }" begin="0" end="${productQnaList.size() }" step="1" varStatus="status">
$.ajax({
   url:"PdtQnaReplyCheck.do",
   data:{"qnaNo":${productQnaBean.no}},
   success:function(data){
      console.log(data.result);
            let stat;
            if(data.result > 0){
               stat ="답변완료";
            }else {
               stat="답변대기";
            }
//          var qnaList = document.getElementsByClassName('qnaList')[${status.index}];
      var qnaList = $(".status${status.index }");
      qnaList.html(stat);
   }
})
</c:forEach>
</script>