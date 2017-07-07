<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
function closeWindow(){
	window.opener.name= "parentPage";
	document.updateForm.target= "parentPage";
	document.updateForm.action="/turnup_fridger/common/admin/irdntManage/updateIrdnt.do";
	document.updateForm.submit();
	window.opener.location.reload();
	self.close();
	}
</script>
</head>
<body>

<h2>재료 수정</h2>

<form id = "form" name="updateForm" method="post" onsubmit="closeWindow()">
<table>
	<tr>
		<th>재료id</th>
		<td><input id = "irdntId" type="text" name="irdntId" value="${param.irdntId}" readOnly><span class="error"><form:errors path="irdnt.irdntId" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>재료명</th>
		<td><input id = "irdntName" type="text" name="irdntName" value="${param.irdntName}"><span class="error"><form:errors path="irdntManage.irdntName" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>카테고리</th>
		<td><input id = "irdntCategory"type="text" name="irdntCategory" value="${param.irdntCategory}"><span class="error"><form:errors path="irdntManage.irdntCategory" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>실온보관기간</th>
		<td><input id = "roomTemPeriod" type="text" name="roomTemPeriod" value="${param.roomTemPeriod}"><span class="error"><form:errors path="irdntManage.roomTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>냉장보관기간</th>
		<td><input id = "coldTemPeriod" type="text" name="coldTemPeriod" value="${param.coldTemPeriod}"><span class="error"><form:errors path="irdntManage.coldTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>냉동보관기간</th>
		<td><input id = "freezeTemPeriod" type="text" name="freezeTemPeriod" value="${param.freezeTemPeriod}"><span class="error"><form:errors path="irdntManage.freezeTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>비고</th>
		<td><input id = "note" type="text" name="note" value="${param.note}"><span class="error"><form:errors path="irdntManage.note" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="수정하기" >
		</td>
	</tr>
</table>
<sec:csrfInput/>
</form>
</body>
</html>