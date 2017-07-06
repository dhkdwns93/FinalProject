<%@page import="java.util.Date"%>
<%@page import="kr.co.turnup_fridger.vo.MyMemo"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${initParam.rootPath}/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#del").on("click", function(){
		if(confirm('정말 삭제하시겠습니까?')){
			return true;
		}
		return false;
	});
	
});
</script> 
<style type="text/css">
@CHARSET "UTF-8";
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

body{
	background: url('${initParam.rootPath}/img/note.jpg') no-repeat center;
	background-size: cover;
}

#title{
	font-size: 30px;
	text-align: right;
	font-family: 'Nanum Pen Script', serif;
	color: white;
	}
	
table{
	align: center;
	text-align: center;
}
</style>
</head>
<body>
<fmt:formatDate value="${requestScope.memo.registeredDate }" pattern="yyyy년 MM월 dd일"/>의 메모
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span id="title">${requestScope.memo.memoName }</span>

<div id="title"></div>
<hr><br>
<table border="1" style="border-collapse:collapse; text-align:center;" align="center">
		<tr height="360" width="400"><!-- rows : 세로  cols : 가로 -->
			<td colspan="2">${requestScope.memo.memoTxt }</td>
		</tr>
		<tr>
			<td><a href="${initParam.rootPath}/common/member/memo/memo_update_form.do"><button type="button" id="mod">수정</button></a></td>
			<td><a href="${initParam.rootPath}/memo/delMemo.do?memoId=${requestScope.memo.memoId}"><button type="button" id="del">삭제</button></a></td>
		</tr>
</table>
</body>
</html>