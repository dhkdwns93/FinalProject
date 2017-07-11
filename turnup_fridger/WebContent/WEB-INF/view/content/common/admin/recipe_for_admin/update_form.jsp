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
	var crse_idx = -1;


	$("input:radio").find("[value=${ requestScope.recipe.recipeLevel}]").prop("checked","checked");
	$("#categoryCode>option").find("[value=${ requestScope.recipe.categoryCode}]").prop("selected", "selected");

	
	//카테고리를 선택했을때 카테고리별 음식분류명 불러오기
	$("#categoryCode").on("change",function(){
		alert($(this).find(":selected").text())
		$.ajax({
			"url":"/turnup_fridger/getTypeNameCategory.do",
			"type":"POST",
			"data":{'categoryName' : $(this).find(":selected").text(),'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json",
			"success":function(list){
				$("#typeCode").empty().append($("<option>").append("선택하세요"))
				
				$.each(list, function(){
					$("#typeCode").append($("<option>").prop("value",this).append(this));
				});//each
			},
			"error":function(xhr, msg, code){
				alert("오류발생-" +msg+ ":" +code);
			}
		})		
	});//categoryName
	
	
	$(document).on("click", ".nextBtn", function(){
		$(this).parent().next().show();
	})
	
	$(document).on("click","#crseBtn", function(){
		crse_idx += 1;
		alert(crse_idx);
		
		$("#recipe_crse_table>tbody").append($("<tr>").append($("<td>").append($("<input>").prop("type", "hidden").prop("name","recipeCrseList["+crse_idx+"].cookingNo").prop("value", irdnt_idx)).append("과정#"+(crse_idx+1)).append($("<textarea>").prop("cols", "50").prop("rows", "3").prop("name", "recipeCrseList["+crse_idx+"].cookingDc")))
													   .append($("<td>").append($("<input>").prop("type", "file").prop("name","recipeCrseList["+crse_idx+"].stepImageUrlSrc"))))
									  .append($("<tr>").append($("<td>").append("팁").append($("<input>").prop("type", "text").prop("name", "recipeCrseList["+crse_idx+"].stepTip"))));
	});
	
	$(document).on("change", "#typeCode", function(){
		var row = $("<input>").prop("type", "hidden").prop("name", "typeName" ).prop("value", $(this).find(":selected").text());
		row.appendTo($("form"));
	});
	
	$(document).on("change", "#categoryCode", function(){
		var row = $("<input>").prop("type", "hidden").prop("name", "CategoryName" ).prop("value", $(this).find(":selected").text());
		row.appendTo($("form"));
	});


	$(document).on("click", ".deleteIrdntBtn", function(){
		$(this).parent().parent().remove();	
	})
	
	
	
	
	

	
});

function openPopup(url){
	window.open(
			url,
			"_blank",
			"fullscreen=yes, height=500, width=500, resizable=no, scrollbars=no, location=no, toolbar=no, directories=no, menubar=no"
			);
}
var irdnt_idx = -1;
function setIrdnt(irdntId, irdntName, irdntTypeCode, irdntTypeName, irdntAmount ){
	irdnt_idx += 1;
	$("#recipe_irdnt_table>tbody").append($("<tr>").append($("<td>").append($("<input>").prop("type", "hidden").prop("name", "recipeIrdntList["+irdnt_idx+"].irdntId").prop("value", irdntId)))
													.append($("<td>").append($("<input>").prop("type", "text").prop("name", "recipeIrdntList["+irdnt_idx+"].irdntName").prop("value", irdntName).prop("readonly", "readonly")))
								  					.append($("<td>").append($("<input>").prop("type", "hidden").prop("name", "recipeIrdntList["+irdnt_idx+"].irdntTypeCode").prop("value",irdntTypeCode)))
								  					.append($("<td>").append($("<input>").prop("type", "text").prop("name", "recipeIrdntList["+irdnt_idx+"].irdntTypeName").prop("value",irdntTypeName).prop("readonly", "readonly")))
								  					.append($("<td>").append($("<input>").prop("type", "text").prop("name", "recipeIrdntList["+irdnt_idx+"].irdntAmount").prop("value",irdntAmount).prop("readonly", "readonly")))
								  					.append($("<td>").append($("<button>").prop("type", "button").prop("class","deleteIrdntBtn").append("삭제"))));
}
</script>

<style>
.image{
position:relative;
}

.image_button{
position: absolute;
top:5px;
right:5px;
}

</style>



<h2>레시피 업데이트</h2>

<form id="recipe_register_form" 
	action="${ initParam.rootPath }/common/admin/recipe/update.do" 
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
					<td>현재사진
						<div class="image">
							
						<img src="${ initParam.rootPath }/images/${ requestScope.recipe.imgUrl }" width="150px" height="150px">
						<div class="image_button">
						<button type="button" id="deleteImgBtn">삭제</button>
						</div>
					</div>
					
					<input type="file" id="imgUrlSrc" name="imgUrlSrc"
						value="${ requestScope.recipe.imgUrl }">
						
						<span class="error"><form:errors
								path="recipeInfo.imgUrl" delimiter="&nbsp;" /> <c:if
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
							<option>가공식품류</option>
							<option>견과류</option>
							<option>곡류</option>
							<option>과일류</option>
							<option>기타</option>
							<option>닭고기류</option>
							<option>돼지고기류</option>
							<option>밀가루</option>
							<option>버섯류</option>
							<option>쇠고기류</option>
							<option>알류</option>
							<option>어류/패류</option>
							<option>채소류</option>
							<option>콩류</option>
							<option>해조류</option>	
					</select>
					<span class="error"><form:errors
								path="recipeInfo.irdntCode" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>난이도</th>
					<td><label for="recipeLevel_1">초보환영<input type="radio"
							name="recipeLevel" id="recipeLevel_1" value="초보환영"></label>
						&nbsp; &nbsp;<label for="recipeLevel_2">보통<input
							type="radio" name="recipeLevel" id="recipeLevel_2" value="보통"></label>
						&nbsp; &nbsp;<label for="recipeLevel_3">어려움<input
							type="radio" name="recipeLevel" id="recipeLevel_3" value="어려움"></label>
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
		<button type="button" class="nextBtn">NEXT >></button>
	</div>
	
<!-- next버튼을 누르면 기본정보 세션에 저장하고 재료정보를 등록하는 부분 나오개 함-->

		
		<!-- 레시피 재료정보 -->
	<div id="recipe_irdnt" style="padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 10px;  background-color: lightgray; margin-bottom: 20px">
	<h3 style="margin:10px">레시피 재료</h3>
		<span class="error"><form:errors
								path="recipeInfo.recipeIrdntList" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span>
		<button type="button" id="irdntBtn" onclick="openPopup('${initParam.rootPath}/irdntList_pop.do')">+재료추가</button>
		<table id="recipe_irdnt_table" style="margin-bottom: 10px">
			<tbody>
				<tr>
					<td><!-- 재료타입(주재료/부재료/양념) --></td>
					<td><!-- 재료명 --></td>
					<td><!-- 중량 --></td>
				</tr>
				<tr>
				<!-- recipeIrdntList를 forEach로 돌림 -->
					<td><input type="hidden" name="recipeIrdntList[0].irdntId" value="${requestScope.recipe.recipeIrdntList[0].irdntId}"></td>
					<td><input type="text" name="recipeIrdntList[0].irdntName" readonly></td>
					<td><input type="hidden" name="recipeIrdntList[0].irdntTypeCode" value="${requestScope.recipe.recipeIrdntList[0].irdntTypeCode}"></td>
					<td><input type="text" name="recipeIrdntList[0].irdntTypeName" readonly></td>
					<td><input type="text" name="recipeIrdntList[0].irdntAmount" readonly></td>
					<td><button type="button" class="deleteIrdntBtn">삭제</button></td>
				</tr>
			</tbody>
		</table>
		<button type="button" class="nextBtn" >NEXT >></button>
	</div>
<!-- next버튼을 누르면 기본정보+재료정보를 세션에 저장하고 과정정보를 등록하는 부분 나오개 함-->



	<!-- 레시피 과정정보 -->
	<div id="recipe_crse" style="padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 10px;  background-color: lightgray; margin-bottom: 20px">
	<h3 style="margin:10px">레시피 과정정보</h3>
	<span class="error"><form:errors
								path="recipeInfo.recipeCrseList" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span>
	<button type="button" id="crseBtn">+과정추가</button>
		<table id="recipe_crse_table" style="margin-bottom: 10px">
			<tbody>
			<tr>
				<td>
				<input type="hidden" name="recipeCrseList[0].cookingNo" value="0">
				과정#1
				<textarea cols="50" rows="3" name="recipeCrseList[0].cookingDc"></textarea>
				</td>
				<td>
				<img src="recipeCrseList[0].stepImageUrlSrc">
				</td>
			</tr>
			<tr>
				<td>
					팁
					<input type="text" name="recipeCrseList[0].stepTip">
				</td>
			</tr>
			</tbody>
			
		</table>
	</div>
	</div>
	<input type="submit" id="updateBtn" value="업데이트">
	<input type="reset" value="초기화">
	
</form>