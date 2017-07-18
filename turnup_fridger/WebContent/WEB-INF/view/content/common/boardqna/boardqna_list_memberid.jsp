<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" 

href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>


<style type="text/css">
form{display:inline}
th{
text-align:center
}
input:focus {
  outline: none;
}
</style>
</head>
<body>
<c:if test="${requestScope.error != null}">
	<script type="text/javascript">alert('권한이 없습니다.')</script>
</c:if>
<jsp:include page="/WEB-INF/view/layout/side_menu/boardSideMenu.jsp"/>


<!-- 검색결과가 없을 때 -->
<c:if test="${empty list}">
<div id="table" style="width:50%; margin-left: auto; margin-right: auto;">
<br><br>
	<h1>QnA 게시판 </h1>
	<hr>
	<table class="table table-hover table-condensed" style="width:100%; border:1; text-align:center;">
		<a href="${initParam.rootPath}/index.do">
			<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" >
				<span class="glyphicon glyphicon-home" aria-hidden="true"></span>
			</button>
		</a>
		<!-- 회원만 등록 가능 -->
		<sec:authorize access="hasRole('ROLE_MEMBER')">
		 	<a href="${initParam.rootPath}/common/boardqna/boardqna_form.do">
		 		<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
				<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
				</button>
			</a>
		</sec:authorize>
		<!-- 검색 버튼 -->
		<div style="float:right">
		<div class="form-inline form-group" >
		<form action="${initParam.rootPath}/common/boardqna/boardQnAByMemberId.do" method="post">
			<input class="form-control" type="text" name="keyword" placeholder="키워드를 입력해주세요">
				<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;">
					<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
				</button>
			<sec:csrfInput/>
		</form>
		</div>
		</div>
	</table>
	<br><h2 style="text-align:center">검색한 아이디가 없습니다.</h2>
</div>
</c:if>
<!-- 검색결과가 있을때  -->
<c:if test="${!empty list}">
<div id="table" style="width:50%; margin-left: auto; margin-right: auto;">
<br><br>
<h1>QnA 게시판 </h1>
<hr>
<table class="table table-hover table-condensed" style="width:100%; border:1; text-align:center;">
<a href="${initParam.rootPath}/index.do">
	<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
		<span class="glyphicon glyphicon-home" aria-hidden="true"></span>
	</button>
</a>
<!-- 회원만 등록 가능 -->
<sec:authorize access="hasRole('ROLE_MEMBER')">
 	<a href="${initParam.rootPath}/common/boardqna/boardqna_form.do">
 		<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
		</button>
	</a>
</sec:authorize>
<!-- 검색 버튼 -->
<div style="float:right">
<div class="form-inline form-group" >
<form action="${initParam.rootPath}/common/boardqna/boardQnAByMemberId.do" method="post">
	<input type="text" name="memberId" placeholder="아이디를 입력해주세요">
		<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
		</button>
	<sec:csrfInput/>
</form>
</div>
</div>
<thead id="thead">
    <tr>
        <th style="width:5%;text-align:center;">번호</th>
        <th style="width:50%;text-align:center;">제목</th>
        <th style="width:10%;text-align:center;">작성일</th>
        <th style="width:15%;text-align:center;">작성자</th>
        <th style="width:10%;text-align:center;">댓글수</th>
    </tr>
 </thead>
<c:forEach var="row" items="${list}" varStatus="status">
    <tr>
        <td>${requestScope.totalCount-((requestScope.pageBean.page -1 ) * 10 + status.index)}</td>
        <td style="width:50%;">
        <form name="form" action="${initParam.rootPath}/common/boardqna/boardQnAView.do" method="post">
        	<!-- 회원일때 보여줌 -->
        	<sec:authorize access="hasRole('ROLE_MEMBER')">
        		<input type="hidden" id="member" name="member" value="<sec:authentication property="principal.memberId"></sec:authentication>"> 
        		<input type="hidden"  name="admin" value="">
        		<input type="hidden" id="memberId" name="memberId" value="${row.memberId}">
        		<input type="hidden" id="boardQnAId" name="boardQnAId" value="${row.boardQnAId}">
        		<input type="submit" id="error" value="${row.boardQnATitle}" style="background-color:white;border:0;WIDTH: 400pt; HEIGHT: 15pt"> 
			</sec:authorize>
        
     		<!-- 관리자일때 보여줌 -->	
     		<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
				<input type="hidden" name="admin" value="<sec:authentication property="principal.adminId"></sec:authentication>"> 
				<input type="hidden" name="member" value="">
				<input type="hidden" name="memberId" value="${row.memberId}">
				<input type="hidden" id="boardQnAId" name="boardQnAId" value="${row.boardQnAId}">
        		<input type="submit" value="${row.boardQnATitle}" style="background-color:white;border:0;WIDTH: 400pt; HEIGHT: 15pt"> 
			</sec:authorize>
			<sec:csrfInput/>
		</form>
        </td> 		
        <td>
            <fmt:formatDate value="${row.boardQnAdate}" pattern="yyyy-MM-dd"/>
        </td>
        <td>        	
        	${row.memberId}
        </td>
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
<p style="text-align:center">
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
			<a href="${initParam.rootPath }/common/boardqna/boardQnAByMemberId.do?page=${requestScope.pageBean.beginPage - 1}&memberId=${requestScope.memberId}">◀</a>
		</c:when>
		<c:otherwise>
				◀	
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
			<a href="${initParam.rootPath }/common/boardqna/boardQnAByMemberId.do?page=${requestScope.pageBean.endPage + 1}&memberId=${requestScope.memberId}">▶</a>
		</c:when>
		<c:otherwise>
				▶		
		</c:otherwise>
	</c:choose>			
	

	<!-- 마지막 페이지로 이동 -->
	<a href="${initParam.rootPath}/common/boardqna/boardQnAByMemberId.do?page=${requestScope.pageBean.totalPage}&memberId=${requestScope.memberId}">마지막페이지</a>
</p>
</div>
</c:if>
</body>
</html>