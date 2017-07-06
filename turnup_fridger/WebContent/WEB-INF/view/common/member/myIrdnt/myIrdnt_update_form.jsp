<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
function closeWindow(){
	setTimeout("window.close()",500)
	}
</script>
</head>
<body>
<h2>나의 식재료 수정</h2>

<form action="/turnup_fridger/common/member/MyIrdnt/updateMyIrdnt.do" method="post">
<table>
	<tr>
		<th>재료명</th>
		<td><input type="text" name="irdntName" value="${param.irdntName}" readOnly><span class="error"><form:errors path="MyIrdnt.irdntName" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관시작일</th>
		<td><input type="date" name="startDate" value="${param.startDate}"><span class="error"><form:errors path="MyIrdnt.startDate" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>유통기한</th>
		<td><input type="date" name="endDate" value="${param.endDate}"><span class="error"><form:errors path="MyIrdnt.endDate" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>수량메모</th>
		<td><input type="text" name="irdntCount" value="${param.irdntCount}"><span class="error"><form:errors path="MyIrdnt.irdntCount" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관시작상태</th>
		<td><input type="text" name="startFreshLevel" value="${param.startFreshLevel}"><span class="error"><form:errors path="MyIrdnt.startFreshLevel" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관장소</th>
		<td><input type="text" name="storgePlace" value="${param.storgePlace}"><span class="error"><form:errors path="MyIrdnt.storgePlace" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="수정하기" onclick="closeWindow()">
		</td>
	</tr>
</table>
<sec:csrfInput/>
</form>
</body>
</html>