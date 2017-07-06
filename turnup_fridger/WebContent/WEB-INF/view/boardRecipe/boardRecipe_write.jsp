<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글작성</title>
<script type="text/javascript" src="/turnup_fridger2/scripts/jquery.js"></script>
<script type="text/javascript">

function insert_event(){
	if(confirm("등록 WANT?")==true){
		location.href="${initParam.rootPath}/boardRecipe/boardRecipeList.do";
	}else{
		return false;
	}
}


</script>

</head>
<body>
<h2>글쓰기</h2>

	<form method="post" action="${initParam.rootPath}/boardRecipe/boardRecipeInsert.do">
		<!-- sec:csrf 대신 쓴다. --><input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		
		작성자
		<input type="text" name="memberId" value="id-2"><br>
		제목
		<input type="text" name="title" size="20" value="${param.title }"><span class="error"><form:errors path="boardShareRecipe.title" delimiter="&nbsp;&nbsp;"/></span><br>
		
		내용
		<input type="text" name="txt" rows="10" cols="80" value="${param.txt }"><span class="error"><form:errors path="boardShareRecipe.txt" delimiter="&nbsp;&nbsp;"/></span><br>
		
		사진
		<input type="text" name="images" value="${param.images }"><br>
		추천수
		<input type="hidden" name="recommand" value="0"><br>
		조회수
		<input type="hidden" name="hits" value="0" ><br>
		기타재료
		<textarea rows="4" cols="80" name="etc" ></textarea> 
		<input type="hidden" name="recipeId" value="0"> 
		<br>
		
		<input type="submit" value="등록" onclick="return insert_event();"/>
		
		</form>
		
		<a href="${initParam.rootPath }/boardRecipe/boardRecipeList.do"><input type="button" value="취소"/></a>
	
</body>
</html>