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
</style>
</head>
<body>
<h1>QnA 게시판 > ${boardQnA.memberId}님의 질문 수정</h1><br>
<hr>
<form action="${initParam.rootPath}/common/boardqna/boardQnAUploadForm.do" method="post">
<input type="hidden" name="boardQnAId" value="${boardQnA.boardQnAId}">
<table>
	<tr>
		<th>작성자</th>
		<td><input type="text" name="memberId" value="${boardQnA.memberId}"></td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="boardQnATitle" value="${boardQnA.boardQnATitle}" placeholder="제목을 입력해주세요"><span class="error"><form:errors path="boardQnA.boardQnATitle" delimiter="&nbsp;"/></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea name="boardQnATxt" row="120" cols="70" placeholder="내용을 입력해주세요">${boardQnA.boardQnATxt}</textarea><span class="error"><form:errors path="boardQnA.boardQnATxt" delimiter="&nbsp;"/></td>
	</tr>	
	<tr>
		<td>
			<input type="submit" value="수정" onclick="return insert_event();">
		</td>
	</tr>
</table>
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