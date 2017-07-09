<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	if(${requestScope.myIrdnt.startFreshLevel=="좋음"}){
		$("#start_good").prop("checked","checked");
	}
	if(${requestScope.myIrdnt.startFreshLevel=="보통"}){
		$("#start_normal").prop("checked","checked");
	}
	if(${requestScope.myIrdnt.startFreshLevel=='나쁨'}){
		$("#start_bad").prop("checked","checked");
	}
	
		if(${requestScope.myIrdnt.storgePlace=='실온'}){
		$("#room").prop("checked","checked");
	}
	if(${requestScope.myIrdnt.storgePlace=='냉장'}){
		$("#cold").prop("checked","checked");
	}
	if(${requestScope.myIrdnt.storgePlace=='냉동'}){
		$("#freeze").prop("checked","checked");
	} 
});

function closeWindow(){
	window.opener.name= "parentPage";
	document.updateMyIrdntForm.target= "parentPage";
	document.updateMyIrdntForm.action="/turnup_fridger/common/member/myIrdnt/updateMyIrdnt.do";
	document.updateMyIrdntForm.submit();
	window.opener.location.reload();
	self.close();
	}
</script>
</head>
<body>
<h2>나의 식재료 수정</h2>
<form name="updateMyIrdntForm" method="post" onsubmit="closeWindow()">
<table>
	<tr>
		<th>재료key</th>
		<td><input type="text" id = "myIrdntKey" name="myIrdntKey" value="${requestScope.myIrdnt.myIrdntKey}" readonly="readonly">
		<span class="error"><form:errors path="myIrdnt.myIrdntKey" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>재료id</th>
		<td><input type="text" id = "irdntId" name="irdntId" value="${requestScope.myIrdnt.irdntId}" readonly="readonly">
		<span class="error"><form:errors path="myIrdnt.irdntId" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>재료명</th>
		<td><input type="text" id = "irdntName" name="irdntName" value="${requestScope.myIrdnt.irdntName}" readonly="readonly">
		<span class="error"><form:errors path="myIrdnt.irdntName" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관시작일</th>
		<td>	
		<input type="date" id = "startDate" name="startDate" value=<fmt:formatDate value="${requestScope.myIrdnt.startDate}" pattern="yyyy-MM-dd"/>>
		<span class="error"><form:errors path="myIrdnt.startDate" delimiter="&nbsp;&nbsp;"/></span></td>
		
	</tr> 
	<tr>
		<th>유통기한</th>
		<td><input type="date" id = "endDate" name="endDate" value="${requestScope.myIrdnt.endDate}">
		<span class="error"><form:errors path="myIrdnt.endDate" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>수량메모</th>
		<td><input type="text" id = "irdntCount" name="irdntCount" value="${requestScope.myIrdnt.irdntCount}">
		<span class="error"><form:errors path="myIrdnt.irdntCount" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	
	<tr class="startRadio">
		<th>보관시작상태</th>
		<td>
		<%-- <c:if test="${requestScope.myIrdnt.startFreshLevel eq '좋음'}">
			$("#start_good").prop("checked","checked");
		</c:if>
		<c:if test="${requestScope.myIrdnt.startFreshLevel eq '보통'}">
			$("#start_normal").prop("checked","checked");
		</c:if>
		<c:if test="${requestScope.myIrdnt.startFreshLevel eq '나쁨'}">
			$("#start_bad").prop("checked","checked");
		</c:if>--%>
		좋음 : <input type="radio" name="startFreshLevel" value="좋음" id="start_good"><span class="error">
		<form:errors path="myIrdnt.startFreshLevel" delimiter="&nbsp;&nbsp;"/></span>
		보통 : <input type="radio" name="startFreshLevel" value="보통" id="start_normal"><span class="error">
		<form:errors path="myIrdnt.startFreshLevel" delimiter="&nbsp;&nbsp;"/></span>
		나쁨 : <input type="radio" name="startFreshLevel" value="나쁨" id="start_bad"><span class="error">
		<form:errors path="myIrdnt.startFreshLevel" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr class="storgeRadio">
		<th>보관장소</th>
		<td>
		실온 : <input type="radio" name="storgePlace" value="실온" id="room"><span class="error">
		<form:errors path="myIrdnt.storgePlace" delimiter="&nbsp;&nbsp;"/></span>
		냉장 : <input type="radio" name="storgePlace" value="냉장" id="cold"><span class="error">
		<form:errors path="myIrdnt.storgePlace" delimiter="&nbsp;&nbsp;"/></span>
		냉동 : <input type="radio" name="storgePlace" value="냉동" id="freeze"><span class="error">
		<form:errors path="myIrdnt.storgePlace" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>신선도</th>
		<td><input type="text" id = "freshLevel" name="freshLevel" value="${requestScope.myIrdnt.freshLevel}" readonly="readonly">
		<span class="error"><form:errors path="myIrdnt.freshLevel" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>냉장고id</th>
		<td><input type="text" id = "fridgerId" name="fridgerId" value="${requestScope.myIrdnt.fridgerId}" readonly="readonly">
		<span class="error"><form:errors path="myIrdnt.fridgerId" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>	
	<tr>
		<td colspan="2">
			<input type="submit" value="수정" id="updateBtn">
		</td>
	</tr>
</table>
<sec:csrfInput/>
</form>
</body>
</html>