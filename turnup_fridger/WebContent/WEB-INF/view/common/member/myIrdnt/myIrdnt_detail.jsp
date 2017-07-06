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
		
		//쿼리스트링으로 수정폼 팝업창으로 붙여서 연다. 
		$(document).on("click","#updateBtn",function(){
			//var myIrdntKey = $(this).parent().children(":first-child").text();
			var irdntName = $("#irdntName").val();
			var startDate = $("#startDate").val();
			var endDate =$("#endDate").val();
			var irdntCount=$("#irdntCount").val();
			var startFreshLevel=$("#startFreshLevel").val();
			var storgePlace=$("#storgePlace").val();
			var fridgerId=${param.fridgerId};
			
			window.open("/turnup_fridger/common/member/myIrdnt/myIrdnt_update_form.do?irdntName="+irdntName+"&startDate="+startDate+"&endDate="+endDate+"&irdntCount="+irdntCount+
					"&startFreshLevel="+startFreshLevel+"&storgePlace="+storgePlace+"&fridgerId="+fridgerId,"myirdnt_detail","width=500, height=400");
		});

	})
</script>
</head>
<body>
<h2>나의 식재료 상세정보</h2>

<!--그냥 정보들을 보여만주는 페이지.  -->

<table>
	<tr>
		<th>재료명</th>
		<td><input type="text" id = "irdntName" name="irdntName" value="${param.irdntName}" readOnly><span class="error"><form:errors path="MyIrdnt.irdntName" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관시작일</th>
		<td><input type="date" id = "startDate" name="startDate" value="${param.startDate}" readOnly><span class="error"><form:errors path="MyIrdnt.startDate" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>유통기한</th>
		<td><input type="date" id = "endDate" name="endDate" value="${param.endDate}" readOnly><span class="error"><form:errors path="MyIrdnt.endDate" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>수량메모</th>
		<td><input type="text" id = "irdntCount" name="irdntCount" value="${param.irdntCount}" readOnly><span class="error"><form:errors path="MyIrdnt.irdntCount" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관시작상태</th>
		<td><input type="text" id = "startFreshLevel" name="startFreshLevel" value="${param.startFreshLevel}" readOnly><span class="error"><form:errors path="MyIrdnt.startFreshLevel" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관장소</th>
		<td><input type="text" id = "storgePlace" name="storgePlace" value="${param.storgePlace}" readOnly><span class="error"><form:errors path="MyIrdnt.storgePlace" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="수정" id="updateBtn">
		</td>
	</tr>
</table>

</body>
</html>