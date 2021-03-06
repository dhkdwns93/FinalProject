<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" 

href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>


<script type="text/javascript" src="/turnup_fridger2/scripts/jquery.js"></script>
<script type="text/javascript">
function upload_event(){
	if (confirm("수정 하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardqna/boardqna_view.do";
	}else{   
		//취소
	    return false;
	}
};
//댓글 수 확인
function checkLength(boardQnATxt) {
    if (boardQnATxt.value.length > 1000 ) {
    	boardQnATxt.blur();
    	boardQnATxt.value = boardQnATxt.value.substring(0, 1000);
        alert('더 이상 입력이 불가능 합니다.');
        boardQnATxt.focus();
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
/* input 정렬 */
input {
   vertical-align:middle;  
}
.textarea_test {
    resize:none;
    line-height:30px;
    width:100%;
    overflow-y:hidden;
    height:100%;
}
th{
	width:10%;
}
td{
	width:70%;
}
</style>
</head>
<body>
<div class="container">
<jsp:include page="/WEB-INF/view/layout/side_menu/boardSideMenu.jsp"/>
	<div id="table" style="width:50%; margin-left: auto; margin-right: auto;">
	<br><br>
	<h1>QnA 게시판 ></h1><h2> ${boardQnA.memberId}님의 질문 수정</h2><br>
	<hr>
	<form action="${initParam.rootPath}/common/boardqna/boardQnAUploadForm.do" method="POST">
	<input type="hidden" name="boardQnAId" value="${boardQnA.boardQnAId}">
	<table style="width:100%;">
		<tr>
			<th>작성자</th>
			<td>
				<input type="text" class="form-control" style="float:left;width:40%;" name="memberId" readonly value="${boardQnA.memberId}">
				<br><br>
			</td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type="text" class="form-control" style="float:left;width:50%;"  name="boardQnATitle" value="${boardQnA.boardQnATitle}" readonly>
				<br><br>
			</td>
		
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea class="form-control textarea_test" style="float:left;width:100%;" onkeyup="checkLength(this); this.style.height='100%'; this.style.height = this.scrollHeight + 'px';"
				id="boardQnATxt" name="boardQnATxt" rows="20" cols="60" placeholder="내용을 입력해주세요" wrap="physical">${boardQnA.boardQnATxt}</textarea>
				<span class="error"><form:errors path="boardQnA.boardQnATxt" delimiter="&nbsp;"/></span>
			</td>
		</tr>	
	</table>
		<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return upload_event();">
			<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
		</button>
	<sec:csrfInput/>
	</form>
	<form name="form" action="${initParam.rootPath}/common/boardqna/boardQnAView.do" method="post">
	        <sec:authorize access="hasRole('ROLE_MEMBER')">
	        	<input type="hidden" id="member" name="member" value="<sec:authentication property="principal.memberId"></sec:authentication>"> 
	        	<input type="hidden"  name="admin" value="">
	        	<input type="hidden" id="memberId" name="memberId" value="${boardQnA.memberId}">
	        	<input type="hidden" id="boardQnAId" name="boardQnAId" value="${boardQnA.boardQnAId}">
				<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
					<span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
				</button>
			</sec:authorize>
		<sec:csrfInput/>
	</form>
	</div>
</div>
</body>
</html>