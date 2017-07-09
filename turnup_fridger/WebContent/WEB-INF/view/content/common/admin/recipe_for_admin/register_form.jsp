<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("div#recipe_irdnt").hide();
	$("div#recipe_crse").hide();
	
	$(document).on("click", ".nextBtn", function(){
		console.log($(this).parent().next());
		$(this).parent().next().show();
	})
	
});
</script>
<h2>레시피 등록</h2>

<form id="recipe_register_form" 
	action="${ initParam.rootPath }/common/admin/recipe/register.do" 
	enctype="multipart/form-data" method="post">

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
		<!-- 레시피 기본정보 -->
	<div id="innerFrom">
	<div id="recipe_info" style="padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 10px;  background-color: lightgray; margin-bottom: 20px">
	<h3 style="margin:10px">레시피 기본정보</h3>
		<table id="recipe_info_table" style="margin-bottom: 10px">
			<tbody>
				<tr>
					<th>레시피 이름</th>
					<td><input type="text" name="recipeName" id="recipeName"
						value="${ param.recipeName }"> <span class="error"><form:errors
								path="recipeInfo.recipeName" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerName != null }">
							${ requestScope.errorMsg_fridgerName }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>레시피설명</th>
					<td><input type="text" name="sumry" id="sumry"
						value="${ param.sumry }"> <span class="error"><form:errors
								path="recipeInfo.fridgerImgSrc" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>레시피사진</th>
					<td><input type="file" id="imgUrlSrc" name="imgUrlSrc"
						value="${ param.imgUrlSrc }"> <span class="error"><form:errors
								path="recipeInfo.imgUrlSrc" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>유형분류</th>
					<td><select name="categoryCode" id="categoryCode">
							<!-- ajax처리로 불러와서 뿌려줌 -->
							<option value="categoryCode">categoryName</option>
					</select>
				</tr>
				<tr>
					<th>음식분류</th>
					<td><select name="typeCode" id="typeCode">
							<!-- ajax처리로 불러와서 뿌려줌 -->
							<option value="typeCode">type_name</option>
					</select>
				</tr>
				<tr>
					<th>재료별 분류</th>
					<td><select name="IRDNT_CODE" id="IRDNT_CODE">
							<!-- ajax처리로 불러와서 뿌려줌 -->
							<option value="IRDNT_CODE">IRDNT_CODE</option>
					</select>
				</tr>
				<tr>
					<th>난이도</th>
					<td><label for="recipeLevel_1">초보환영<input type="radio"
							name="recipeLevel" id="recipeLevel_1" value="초보환영"></label>
						&nbsp; &nbsp;<label for="recipeLevel_2">보통<input
							type="radio" name="recipeLevel" id="recipeLevel_2" value="보통"></label>
						&nbsp; &nbsp;<label for="recipeLevel_3">어려움<input
							type="radio" name="recipeLevel" id="recipeLevel_3" value="어려움"></label>
				</tr>
				<tr>
					<th>소요시간</th>
					<td><input type="number" id="cookingTime" name="cookingTime"
						value="${ param.cookingTime }"> 분 <span class="error"><form:errors
								path="recipeInfo.cookingTime" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>칼로리</th>
					<td><input type="number" id="calorie" name="calorie"
						value="${ param.calorie }"> kcal <span class="error"><form:errors
								path="recipeInfo.calorie" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>기준인분수</th>
					<td><input type="number" id="Qnt" name="Qnt"
						value="${ param.Qnt }"> 인분 <span class="error"><form:errors
								path="recipeInfo.Qnt" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>가격정보</th>
					<td><input type="number" id="price" name="price"
						value="${ param.price }"> 원 <span class="error"><form:errors
								path="recipeInfo.price" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>참조페이지</th>
					<td><input type="text" id="detUrl" name="detUrl"
						value="${ param.detUrl }"> <span class="error"><form:errors
								path="recipeInfo.detUrl" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
			</tbody>
		</table>
		<button type="button" class="nextBtn">NEXT >></button>
	</div>
	
<!-- next버튼을 누르면 기본정보 세션에 저장하고 재료정보를 등록하는 부분 나오개 함-->

		
		<!-- 레시피 재료정보 -->
	<div id="recipe_irdnt" style="padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 10px;  background-color: lightgray; margin-bottom: 20px">
	<h3 style="margin:10px">레시피 재료</h3>
		<table id="recipe_irdnt_table" style="margin-bottom: 10px">
			<tbody>
				<tr>
					<td><button type="button" id="irdntBtn">+재료추가</button></td>
				</tr>
			</tbody>
		</table>
		<button type="button" class="nextBtn" >NEXT >></button>
	</div>
<!-- next버튼을 누르면 기본정보+재료정보를 세션에 저장하고 과정정보를 등록하는 부분 나오개 함-->



	<!-- 레시피 과정정보 -->
	<div id="recipe_crse" style="padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 10px;  background-color: lightgray; margin-bottom: 20px">
	<h3 style="margin:10px">레시피 과정정보</h3>
		<table id="recipe_crse_table" style="margin-bottom: 10px">
			<tbody>
				<tr>
					<td><button type="button" id="crseBtn">+과정추가</button></td>
				</tr>
			</tbody>
			
		</table>
	</div>
	</div>
	<input type="submit" id="registerBtn" value="등록">
	<input type="reset" value="초기화">
	
</form>