<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%
	request.setAttribute("date", new Date());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${initParam.rootPath}/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#submit").on("click", function(){
		alert('등록되었습니다');
	});
});
</script>
<style type="text/css">
@CHARSET "UTF-8";

@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

body {
	background: url('${initParam.rootPath}/img/note.jpg') no-repeat center;
	background-size: cover;
	color: white;
}

div {
	font-size: 30px;
	text-align: right;
	font-family: 'Nanum Pen Script', serif;
	color: white;
}

table {
	align: center;
	text-align: center;
}

.error{
	color: red;
	background-color: #FFFFFF;
	background: rgba(255, 255, 255, 0.5);
	font-size: 12px;
	text-align: right;
}
</style>
</head>
<body>
	<div>
		<fmt:formatDate value="${requestScope.date }" pattern="yyyy년 MM월 dd일" />자 장바구니 메모
	</div>
	<span id="error"><c:if test="${requestScope.error != null }">${requestScope.error }</c:if></span>
	<form action="${initParam.rootPath}/memo/addMemo.do" method="post">
	
		<table>
			<tr>
				<td><span class="error"><form:errors path="myMemo.memoName" /></span><br>
				<input type="text" name="memoName" size="50" style="background-color: transparent"></td>
			</tr>
			<tr>
				<td><span class="error"><form:errors path="myMemo.memoTxt" /></span><br>
				<textarea rows="21" cols="51" name="memoTxt" style="background-color: transparent"></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<sec:authentication property="principal.memberId" var="mid" />
					<input type="hidden" name="memberId" value="${mid}">
					<input type="submit" id="submit" value="저장">
				</td>
			</tr>
		</table>
		<sec:csrfInput/>
	</form>
</body>
</html>