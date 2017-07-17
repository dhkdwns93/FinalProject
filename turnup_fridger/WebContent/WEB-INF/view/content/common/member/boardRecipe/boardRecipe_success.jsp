<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>게시물 등록된것이여</h2>
<c:forEach items="${boardShareRecipeList }" var="list">
게시물번호 : ${recipeId }<br>
작성자  :${list.shareRecipeIrdnt.memberId }<br>
재료 	 :	<div>
		<c:forEach items="${list.boardShareRecipe }" var="meIrdntName">
			<c:forEach items="${meIrdntName }" var="irdntNames">
			<li>${irdntNames}</li>
			</c:forEach>
		</c:forEach>
		</div>
제목	 :${list.boardShareRecipe.title }<br>
내용	 :${list.boardShareRecipe.txt }<br>
<%-- <c:forEach var="list" items="${requestScope.boardShareRecipe.images }">
사진 	 :${list.imgUrl }<br>
</c:forEach> --%>
기타내용:${list.boardShareRecipe.etc }<br>
추천수  :${list.boardShareRecipe.recommand }<br>
조회수  :${list.boardShareRecipe.hits }<br>
</c:forEach>
<br>
<a href="${initParam.rootPath }/common/boardRecipe/boardRecipe_write.do">등록폼</a>
<a href="${initParam.rootPath }/boardRecipe/boardRecipeList.do">목록</a>


</body>
</html>