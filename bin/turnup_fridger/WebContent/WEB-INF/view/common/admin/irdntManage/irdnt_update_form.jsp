<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2>재료 수정</h2>

<form action="/turnup_fridger/irdntManage/updateIrdnt.do" method="post">
<table>
	<tr>
		<th>재료id</th>
		<td><input type="text" name="irdntId" value="${param.irdntId}" readOnly><span class="error"><form:errors path="irdnt.irdntId" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>재료명</th>
		<td><input type="text" name="irdntName" value="${param.irdntName}"><span class="error"><form:errors path="irdnt.irdntName" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>카테고리</th>
		<td><input type="text" name="irdntPeriod" value="${param.irdntCategory}"><span class="error"><form:errors path="irdnt.irdntCategory" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>실온보관기간</th>
		<td><input type="text" name="irdntPeriod" value="${param.roomTemPeriod}"><span class="error"><form:errors path="irdnt.roomTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>냉장보관기간</th>
		<td><input type="text" name="irdntPeriod" value="${param.coldTemPeriod}"><span class="error"><form:errors path="irdnt.coldTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>냉동보관기간</th>
		<td><input type="text" name="irdntPeriod" value="${param.freezeTemPeriod}"><span class="error"><form:errors path="irdnt.freezeTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>비고</th>
		<td><input type="text" name="irdntPeriod" value="${param.note}"><span class="error"><form:errors path="irdnt.note" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="수정하기">
		</td>
	</tr>
</table>
<sec:csrfInput/>
</form>
</body>
</html>