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
	$("div.image_none").hide();
	$("div.StepImage_none").hide();
	var crse_idx = -1;
	var irdnt_idx = -1;
	var removeIrdnt_idx = -1;
	var removeCrse_idx = -1;
	

	//선택된 유형분류 표시
	$("#categoryCode").find("[value=${ requestScope.recipe.categoryCode}]").prop("selected", "selected");

	
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
	

	/* 
		$.each("${requestScope.recipe.recipeIrdntList}", function(){
		irdnt_idx += 1;
		$("#recipe_irdnt_table>tbody").append($("<tr>").append($("<td>").append($("<input>").prop("type","hidden")
																								.prop("name", "recipeIrdntList["+irdnt_idx+"].irdntId")
																								.prop("value", this.irdntId)))
													.append($("<td>").append($("<input>").prop("type","text")
																								.prop("name", "recipeIrdntList["+irdnt_idx+"].irdntName")
																								.prop("value", this.irdntName).prop("readonly", "readonly")))
													.append($("<td>").append($("<input>").prop("type","hidden")
																								.prop("name", "recipeIrdntList["+irdnt_idx+"].irdntTypeCode")
																								.prop("value", this.irdntTypeCode)))
													.append($("<td>").append($("<input>").prop("type","text")
															.prop("name", "recipeIrdntList["+irdnt_idx+"].irdntTypeName")
															.prop("value", this.irdntTypeName).prop("readonly", "readonly")))
													.append($("<td>").append($("<input>").prop("type","text")
															.prop("name", "recipeIrdntList["+irdnt_idx+"].irdntAmount")
															.prop("value", this.irdntAmount).prop("readonly", "readonly"))));
	})
	 */
	
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
		
		$("#recipe_crse_table>tbody").append($("<tr>").prop("class","newCrseRow"+crse_idx).append($("<td>").prop("rowspan", "3").append($("<input>").prop("type", "hidden").prop("name","addCrseList["+crse_idx+"].cookingNo").prop("value", crse_idx+1)).append("과정"+(crse_idx+1)))
									.append($("<td>").append($("<textarea>").prop("cols", "60").prop("rows", "3").prop("name", "addCrseList["+crse_idx+"].cookingDc").prop("size", "60"))))
									.append($("<tr>").prop("class","newCrseRow"+crse_idx).append($("<td>").append($("<input>").prop("type", "file").prop("name","addCrseList["+crse_idx+"].stepImageUrlSrc"))))
									.append($("<tr>").prop("class","newCrseRow"+crse_idx).append($("<td>").append($("<input>").prop("type", "text").prop("name", "addCrseList["+crse_idx+"].stepTip").prop("placeholder","간단한 팁이 있다면 입력해주세요!").prop("size", "60"))));
	});
	
	$(document).on("change", "#typeCode", function(){
		var row = $("<input>").prop("type", "hidden").prop("name", "typeName" ).prop("value", $(this).find(":selected").text());
		row.appendTo($("form"));
	});
	
	$(document).on("change", "#categoryCode", function(){
		var row = $("<input>").prop("type", "hidden").prop("name", "CategoryName" ).prop("value", $(this).find(":selected").text());
		row.appendTo($("form"));
	});


	$(document).on("click", ".deleteOldIrdntBtn", function(){
		$(this).parent().parent().children(":first-child").children(":first-child").prop("name", "removeIrdntList" )
		$(this).parent().parent().hide();	
	})
	

	$(document).on("click", ".deleteCrseBtn", function(){
		
		removeCrse_idx += 1;	
		console.log($("#recipe_crse_table tbody").find(".6"));
		$("#recipe_crse_table tbody").find(".6").hide();
		$("#recipe_crse_table tbody").find(".6").children("input#OldCrseList.cookingNo").prop("name", "removeCrseList["+removeCrse_idx+"].cookingNo" )
		$(this).parent().find("input#OldCrseList.recipeId").prop("name", "removeCrseList["+removeCrse_idx+"].recipeId" )
		$("#recipe_crse_table tbody").filter("."+this.value).hide();
	})
	
	
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
	
	$(document).on("click", "#deleteStepImgBtn", function(){
		console.log($(".stepImage").find("img"))
		if(confirm("기존사진을 삭제하시겠습니까?") != true){
			return false;
		}else{
			$(this).parent().parent().hide();
			$(this).parent().parent().parent().children("div.stepImage_none").show();
			$("#stepImageUrl").removeAttr("value");
			$(this).parent().parent().parent().append($("<input>").prop("type", "file").prop("name", "OldCrseList.stepImageUrlSrc").prop("id", "stepImageUrlSrc"));
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
	
	
	$(document).on("click", "#backStepImgBtn", function(){
		$(this).parent().parent().children("#stepImageUrlSrc").remove();
			$("div.stepImage").show();
			$("div.stepImage_none").hide();
			$("input#stepImageUrlSrc").hide();
			$("#stepImageUrl").prop("value", "${ requestScope.recipe.imgUrl }");
	})
	

	$(document).on("click", "#backIrdntBtn", function(){
		$("#recipe_irdnt_table tr").filter(".oldIrdntRow").show().children(":first-child").children(":first-child").prop("name", "IrdntList");
		$("#recipe_irdnt_table tr").filter(".newIrdntRow").remove();
			
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
	$("#recipe_irdnt_table>tbody").append($("<tr>").prop("class","newIrdntRow").append($("<td>").append($("<input>").prop("type", "hidden").prop("name", "addIrdntList["+irdnt_idx+"].irdntId").prop("value", irdntId)))
													.append($("<td>").append($("<input>").prop("type", "text").prop("name", "addIrdntList["+irdnt_idx+"].irdntName").prop("size", "10").prop("value", irdntName).prop("readonly", "readonly")))
								  					.append($("<td>").append($("<input>").prop("type", "hidden").prop("name", "addIrdntList["+irdnt_idx+"].irdntTypeCode").prop("value",irdntTypeCode)))
								  					.append($("<td>").append($("<input>").prop("type", "text").prop("name", "addIrdntList["+irdnt_idx+"].irdntTypeName").prop("size", "5").prop("value",irdntTypeName).prop("readonly", "readonly")))
								  					.append($("<td>").append($("<input>").prop("type", "text").prop("name", "addIrdntList["+irdnt_idx+"].irdntAmount").prop("size", "5").prop("value",irdntAmount).prop("readonly", "readonly")))
								  					.append($("<td>").append($("<button>").prop("type", "button").prop("class","deleteIrdntBtn").append("삭제"))));
}
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
						value="${ param.recipe.recipeName }"> <span class="error"><form:errors
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
		<button type="button" class="nextBtn recipe_irdnt">NEXT >></button>

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
		<button type="button" id="backIrdntBtn">되돌리기</button>
		<table id="recipe_irdnt_table" style="margin-bottom: 10px">
			<tbody>
				<tr>
					<td><!-- 재료타입(주재료/부재료/양념) --></td>
					<td><!-- 재료명 --></td>
					<td><!-- 중량 --></td>
					<td><!-- 삭제 --></td>
				</tr>
				<c:forEach items="${ requestScope.recipe.recipeIrdntList }" var="recipeIrdnt">
					<tr class="oldIrdntRow">
						<td><input type="hidden" name="irdntList" value="${recipeIrdnt.irdntId}"></td>
						<td><input type="text" size="10" value="${recipeIrdnt.irdntName}" readonly></td>
						<td><input type="hidden" value="${recipeIrdnt.irdntTypeCode}"></td>
						<td><input type="text" size="5" value="${recipeIrdnt.irdntTypeName}" readonly></td>
						<td><input type="text" size="5" value="${recipeIrdnt.irdntAmount}" readonly></td>
						<td><button type="button" class="deleteOldIrdntBtn">삭제</button></td>
					</tr>
				</c:forEach>

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
	<button type="button" id="backCrseBtn">되돌리기</button>
	<button type="button" class="deleteCrseBtn">삭제</button>
		<table id="recipe_crse_table" style="margin-bottom: 10px; ">
			<tbody>
				<c:forEach items="${ requestScope.recipe.recipeCrseList }" var="recipeCrse">
					<tr class="${ recipeCrse.cookingNo }">
						<td  rowspan="3" width="60px">
						<input type="hidden" id="OldCrseList.cookingNo" name="OldCrseList.cookingNo" value=" ${ recipeCrse.cookingNo }">
						<input type="hidden" id="OldCrseList.recipeId" name="OldCrseList.recipeId" value=" ${ recipeCrse.recipeId }">
						과정${ recipeCrse.cookingNo }<br>
						
						
						</td>
						
						<td width="300px" ><textarea cols="60" rows="3" name="OldCrseList.cookingDc">(${ recipeCrse.cookingNo }) : ${recipeCrse.cookingDc}</textarea>
						</td>
					</tr>
					
					<tr class="${ recipeCrse.cookingNo }">
					<td>

							<div class="stepImage">
								<!-- 내가 저장한 사진경로와 API 사진경로가 다른 문제 해결해야함 -->
								<img src="${ recipeCrse.stepImageUrl }" height="150px">
								<input type="hidden" name="stepImageUrl" id="stepImageUrl" value="${ recipeCrse.stepImageUrl }">
								<div class="stepImage_button">
									<button type="button" id="deleteStepImgBtn">삭제</button>
								</div>
							</div>
							<div class="stepImage_none">
								<button type="button" id="backStepImgBtn">원래 사진 복구</button>
							</div>
						</td>
					</tr>
					
					
					<tr class="${ recipeCrse.cookingNo }">
					
						<td>
						<input type="text" id="OldCrseList" name="OldCrseList.cookingNo" value=" ${ recipeCrse.stepTip }" size="60">

					</td>
					</tr>
					
				</c:forEach>
			</tbody>
			
		</table>
	</div>
	</div>
	<input type="submit" id="updateBtn" value="업데이트">
	<input type="reset" value="초기화">
	
</form>