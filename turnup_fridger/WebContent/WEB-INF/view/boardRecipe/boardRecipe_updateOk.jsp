<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<form method="post" action="${initParam.rootPath }/boardRecipe/boardRecipeView.do">
	<table border="1" width="500px">
		<tr>
			<th>번호</th>
			<td>${dataUp.recipeId }</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${dataUp.title }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${dataUp.memberId }</td>
		</tr>
		<tr>	
			<th>작성일</th>
			<td><fmt:formatDate value="${dataUp.date }" pattern="yyyy-MM-dd a HH:mm:ss"/></td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${dataUp.txt}</td>
		</tr>
		<tr>	
			<th>조회수</th>
			<td>${dataUp.recommand}</td>
		</tr>
		<tr>
			<th>추천수</th>
			<td>${dataUp.hits }</td>
		</tr>
		<tr>	
			<th>사진</th>
			<td>${dataUp.images }</td>
		</tr>
			
	</table>
	<input type="hidden" name="recipeId" value="${dataUp.recipeId }"><br>
	<input type="button" value="확인">
	<sec:csrfInput/> 
</form>
	<a href="${initParam.rootPath }/boardRecipe/boardRecipeList.do">글 목록</a>
</body>
</html>