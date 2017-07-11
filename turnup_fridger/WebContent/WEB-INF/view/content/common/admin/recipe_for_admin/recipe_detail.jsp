<%@ page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html>
<title>레시피 상세화면</title>

<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#updateBtn").on("click", function(){
		window.open(
				"${ initParam.rootPath }/common/admin/recipe/update_chk.do?recipeId=${requestScope.recipe.recipeId}",
				"_blank",
				"fullscreen=yes, height=700, width=500, resizable=no, scrollbars=no, location=no, toolbar=no, directories=no, menubar=no"
				);
	});

	$("#deleteBtn").on("click", function(){
		$.ajax({
			"url":"/turnup_fridger/common/admin/recipe/update.do",
			"type":"POST",
			"data":{'recipe' : $("#categoryName").val(),'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json",
			"success":function(list){
				$("#typeName").empty();
				$.each(list, function(){
					$("#typeName").append($("<option>").prop("value",this).append(this))
				});//each
			},
			"error":function(xhr, msg, code){
				alert("오류발생-" +msg+ ":" +code);
			}
			
		})
	});
		
})
</script>
<style>
div#whole{
margin:10px;
width:auto;
}
div#recipe_info{
padding:15px;
background-color:lightgray;
position:relative;
margin:10px;
width: auto;
height: auto;
}

div#recipe_irdnt{
position: absolute;
top:0;
width: 350px;
right: 0;
}

div#recipe_crse{
padding:15px;
background-color:lightgray;
margin:10px;
width: auto;
top: 650px;
}
</style>

<div class="container" >
<h2>레시피 상세화면</h2>

<div id="whole">
	<div id="recipe_info">
		<h3>레시피 기본정보</h3>
		<table>
			<tbody>
				<tr>
					<th>레시피명</th>
					<td>${ requestScope.recipe.recipeName }</td>
				</tr>
				<tr>
					<th>유형분류</th>
					<td>${ requestScope.recipe.categoryName }</td>
				</tr>
				<tr>
					<th>음식분류</th>
					<td>${ requestScope.recipe.typeName }</td>
				</tr>
				<tr>
					<th>조리시간</th>
					<td>${ requestScope.recipe.cookingTime }</td>
				</tr>
				<tr>
					<th>칼로리</th>
					<td>${ requestScope.recipe.calorie }</td>
				</tr>
				<tr>
					<th>기준인분</th>
					<td>${ requestScope.recipe.qnt }</td>
				</tr>
				<tr>
					<th>난이도</th>
					<td>${ requestScope.recipe.recipeLevel }</td>
				</tr>
				<tr>
					<th>재료별분류</th>
					<td>${ requestScope.recipe.irdntCode }</td>
				</tr>
				<tr>
					<th>기준가격</th>
					<td>${ requestScope.recipe.price }</td>
				</tr>
				<tr>
					<th>사진</th>
					<td><img src="${ requestScope.recipe.imgUrl }" width="400px"></td>
				</tr>
				<tr>
					<th>조회수</th>
					<td>${ requestScope.recipe.recipeHits }</td>
				</tr>
			</tbody>
		</table>
	
	<div id="recipe_irdnt">
		<h3>레시피 재료정보</h3>
		
		<div>
		주재료 :
		<c:forEach items="${ requestScope.recipe.recipeIrdntList }" var="recipeIrdnt" >
		<c:if test="${recipeIrdnt.irdntTypeCode == 3060001}">
		${ recipeIrdnt.irdntName }, 
		</c:if>
		</c:forEach>
		</div>
		<div>
		부재료 : 
		<c:forEach items="${ requestScope.recipe.recipeIrdntList }" var="recipeIrdnt" >
		<c:if test="${recipeIrdnt.irdntTypeCode == 3060002}">
		${ recipeIrdnt.irdntName }, 
		</c:if>
		</c:forEach>
		</div>
		<div>
		양념 : 
		<c:forEach items="${ requestScope.recipe.recipeIrdntList }" var="recipeIrdnt" >
		<c:if test="${recipeIrdnt.irdntTypeCode == 3060003}">
		${ recipeIrdnt.irdntName }, 
		</c:if>
		</c:forEach>
		</div>
	</div>
	</div>

	

	<div id="recipe_crse">
	<h3>레시피 과정정보</h3>
	<table>
	<c:forEach items="${ requestScope.recipe.recipeCrseList }" var="recipeCrse">
	<tr>
		<td>
			${recipeCrse.cookingNo} - ${recipeCrse.cookingDc}<br>
			<c:if test="${recipeCrse.stepTip !='null'}">
				(팁: ${recipeCrse.stepTip} )<br>
			</c:if>
			<c:if test="${recipeCrse.stepImageUrl != 'null'}">
				<img src="${ recipeCrse.stepImageUrl }"><br>
			</c:if>
			</td>
		</tr>
	</c:forEach>
	</table>
	</div>
</div>
<div style="margin-right: 50px;  width: auto;  right:0; position: absolute;">

<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
<button type="button" id="updateBtn" onclick="('/turnup_fridger/common/admin/recipe/update.do?recipeId=')">수정</button> 
<button type="button" id="deletBtn">삭제</button> 
</sec:authorize>
<button type="button" onclick="window.history.back()">뒤로가기</button>
</div>


</div>
