<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script type="text/javascript" src="/turnup_fridger/scripts/bootstrap.min.js"></script>
<script type="text/javascript">
function closeWindow(){
	//window.opener.name= "parentPage";
	//document.insertForm.target= "parentPage";
	document.insertForm.action="/turnup_fridger/common/admin/irdntManage/createIrdnt.do";
	//document.insertForm.submit();
	window.opener.location.reload();
	//self.close();
	}
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

<h3 style="font-weight:bold; text-align:center;">재료 등록</h3><hr><br>

<form id = "form" name = "insertForm" method="post" onsubmit="closeWindow()">
<table>
	<tr>
		<th>재료명</th>
		<td><input type="text" name="irdntName" value="${param.irdntName}">
		<span class="error"><form:errors path="irdntManage.irdntName" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>카테고리</th>
		<td><input type="text" name="irdntCategory" value="${param.irdntCategory}">
		<span class="error"><form:errors path="irdntManage.irdntCategory" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>실온보관기간</th>
		<td><input type="text" name="roomTemPeriod" value="${param.roomTemPeriod}">
		<span class="error"><form:errors path="irdntManage.roomTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>냉장보관기간</th>
		<td><input type="text" name="coldTemPeriod" value="${param.coldTemPeriod}">
		<span class="error"><form:errors path="irdntManage.coldTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>냉동보관기간</th>
		<td><input type="text" name="freezeTemPeriod" value="${param.freezeTemPeriod}">
		<span class="error"><form:errors path="irdntManage.freezeTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>비고</th>
		<td><input type="text" name="note" value="${param.note}">
		<span class="error"><form:errors path="irdntManage.note" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="등록하기" class="btn btn-warning"><br>
		</td>
	</tr>
</table>
<sec:csrfInput/>
</form><br>


</body>
</html>