<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<link href="${ initParam.rootPath }/css/bootstrap.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script type="text/javascript">
$(document).ready(function(){
	$("div#recipe_irdnt").hide();
	$("div#recipe_crse").hide();
	var crse_idx = -1;
	
	//카테고리를 선택했을때 카테고리별 음식분류명 불러오기
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
			},
			"error":function(xhr, msg, code){
				alert("오류발생-" +msg+ ":" +code);
			}
		})		
	});//categoryCode
	
	
	$(document).on("click", ".nextBtn", function(){
		$(this).parent().next().show();
	})
	
	//레시피 과정정보 추가하기
	$(document).on("click","#crseBtn", function(){
		crse_idx += 1;
		$("#recipe_crse_table>tbody").append($("<tr>").append($("<td>").append($("<input>").prop("type", "hidden").prop("name","recipeCrseList["+crse_idx+"].cookingNo").prop("value", irdnt_idx)).append(" 과정#"+(crse_idx+1)).append($("<br><textarea>").prop("cols", "50").prop("rows", "3").prop("name", "recipeCrseList["+crse_idx+"].cookingDc")))
													   .append($("<td>").append($("<input>").prop("type", "file").prop("name","recipeCrseList["+crse_idx+"].stepImageUrlSrc"))))
									  .append($("<tr>").append($("<td>").append("팁").append($("<input>").prop("type", "text").prop("name", "recipeCrseList["+crse_idx+"].stepTip"))));
	});
	
	
	
	$(document).on("click", ".deleteIrdntBtn", function(){
		$(this).parent().parent().remove();	
	})
	

	$(document).on("change", "#typeCode", function(){
		var row = $("<input>").prop("type", "hidden").prop("name", "typeName" ).prop("value", $(this).find(":selected").text());
		row.appendTo($("form"));
	});
	
	$(document).on("change", "#categoryCode", function(){
		var row = $("<input>").prop("type", "hidden").prop("name", "CategoryName" ).prop("value", $(this).find(":selected").text());
		row.appendTo($("form"));
	});
	
});

/* 레시피 재료정보 추가를 위한 function */
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
								  					.append($("<td>").append($("<button>").prop("type", "button").prop("class"," btn btn-default deleteIrdntBtn").append($("<span>").prop("class", "glyphicon glyphicon-trash").prop("aria-hidden", "true")))));
}
</script>


<style>

td{
	padding: 5px;
}
th{
	padding-right: 20px;
}
</style>


<h2 style="font-weight:bold; text-align:center; ">레시피 등록</h2><hr>

<form id="recipe_register_form" 
	action="${ initParam.rootPath }/common/admin/recipe/register.do" 
	enctype="multipart/form-data" method="post">

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
		<!-- 레시피 기본정보 -->
	<div id="recipe_info" style="border-bottom: 1px solid orange; padding-left: 50px; padding-bottom: 20px; margin-left: 450px; margin-right: 300px;">
	<h3 style="margin:10px">레시피 기본정보</h3>
		<table id="recipe_info_table">
			<tbody>
				<tr>
					<th>레시피 이름</th>
					<td><input type="text" class="form-control" name="recipeName" id="recipeName" value="${ param.recipeName }"> 
						  <span class="error"><form:errors path="recipeInfo.recipeName" delimiter="&nbsp;" /> 
						  <c:if test="${ requestScope.errorMsg_duplicateId != null }">
							  ${ requestScope.errorMsg_duplicateId }
						  </c:if> </span></td>
				</tr>
				<tr>
					<th>레시피설명</th>
					<td><input type="text" class="form-control" name="sumry" id="sumry"
						value="${ param.sumry }"> <span class="error"><form:errors
								path="recipeInfo.sumry" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
				<tr>
					<th>레시피사진</th>
					<td><input type="file" class="form-control" id="imgUrlSrc" name="imgUrlSrc"
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
							<!-- categoryCode선택에 따라 typeCode의 옵션들이 달라짐  -->
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
							name="recipeLevel" id="recipeLevel_1" value="초보환영" checked></label>
						&nbsp; &nbsp;<label for="recipeLevel_2">보통<input
							type="radio" name="recipeLevel" id="recipeLevel_2" value="보통"></label>
						&nbsp; &nbsp;<label for="recipeLevel_3">어려움<input
							type="radio" name="recipeLevel" id="recipeLevel_3" value="어려움"></label>
					</td>
				</tr>
				<tr>
					<th>소요시간</th>
					<td><input type="number" class="form-control" id="cookingTime" name="cookingTime" value="${ param.cookingTime }"></td>
					<td> 분 </td>
				</tr>
				<tr>
					<td></td><td></td>
					<td style="text-align: rignt;">
						<span class="error"><form:errors path="recipeInfo.cookingTime" delimiter="&nbsp;" /> 
							<c:if test="${ requestScope.errorMsg_fridgerImgSrc != null }">
								${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> 
						</span>
					</td>
				</tr>
				<tr>
					<th>칼로리</th>
					<td><input type="number" class="form-control" id="calorie" name="calorie" value="${ param.calorie }"></td>
					<td>kcal</td>
				</tr>
				<tr>
					<td></td><td></td>
					<td style="text-align: rignt;">
						<span class="error"><form:errors path="recipeInfo.calorie" delimiter="&nbsp;" />
							<c:if test="${ requestScope.errorMsg_fridgerImgSrc != null }">
								${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> 
						</span>
					</td>
				</tr>
				<tr>
					<th>기준인분수</th>
					<td><input type="number" class="form-control" id="qnt" name="qnt" value="${ param.qnt }"></td>
					<td>인분 </td>
				</tr>
				<tr>
					<td></td><td></td>
					<td>
						<span class="error"><form:errors path="recipeInfo.qnt" delimiter="&nbsp;" />
							<c:if test="${ requestScope.errorMsg_fridgerImgSrc != null }">
								${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> 
						</span>
					</td>
				</tr>
				<tr>
					<th>가격정보</th>
					<td><input type="number" class="form-control" id="price" name="price" value="${ param.price }"></td>
					<td>원</td>
				</tr>
				<tr>
					<td></td><td></td>
					<td>
						<span class="error"><form:errors path="recipeInfo.price" delimiter="&nbsp;" /> 
							<c:if test="${ requestScope.errorMsg_fridgerImgSrc != null }">
								${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> 
						</span>
					</td>
				</tr>
				<tr>
					<th>참조페이지</th>
					<td><input type="text" class="form-control" id="detUrl" name="detUrl"
						value="${ param.detUrl }"> <span class="error"><form:errors
								path="recipeInfo.detUrl" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span></td>
				</tr>
			</tbody>
		</table>
		<button type="button" class="btn btn-default nextBtn">NEXT >></button>
	</div>
	
<!-- next버튼을 누르면 기본정보 세션에 저장하고 재료정보를 등록하는 부분 나오개 함-->

		
		<!-- 레시피 재료정보 -->
	<div id="recipe_irdnt" style="border-bottom: 1px solid orange; padding: 10px; margin-left: 450px; margin-right: 300px;">
	<h3 style="margin:10px">레시피 재료</h3>
		<span class="error"><form:errors
								path="recipeInfo.recipeIrdntList" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span>
		<button type="button" id="irdntBtn" class="btn btn-default" onclick="openPopup('${initParam.rootPath}/irdntList_pop.do')">+재료추가</button>
		<table id="recipe_irdnt_table" style="margin-bottom: 10px">
			<tbody>
				<tr>
					<td><!-- 재료타입(주재료/부재료/양념) --></td>
					<td><!-- 재료명 --></td>
					<td><!-- 중량 --></td>
				</tr>
			</tbody>
		</table>
		<button type="button" class="btn btn-default nextBtn" >NEXT >></button>
	</div>
<!-- next버튼을 누르면 기본정보+재료정보를 세션에 저장하고 과정정보를 등록하는 부분 나오개 함-->



	<!-- 레시피 과정정보 -->
	<div id="recipe_crse" style="border-bottom: 1px solid orange; padding: 10px; margin-left: 450px; margin-right: 300px;">
	<h3 style="margin:10px">레시피 과정정보</h3>
	<span class="error"><form:errors
								path="recipeInfo.recipeCrseList" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span>
	<button type="button" class="btn btn-default " id="crseBtn">+과정추가</button><br>
		<table id="recipe_crse_table" style="margin-bottom: 10px">
			<tbody>
			</tbody>
			
		</table>
	</div>
	<div style="padding: 10px; margin-left: 450px;">
	<input type="submit" id="registerBtn" value="등록" class="btn btn-warning">
	<input type="reset" value="초기화" class="btn btn-warning">
	</div>
</form>
