<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>식재료 추가</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript" src="/turnup_fridger/scripts/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){		
		//검색버튼을 누르면,myIrdnt_search_result팝업창을 열고-> 팝업창에서 irdntId가 넘어올예정.
		$("#searchBtn").on("click",function(){
			window.open("/turnup_fridger/common/member/myIrdnt/myIrdnt_search_result.do","Irdnt_search","width=900, height=600");
		})//searchBtn

	})//ready
	function closeWindow(){
		document.myIrdntForm.action="/turnup_fridger/common/member/myIrdnt/createMyIrdnt.do";
		window.opener.location.reload();
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
<h2 style="text-align:center;font-weight:bold;">냉장고 속 재료 추가</h2><hr><br>

<form name="myIrdntForm" method="post" onsubmit="closeWindow()">
<div>
<table>
	<tr>
		<th>재료명</th>
		<td>
			<input type="hidden" name="fridgerId" id="fridgerId" value="${param.fridgerId}">
			<span class="error"><form:errors path="MyIrdnt.fridgerId" delimiter="&nbsp;&nbsp;"/></span>

			<input type="text" name ="irdntName" id="irdntName" style="width:118.4px; height:26px;">
			<button type="button" id="searchBtn" class="btn btn-default btn-lg" style=" border:0;outline:0;width:40px;height:40px;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
			</button>
			
			<input type="hidden" name="irdntId" id="irdntId" value="${param.irdntId}">
			<span class="error"><form:errors path="myIrdnt.irdntId" delimiter="&nbsp;&nbsp;"/>
			</span></td>
	</tr>
	<tr>
		<th>보관시작일</th>
		<td style="padding:10px;">
		<input type="date" name="startDate" value="${param.startDate}" style="width:178.4px; height:26px;"><span class="error"><form:errors path="myIrdnt.startDate" delimiter="&nbsp;&nbsp;"/></span></td>
		<%--
		<!--오늘 체크된걸로 나오는 라디오버튼   -->
		오늘 : <input type="radio" name="startDate" value="<%=String.format("%tY-%<tm-%<td",new Date())%>"><span class="error"><form:errors path="MyIrdnt.startDate" delimiter="&nbsp;&nbsp;"/></span>
		선택 : <input type="radio" name="startDate" value="${param.startDate}"><span class="error"><form:errors path="MyIrdnt.startDate" delimiter="&nbsp;&nbsp;"/></span></td>--%>
	</tr>
	<tr>
		<!--null허용  -->
		<th>유통기한</th> 
		<td><input type="date" name="endDate" value="${param.endDate}" style="width:178.4px; height:26px;"><span class="error"><form:errors path="myIrdnt.endDate" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<!--null허용  -->
		<th>수량메모</th>
		<td><input type="text" name="irdntCount" value="${param.irdntCount}"><span class="error"><form:errors path="myIrdnt.irdntCount" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관시작상태</th><!-- 라디오버튼 / 좋음,보통,나쁨 -->
		<td>
		좋음 <input type="radio" name="startFreshLevel" value="좋음"><span class="error"><form:errors path="myIrdnt.startFreshLevel" delimiter="&nbsp;&nbsp;"/></span>&nbsp;
		보통 <input type="radio" name="startFreshLevel" value="보통" checked="checked"><span class="error"><form:errors path="MyIrdnt.startFreshLevel" delimiter="&nbsp;&nbsp;"/></span>&nbsp;
		나쁨 <input type="radio" name="startFreshLevel" value="나쁨"><span class="error"><form:errors path="myIrdnt.startFreshLevel" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관장소</th><!--라디오버튼 / 실온,냉장,냉동  -->
		<td>
		실온 <input type="radio" name="storgePlace" value="실온"><span class="error"><form:errors path="myIrdnt.storgePlace" delimiter="&nbsp;&nbsp;"/></span>&nbsp;
		냉장 <input type="radio" name="storgePlace" value="냉장"><span class="error"><form:errors path="myIrdnt.storgePlace" delimiter="&nbsp;&nbsp;"/></span>&nbsp;
		냉동 <input type="radio" name="storgePlace" value="냉동"><span class="error"><form:errors path="myIrdnt.storgePlace" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="등록하기"  class="btn btn-warning">
		</td>
	</tr>
</table>
</div>
<sec:csrfInput/>

</form>

</body>
</html>