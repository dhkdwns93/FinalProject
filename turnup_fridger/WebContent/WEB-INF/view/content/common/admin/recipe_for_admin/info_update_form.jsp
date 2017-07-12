<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("div.image_none").hide();
	
	$("#categoryCode").on("change",function(){
		$.ajax({
			"url":"/turnup_fridger/getTypeCodeAndName.do",
			"type":"POST",
			"data":{'categoryCode' : $(this).find(":selected").val(),'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json",
			"success":function(list){
				$("#typeCode").empty().append($("<option>").append("선택하세요"))
				
				$.each(list, function(){
					$("#typeCode").append($("<option>").prop("value",this.typeCode).append(this.typeName));
				});//each
				//선택된 음식분류 표시
				$("#typeCode").find("[value=${requestScope.recipe.typeCode}]").prop("selected", "selected")
			
			},
			"error":function(xhr, msg, code){
				alert("오류발생-" +msg+ ":" +code);
			}
		})
	});//categoryName
	
	
	/* 
	$(document).on("change", "#typeCode", function(){
		var row = $("<input>").prop("type", "hidden").prop("name", "typeName" ).prop("value", $(this).find(":selected").text());
		row.appendTo($("form"));
	});
	
	$(document).on("change", "#categoryCode", function(){
		var row = $("<input>").prop("type", "hidden").prop("name", "CategoryName" ).prop("value", $(this).find(":selected").text());
		row.appendTo($("form"));
	}); */
	
	$(document).on("click", "#deleteImgBtn", function(){
		console.log($(".image").find("img"))
		if(confirm("기존사진을 삭제하시겠습니까?") != true){
			return false;
		}else{
			$("div.image").hide();
			$("div.image_none").show();
			$("#imgUrl").removeAttr("value");
			$("div.image").parent().append($("<input>").prop("type", "file").prop("name", "imgUrlSrc").prop("id", "imgUrlSrc"));
			alert("기존사진이 삭제되었습니다. 새로운 사진을 등록해주세요.");
		}
	})
	
	$(document).on("click", "#backImgBtn", function(){
		$("#imgUrlSrc").remove();
			$("div.image").show();
			$("div.image_none").hide();
			$("input#imgUrlSrc").hide();
			$("#imgUrl").prop("value", "${ requestScope.recipe.imgUrl }");
	})

	$(document).on("change", "#typeCode", function(){
		alert($(this).find(":selected").text())
		var row = $("<input>").prop("type", "hidden").prop("name", "typeName" ).prop("value", $(this).find(":selected").text());
		row.appendTo($("form"));
	});
	
	$(document).on("change", "#categoryCode", function(){
		var row = $("<input>").prop("type", "hidden").prop("name", "CategoryName" ).prop("value", $(this).find(":selected").text());
		row.appendTo($("form"));
	});
	
});



</script>

<style>
.image{
position:relative;
width: 100%;
}


.image_button{
position: absolute;
top:5px;
left:5px;
}


.stepImage{
position:relative;
width: 100%;
}


.stepImage_button{
position: absolute;
top:5px;
left:5px;
}

</style>



<h2>레시피 업데이트</h2>

<form id="recipe_register_form" 
	action="${ initParam.rootPath }/common/admin/recipe/info/update.do" 
	enctype="multipart/form-data" method="post">

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
	<input type="hidden" name="recipeId" value="${requestScope.recipe.recipeId}"> 
		<!-- 레시피 기본정보 -->
	<div id="innerFrom">
	<div id="recipe_info" style="padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 10px;  background-color: lightgray; margin-bottom: 20px">
	<h3 style="margin:10px">레시피 기본정보</h3>
		<table id="recipe_info_table" style="margin-bottom: 10px">
			<tbody>
				<tr>
					<th>레시피 이름</th>
					<td><input type="text" name="recipeName" id="recipeName"
						value="${ requestScope.recipe.recipeName }"> <span class="error"><form:errors
								path="recipeInfo.recipeName" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_duplicateId != null }">
							${ requestScope.errorMsg_duplicateId }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>레시피설명</th>
					<td><input type="text" name="sumry" id="sumry"
						value="${ requestScope.recipe.sumry }"> <span class="error"><form:errors
								path="recipeInfo.sumry" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>레시피사진</th>
					<td>
						<div class="image">
							<!-- 내가 저장한 사진경로와 API 사진경로가 다른 문제 해결해야함 -->
							<img src="${ requestScope.recipe.imgUrl }" height="150px">
							<input type="hidden" name="imgUrl" id="imgUrl" value="${ requestScope.recipe.imgUrl }">
							<div class="image_button">
							<button type="button" id="deleteImgBtn">삭제</button>
							</div>
						</div>
						<div class="image_none">
							<button type="button" id="backImgBtn">원래 사진 복구</button>
						</div>
					
						<span class="error"><form:errors
								path="recipeInfo.imgUrlSrc" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>유형분류</th>
					<td><select name="categoryCode" id="categoryCode">
							<option>선택하세요</option>
							<option value="3020001">한식</option>
							<option value="3020002">서양</option>
							<option value="3020003">일본</option>
							<option value="3020004">중국</option>
							<option value="3020005">동남아시아</option>
							<option value="3020006">이탈리아</option>
							<option value="3020009">퓨전</option>
						
					</select>
					<span class="error"><form:errors
								path="recipeInfo.categoryName" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_categoryCode != null }">
							${ requestScope.errorMsg_categoryCode }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>음식분류</th>
					<td><select name="typeCode" id="typeCode">
							<option>---------</option>
					</select>
					
					<span class="error"><form:errors
								path="recipeInfo.typeName" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>재료별 분류</th>
					<td><select name="irdntCode" id="irdntCode">
							<option>선택하세요</option>
							<option ${ requestScope.recipe.irdntCode eq '가공식품류' ? 'selected':'' }>가공식품류</option>
							<option ${ requestScope.recipe.irdntCode eq '견과류' ? 'selected':'' }>견과류</option>
							<option ${ requestScope.recipe.irdntCode eq '곡류' ? 'selected':'' }>곡류</option>
							<option ${ requestScope.recipe.irdntCode eq '과일류' ? 'selected':'' }>과일류</option>
							<option ${ requestScope.recipe.irdntCode eq '기타' ? 'selected':'' }>기타</option>
							<option ${ requestScope.recipe.irdntCode eq '닭고기류' ? 'selected':'' }>닭고기류</option>
							<option ${ requestScope.recipe.irdntCode eq '돼지고기류' ? 'selected':'' }>돼지고기류</option>
							<option ${ requestScope.recipe.irdntCode eq '밀가루' ? 'selected':'' }>밀가루</option>
							<option ${ requestScope.recipe.irdntCode eq '버섯류' ? 'selected':'' }>버섯류</option>
							<option ${ requestScope.recipe.irdntCode eq '쇠고기류' ? 'selected':'' }>쇠고기류</option>
							<option ${ requestScope.recipe.irdntCode eq '알류' ? 'selected':'' }>알류</option>
							<option ${ requestScope.recipe.irdntCode eq '어류/패류' ? 'selected':'' }>어류/패류</option>
							<option ${ requestScope.recipe.irdntCode eq '채소류' ?'selected':'' }>채소류</option>
							<option ${ requestScope.recipe.irdntCode eq '콩류' ? 'selected':'' }>콩류</option>
							<option ${ requestScope.recipe.irdntCode eq '해조류' ? 'selected':'' }>해조류</option>	
					</select>
					<span class="error"><form:errors
								path="recipeInfo.irdntCode" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>난이도</th>
					<td>
					<label for="recipeLevel_1">초보환영<input type="radio"
							name="recipeLevel" id="recipeLevel_1" value="초보환영"  ${ requestScope.recipe.recipeLevel eq '초보환영' ? 'checked':''} ></label>
						&nbsp; &nbsp;<label for="recipeLevel_2">보통<input
							type="radio" name="recipeLevel" id="recipeLevel_2" value="보통" ${ requestScope.recipe.recipeLevel eq '보통' ? 'checked':''}></label>
						&nbsp; &nbsp;<label for="recipeLevel_3">어려움<input
							type="radio" name="recipeLevel" id="recipeLevel_3" value="어려움" ${ requestScope.recipe.recipeLevel eq '어려움' ? 'checked':''}></label>
					</td>
				</tr>
				<tr>
					<th>소요시간</th>
					<td>${ requestScope.recipe.cookingTime } -> <input type="number" id="cookingTime" name="cookingTime"> 분
							 <span class="error"><form:errors
								path="recipeInfo.cookingTime" delimiter="&nbsp;"/> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>칼로리</th>
					<td>${ requestScope.recipe.calorie } -> <input type="number" id="calorie" name="calorie"> kcal <span class="error"><form:errors
								path="recipeInfo.calorie" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>기준인분수</th>
					<td>${ requestScope.recipe.qnt } -> <input type="number" id="qnt" name="qnt"> 인분 
							<span class="error"><form:errors
								path="recipeInfo.qnt" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>가격정보</th>
					<td>${ requestScope.recipe.price } -> <input type="number" id="price" name="price"> 원
							 <span class="error"><form:errors
								path="recipeInfo.price" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>참조페이지</th>
					<td><input type="text" id="detUrl" name="detUrl"
						value="${ requestScope.recipe.detUrl }"> <span class="error"><form:errors
								path="recipeInfo.detUrl" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
			</tbody>
		</table>

	</div>

	<input type="submit" id="updateBtn" value="업데이트">
	<input type="reset" value="초기화">
	</div>
</form>