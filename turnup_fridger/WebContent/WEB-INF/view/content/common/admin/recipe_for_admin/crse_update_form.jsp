<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("div.image_none").hide();
	$("div.StepImage_none").hide();
	var crse_idx = -1;
	var irdnt_idx = -1;
	var removeIrdnt_idx = -1;
	var removeCrse_idx = -1;

	
	
	
	$(document).on("click","#crseBtn", function(){
		crse_idx += 1;
		alert(crse_idx);
		
		$("#recipe_crse_table>tbody").append($("<tr>").prop("class","newCrseRow"+crse_idx).append($("<td>").prop("rowspan", "3").append($("<input>").prop("type", "hidden").prop("name","addCrseList["+crse_idx+"].cookingNo").prop("value", crse_idx+1)).append("과정"+(crse_idx+1)))
									.append($("<td>").append($("<textarea>").prop("cols", "60").prop("rows", "3").prop("name", "addCrseList["+crse_idx+"].cookingDc").prop("size", "60"))))
									.append($("<tr>").prop("class","newCrseRow"+crse_idx).append($("<td>").append($("<input>").prop("type", "file").prop("name","addCrseList["+crse_idx+"].stepImageUrlSrc"))))
									.append($("<tr>").prop("class","newCrseRow"+crse_idx).append($("<td>").append($("<input>").prop("type", "text").prop("name", "addCrseList["+crse_idx+"].stepTip").prop("placeholder","간단한 팁이 있다면 입력해주세요!").prop("size", "60"))));
	});
	



	$(document).on("click", ".deleteCrseBtn", function(){
		
		removeCrse_idx += 1;	
		console.log($("#recipe_crse_table tbody").find(".6"));
		$("#recipe_crse_table tbody").find(".6").hide();
		$("#recipe_crse_table tbody").find(".6").children("input#OldCrseList.cookingNo").prop("name", "removeCrseList["+removeCrse_idx+"].cookingNo" )
		$(this).parent().find("input#OldCrseList.recipeId").prop("name", "removeCrseList["+removeCrse_idx+"].recipeId" )
		$("#recipe_crse_table tbody").filter("."+this.value).hide();
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
	
						


	
	
	$(document).on("click", "#backStepImgBtn", function(){
		$(this).parent().parent().children("#stepImageUrlSrc").remove();
			$("div.stepImage").show();
			$("div.stepImage_none").hide();
			$("input#stepImageUrlSrc").hide();
			$("#stepImageUrl").prop("value", "${ requestScope.recipe.imgUrl }");
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