<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
function insert_event(){
	if (confirm("등록 하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardfree/boardfree_view.do";
	}else{   
		//취소
	    return false;
	}
};
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
</style>
</head>
<body>
<h1>게시물 수정</h1><br>
<hr>
<form action="${initParam.rootPath}/common/boardfree/boardFreeUploadForm.do" method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">

<table>
	<tr>
		<th>작성자</th>
		<td><input type="text" name="memberId" value="${boardFree.memberId}"></td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="boardFreeTitle" value="${boardFree.boardFreeTitle}" placeholder="제목을 입력해주세요"><span class="error"><form:errors path="boardFree.boardFreeTitle" delimiter="&nbsp;"/></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea name="boardFreeTxt" row="120" cols="70" placeholder="내용을 입력해주세요">${boardFree.boardFreeTxt}</textarea><span class="error"><form:errors path="boardFree.boardFreeTxt" delimiter="&nbsp;"/></td>
	</tr>	
</table>
			<input type="hidden" name="boardFreeId" value="${boardFree.boardFreeId}">
			<input type="hidden" name="boardFreeHits" value="${boardFree.boardFreeHits}">
			<input type="submit" value="수정" onclick="return insert_event();">
</form>
<form action="${initParam.rootPath}/common/boardfree/boardFreeView.do" method="post">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
        <input type="hidden" name="member" value=""> 
        <input type="hidden" name="admin" value="">
        <input type="hidden" name="memberId" value="${boardFree.memberId}">
<button value="${boardFree.boardFreeId}" name="boardFreeId">뒤로가기</button>
</form>    
</body>
</html>