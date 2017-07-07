<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
	
			if(${requestScope.myIrdnt.startFreshLevel=="좋음"} ){
				$("#start_good").prop("checked","checked");
			}
			if(${requestScope.myIrdnt.startFreshLevel=="보통"}){
				$("#start_normal").prop("checked","checked");
			}
			if(${requestScope.myIrdnt.startFreshLevel=="나쁨"}){
				$("#start_bad").prop("checked","checked");
			}
			
 			if(${requestScope.myIrdnt.storgePlace=="실온"}){
				$("#room").prop("checked","checked");
			}
			if(${requestScope.myIrdnt.storgePlace=="냉장"}){
				$("#cold").prop("checked","checked");
			}
			if(${requestScope.myIrdnt.storgePlace=="냉동"}){
				$("#freeze").prop("checked","checked");
			} 

			//readonly들 해제하고, 수정모드 버튼 숨기고, 수정버튼 나오게 해야지. 
			//$("#startDate").prop('readonly',false);
			//$("#endDate").prop('readonly',false);
			//$("#irdntCount").prop('readonly',false);
		
			//$("#storgePlace_text").hide();
			//$("#startFreshLevel_text").hide();
			//$(".startRadio").show();
			//$(".storgeRadio").show();
		/* 			
			if($("#startFreshLevel_text").val()=="좋음"){
				$("#start_good").prop("checked","checked");
			}
			if($("#startFreshLevel_text").val()=="보통"){
				$("#start_normal").prop("checked","checked");
			}
			if($("#startFreshLevel_text").val()=="나쁨"){
				$("#start_bad").prop("checked","checked");
			}
			
			if($("#storgePlace_text").val()=="실온"){
				$("#room").prop("checked","checked");
			}
			if($("#storgePlace_text").val()=="냉장"){
				$("#cold").prop("checked","checked");
			}
			if($("#storgePlace_text").val()=="냉동"){
				$("#freeze").prop("checked","checked");
			} */
			
		//	$("#updateMode").hide();
			//$("#updateBtn").show(); 

		
	});
</script>
</head>
<body>
<h2>나의 식재료 수정</h2>
<form action="/turnup_fridger/common/member/myIrdnt/updateMyIrdnt.do" method="post">
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
		
<%-- 	<tr class="startText">
		<th>보관시작상태</th>
		<td><input type="text" id = "startFreshLevel_text" value="${requestScope.myIrdnt.startFreshLevel}" readonly="readonly">
		<span class="error"><form:errors path="myIrdnt.startFreshLevel" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr class="storgeText">
		<th>보관장소</th>
		<td><input type="text" id = "storgePlace_text" value="${requestScope.myIrdnt.storgePlace}" readonly="readonly">
		<span class="error"><form:errors path="myIrdnt.storgePlace" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr> --%>
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

<%-- <form action="/turnup_fridger/common/member/myIrdnt/updateMyIrdnt.do?fridgerId=${param.fridgerId }" method="post">
<table>
	<tr>
		
		<td><input type="hidden" name="myIrdntKey" value="${param.irdntName}" readOnly><span class="error"><form:errors path="MyIrdnt.irdntName" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>재료명</th>
		<td><input type="text" name="irdntName" value="${param.irdntName}" readOnly><span class="error"><form:errors path="MyIrdnt.irdntName" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>	
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
</form> --%>
</body>
</html>