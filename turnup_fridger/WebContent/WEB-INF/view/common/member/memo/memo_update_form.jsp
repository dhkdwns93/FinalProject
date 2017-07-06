<%@page import="kr.co.turnup_fridger.vo.MyMemo"%>
<%@page import="java.util.Date"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<% request.setAttribute("date", new Date()); %>
<% request.setAttribute("memo", new MyMemo(27, "야식", "떡볶이, 피자ㄷㄷㄷ", "shh", new Date(117,06,05))); %>

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
	}
	
table{
	align: center;
	text-align: center;
	color: white;
}

.error{
	color: red;
	font-size: 12px;
	text-align: center;
}
</style>
</head>
<body>
<div><fmt:formatDate value="${requestScope.date }" pattern="yyyy년 MM월 dd일"/> 자 장바구니 메모</div><br>
<form action="${initParam.rootPath}/memo/modMemo.do" method="post">
<span class="error"><form:errors path="memo.memoTxt"/>
	<c:if test="${requestScope.error != null }">${requestScope.error }</c:if>
</span>
	<table align="center">
		<tr>
			<td><input type="text" name="memoName" style="background-color: transparent" placeholder="${requestScope.memo.memoName }" size="50"></td>
		</tr>
		<tr><!-- rows : 세로  cols : 가로 -->
			<td><textarea rows="21" cols="51" name="memoTxt" style="background-color: transparent" placeholder="${requestScope.memo.memoTxt}"></textarea></td>
		</tr>
		<tr>
			<td><input type="submit" value="수정">
				<input type="hidden" name="memberId" value="${requestScope. }">
				<input type="hidden" name="memoId" value="">
				<input type="hidden" name="registeredDate" value="">
			</td>
		</tr>
	</table><sec:csrfInput/>
</form>
</body>
</html>