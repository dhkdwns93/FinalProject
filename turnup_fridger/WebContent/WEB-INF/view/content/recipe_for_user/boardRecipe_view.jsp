<%@page import="kr.co.turnup_fridger.vo.BoardShareRecipe"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
BoardShareRecipe boardShareRecipe = new BoardShareRecipe();
Cookie hits = new Cookie("hits", request.getParameter("hits"));
hits.setMaxAge(60*60*24);
response.addCookie(hits);

%>
</head>
<body>
<a href="${initParam.rootPath }/boardRecipe/boardRecipeList.do">목록</a>
<hr>
<h2>게시물 보기(상세페이지)</h2>
<form action="${initParam.rootPath }/boardRecipe/boardRecipeUpdate.do" method="post">
	<table border="1" width="500px">
		<tr>
			<th>번호</th>
			<td>${boardView.recipeId }</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${boardView.title }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${boardView.memberId }</td>
		</tr>
		<tr>	
			<th>작성일</th>
			<td><fmt:formatDate value="${boardView.date}" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${boardView.txt}</td>
		</tr>
		<tr>	
			<th>추천수</th>
			<td>${boardView.recommand}</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${boardView.hits }</td>
		</tr>
		<tr>	
			<th>사진</th>
			<td>${boardView.images }</td>
		</tr>
			
	</table>
	<input type="hidden" name="recipeId" value="${boardView.recipeId}"><br>
	<input type="submit" value="수정">
	<sec:csrfInput/>
	 </form>
	 <a href="${initParam.rootPath }/boardRecipe/boardRecipeUpdate.do?recipeId=${boardView.recipeId}">수정</a>
	 
	 
	
	
	<a href="${initParam.rootPath }/boardRecipe/boardRecipeDelete.do?recipeId=${boardView.recipeId}">삭제</a>
	

</body>
</html>