<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="kr.co.turnup_fridger.vo.MyMemo"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table border="1" style="border-collapse:collapse; text-align:center;" align="center" width="350">
<thead>
<tr>
	<td>작성일</td>
	<td>제목</td>
</tr>
</thead>
<tbody>
<c:forEach items="${requestScope.list }" var="memo">
	<tr>
		<td><fmt:formatDate value="${memo.registeredDate }" pattern="yyyy년 MM월 dd일"/></td>
		<td><a href="#" onClick="window.open('${initParam.rootPath}/memo/findOneMemo.do?${memo.memoId }','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=450px, height=430px ,top=10, left=10', bottom=10, right=10)">${memo.memoName}</a></td>
	</tr>
</c:forEach>
</tbody>
</table>
</body>
</html>