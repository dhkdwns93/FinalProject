<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<style type="text/css">
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
<h1>공지사항</h1><br>
<table class="table table-hover table-condensed" style="width:100%; border:1; text-align:center;">
	<a href="${initParam.rootPath}/index.do"><button style="text-align:right">홈으로</button></a>
	
	<!-- 검색 버튼 -->
	<div style="float:right">
	<form action="${initParam.rootPath}/boardnotice/boardNoticeByItems.do" method="post">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<select name="items" id="items" value="${requestScope.items}">
				<option value="전체보기">전체보기</option>
				<option value="공지사항" >공지사항</option>
				<option value="뉴스" >뉴스</option>
			</select>
		<input type="submit" value="검색"/>
	</form>
	</div>
<thead>
    <tr style="text-align:center;">
        <th>번호</th>
        <th>말머리</th>
        <th>제목</th>
        <th>작성일</th>
        <th>작성자</th>
    </tr>
 </thead>
<tbody>
<c:forEach var="row" items="${list}">
    <tr>
        <td>${row.id}</td>
        <td>${row.items}</td>
        
        <td>
    		<form action="${initParam.rootPath}/boardnotice/boardNoticeView.do" method="post">
    			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
    			<input type="hidden" name="id" value="${row.id}">
    			<input type="submit" value="${row.title}" style="background-color:white;border:0;WIDTH: 400pt; HEIGHT: 15pt"> 
			</form>           
        </td>
        <td>
            <fmt:formatDate value="${row.date}" pattern="yyyy-MM-dd"/>
        </td>
        <td>관리자</td>
    </tr>    
</c:forEach>
 </tbody>
</table>
<!-- 관리자만 등록 가능 -->
 <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
 	<a href="${initParam.rootPath}/common/admin/boardnotice/boardnotice_form.do"><button>등록</button></a>
 </sec:authorize>
</div>
<p style="text-align:center">
	<%-- ######################################################
														페이징 처리
			###################################################### --%>
	<!-- 첫페이지로 이동 -->
	<a href="${initParam.rootPath}/boardnotice/boardNoticeList.do?page=1">첫페이지</a>

	<!--
		이전 페이지 그룹 처리.
		만약에 이전페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리.
	 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.previousPageGroup}">
			<%-- 이전페이지 그룹이 있디면 : previousPageGroup()--%>
			<a href="${initParam.rootPath }/boardnotice/boardNoticeList.do?page=${requestScope.pageBean.beginPage - 1}">☜</a>
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
			<a href="${initParam.rootPath }/boardnotice/boardNoticeList.do?page=${requestScope.pageBean.endPage + 1}">☞</a>
		</c:when>
		<c:otherwise>
				☞		
		</c:otherwise>
	</c:choose>			
	
	
	
	
	
	
	
	<!-- 마지막 페이지로 이동 -->
	<a href="${initParam.rootPath}/boardnotice/boardNoticeList.do?page=${requestScope.pageBean.totalPage}">마지막페이지</a>



</p>
</body>
</html>