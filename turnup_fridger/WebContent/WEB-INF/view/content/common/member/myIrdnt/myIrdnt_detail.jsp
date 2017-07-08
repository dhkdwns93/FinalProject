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
	$(document).ready(function(){
		$("#updateBtn").hide();
		
		$("#updateMode").on("click",function(){
			//readonly들 해제하고, 수정모드 버튼 숨기고, 수정버튼 나오게 해야지. 
			$("#startDate").prop('readonly',false);
			$("#endDate").prop('readonly',false);
			$("#irdntCount").prop('readonly',false);
			$("#storgePlace").prop('readonly',false);
			$("#startFreshLevel").prop('readonly',false);
			$("#updateMode").hide();
			$("#updateBtn").show();
			
			
		})//updatemode

		function updateClose(){
		//	document.updateForm.action="/turnup_fridger/common/member/myIrdnt/updateMyIrdnt.do";
		}
		
	})
</script>
</head>
<body>
<h2>나의 식재료 상세정보</h2>

<!--그냥 정보들을 보여만주는 페이지.  -->
<form name="updateForm" method="post" "action="/turnup_fridger/common/member/myIrdnt/updateMyIrdnt.do">
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
		<td><input type="date" id = "startDate" name="startDate" value="${requestScope.myIrdnt.startDate}" readonly="readonly">
		<span class="error"><form:errors path="myIrdnt.startDate" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>유통기한</th>
		<td><input type="date" id = "endDate" name="endDate" value="${requestScope.myIrdnt.endDate}" readonly="readonly">
		<span class="error"><form:errors path="myIrdnt.endDate" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>수량메모</th>
		<td><input type="text" id = "irdntCount" name="irdntCount" value="${requestScope.myIrdnt.irdntCount}" readonly="readonly">
		<span class="error"><form:errors path="myIrdnt.irdntCount" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관시작상태</th>
		<td> 
		좋음 : <input type="radio" name="startFreshLevel" value="좋음"><span class="error"><form:errors path="myIrdnt.startFreshLevel" delimiter="&nbsp;&nbsp;"/></span>
		보통 : <input type="radio" name="startFreshLevel" value="보통" checked="checked"><span class="error"><form:errors path="myIrdnt.startFreshLevel" delimiter="&nbsp;&nbsp;"/></span>
		나쁨 : <input type="radio" name="startFreshLevel" value="나쁨"><span class="error"><form:errors path="myIrdnt.startFreshLevel" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관장소</th>
		<td>
		실온 : <input type="radio" name="storgePlace" value="실온"><span class="error"><form:errors path="myIrdnt.storgePlace" delimiter="&nbsp;&nbsp;"/></span>
		냉장 : <input type="radio" name="storgePlace" value="냉장"><span class="error"><form:errors path="myIrdnt.storgePlace" delimiter="&nbsp;&nbsp;"/></span>
		냉동 : <input type="radio" name="storgePlace" value="냉동"><span class="error"><form:errors path="myIrdnt.storgePlace" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관시작상태</th>
		<td><input type="text" id = "startFreshLevel" name="startFreshLevel" value="${requestScope.myIrdnt.startFreshLevel}" readonly="readonly">
		<span class="error"><form:errors path="myIrdnt.startFreshLevel" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관장소</th>
		<td><input type="text" id = "storgePlace" name="storgePlace" value="${requestScope.myIrdnt.storgePlace}" readonly="readonly">
		<span class="error"><form:errors path="myIrdnt.storgePlace" delimiter="&nbsp;&nbsp;"/></span></td>
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
			<button type="button" id="updateMode">수정모드</button>
			<input type="submit" value="수정" id="updateBtn">
		</td>
	</tr>
</table>
<sec:csrfInput/>
</form>

</body>
</html>