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
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
@CHARSET "UTF-8";
@import url('https://fonts.googleapis.com/css?family=Julius+Sans+One|Coming+Soon|Philosopher|Kalam|Handlee|Kite+One');
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

body {
	background: url('${initParam.rootPath}/img/note-new.jpg') no-repeat center;
	background-size: cover;
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
	margin-left: auto;
	margin-right: auto;
}

.error{
	color: red;
	background-color: #FFFFFF;
	background: rgba(255, 255, 255, 0.5);
	font-size: 12px;
	text-align: right;
}

#submit{
	font-family: 'Kite One', sans-serif;
	font-size: 15px;
}
#memoName, #memoTxt{
	font-size: 18px;
}
</style>
</head>
<body>
	<div id="memoDate">
		<fmt:formatDate value="${requestScope.date }" pattern="yyyy년 MM월 dd일" />자 장바구니 메모
	</div>
	<form action="${initParam.rootPath}/memo/addMemo.do" method="post">
		<sec:csrfInput/>
		<table>
			<tr>
				<td><span class="error"><form:errors path="myMemo.memoName" /></span><br>
				<input type="text" id="memoName" class="form-control" name="memoName" value="${param.memoName}" size="41" style="background-color: transparent; color:black;"></td>
			</tr>
			<tr>
				<td><span class="error"><form:errors path="myMemo.memoTxt" /></span><br>
				<textarea rows="12" cols="43" id="memoTxt" class="form-control" name="memoTxt" style="background-color: transparent; color:black;">${param.memoTxt}</textarea>
				</td>
			</tr>
			<tr>
				<td>
					<sec:authentication property="principal.memberId" var="mid" />
					<input type="hidden" name="memberId" value="${mid}">
					<button type="submit" id="submit" class="btn btn-default btn-md"  style="border:0;outline:0;">
					<span class="glyphicon glyphicon-ok" aria-hidden="true"></span></button>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>