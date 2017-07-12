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
/*  		$.ajax({
			"url":"${initParam.rootPath}/memo/memoList.do",
			"data": "memberId="+$("#id").val(),
			"dataType" : "json",
			"success" : function(memoList){
				var list = ""; 
				$.each(memoList, function(){
					list += "<tr><td>"+this.memoId+"</td><td><a href='#' onClick='window.open(${initParam.rootPath}/memo/memoDetail.do?)'>"+this.memoName+"</a></td><td>"+this.registeredDate+"</td></tr>";
				});
				$("#tbody").html(list);
			},
			"error":function(xhr, msg, code){
				alert('error - '+code);
			}
		}); */
		
 	// 메모상세보기 팝업
/*  		$(document).on("click","#memoDetailPopup", function(){
 			alert($(this).val());
 			window.open(
 					"${ initParam.rootPath }/memo/findOneMemo.do?memoId="+$(this).val(),
 					"_blank",
 					"fullscreen=yes, height=430, width=450, resizable=no, scrollbars=no, location=no, toolbar=no, directories=no, menubar=no"
 					);
 		}); */
 		
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
#memoListT{
	width:100%; 
	height:300px; 
	overflow:auto;
}
</style>
</head>
<body>
<input type="hidden" id="id" value="<sec:authentication property='principal.memberId'/>">
<p id="memoNum">현재 <span id="count"></span> 개의 메모가 있습니다</p>
<div class="container">
<div id="memoListT">
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
<a href="${initParam.rootPath}/"><button type="button" id="back" class="one">뒤로가기</button></a>
</body>
</html>