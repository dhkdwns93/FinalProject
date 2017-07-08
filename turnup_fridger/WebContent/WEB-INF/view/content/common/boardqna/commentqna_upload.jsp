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
function upload_event(){
	if (confirm("등록 하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/common/boardqna/boardqna_view.do";
	}else{   
		//취소
	    return false;
	}
};

window.onload = function(){
	var x = opener.document.getElementById('form').value;
	document.getElementById('form').value = x;
};

</script>
</head>
<body>
<form name="form" id="form" action="${initParam.rootPath}/common/commentqna/boardQnAUploadForm.do" method="post" >

	<table border="1">
		<tr>
			<td>
				<input type="text" name="memberId" id="memberId"value="${commentQnA.memberId}"><br>
				<textarea name="commentQnATxt" id="commentQnATxt" row="120"cols="70" placeholder="내용을 입력해주세요">${commentQnA.commentQnATxt}</textarea>
			</td>
		</tr>
	</table>
		<input type="hidden" name="commentQnAId" id="commentQnAId" value="${commentQnA.commentQnAId}">
		<input type="hidden" name="boardQnAId" id="boardQnAId" value="${commentQnA.boardQnAId}">
		<input type="submit" value="수정" onclick="return upload_event();">
		<sec:csrfInput/>	
</form>
</body>
</html>



