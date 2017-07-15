<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
form{display:inline}
/* focus none 지정 */
input:focus {
  outline: none;
}
/* th 가운데 정렬 정렬 */
th{
text-align:center
}
/* input 정렬 */
input {
   vertical-align:middle;  
}
</style>
</head>
<body>
<div id="table" style="width:800px; margin-left: auto; margin-right: auto;">
<h1>자유 게시판</h1><br>	
<table class="table table-hover table-condensed" style="width:100%; border:1; text-align:center;">
	<a href="${initParam.rootPath}/index.do"><button style="text-align:right">홈으로</button></a>
	<div style="float:right">
	<form action="${initParam.rootPath}/common/boardfree/boardFreeBySelect.do" method="post">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<select name="select" id="select">
			<option>전체보기</option>
			<option value="제목">제목</option>
			<option value="아이디">아이디</option>
		</select>
		<input type="text" name="keyword" placeholder="키워드를 입력해주세요">
		<button>검색</button>
	</form>
	</div>
	<thead id="thead">
    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성일</th>
        <th>작성자</th>
        <th>조회수</th>
        <th>댓글수</th>
    </tr>
 </thead>
 
<tbody id="tbody">
<c:forEach var="row" items="${list}" varStatus="status">
    <tr>
        <td>${requestScope.totalCount-((requestScope.pageBean.page -1 ) * 10 + status.index)}</td>
        <td>
    		<form action="${initParam.rootPath}/common/boardfree/boardFreeView.do" method="post">
	    		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	       		<input type="hidden" name="boardFreeId" value="${row.boardFreeId}">
	        	<input type="submit" value="${row.boardFreeTitle}" style="background-color:white;border:0;WIDTH: 350pt; HEIGHT: 15pt"> 
			</form> 
        </td>
        <td>
            <fmt:formatDate value="${row.date}" pattern="yyyy-MM-dd"/>
        </td>
        <td>${row.memberId}</td>
        <td>${row.boardFreeHits}</td>
        <td>
        	<c:if test="${row.commentCount == 0}">
        		0
        	</c:if>
        	<c:if test="${row.commentCount != 0}">
        		${row.commentCount}
        	</c:if>
        </td>
    </tr>    
</c:forEach>
 </tbody>
</table>
<sec:authorize access="hasRole('ROLE_MEMBER')">
	<a href="${initParam.rootPath}/common/boardfree/boardfree_form.do"><button>등록</button></a>
</sec:authorize>
</div>
<p style="text-align:center">
	<%-- ######################################################
														페이징 처리
			###################################################### --%>
	<!-- 첫페이지로 이동 -->
	<a href="${initParam.rootPath}/common/boardfree/boardFreeByBoardFreeHits.do?page=1">첫페이지</a>

	<!--
		이전 페이지 그룹 처리.
		만약에 이전페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리.
	 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.previousPageGroup}">
			<%-- 이전페이지 그룹이 있디면 : previousPageGroup()--%>
			<a href="${initParam.rootPath }/common/boardfree/boardFreeByBoardFreeHits.do?page=${requestScope.pageBean.beginPage - 1}">☜</a>
		</c:when>
		<c:otherwise>
				☜	
		</c:otherwise>
	</c:choose>
	
	<!-- 
		현재 page가 속한 page 그룹내의 페이지들 링크.
		현재 pageGroup의 시작page ~ 끝 page
	 -->
	 <!-- 만약에 page가 현재페이지면 링크처리를 하지 않고 page가 현재페이지가 아니라면 링크처리. -->
		<c:forEach begin="${requestScope.pageBean.beginPage}" end="${requestScope.pageBean.endPage}" var="page">
			<c:choose>
				<c:when test="${requestScope.pageBean.page != page}"> <%-- 현재패이지가 아니라면 --%>
					<a href="${initParam.rootPath}/common/boardfree/boardFreeByBoardFreeHits.do?page=${page}">&nbsp;${page}&nbsp;</a>
				</c:when>
				<c:otherwise>
					&nbsp;[${page}]&nbsp;
				</c:otherwise>
			</c:choose>
		</c:forEach>
	

	<!-- 
		다음페이지 그룹으로 이동
		만약에 다음페이지 그룹이 있으면 링크 처리 없으면 화살표만 나오도록 처리
	 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.nextPageGroup}">
			<%-- 다음페이지 그룹이 있디면 : nextPageGroup()--%>
			<a href="${initParam.rootPath }/common/boardfree/boardFreeByBoardFreeHits.do?page=${requestScope.pageBean.endPage + 1}">☞</a>
		</c:when>
		<c:otherwise>
				☞		
		</c:otherwise>
	</c:choose>			
	
	<!-- 마지막 페이지로 이동 -->
	<a href="${initParam.rootPath}/common/boardfree/boardFreeByBoardFreeHits.do?page=${requestScope.pageBean.totalPage}">마지막페이지</a>

</p>
</body>
</html>