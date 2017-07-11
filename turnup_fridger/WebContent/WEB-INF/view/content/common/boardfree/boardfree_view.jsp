<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
</script>
<script type="text/javascript">

//게시물 삭제
function delete_event(){
	if (confirm("정말 삭제하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardfree/boardfree_list.do";
	}else{   
		//취소
	    return false;
	}
};

//댓글 삭제
function delete_event2(){
	if (confirm("정말 삭제하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardfree/boardfree_view.do";
	}else{   
		//취소
	    return false;
	}
};


//댓글 등록
function insert_event(){
	if (confirm("등록 하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardfree/boardfree_view.do";
	}else{   
		//취소
	    return false;
	}
};

/* 
function popup(frm){
	window.name="opener";
	window.open("/turnup_fridger/common/boardfree/commentfree_upload.do","commentupload","width=500, height=400");

}
 */
</script>
<style type="text/css">
 form{display:inline}
 span, td, th{
	padding: 5px; 
 }
 span.error{
	font-size:small;
	color: red;
 }
</style>

</head>
<body>
<h1>자유 게시판 > ${boardFree.memberId}님의 글</h1><br>
<hr>
<table border="1" style="text-align:center">
	<tr>
		<td>제목</td>
		<td>${boardFree.boardFreeTitle}</td>
	</tr>
	<tr>
		<td>작성날짜</td>
		<td><fmt:formatDate value="${boardFree.date}" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td>${boardFree.memberId}</td>
	</tr>	
	<tr>
		<td>내용</td>
		<td>
			${boardFree.boardFreeTxt}
		</td>	
	</tr>
	<tr>
		<td>조회수</td>
		<td>
			${boardFree.boardFreeHits}
		</td>	
	</tr>
</table>

<!-- 회원 수정폼 -->
 <sec:authorize access="hasRole('ROLE_MEMBER')">
	<form action="${initParam.rootPath}/common/boardfree/boardFreeUploadView.do" method="post">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<input type="hidden" name="boardFreeId" id="boardFreeId" value="${boardFree.boardFreeId}">
		<input type="hidden" name="memberId" value="<sec:authentication property="principal.memberId"></sec:authentication>">
		<input type="hidden" name="writer" value="${boardFree.memberId}">
		<button>수정하기</button>
	</form>
</sec:authorize>


<!-- 회원 권한 폼 -->
<sec:authorize access="hasRole('ROLE_MEMBER')">
<form action="${initParam.rootPath}/common/boardfree/boardFreeRemove.do" method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<input type="hidden" name="boardFreeId" value="${boardFree.boardFreeId}">
	<input type="hidden" name="writer" value="${boardFree.memberId}">	
	<input type="hidden" name="memberId" value="<sec:authentication property="principal.memberId"></sec:authentication>">
	<input type="hidden" name="adminId" value="">
	<input type="submit" value="삭제하기" onclick="return delete_event();">
</form>
</sec:authorize>


<!-- 관리자 권한 폼 -->
<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
<form action="${initParam.rootPath}/common/boardfree/boardFreeRemove.do" method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<input type="hidden" name="boardFreeId" value="${boardFree.boardFreeId}">
	<input type="hidden" name="writer" value="${boardFree.memberId}">
	<input type="hidden" name="adminId" value="<sec:authentication property="principal.adminId"></sec:authentication>">
	<input type="hidden" name="memberId" value="">
	<input type="submit" value="삭제하기" onclick="return delete_event();">
</form>
</sec:authorize>




<form action="${initParam.rootPath}/common/boardfree/boardFreeList.do" method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<input type="submit" value="목록으로"/>
</form>
<hr>

<!-- 댓글 목록 -->
댓글 목록<br>
<c:if test="${empty commentFree}">
 해당 게시물에 댓글이 없습니다.
</c:if>
<c:if test="${!empty commentFree}">
<c:forEach var="list" items="${commentFree}">
<table border="1" style="text-align:center">
<thead id="thead">
    <tr>
        <th>내용</th>
        <th>작성일</th>
        <th>작성자</th>
        <th>수정</th>
        <th>삭제</th>
    </tr>
 </thead>
<tbody id="tbody">
	<tr>
		<td>
			${list.commentFreeTxt}
		</td>
		<td>
			<fmt:formatDate value="${list.commentFreedate}" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
		<td>
			${list.memberId}
		</td>
		<td>
<%-- 			<sec:authorize access="hasRole('ROLE_MEMBER')">
		     	<form name="commentFreeUpload" method="post">
		     	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<input type="hidden" name="commentFreeId" id="commentFreeId" value="${list.commentFreeId}">
					<input type="hidden" name="commentFreeTxt" id="commentFreeTxt" value="${list.commentFreeTxt}">
					<input type="hidden" name="writer" id="writer" value="${list.memberId}">
					<input type="hidden" name="memberId" id="memberId" value="<sec:authentication property="principal.memberId"></sec:authentication>">
					<input type="hidden" name="boardFreeId" id="boardFreeId" value="${list.boardFreeId}">
					<a href="javascript:popup();"><input type="button" value="수정하기"></a>
				</form>	
			</sec:authorize> --%>
			<sec:authorize access="hasRole('ROLE_MEMBER')">
		     	<form  action="${initParam.rootPath}/common/commentfree/commentFreeUploadView.do" method="post">
		     	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<input type="hidden" name="commentFreeId" id="commentFreeId" value="${list.commentFreeId}">
					<input type="hidden" name="commentFreeTxt" id="commentFreeTxt" value="${list.commentFreeTxt}">
					<input type="hidden" name="writer" id="writer" value="${list.memberId}">
					<input type="hidden" name="memberId" id="memberId" value="<sec:authentication property="principal.memberId"></sec:authentication>">
					<input type="hidden" name="boardFreeId" id="boardFreeId" value="${list.boardFreeId}">
					<input type="submit" value="수정하기"></a>
				</form>	
			</sec:authorize> 
			
		</td>
		
		<td>
			<!-- 회원 권한 폼 -->
			<sec:authorize access="hasRole('ROLE_MEMBER')">
		     <form action="${initParam.rootPath}/common/commentfree/commentFreeRemove.do" method="post">
		     <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<input type="hidden" name="commentFreeId" value="${list.commentFreeId}">
				<input type="hidden" name="boardFreeId" value="${list.boardFreeId}">
				<input type="hidden" name="writer" value="${list.memberId}">
				<input type="hidden" name="memberId" value="<sec:authentication property="principal.memberId"/>">
				<input type="hidden" name="adminId" value="">
				<input type="submit" value="삭제하기" onclick="return delete_event2();">
			 </form>
			 </sec:authorize>
			
			<!-- 관리자 권한 폼 -->
			<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
		     <form action="${initParam.rootPath}/common/commentfree/commentFreeRemove.do" method="post">
		     <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<input type="hidden" name="commentFreeId" value="${list.commentFreeId}">
				<input type="hidden" name="boardFreeId" value="${list.boardFreeId}">
				<input type="hidden" name="writer" value="${list.memberId}">
				<input type="hidden" name="memberId" value="">
				<input type="hidden" name="adminId" value="<sec:authentication property="principal.adminId"/>">
				<input type="submit" value="삭제하기" onclick="return delete_event2();">
			 </form>			
			</sec:authorize>
		</td>
	</tr>   
 </tbody>
</table>	
</c:forEach>
<p>
	<%-- ######################################################
														페이징 처리
			###################################################### --%>
	<!-- 첫페이지로 이동 -->
	<a href="${initParam.rootPath}/common/boardfree/boardFreeView.do?page=1&boardFreeId=${requestScope.boardFreeId}">첫페이지</a>

	<!--
		이전 페이지 그룹 처리.
		만약에 이전페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리.
	 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.previousPageGroup}">
			<%-- 이전페이지 그룹이 있디면 : previousPageGroup()--%>
			<a href="${initParam.rootPath }/common/boardfree/boardFreeView.do?page=${requestScope.pageBean.beginPage - 1}&boardFreeId=${requestScope.boardFreeId}">☜</a>
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
					<a href="${initParam.rootPath}/common/boardfree/boardFreeView.do?page=${page}&boardFreeId=${requestScope.boardFreeId}">&nbsp;${page}&nbsp;</a>
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
			<a href="${initParam.rootPath }/common/boardfree/boardFreeView.do?page=${requestScope.pageBean.endPage + 1}&boardFreeId=${requestScope.boardFreeId}">☞</a>
		</c:when>
		<c:otherwise>
				☞		
		</c:otherwise>
	</c:choose>			
	

	<!-- 마지막 페이지로 이동 -->
	<a href="${initParam.rootPath}/common/boardfree/boardFreeView.do?page=${requestScope.pageBean.totalPage}&boardFreeId=${requestScope.boardFreeId}">마지막페이지</a>
</p>
</c:if>



 <sec:authorize access="hasRole('ROLE_MEMBER')">
<hr>
댓글작성
<form action="${initParam.rootPath}/common/commentfree/commentFreeAdd.do" method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<table border="1" style="text-align:center">
<thead id="thead">
    <tr>
        <th>내용</th>
        <th>작성자</th>
    </tr>
 </thead>
<tbody id="tbody">
	<tr>
		<td><textarea name="commentFreeTxt" row="120" cols="70" placeholder="내용을 입력해주세요"></textarea><span class="error"><form:errors path="list.commentFreeTxt" delimiter="&nbsp;"/></td>
		<td><input type="text" name="memberId" readonly value="<sec:authentication property="principal.memberId"></sec:authentication>"></td>
	</tr>   
 </tbody>
</table>
<input type="hidden" name="boardFreeId" value="${boardFree.boardFreeId}">
<input type="submit" value="등록하기" onclick="insert_event();">
</form>
</sec:authorize>

</body>
</html>