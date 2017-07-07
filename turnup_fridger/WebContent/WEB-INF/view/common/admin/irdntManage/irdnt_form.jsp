<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		
		if($("#roomTemPeriod").val==0){
			$("#roomTemPeriod").val==1000;
		}
		if($("#coldTemPeriod").val==0){
			$("#coldTemPeriod").val==1000;
		}
		if($("#freezeTemPeriod").val==0){
			$("#freezeTemPeriod").val==1000;
		}
	})

</script>
<h2>재료 등록</h2>

<form action="/turnup_fridger/common/admin/irdntManage/createIrdnt.do" method="post">
<table>
	<tr>
		<th>재료명</th>
		<td><input type="text" name="irdntName" value="${param.irdntName}"><span class="error">
		<form:errors path="irdntManage.irdntName" delimiter="&nbsp;&nbsp;"/>
		<c:if test="${ requestScope.errorMsg_irdntName != null }">${ requestScope.errorMsg_irdntName }</c:if>
		</span></td>
	</tr>
	<tr>
		<th>카테고리</th>
		<td>
		<select name="irdntCategory" id="irdntCategory">
			<option value="전체">전체</option>
			<c:forEach items="${requestScope.irdntCategory}" var="cate">
				<option value="${cate}">${cate}</option>
			</c:forEach>
		</select> 
		<%-- <input type="text" name="irdntCategory" value="${param.irdntCategory}"><span class="error"><form:errors path="irdntManage.irdntCategory" delimiter="&nbsp;&nbsp;"/></span> --%>
		</td>
	</tr>
	<tr>
		<th>실온보관기간</th>
		<td><input type="text" name="roomTemPeriod" id = "roomTemPeriod" value="${param.roomTemPeriod}"><span class="error">
		<form:errors path="irdntManage.roomTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>냉장보관기간</th>
		<td><input type="text" name="coldTemPeriod" id = "coldTemPeriod" value="${param.coldTemPeriod}"><span class="error">
		<form:errors path="irdntManage.coldTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>냉동보관기간</th>
		<td><input type="text" name="freezeTemPeriod" id = "freezeTemPeriod" value="${param.freezeTemPeriod}"><span class="error">
		<form:errors path="irdntManage.freezeTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
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