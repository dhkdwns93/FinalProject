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
<h1>QnA 게시판 ></h1><h2>질문 등록</h2><br>
<hr>
<form action="${initParam.rootPath}/common/boardqna/boardQnAAdd.do" method="POST">
<table>
	<tr>
		<th>작성자</th>
		<td><input class="form-control" style="float:left;width:40%;" type="text" name="memberId" readonly value="<sec:authentication property="principal.memberId"></sec:authentication>"></td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input class="form-control" type="text" name="boardQnATitle" value="${boardQnA.boardQnATitle}" placeholder="제목을 입력해주세요">
			<span class="error"><form:errors path="boardQnA.boardQnATitle" delimiter="&nbsp;"/></span>
		</td>
	</tr>
	<tr>
		<th>내용</th>
		<td>
			<textarea class="form-control" name="boardQnATxt" row="120" cols="70" placeholder="내용을 입력해주세요">${boardQnA.boardQnATxt}</textarea>
			<span class="error"><form:errors path="boardQnA.boardQnATxt" delimiter="&nbsp;"/></span>
		</td>
	</tr>	
</table>
<input type="submit" value="등록" onclick="return insert_event();">
<sec:csrfInput/>
</form>
<form action="${initParam.rootPath}/common/boardqna/boardQnAList.do" method="POST">
	<input type="submit" value="뒤로가기">
	<sec:csrfInput/>
</form>
</div>
</body>
</html>