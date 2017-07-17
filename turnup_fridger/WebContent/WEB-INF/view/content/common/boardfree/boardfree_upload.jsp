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
h1{display:inline}
h2{display:inline}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/view/layout/side_menu/boardSideMenu.jsp"/>
<div id="table" style="width:50%; margin-left: auto; margin-right: auto;">
<br><br>
<h1>자유 게시판 ></h1><h2>${boardFree.memberId}님의 질문 수정</h2><br>
<hr>
<form action="${initParam.rootPath}/common/boardfree/boardFreeUploadForm.do" method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<table>
	<tr>
		<th>작성자</th>
		<td>
			<input class="form-control" style="float:left;width:40%;" type="text" name="memberId" readonly value="${boardFree.memberId}">
		</td>
	</tr>
	<tr>
		<th>제목</th>
		<td>
			<input  class="form-control" type="text" name="boardFreeTitle" value="${boardFree.boardFreeTitle}" placeholder="제목을 입력해주세요">
			<span class="error"><form:errors path="boardFree.boardFreeTitle" delimiter="&nbsp;"/></span>
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td>
			<textarea  class="form-control" name="boardFreeTxt" row="120" cols="70" placeholder="내용을 입력해주세요">${boardFree.boardFreeTxt}</textarea>
			<span class="error"><form:errors path="boardFree.boardFreeTxt" delimiter="&nbsp;"/></span>
		</td>
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
</div>
</body>
</html>