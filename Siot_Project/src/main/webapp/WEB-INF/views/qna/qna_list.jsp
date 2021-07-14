<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="/WEB-INF/views/include/manage_header.jsp"%>

<section id="pageSize">
	<div class="formBox" id="list">
		<h2>1:1 Q&amp;A LIST</h2>
		<table>
			<colgroup>
				<col style="width: 150px">
				<col style="width: 750px">
				<col style="width: 200px">
				<col style="width: 180px">
			</colgroup>
			<thead>
				<tr>
					<th>상태</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody class="qnaList">
				<c:forEach var="qnaBean" items="${qnaList }" begin="0"
					end="${qnaList.size() }" step="1" varStatus="status">
					<tr id="a${status.index }" data-no="${qnaBean.no}">
						<td class="status${status.index }"></td>
						<td><a href="QnaInfo.do?no=${qnaBean.no}">${qnaBean.subject}</a></td>
						<td>${qnaBean.name}</td>
						<td><fmt:formatDate value="${qnaBean.qnaDate}"
								pattern="yyyy-MM-dd HH:ss" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="pagination">
			<c:if test="${startPage > pageGroup }">
				<a href="QnaList.do?clickedPage=${startPage - pageGroup}"> <span
					class="material-icons">chevron_left</span>
				</a>
			</c:if>
			<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1"
				varStatus="status">
				<c:choose>
					<c:when test="${currentPage==i }">
						<a href="QnaList.do?clickedPage=${ i}" class="clicked">${i }</a>
					</c:when>

					<c:otherwise>
						<a href="QnaList.do?clickedPage=${ i}">${i }</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${endPage<paginationTotal }">
				<a href="QnaList.do?clickedPage=${startPage + pageGroup}"> <span
					class="material-icons">chevron_right</span>
				</a>
			</c:if>
		</div>
	</div>
</section>
<%@ include file="/WEB-INF/views/include/footer.jsp"%>
<script>


// 	$.ajax({
// 		url:"QnaList02.do",
// 		success:function(data){
// 			let qnaNoList = data.qnaNoList;
			
// 			let stat ;
// 			$.each(qnaNoList,function(i,item){
// 				let _qnaNo= data.qnaNoList[i];
// 				$.ajax({
// 					url:"QnaReplyCheck.do",
// 					data:{"qnaNo":_qnaNo},
// 					success:function(data){
// 						//console.log(data.result);
// 						$.each(data,function(i,item){
// 							console.log(item);
// 								if(item>0){
// 									stat ="답변완료";
// 									}else{
// 										stat="답변대기";
// 									}
// 								let _parent = $("tr data-no='"+_qnaNo+"'");
								
// 									$('.status').append(`
// 										\${stat}
								
// 									`);	
// 								})
// 						})
						
// 					}
// 				})
// 			})
			
// 		}
// 	})
	<c:forEach var="qnaBean" items="${qnaList }" begin="0" end="${qnaList.size() }" step="1" varStatus="status">
		$.ajax({
			url:"QnaReplyCheck.do",
			data:{"qnaNo":${qnaBean.no}},
			success:function(data){
				console.log(data.result);
						let stat;
						if(data.result > 0){
							stat ="답변완료";
						}else {
							stat="답변대기";
						}
				var qnaList = $(".status${status.index }");
				qnaList.html(stat);
			}
		})
	</c:forEach>
	
</script>
