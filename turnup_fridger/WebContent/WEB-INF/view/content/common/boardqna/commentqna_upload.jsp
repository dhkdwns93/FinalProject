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
$(document).ready(function(){
	$("#submit").on("click", function(){
		alert('수정되었습니다');
	});
});


window.onload = function(){
	document.getElementById('memberId').value = opener.document.getElementById('memberId').value;
	document.getElementById('commentQnATxt').value = opener.document.getElementById('commentQnATxt').value;
	document.getElementById('boardQnAId').value = opener.document.getElementById('boardQnAId').value;
	document.getElementById('commentQnAId').value = opener.document.getElementById('commentQnAId').value;
	};



function closeWindow(){
	var form = document.upload;
		
	window.opener.name = "opener";
	form.target = "opener";
	form.action = "/turnup_fridger/common/commentqna/commentQnAUploadForm.do";
	form.submit();
	window.opener.location.reload();
	self.close();
};
</script>
</head>
<body>
<form id="upload" method="post" action="${initParam.rootPath}/common/commentqna/commentQnAUploadForm.do" onsubmit="closeWindow()">
	<table border="1">
		<tr>
			<td>
				<input type="text" name="memberId" id="memberId"><br>
				<textarea name="commentQnATxt" id="commentQnATxt" row="120"cols="70"></textarea>
			</td>
		</tr>
	</table>
		<input type="hidden" name="commentQnAId" id="commentQnAId">
		<input type="hidden" name="boardQnAId" id="boardQnAId">
		<input id="submit" type="submit" value="수정">
<sec:csrfInput/>
</form>
</body>
</html>



