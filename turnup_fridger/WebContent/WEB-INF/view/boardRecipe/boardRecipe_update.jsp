<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger2.1/scripts/jquery.js"></script>
<script type="text/javascript">

</script>
</head>
<body>
<form name="form1" method="post" action="${initParam.rootPath }/boardRecipe/boardRecipeUpdateOk.do">
	<table border="1" width="600px">
		<tr>
			<th>번호</th>
			<td>${boardUpdate.recipeId }  </td>
		</tr>
		<tr>
			<th>제목</th>
			<td>
				<input name="title" id="title"  value="${boardUpdate.title }" placeholder="제목을 입력해주세요"/></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${boardUpdate.memberId }</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><input type="hidden" name="date" value="${boardUpdate.date }"><fmt:formatDate value="${dataUp.date}" pattern="yyyy-MM-dd"/></td>
		
		</tr>
		<tr>
			<th>내용</th>
			<td><input name="txt" value="${boardUpdate.txt }"/></td>
		</tr>
		<tr>
			<th>기타재료</th>
			<td><input name="etc" value="${boardUpdate.etc }"/></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${boardUpdate.recommand }</td>
		</tr>
		<tr>
			<th>추천수</th>
			<td>${boardUpdate.hits }</td>
		</tr>
		<tr>
			<th>사진</th>
			<td><input type="file" name="images" value="${boardUpdate.images }"/></td>
		</tr>
	
	</table>
	<input type="hidden" name="recipeId" value="${boardUpdate.recipeId}">
	<input type="submit" value="확인">
	<sec:csrfInput/>
</form>
	
	<a href="${initParam.rootPath }/boardRecipe/boardRecipeView.do?recipeId=${boardUpdate.recipeId}"><input type="button" value="취소"></a>
</body>
</html>