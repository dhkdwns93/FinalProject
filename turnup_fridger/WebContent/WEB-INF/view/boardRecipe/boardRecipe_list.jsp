<%@page import="kr.co.turnup_fridger.vo.BoardShareRecipe"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="/turnup_fridger2.1/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#btnWrite').on('click', function(){
		location.href = '${initParam.rootPath}/boardRecipe/boardRecipeInsert.do';
	});
	
});


</script>
</head>
<body>
<h2>T.O.P 4</h2>
<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>추천수</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="top" items="${requestScope.top}">
		<tr>
			<td>${top.recipeId}</td>
			<td><a href="${initParam.rootPath }/boardRecipe/boardRecipeView.do?recipeId=${top.recipeId}">${top.title}</a></td>
			<td>${top.memberId }</td>
			<td>${top.date}</td>
			<td>${top.hits }</td>
			<td>${top.recommand }</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<hr>
<h2>게시물 목록</h2>
<form name="form1" method="post" action="${initParam.rootPath }/boardRecipe/selectSearch.do">
	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<select name="searchOption">
		<option value="default">선택</option>
		<option value="title">제목</option>
		<option value="memberId" >작성자</option>
		<option value="txt">내용</option>
	</select>
	<input type="text" name="keyword"/>
	<input type="submit" value="검색"/>
	<input type="reset" value="초기화"/>
	
	<button type="button" id="btnWrite" value="click">글쓰기</button>
	<a href="${initParam.rootPath }/boardRecipe/boardRecipeList.do">목록</a>

</form>
<table border="1" width="600px">
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>추천수</th>
			<th>추천?</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="row" items="${requestScope.list}">
		<tr>
			<td>${row.recipeId}</td>
			<td><a href="${initParam.rootPath }/boardRecipe/boardRecipeView.do?recipeId=${row.recipeId}">${row.title}</a></td>
			<td>${row.memberId }</td>
			<td>${row.date}</td>
			<td>${row.hits }</td>
			<td>${row.recommand }</td> 
			<%-- <c:if test="${sessionScope.recommandBoard.memberId == memberLoginInfo.memberId  }"> --%>
			<td><a href="${initParam.rootPath }/boardRecipe/increaseRecommand.do?recipeId=${row.recipeId}&memberId=${row.memberId}&recommand=${row.recommand}">추천얍</a></td>
			<%-- </c:if> --%>
		</tr>
	</c:forEach>
	</tbody>
</table>
<p>
	<%-- ######################################################
														페이징 처리
			###################################################### --%>
	<!-- 첫페이지로 이동 -->
	<a href="${initParam.rootPath }/boardRecipe/boardRecipeList.do?page=1">첫페이지</a>

	<!--
		이전 페이지 그룹 처리.
		만약에 이전페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리.
	 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.previousPageGroup }" >
			<!-- 이전페이지 그룹이 있따면 isPreviousPageGroup()-->
			<a href="${initParam.rootPath }/itemList?page=${requestScope.pageBean.beginPage - 1}">◀</a>
		</c:when>
		<c:otherwise>
			◀	
		</c:otherwise>
	</c:choose>
	
	
	
	
	
	<!-- 
		현재 page가 속한 page 그룹내의 페이지들 링크.
		현재 pageGroup의 시작page ~ 끝 page
	 -->
	 <!-- 만약에 page가 현재페이지면 링크처리를 하지 않고 p가 현재페이지가 아니라면 링크처리. -->
	
	<c:forEach begin="${requestScope.pageBean.beginPage }" 
			   end="${requestScope.pageBean.endPage }" var="page">
			   <c:choose>
			   	<c:when test="${requestScope.pageBean.page != page}">
			   	<!-- 현재페이지가 아니라면 -->
					<a href="${initParam.rootPath }/boardRecipe/boardRecipeList.do?page=${page}">${page }</a>
			   	
			   	</c:when>
			   	<c:otherwise>
			   		&nbsp;[${page}]&nbsp;
			   	</c:otherwise>
			   </c:choose>
	</c:forEach>
	
	
	
	<!-- 
		다음페이지 그룹으로 이동
		만약에 다음페이지 그룹이 있으면 링크 처리 없으면 화살표만 나오도록 처리
	 -->
	
	<c:choose>
		<c:when test="${requestScope.pageBean.nextPageGroup}">
			<a href="${initParam.rootPath }/boardRecipe/boardRecipeList.do?page=${requestScope.pageBean.endPage + 1}">▶</a>
		</c:when>
		<c:otherwise>
		▶
		</c:otherwise>
	</c:choose>
	
	
	
	
	
	
	
	<!-- 마지막 페이지로 이동 -->

	<a href="${initParam.rootPath }/board/list.do?page=${requestScope.pageBean.totalPage}">마지막 페이지</a>




</p>

</body>
</html>