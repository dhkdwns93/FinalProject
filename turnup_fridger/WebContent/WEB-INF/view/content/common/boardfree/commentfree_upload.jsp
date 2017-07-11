<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
/* $(document).ready(function(){
	$("#submit").on("click", function(){
		alert('수정되었습니다');
	});
});


window.onload = function(){
	document.getElementById('memberId').value = opener.document.getElementById('memberId').value;
	document.getElementById('commentFreeId').value = opener.document.getElementById('commentFreeId').value;
	document.getElementById('commentFreeTxt').value = opener.document.getElementById('commentFreeTxt').value;
	document.getElementById('boardFreeId').value = opener.document.getElementById('boardFreeId').value;
	};



function closeWindow(){
	var form = document.upload;
		
	window.opener.name = "opener";
	form.target = "opener";
	form.action = "/turnup_fridger/common/commentfree/commentFreeUploadForm.do";
	form.submit();
	window.opener.location.reload();
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
</style>
</head>
<body>
<h1>자유 게시판 > 댓글 수정</h1><br>
<hr>
<form id="upload" method="post" action="${initParam.rootPath}/common/commentfree/commentFreeUploadForm.do"<%--  onsubmit="closeWindow()" --%>>
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">

<table>
	<tr>
		<th>작성자</th>
		<td><input type="text" name="memberId" id="memberId" readonly value="${commentFree.memberId }"><br></td>
	</tr>
	<tr>
		<th>내용</th>
		<td>
			<textarea name="commentFreeTxt" id="commentFreeTxt" row="120"cols="70">${commentFree.commentFreeTxt}</textarea>
			<span class="error"><form:errors path="commentFree.commentFreeTxt" delimiter="&nbsp;"/>
		</td>
	</tr>
</table>
		<input type="hidden" name="commentFreeId" id="commentFreeId" value="${commentFree.commentFreeId}">
		<input type="hidden" name="boardFreeId" id="boardFreeId" value="${commentFree.boardFreeId}">
		<input id="submit" type="submit" value="수정">
</form>
</body>
</html>



