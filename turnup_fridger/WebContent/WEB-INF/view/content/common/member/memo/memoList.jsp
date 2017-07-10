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
		// 내 메모목록불러오기
 		$.ajax({
			"url":"${initParam.rootPath}/memo/memoList.do",
			"data": "memberId="+$("#id").val(),
			"dataType" : "json",
			"success" : function(memoList){
				var list = ""; 
				$.each(memoList, function(){
					list += "<tr><td><a href='${initParam.rootPath}/memo/findOneMemo.do?memoId="+this.memoId+"'>"+this.memoName+"</a></td><td>"+this.registeredDate+"</td></tr>";
				});
				$("#tbody").html(list);
			},
			"error":function(xhr, msg, code){
				alert('error - '+code);
			}
		});
		
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
#memoNum{
	text-align: center;
}
</style>
</head>
<body>
<input type="hidden" id="id" value="<sec:authentication property="principal.memberId"/>">
<div id="memoNum">현재 <span id="count"></span> 개의 메모가 있습니다</div>
<table class="table" border="1" style="border-collapse:collapse; text-align:center;" align="center" width="350">
<thead>
<tr>
	<td>제목</td>
	<td>작성일</td>
</tr>
</thead>
<tbody id="tbody">

</tbody>
<%-- <tr>
	<td>제목</td>
	<td>작성일</td>
</tr>
<c:forEach items="${requestScope.list }" var="memo">
<tr>
	<td><fmt:formatDate value="${memo.registeredDate}"/></td>
	<td><a href="#" onClick="window.open('${initParam.rootPath}/memo/memoDetail.do?memoId=${memo.memoId}','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=450px, height=430px ,top=10, left=10', bottom=10, right=10)">${memo.memoName}</a></td>
</tr>
</c:forEach> --%>
</table>
<a href="${initParam.rootPath}/"><button type="button" id="back" class="one">뒤로가기</button></a>
</body>
</html>