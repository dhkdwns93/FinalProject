<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>



<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<style type="text/css">

/* focus none 지정 */
input:focus {
  outline: none;
}
/* th 가운데 정렬 정렬 */
th{
text-align:center;
}

/* input 정렬 */
input {
   vertical-align:middle;  
}

.blink {
    -webkit-animation: blink 2.5s linear infinite;
} 

@-webkit-keyframes blink {
    0% { color: red; }
    33% { color: yellow; }
    66% { color: blue; }
    100% { color: green; }
}
</style>
</head>
<body>
<div class="container">

<jsp:include page="/WEB-INF/view/layout/side_menu/boardSideMenu.jsp"/>

<!-- 현재 날짜 확인 -->
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />  


<!-- 검색 결과가 없을 때  -->
<c:if test="${empty list}">
<div id="table" style="width:auto; margin-left: auto; margin-right: auto;">
<br><br>
<h1>공지사항</h1>
<hr>
<table class="table table-hover table-condensed" style="width:100%; border:1; text-align:center;">
<div class="form-inline form-group" >
<a href="${initParam.rootPath}/index.do">
	<button type="button" class="btn btn-default btn-lg"  style="border:0;outline:0;">
			<span class="glyphicon glyphicon-home" aria-hidden="true"></span>
	</button>
</a>
<!-- 관리자만 등록 가능 -->
 <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
 <a href="${initParam.rootPath}/common/admin/boardnotice/boardnotice_form.do">
	 <button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
	 </button>
 </a>
 </sec:authorize>
	<!-- 검색 버튼 -->
	<div style="float:right">
		<div style="float:right">
			<form class="form-inline" action="${initParam.rootPath}/boardnotice/boardNoticeByItems.do" method="post">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<select class="form-control" name="items" id="items">
						<option>전체보기</option>
						<option value="공지사항">공지사항</option>
						<option value="뉴스">뉴스</option>
					</select>
				<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;">
					<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
				</button>
			</form>
		</div>
	</div>
		<br><h2 style="text-align:center;">등록된 게시물이 없습니다.</h2>
</div>
</table>
</div>
</c:if>

<c:if test="${!empty list}">
<div id="table" style="width:auto; margin-left: auto; margin-right: auto;">
<br><br>
<h1>공지사항</h1>
<hr>
<div class="form-inline form-group" >
<a href="${initParam.rootPath}/index.do">
	<button type="button" class="btn btn-default btn-lg"  style="border:0;outline:0;">
			<span class="glyphicon glyphicon-home" aria-hidden="true"></span>
	</button>
</a>
<!-- 관리자만 등록 가능 -->
 <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
 <a href="${initParam.rootPath}/common/admin/boardnotice/boardnotice_form.do">
	 <button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
	 </button>
 </a>
 </sec:authorize>
	<!-- 검색 버튼 -->
	<div style="float:right">
		<div style="float:right">
			<form class="form-inline" action="${initParam.rootPath}/boardnotice/boardNoticeByItems.do" method="post">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<select class="form-control" name="items" id="items">
						<option>전체보기</option>
						<option value="공지사항">공지사항</option>
						<option value="뉴스">뉴스</option>
					</select>
				<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;">
					<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
				</button>
			</form>
		</div>
	</div>
</div>
<table class="table table-hover table-condensed" style="width:auto; border:1; text-align:center;">
<thead>
    <tr>
        <th style="width:5%;text-align:center;">번호</th>
        <th style="width:10%;text-align:center;">말머리</th>
        <th style="width:50%;text-align:center;">제목</th>
        <th style="width:5%;text-align:center;"></th>
        <th style="width:10%;text-align:center;">작성일</th>
        <th style="width:10%;text-align:center;">작성자</th>
    </tr>
 </thead>
<tbody>
<c:forEach var="row" items="${list}" varStatus="status">
    <tr>
        <td>
        	${requestScope.totalCount-((requestScope.pageBean.page -1 ) * 10 + status.index)}
        	<!-- 전체 데이터 수 - ( (현재 페이지 번호 - 1) * 한 페이지당 보여지는 데이터 수 + 현재 게시물 출력 순서 )  ////
        	 count라던지, index 또는 last first등의 접근을 통해 조금더 세밀한 제어를 가능   /// status.index : 0부터의 순서-->
        </td>
        <td>${row.items}</td>
        
        <td style="width:50%;">
    		<form action="${initParam.rootPath}/boardnotice/boardNoticeView.do" method="post">
    			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
    			<input type="hidden" name="id" value="${row.id}">
    			<input type="submit" value="${row.title}" style="background-color:white;border:0;WIDTH:90%;HEIGHT:100%"> 
			</form>           
        </td>
        <td>
        	   <fmt:formatDate value="${row.date}" pattern="yyyy-MM-dd" var="date"/>
    			<c:if test="${today == date }">
					<a class="blink">new</a>
				</c:if>
        </td>
        <td>
            <fmt:formatDate value="${row.date}" pattern="yyyy-MM-dd"/>
        </td>
        <td>관리자</td>
    </tr>    
</c:forEach>
 </tbody>
</table>
<p style="text-align:center">
	<%-- 페이징 처리 --%>
	<!-- 첫페이지로 이동 -->
	<a href="${initParam.rootPath}/boardnotice/boardNoticeList.do?page=1">첫페이지</a>

	<!--
		이전 페이지 그룹 처리.
		만약에 이전페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리.
	 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.previousPageGroup}">
			<%-- 이전페이지 그룹이 있디면 : previousPageGroup()--%>
			<a href="${initParam.rootPath }/boardnotice/boardNoticeList.do?page=${requestScope.pageBean.beginPage - 1}">◀</a>
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
					<a href="${initParam.rootPath}/boardnotice/boardNoticeList.do?page=${page}">&nbsp;${page}&nbsp;</a>
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
			<a href="${initParam.rootPath }/boardnotice/boardNoticeList.do?page=${requestScope.pageBean.endPage + 1}">▶</a>
		</c:when>
		<c:otherwise>
				▶		
		</c:otherwise>
	</c:choose>			
	<!-- 마지막 페이지로 이동 -->
	<a href="${initParam.rootPath}/boardnotice/boardNoticeList.do?page=${requestScope.pageBean.totalPage}">마지막페이지</a>
</p>
</div>
</c:if>

</div>
</body>
</html>