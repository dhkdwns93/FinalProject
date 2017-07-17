<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
/* 
window.onload = function(){
	document.getElementById('memberId').value = opener.document.getElementById('memberId').value;
	document.getElementById('commentQnATxt').value = opener.document.getElementById('commentQnATxt').value;
	document.getElementById('boardQnAId').value = opener.document.getElementById('boardQnAId').value;
	document.getElementById('commentQnAId').value = opener.document.getElementById('commentQnAId').value;
	};



function closeWindow(){
	window.opener.name = "parentPage";
	document.upload.target = "parentPage";
	document.upload.action = "/turnup_fridger/common/commentqna/commentQnAUploadForm.do";
	document.upload.submit();
	opener.location.reload();
	self.close();
}; */
</script>
<style type="text/css">
span, td, th{
	padding: 5px; 
}
span.error{
	font-size:small;
	color: red;
}
form{display:inline}
h1{display:inline}
h2{display:inline}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/view/layout/side_menu/boardSideMenu.jsp"/>
<div id="table" style="width:50%; margin-left: auto; margin-right: auto;">
<br><br>
<h1>QnA 게시판 ></h1>
				<c:if test="${commentQnA.memberId != null}">
					<h2>${boardFree.memberId}님의 댓글 수정</h2>
				</c:if>
				<c:if test="${commentQnA.adminId != null}">
					<h2>${boardFree.adminId}님의 댓글 수정</h2>
				</c:if>
<hr>
<form id="upload" method="post" action="${initParam.rootPath}/common/commentqna/commentQnAUploadForm.do" <%-- onsubmit="closeWindow()" --%>>
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<table>
		<tr>
			<th>작성자</th>
			<th>				
				<c:if test="${commentQnA.memberId != null}">
					<input type="text" name="memberId" id="memberId" readonly value="${commentQnA.memberId}"><br>
				</c:if>
				<c:if test="${commentQnA.adminId != null}">
					<input type="text" name="adminId" id="adminId" readonly value="${commentQnA.adminId}"><br>
				</c:if>
			</th>
		</tr>
		<tr>	
			<td>	
				내용
			</td>
			<td>
				<textarea name="commentQnATxt" id="commentQnATxt" row="120"cols="70">${commentQnA.commentQnATxt}</textarea>
				<span class="error"><form:errors path="commentQnA.commentQnATxt" delimiter="&nbsp;"/>	
			</td>
		</tr>
	</table>
		<input type="hidden" name="commentQnAId" id="commentQnAId" value="${commentQnA.commentQnAId}">
		<input type="hidden" name="boardQnAId" id="boardQnAId" value="${commentQnA.boardQnAId}">
		<input id="submit" type="submit" value="수정">
</form>
        <form name="form" action="${initParam.rootPath}/common/boardqna/boardQnAView.do" method="post">
        	<!-- 회원일때 보여줌 -->
        	<sec:authorize access="hasRole('ROLE_MEMBER')">
        		<input type="hidden" id="member" name="member" value="<sec:authentication property="principal.memberId"></sec:authentication>"> 
        		<input type="hidden"  name="admin" value="">
        		<input type="hidden" id="memberId" name="memberId" value="${commentQnA.memberId}">
        		<input type="hidden" id="boardQnAId" name="boardQnAId" value="${commentQnA.boardQnAId}">
 				<input id="submit" type="submit" value="뒤로가기">
			</sec:authorize>
        
     		<!-- 관리자일때 보여줌 -->	
     		<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
				<input type="hidden" name="admin" value="<sec:authentication property="principal.adminId"></sec:authentication>"> 
				<input type="hidden" name="member" value="">
				<input type="hidden" name="memberId" value="${commentQnA.memberId}">
				<input type="hidden" id="boardQnAId" name="boardQnAId" value="${commentQnA.boardQnAId}">
				<input id="submit" type="submit" value="뒤로가기">
			</sec:authorize>
			<sec:csrfInput/>
		</form>
</body>
</html>



