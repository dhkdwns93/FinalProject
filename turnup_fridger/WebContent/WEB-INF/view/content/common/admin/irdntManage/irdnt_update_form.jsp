<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재료 정보 수정</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script type="text/javascript" src="/turnup_fridger/scripts/bootstrap.min.js"></script>
<script type="text/javascript">
function closeWindow(){
	window.opener.name= "parentPage";
	document.updateForm.target= "parentPage";
	document.updateForm.action="/turnup_fridger/common/admin/irdntManage/updateIrdnt.do";
	document.updateForm.submit();
	window.opener.location.reload();
	self.close();
	};
	
</script>
<style>
table {
	border-collapse: collapse;
	margin-left: auto;
	margin-right: auto;

}

table, th, td {
	border: 0.5px ridge;
	text-align: center;
	padding: 10px;
}
</style>
</head>
<body>

<h3 style="text-align:center; font-weight:bold;">재료 수정</h3><hr><br>

<form id = "form" name="updateForm" method="post" onsubmit="closeWindow()">
<table>
	<tr>
		<th>재료id</th>
		<td><input id = "irdntId" type="text" name="irdntId" value="${requestScope.irdnt.irdntId}" readOnly>
		<span class="error"><form:errors path="irdntManage.irdntId" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>재료명</th>
		<td><input id = "irdntName" type="text" name="irdntName" value="${requestScope.irdnt.irdntName}"readOnly>
		<span class="error"><form:errors path="irdntManage.irdntName" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>카테고리</th>
		<td><input id = "irdntCategory"type="text" name="irdntCategory" value="${requestScope.irdnt.irdntCategory}">		
		<span class="error"><form:errors path="irdntManage.irdntCategory" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>실온보관기간</th>
		<td><input id = "roomTemPeriod" type="text" name="roomTemPeriod" value="${requestScope.irdnt.roomTemPeriod}">
		<span class="error"><form:errors path="irdntManage.roomTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>냉장보관기간</th>
		<td><input id = "coldTemPeriod" type="text" name="coldTemPeriod" value="${requestScope.irdnt.coldTemPeriod}">
		<span class="error"><form:errors path="irdntManage.coldTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>냉동보관기간</th>
		<td><input id = "freezeTemPeriod" type="text" name="freezeTemPeriod" value="${requestScope.irdnt.freezeTemPeriod}">
		<span class="error"><form:errors path="irdntManage.freezeTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>비고</th>
		<td><input id = "note" type="text" name="note" value="${requestScope.irdnt.note}">
		<span class="error"><form:errors path="irdntManage.note" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" class="btn btn-warning" value="수정하기" >
		</td>
	</tr>
</table>
<sec:csrfInput/>
</form>
</body>
</html>