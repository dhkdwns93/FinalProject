<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setAttribute("date", new Date()); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/ttFridger/js/jquery-3.2.1.js"></script>
<style type="text/css">
@CHARSET "UTF-8";
@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);

body{
	background: url('${initParam.rootPath}/img/note.jpg') no-repeat center;
	background-size: cover;
}

div{
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
<div><fmt:formatDate value="${requestScope.date }" pattern="yyyy년 MM월 dd일"/> 자 장바구니 메모</div><br>
<form action="${initParam.rootPath}/memo/addMemo.do" method="post">
<span class="error"><form:errors path="memo.memoTxt"/>
	<c:if test="${requestScope.error != null }">${requestScope.error }</c:if>
</span>
	<table align="center">
		<tr>
			<td><input type="text" name="memoName" placeholder="${requestScope.date }" size="50"  style="background-color: transparent"></td>
		</tr>
		<tr><!-- rows : 세로  cols : 가로 -->
			<td><textarea rows="21" cols="51" name="memoTxt" style="background-color: transparent"></textarea></td>
		</tr>
		<tr>
			<td><input type="submit" value="저장">
			<sec:authentication property="principal.memberId"></sec:authentication>
			</td>
		</tr>
	</table>
	<sec:csrfInput/>
</form>
</body>
</html>