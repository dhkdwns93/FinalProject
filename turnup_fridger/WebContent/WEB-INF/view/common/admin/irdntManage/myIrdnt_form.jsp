<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		//검색버튼을 누르면,myIrdnt_search_result팝업창을 열고-> 팝업창에서 irdntId가 넘어올예정.
		$("#searchBtn").on("click",function(){
			window.open("/turnup_fridger/common/member/myIrdnt/myIrdnt_search_result.do","Irdnt_search","width=1100, height=700");
		})//searchBtn
		
		
		
	})//ready
</script>
</head>
<body>
<h2>나의 식재료 등록</h2>

<form action="/turnup_fridger/common/member/MyIrdnt/createMyIrdnt.do" method="post" name="form">
<table>
	<tr>
		<th>재료명</th>
		<td>
			<input type="text" name ="irdntName" id="irdntName"><button type="button" id="searchBtn">검색</button>
			<!-- 검색클릭하면 재료명으로 검색해서 id만 골라오는거 하기. 여기에 id저장. --> 
			재료id<input type="text" name="irdntId" id="irdntId" value="${param.irdntId}"><span class="error"><form:errors path="MyIrdnt.irdntId" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관시작일</th>
		<td>
		<input type="date" name="startDate" value="${param.startDate}"><span class="error"><form:errors path="MyIrdnt.startDate" delimiter="&nbsp;&nbsp;"/></span></td>
		<%--
		<!--오늘 체크된걸로 나오는 라디오버튼   -->
		오늘 : <input type="radio" name="startDate" value="<%=String.format("%tY-%<tm-%<td",new Date())%>"><span class="error"><form:errors path="MyIrdnt.startDate" delimiter="&nbsp;&nbsp;"/></span>
		선택 : <input type="radio" name="startDate" value="${param.startDate}"><span class="error"><form:errors path="MyIrdnt.startDate" delimiter="&nbsp;&nbsp;"/></span></td>--%>
	</tr>
	<tr>
		<!--null허용  -->
		<th>유통기한</th> 
		<td><input type="date" name="endDate" value="${param.endDate}"><span class="error"><form:errors path="MyIrdnt.endDate" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<!--null허용  -->
		<th>수량메모</th>
		<td><input type="text" name="irdntCount" value="${param.irdntCount}"><span class="error"><form:errors path="MyIrdnt.irdntCount" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관시작상태</th><!-- 라디오버튼 / 좋음,보통,나쁨 -->
		<td>
		좋음 : <input type="radio" name="startFreshLevel" value="좋음"><span class="error"><form:errors path="MyIrdnt.startFreshLevel" delimiter="&nbsp;&nbsp;"/></span>
		보통 : <input type="radio" name="startFreshLevel" value="보통" checked="checked"><span class="error"><form:errors path="MyIrdnt.startFreshLevel" delimiter="&nbsp;&nbsp;"/></span>
		나쁨 : <input type="radio" name="startFreshLevel" value="나쁨"><span class="error"><form:errors path="MyIrdnt.startFreshLevel" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>보관장소</th><!--라디오버튼 / 실온,냉장,냉동  -->
		<td>
		실온 : <input type="radio" name="storgePlace" value="실온"><span class="error"><form:errors path="MyIrdnt.storgePlace" delimiter="&nbsp;&nbsp;"/></span>
		냉장 : <input type="radio" name="storgePlace" value="냉장"><span class="error"><form:errors path="MyIrdnt.storgePlace" delimiter="&nbsp;&nbsp;"/></span>
		냉동 : <input type="radio" name="storgePlace" value="냉동"><span class="error"><form:errors path="MyIrdnt.storgePlace" delimiter="&nbsp;&nbsp;"/></span></td>
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