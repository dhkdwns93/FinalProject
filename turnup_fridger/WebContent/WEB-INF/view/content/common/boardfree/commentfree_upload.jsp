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
//글자수 확인
function checkLength(commentFreeTxt) {
    if (commentFreeTxt.value.length > 100 ) {
    	commentFreeTxt.blur();
    	commentFreeTxt.value = commentFreeTxt.value.substring(0, 100);
        alert('더 이상 입력이 불가능 합니다.');
        commentFreeTxt.focus();
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
th{
	width:10%;
}
td{
	width:70%;
}
.textarea_test {
    resize:none;
    line-height:30px;
    width:100%;
    overflow-y:hidden;
    height:100%;
}
</style>
</head>
<body>

<div class="container">
<jsp:include page="/WEB-INF/view/layout/side_menu/boardSideMenu.jsp"/>
	<div id="table" style="width:50%; margin-left: auto; margin-right: auto;">
	<br><br>
	<h1>자유 게시판 ></h1><h2>${commentFree.memberId }님의 댓글 수정</h2><br>
	<hr>
		<form id="upload" method="post" action="${initParam.rootPath}/common/commentfree/commentFreeUploadForm.do"<%--  onsubmit="closeWindow()" --%>>
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<table style="width:100%;">
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" class="form-control" style="float:left;width:40%;" name="memberId" id="memberId" readonly value="${commentFree.memberId }">
					<br><br>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea class="form-control textarea_test" style="float:left;width:100%;" onkeyup="checkLength(this); this.style.height='100%'; this.style.height = this.scrollHeight + 'px';"
					name="commentFreeTxt" id="commentFreeTxt" rows="10" cols="60" placeholder="내용을 입력해주세요" wrap="physical">${commentFree.commentFreeTxt}</textarea>
					<span class="error"><form:errors path="commentFree.commentFreeTxt" delimiter="&nbsp;"/></span>
				</td>
			</tr>
		</table>
		<%-- 수정 확인 버튼 --%>
				<input type="hidden" name="commentFreeId" id="commentFreeId" value="${commentFree.commentFreeId}">
				<input type="hidden" name="boardFreeId" id="boardFreeId" value="${commentFree.boardFreeId}">
				<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return comment_update_event();">
					<span class="glyphicon glyphicon-ok" aria-hidden="true"></span>
				</button>
		</form>
		<%-- 뒤로가기 버튼 --%>
		<form action="${initParam.rootPath}/common/boardfree/boardFreeView.do" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		        <input type="hidden" name="member" value=""> 
		        <input type="hidden" name="admin" value="">
		        <input type="hidden" name="memberId" value="${commentFree.memberId}">
		        <input type="hidden" name="boardFreeId" value="${commentFree.boardFreeId}">
				<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
					<span class="glyphicon glyphicon-arrow-left" aria-hidden="true"></span>
				</button>
		</form> 
	</div>
</div>
</body>
</html>



