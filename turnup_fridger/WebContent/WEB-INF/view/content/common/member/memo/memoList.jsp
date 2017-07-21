<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="kr.co.turnup_fridger.vo.MyMemo"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${initParam.rootPath}/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	// 개수 불러오기
	$.ajax({
		"url":"${initParam.rootPath}/memo/findMemoCount.do",
		"data": "memberId="+$("#id").val(),
		"success" : function(count){
			$("#count").text(count);
		},
		"error":function(xhr, msg, code){
			alert('error!'+code);
		}
	});
});
</script>
<style type="text/css">
p{
	text-align: center;
}
</style>
</head>
<body>
<div class="container"><!-- container를 인클루드제외하고 하는게 더 이쁜 것 같기도 -->
<jsp:include page="/WEB-INF/view/layout/side_menu/memberSideMenu.jsp"/>
<div class='right-box-sidemenu'>
<input type="hidden" id="id" value="<sec:authentication property='principal.memberId'/>">

<div style="text-align: center;"><h2>나의 메모</h2></div><br>
<p id="memoNum">현재 <span id="count"></span> 개의 메모가 있습니다</p>
<div class="tableListScroll">
<table id="tt" class="table table-hover">

	<tr>
		<td>NO</td>
		<td>제목</td>	
		<td>작성일</td>
	</tr>
	<c:forEach items="${requestScope.list }" var="memo">
		<tr>
			<td>${memo.memoId}</td>
			<td><a href="#" onClick="window.open('${initParam.rootPath}/memo/memoDetailPopup.do?memoId=${memo.memoId}','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=450px, height=430px ,top=10, left=10', bottom=10, right=10)">${memo.memoName}</a></td>
			<td><fmt:formatDate value="${memo.registeredDate}" pattern="yyyy년 MM월 dd일"/></td>
		</tr>
	</c:forEach>
</table>
</div>
</div>
</div>
</body>
</html>