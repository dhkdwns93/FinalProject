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
//댓글 수정
function comment_update_event(){
	
	if (confirm("수정 하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardfree/boardfree_view.do";
	}else{   
		//취소
	    return false;
	}
}; 
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
form{display:inline}
 span, td, th{
	padding: 5px; 
 }
 span.error{
	font-size:small;
	color: red;
 }
 h1{display:inline}
h2{display:inline}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/view/layout/side_menu/boardSideMenu.jsp"/>
<div id="table" style="width:50%; margin-left: auto; margin-right: auto;">
<br><br>
<h1>자유 게시판 ></h1><h2>${commentFree.memberId }님의 댓글 수정</h2><br>
<hr>
<form id="upload" method="post" action="${initParam.rootPath}/common/commentfree/commentFreeUploadForm.do"<%--  onsubmit="closeWindow()" --%>>
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">

<table>
	<tr>
		<th>작성자</th>
		<td><input type="text" class="form-control" style="float:left;width:40%;" name="memberId" id="memberId" readonly value="${commentFree.memberId }"><br></td>
	</tr>
	<tr>
		<th>내용</th>
		<td>
			<textarea class="form-control" name="commentFreeTxt" id="commentFreeTxt" row="120"cols="70">${commentFree.commentFreeTxt}</textarea>
			<span class="error"><form:errors path="commentFree.commentFreeTxt" delimiter="&nbsp;"/></span>
		</td>
	</tr>
</table>
		<input type="hidden" name="commentFreeId" id="commentFreeId" value="${commentFree.commentFreeId}">
		<input type="hidden" name="boardFreeId" id="boardFreeId" value="${commentFree.boardFreeId}">
		<input id="submit" type="submit" value="수정"  onclick="return comment_update_event();">
</form>
<form action="${initParam.rootPath}/common/boardfree/boardFreeView.do" method="post">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
        <input type="hidden" name="member" value=""> 
        <input type="hidden" name="admin" value="">
        <input type="hidden" name="memberId" value="${commentFree.memberId}">
<button value="${commentFree.boardFreeId}" name="boardFreeId">뒤로가기</button>
</form> 
</div>
</body>
</html>



