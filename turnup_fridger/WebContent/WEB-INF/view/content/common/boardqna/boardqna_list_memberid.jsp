<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
form{display:inline}
</style>
</head>
<body>
<h1>QnA 게시판 </h1><br>
<hr>
<form action="${initParam.rootPath}/common/boardqna/boardQnAByMemberId.do" method="post">
	QnA > ${row.memberId}검색
	<input type="text" name="memberId" placeholder="아이디를 입력해주세요">
	<button>검색</button>
	<sec:csrfInput/>
</form>
<form action="${initParam.rootPath}/common/boardqna/boardQnAList.do" method="post">
	<button>전체보기</button>
	<sec:csrfInput/>
</form><br>
<c:if test="${empty list}">
	검색한 아이디가 없습니다.
</c:if>
<c:if test="${!empty list}">
<table border="1" width="600px">
<thead id="thead">
    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성일</th>
        <th>작성자</th>
    </tr>
 </thead>
 
<tbody id="tbody">
<c:forEach var="row" items="${list}">
    <tr>
        <td>${row.boardQnAId}</td>
        <td>
        	<form action="${initParam.rootPath}/common/boardqna/boardQnAView.do" method="post">
        	<!-- 회원일때 보여줌 -->
        	<sec:authorize access="hasRole('ROLE_MEMBER')">
        		<input type="hidden" name="member" value="<sec:authentication property="principal.memberId"></sec:authentication>"> 
        		<input type="hidden" name="admin" value="">
        		<input type="hidden" name="memberId" value="${row.memberId}">
				<button value="${row.boardQnAId}" name="boardQnAId" style="background-color:white;border:0">${row.boardQnATitle}</button>  
			</sec:authorize>
        
     		<!-- 관리자일때 보여줌 -->	
     		<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
				<input type="hidden" name="admin" value="<sec:authentication property="principal.adminId"></sec:authentication>"> 
				<input type="hidden" name="member" value="">
				<input type="hidden" name="memberId" value="${row.memberId}">
				<button value="${row.boardQnAId}" name="boardQnAId" style="background-color:white;border:0">${row.boardQnATitle}</button>  
			</sec:authorize>
			<sec:csrfInput/>
		</form>
        </td>
        <td>
            <fmt:formatDate value="${row.boardQnAdate}" pattern="yyyy-MM-dd"/>
        </td>
        <td>${row.memberId}</td>
    </tr>    
</c:forEach>
 </tbody>
</table>
<p>
	<%-- ######################################################
														페이징 처리
			###################################################### --%>
	<!-- 첫페이지로 이동 -->
	<a href="${initParam.rootPath}/common/boardqna/boardQnAByMemberId.do?page=1&memberId=${requestScope.memberId}">첫페이지</a>

	<!--
		이전 페이지 그룹 처리.
		만약에 이전페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리.
	 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.previousPageGroup}">
			<%-- 이전페이지 그룹이 있디면 : previousPageGroup()--%>
			<a href="${initParam.rootPath }/common/boardqna/boardQnAByMemberId.do?page=${requestScope.pageBean.beginPage - 1}&memberId=${requestScope.memberId}">☜</a>
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
					<a href="${initParam.rootPath}/common/boardqna/boardQnAByMemberId.do?page=${page}&memberId=${requestScope.memberId}">&nbsp;${page}&nbsp;</a>
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
			<a href="${initParam.rootPath }/common/boardqna/boardQnAByMemberId.do?page=${requestScope.pageBean.endPage + 1}&memberId=${requestScope.memberId}">☞</a>
		</c:when>
		<c:otherwise>
				☞		
		</c:otherwise>
	</c:choose>			
	

	<!-- 마지막 페이지로 이동 -->
	<a href="${initParam.rootPath}/common/boardqna/boardQnAByMemberId.do?page=${requestScope.pageBean.totalPage}&memberId=${requestScope.memberId}">마지막페이지</a>
</p>
</c:if><br>
<!-- 회원만 등록 가능 -->
 <sec:authorize access="hasRole('ROLE_MEMBER')">
 	<a href="${initParam.rootPath}/common/boardqna/boardqna_form.do"><button>등록</button></a>
 </sec:authorize>
<a href="${initParam.rootPath}/index.do"><button>홈으로</button></a>
</body>
</html>