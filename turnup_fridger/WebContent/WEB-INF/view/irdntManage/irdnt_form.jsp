<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2>재료 등록</h2>

<form action="/turnup_fridger/irdntManage/createIrdnt.do" method="post">
<table>
	<tr>
		<th>재료ID</th>
		<td><input type="text" name="irdntId" value="${param.irdntId}"><span class="error"><form:errors path="irdnt.irdntId" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>재료명</th>
		<td><input type="text" name="irdntName" value="${param.irdntName}"><span class="error"><form:errors path="irdnt.irdntName" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관기간</th>
		<td><input type="text" name="irdntPeriod" value="${param.irdntPeriod}"><span class="error"><form:errors path="irdnt.irdntPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="등록하기">
		</td>
	</tr>
</table>
</form>


</body>
</html>