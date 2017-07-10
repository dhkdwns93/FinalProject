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
		alert($(this).find(":selected").text());
		var row = $("<input>").prop("type", "hidden").prop("name", "typeName" ).prop("value", $(this).find(":selected").text());
		row.appendTo($("form"));
	});
	
	$(document).on("change", "#categoryCode", function(){
		alert($(this).find(":selected").text());
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
								test="${ requestScope.errorMsg_duplicateId != null }">
							${ requestScope.errorMsg_duplicateId }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>레시피설명</th>
					<td><input type="text" name="sumry" id="sumry"
						value="${ param.sumry }"> <span class="error"><form:errors
								path="recipeInfo.sumry" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>레시피사진</th>
					<td><input type="file" id="imgUrlSrc" name="imgUrlSrc"
						value="${ param.imgUrlSrc }">
						
						<span class="error"><form:errors
								path="recipeInfo.imgUrl" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>유형분류</th>
					<td><select name="categoryCode" id="categoryCode">
							<!-- ajax처리로 불러와서 뿌려줌 -->
							<option value="categoryCode">categoryName</option>
							<option value="3020001">한식</option>
							<option value="3020009">퓨전</option>
							<option value="3020002">서양</option>
							<option value="3020003">일본</option>
							<option value="3020006">이탈리아</option>
					</select>
					<span class="error"><form:errors
								path="recipeInfo.categoryName" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>음식분류</th>
					<td><select name="typeCode" id="typeCode">
							<!-- ajax처리로 불러와서 뿌려줌 -->
							<option value="typeCode">typeName</option>
							<option value="3010018">부침</option>
							<option value="3010007">나물/생채/샐러드</option>
							<option value="3010006">찜</option>
							<option value="3010008">밑반찬/김치</option>
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
							<!-- ajax처리로 불러와서 뿌려줌 -->
							<option value="irdntCode">irdntCode</option>
							<option value="밀가루">밀가루</option>
							<option value="어류/패류">어류/패류</option>
							<option value="콩류">콩류</option>
							<option value="채소류">채소류</option>
							<option value="닭고기류">닭고기류</option>
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
							name="recipeLevel" id="recipeLevel_1" value="초보환영" checked></label>
						&nbsp; &nbsp;<label for="recipeLevel_2">보통<input
							type="radio" name="recipeLevel" id="recipeLevel_2" value="보통"></label>
						&nbsp; &nbsp;<label for="recipeLevel_3">어려움<input
							type="radio" name="recipeLevel" id="recipeLevel_3" value="어려움"></label>
					</td>
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
					<td><input type="number" id="qnt" name="qnt"
						value="${ param.Qnt }"> 인분 <span class="error"><form:errors
								path="recipeInfo.qnt" delimiter="&nbsp;" /> <c:if
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
			</tbody>
			
		</table>
	</div>
	</div>
	<input type="submit" id="registerBtn" value="등록">
	<input type="reset" value="초기화">
	
</form>