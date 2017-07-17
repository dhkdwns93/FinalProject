<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger2/scripts/jquery.js"></script>
<script type="text/javascript">
function insert_event(){
	if (confirm("등록 하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardqna/boardqna_view.do";
	}else{   
		//취소
	    return false;
	}
};
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
<h1>QnA 게시판 ></h1><h2>${boardQnA.memberId}님의 질문 수정</h2><br>
<hr>
<form action="${initParam.rootPath}/common/boardqna/boardQnAAdd.do" method="POST">
<input type="hidden" name="boardQnAId" value="${boardQnA.boardQnAId}">
<table>
	<tr>
		<th>작성자</th>
		<td><input type="text" class="form-control" style="float:left;width:40%;" name="memberId" readonly value="${boardQnA.memberId}"></td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" class="form-control"  name="boardQnATitle" value="${boardQnA.boardQnATitle}" placeholder="제목을 입력해주세요"><span class="error"><form:errors path="boardQnA.boardQnATitle" delimiter="&nbsp;"/></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea class="form-control"  name="boardQnATxt" row="120" cols="70" placeholder="내용을 입력해주세요">${boardQnA.boardQnATxt}</textarea><span class="error"><form:errors path="boardQnA.boardQnATxt" delimiter="&nbsp;"/></td>
	</tr>	
</table>
	<input type="submit" value="수정" onclick="return insert_event();">
<sec:csrfInput/>
</form>
<form name="form" action="${initParam.rootPath}/common/boardqna/boardQnAView.do" method="post">
        <sec:authorize access="hasRole('ROLE_MEMBER')">
        	<input type="hidden" id="member" name="member" value="<sec:authentication property="principal.memberId"></sec:authentication>"> 
        	<input type="hidden"  name="admin" value="">
        	<input type="hidden" id="memberId" name="memberId" value="${boardQnA.memberId}">
        	<input type="hidden" id="boardQnAId" name="boardQnAId" value="${boardQnA.boardQnAId}">
			<input type="submit" value="뒤로가기">
		</sec:authorize>
	<sec:csrfInput/>
</form>
</body>
</html>