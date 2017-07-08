<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2>재료 등록</h2>

<form action="/turnup_fridger/common/admin/irdntManage/createIrdnt.do" method="post">
<table>
	<tr>
		<th>재료명</th>
		<td><input type="text" name="irdntName" value="${param.irdntName}"><span class="error"><form:errors path="irdntManage.irdntName" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>카테고리</th>
		<td><input type="text" name="irdntCategory" value="${param.irdntCategory}"><span class="error"><form:errors path="irdntManage.irdntCategory" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>실온보관기간</th>
		<td><input type="text" name="roomTemPeriod" value="${param.roomTemPeriod}"><span class="error"><form:errors path="irdntManage.roomTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>냉장보관기간</th>
		<td><input type="text" name="coldTemPeriod" value="${param.coldTemPeriod}"><span class="error"><form:errors path="irdntManage.coldTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>냉동보관기간</th>
		<td><input type="text" name="freezeTemPeriod" value="${param.freezeTemPeriod}"><span class="error"><form:errors path="irdntManage.freezeTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>비고</th>
		<td><input type="text" name="note" value="${param.note}"><span class="error"><form:errors path="irdntManage.note" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="등록하기">
		</td>
	</tr>
</table>
<sec:csrfInput/>
</form>


</body>
</html>