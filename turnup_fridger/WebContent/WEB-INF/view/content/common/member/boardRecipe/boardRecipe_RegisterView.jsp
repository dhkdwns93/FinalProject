<%@page import="kr.co.turnup_fridger.vo.BoardShareRecipe"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/turnup_fridger2.2/scripts/jquery.js"></script>
<script type="text/javascript">

</script>
<title>Insert title here</title>
<%

Cookie hits = new Cookie("hits", request.getParameter("hits"));
hits.setMaxAge(60*60*24);
response.addCookie(hits);

%>
</head>
<body>
<a href="${initParam.rootPath }/boardRecipe/boardRecipeList.do">목록</a>
<hr>
<h2>게시물 보기(상세페이지)</h2>
<form action="${initParam.rootPath }/common/boardRecipe/boardRecipeUpdate.do" method="post">

<c:forEach items="${boardView }" var="list">
	<table border="1" width="500px">
		<tr>
			<th>번호</th>
			<td>${list.recipeId }</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${list.title }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${list.memberId }</td>
		</tr>
		<tr>	
			<th>작성일</th>
			<td><fmt:formatDate value="${list.date}" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
		</tr>
		<tr>
			<th>재료</th>
			<td>${list.irdntManage.irdntName}</td>
		</tr>
		
		<tr>
			<th>내용</th>
			<td>${list.txt}</td>
		</tr>
		<tr>	
			<th>추천수</th>
			<td>${list.recommand}</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${list.hits }</td>
		</tr>
	</table>
	<input type="hidden" name="recipeId" value="${list.recipeId}"><br>
</c:forEach>

<!-- 관리자는 삭제가능 -->
	<sec:authorize access="isAuthenticated()">
	<input type="submit" value="수정">
	</sec:authorize>
	<sec:csrfInput/>
	 </form>
	 

<!-- 회원만 수정/삭제 가능 (자기자신이 올린 게시물만 가능) -->
<sec:authorize access="hasRole('ROLE_MEMBER')">
	<a href="${initParam.rootPath }/common/boardRecipe/boardRecipeUpdate.do?recipeId=${list.recipeId}">수정</a>
	<a href="${initParam.rootPath }/common/boardRecipe/boardRecipeDelete.do?recipeId=${list.recipeId}">삭제</a>
</sec:authorize>



<input type="button" name="back" value="뒤로가기" onClick="javascript:history.go(-1);"/>
</body>
</html>