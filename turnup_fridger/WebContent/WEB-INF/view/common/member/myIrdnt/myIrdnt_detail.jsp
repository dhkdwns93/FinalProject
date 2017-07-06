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
			var irdntId = $(this).parent().parent().children(":first-child").text();
			var irdntName=$(this).parent().parent().children(":nth-child(2)").text();
			var irdntCategory=$(this).parent().parent().children(":nth-child(3)").text();
			var roomTemPeriod=$(this).parent().parent().children(":nth-child(4)").text();
			var coldTemPeriod=$(this).parent().parent().children(":nth-child(5)").text();
			var freezeTemPeriod=$(this).parent().parent().children(":nth-child(6)").text();
			var note=$(this).parent().parent().children(":nth-child(7)").text();
			
			window.open("/turnup_fridger/common/member/MyIrdnt/myIrdnt_update_form.do?irdntId="+irdntId+"&irdntName="+irdntName+"&irdntCategory="+
					irdntCategory+"&roomTemPeriod="+roomTemPeriod+"&coldTemPeriod="+coldTemPeriod+"&freezeTemPeriod="+freezeTemPeriod+"&note="+note
					,"updateForm","width=500, height=400");				
		});//update

	})
</script>
</head>
<body>
<h2>나의 식재료 상세정보</h2>

<!--그냥 정보들을 보여만주는 페이지.  -->

<table>
	<tr>
		<th>재료명</th>
		<td><input type="text" name="irdntName" value="${param.irdntName}" readOnly><span class="error"><form:errors path="MyIrdnt.irdntName" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관시작일</th>
		<td><input type="date" name="startDate" value="${param.startDate}" readOnly><span class="error"><form:errors path="MyIrdnt.startDate" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>유통기한</th>
		<td><input type="date" name="endDate" value="${param.endDate}" readOnly><span class="error"><form:errors path="MyIrdnt.endDate" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>수량메모</th>
		<td><input type="text" name="irdntCount" value="${param.irdntCount}" readOnly><span class="error"><form:errors path="MyIrdnt.irdntCount" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관시작상태</th>
		<td><input type="text" name="startFreshLevel" value="${param.startFreshLevel}" readOnly><span class="error"><form:errors path="MyIrdnt.startFreshLevel" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관장소</th>
		<td><input type="text" name="storgePlace" value="${param.storgePlace}" readOnly><span class="error"><form:errors path="MyIrdnt.storgePlace" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="수정">
		</td>
	</tr>
</table>

</body>
</html>