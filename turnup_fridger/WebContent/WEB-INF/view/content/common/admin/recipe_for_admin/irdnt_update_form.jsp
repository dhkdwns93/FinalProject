<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<link href="${ initParam.rootPath }/css/bootstrap.css" rel="stylesheet">
<script type="text/javascript">
$(document).ready(function(){

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
	
		$(document).on("click", ".deleteIrdntBtn", function(){
		$(this).parent().parent().remove();	
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
													.append($("<td>").append($("<input>").prop("type", "text").prop("name", "addIrdntList["+irdnt_idx+"].irdntName").prop("value",irdntName).prop("size", "10").prop("readonly", "readonly")))
								  					.append($("<td>").append($("<input>").prop("type", "hidden").prop("name", "addIrdntList["+irdnt_idx+"].irdntTypeCode").prop("value",irdntTypeCode)))
								  					.append($("<td>").append($("<input>").prop("type", "text").prop("name", "addIrdntList["+irdnt_idx+"].irdntTypeName").prop("value",irdntTypeName).prop("size", "5").prop("readonly", "readonly").val(irdntTypeName)))
								  					.append($("<td>").append($("<input>").prop("type", "text").prop("name", "addIrdntList["+irdnt_idx+"].irdntAmount").prop("value",irdntAmount).prop("size", "5").prop("readonly", "readonly").val(irdntAmount)))
								  					.append($("<td>").append($("<button>").prop("type", "button").prop("class","deleteIrdntBtn").append("삭제"))));
	
}
</script>


<style>
.image{
position:relative;
width: 100%;
}


.deleteOldIrdntBtn{
right:25px;
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


<div style="margin-top: 20px; margin-left: 70px;">
<h2>레시피 업데이트</h2>

<form id="recipe_register_form" 
	action="${ initParam.rootPath }/common/admin/recipe/irdnt/update.do" 
	 method="post">

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
	<input type="hidden" name="recipeId" value="${requestScope.recipe.recipeId}"> 

	<div id="innerFrom">
		<!-- 레시피 재료정보 -->
	<div id="recipe_irdnt" style="padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 10px; margin-bottom: 20px">
	<h3 style="margin:10px">레시피 재료</h3>
		<span class="error"><form:errors
								path="recipeInfo.recipeIrdntList" delimiter="&nbsp;" /> <c:if
								test="${ requestScope.errorMsg_fridgerImgSrc != null }">
							${ requestScope.errorMsg_fridgerImgSrc }
							</c:if> </span>
		<button type="button" class="btn btn-default" id="irdntBtn" onclick="openPopup('${initParam.rootPath}/irdntList_pop.do')">+재료추가</button>
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
						<td><input type="hidden" name="irdntList" value="${recipeIrdnt.irdntNo}"></td>
						<td><input type="text" size="10" value="${recipeIrdnt.irdntName}" readonly></td>
						<td><input type="hidden" value="${recipeIrdnt.irdntTypeCode}"></td>
						<td><input type="text" size="5" value="${recipeIrdnt.irdntTypeName}" readonly></td>
						<td><input type="text" size="5" value="${recipeIrdnt.irdntAmount}" readonly></td>
						<td><button type="button" class="btn btn-default" class="deleteOldIrdntBtn">삭제</button></td>
					</tr>
				</c:forEach>

			</tbody>
		</table>
	</div>


</div>
	<input type="submit" class="btn btn-warning" id="updateBtn" value="업데이트">
	<input type="reset" class="btn btn-warning" value="초기화">
	
</form>
</div>