<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link href="${ initParam.rootPath }/css/bootstrap.css" rel="stylesheet">
<script type="text/javascript">
$(document).ready(function(){
	$("div.stepImage_none").hide();
	$("div.stepImage_deleted").hide();
	var newCrse_idx = 0;
	var list_size= ${requestScope.recipe.recipeCrseList.size()-1};
	var crse_idx = list_size;
	var removeCrse_idx = 0;

	
	
	$(document).on("click","#crseBtn", function(){
		alert(crse_idx);
		crse_idx += 1;
		$("#recipe_crse_table").append($("<table>").prop("class","recipe_crse_table").prop("id","newCrseRow").append($("<tbody>")
							.append($("<tr>").append($("<td>").prop("rowspan", "3").prop("width","60px").append($("<input>").prop("type", "hidden").prop("name","addCrseList["+newCrse_idx+"].cookingNo")).append((crse_idx+1)))
									.append($("<td>").append($("<textarea>").prop("cols", "60").prop("rows", "3").prop("name", "addCrseList["+newCrse_idx+"].cookingDc").prop("size", "60"))))
									.append($("<tr>").append($("<td>").append($("<input>").prop("type", "file").prop("name", "addCrseList["+newCrse_idx+"].stepImageUrlSrc"))))
									.append($("<tr>").append($("<td>").append($("<input>").prop("type", "text").prop("name", "addCrseList["+newCrse_idx+"].stepTip").prop("placeholder","간단한 팁이 있다면 입력해주세요!").prop("size", "60"))))))
		
		newCrse_idx += 1;
	});
	



	$(document).on("click", "#deleteCrseBtn", function(){
		
		//console.log($(".recipe_crse_table:eq("+crse_idx+")").prop("id") == 'newCrseRow')
		
			if($(".recipe_crse_table:eq("+crse_idx+")").prop("id") == 'newCrseRow'){
				$(".recipe_crse_table:eq("+crse_idx+")").remove();
				crse_idx -= 1;
			}else{
				$(".recipe_crse_table:eq("+crse_idx+")").hide();
				$(".recipe_crse_table:eq("+crse_idx+")").find("#cookingNo").prop("name", "removeCrseList["+removeCrse_idx+"].cookingNo");
				$(".recipe_crse_table:eq("+crse_idx+")").find("#cookingDc").prop("name", "removeCrseList["+removeCrse_idx+"].cookingDc");
				$(".recipe_crse_table:eq("+crse_idx+")").find("#stepImageUrl").prop("name", "removeCrseList["+removeCrse_idx+"].stepImageUrl");
				$(".recipe_crse_table:eq("+crse_idx+")").find("#stepTip").prop("name", "removeCrseList["+removeCrse_idx+"].stepTip");
				removeCrse_idx += 1;
				crse_idx -= 1;
			}
		/* $(this).parent().parent().parent().parent().hide();
		$(this).parent().children(":first-child").prop("name", "removeCrseList["+removeCrse_idx+"].cookingNo")
		$(this).parent().children(":nth-child(2)").prop("name", "removeCrse["+removeCrse_idx+"].cookingNo")
		
		$("#recipe_crse_table tbody").find(".6").children("input#currentCrseList.cookingNo").prop("name", "removeCrseList["+removeCrse_idx+"].cookingNo" )
		$(this).parent().find("input#currentCrseList.recipeId").prop("name", "removeCrseList["+removeCrse_idx+"].recipeId" )
		$("#recipe_crse_table tbody").hide(); */
	})
	
	$(document).on("click", "#deleteStepImgBtn", function(){
		console.log($(".stepImage").find("img"))
		if(confirm("기존사진을 삭제하시겠습니까?") != true){
			return false;
		}else{
			$(this).parent().parent().hide();
			$(this).parent().parent().parent().children("div.stepImage_deleted").show();
			$(this).parent().parent().find("#stepImageUrl").removeAttr("value");
			$(this).parent().parent().parent().find(".stepImage_none").show();
			alert("기존사진이 삭제되었습니다. 새로운 사진을 등록해주세요.");
		}
	})
	
	
	$(document).on("click", "#backStepImgBtn", function(){
		//console.log($(this).parent().parent().children(".stepImage").find("#stepImageUrl"));
		//console.log($(this).parent().parent().children(".stepImage").find("img").prop("id"));
			$(this).parent().parent().find("div.stepImage_none").hide();
			$(this).parent().filter("div.stepImage_deleted").hide();
			$(this).parent().parent().children(".stepImage").show();
			$(this).parent().parent().children(".stepImage").find("#stepImageUrl").val($(this).parent().parent().children(".stepImage").find("img").prop("id"));
			$(this).parent().parent().children("#stepImageUrlSrc").prop("value","").hide();
	})
	
	$(document).on("click", "#backCrseBtn", function(){
		removeCrse_idx = 0;
		crse_idx= list_size;

		$(".recipe_crse_table").show();
		$(".recipe_crse_table[id=newCrseRow]").remove();
		$(".recipe_crse_table").each(function(){
			$(this).find("#cookingNo").prop("name", "currentCrseList["+$(this).prop("id")+"].cookingNo");
			$(this).find("#cookingDc").prop("name", "currentCrseList["+$(this).prop("id")+"].cookingDc");
			$(this).find("#stepImageUrlSrc").prop("name", "currentCrseList["+$(this).prop("id")+"].stepImageUrlSrc");
			$(this).find("#stepImageUrl").prop("name", "currentCrseList["+$(this).prop("id")+"].stepImageUrl");
			$(this).find("#stepTip").prop("name", "currentCrseList["+$(this).prop("id")+"].stepTip");
		})
	})

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

tr, td{
border:1px solid black
}

.recipe_crse_table {
margin-bottom: 10px;
}
.stepImage_button{
position: absolute;
top:5px;
right: 50px;
}

h2, h3{
	text-align: center;
}
</style>



<h2>레시피 업데이트</h2>
<form id="recipe_register_form" 
	action="${ initParam.rootPath }/common/admin/recipe/crse/update.do" 
	enctype="multipart/form-data" method="post">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
	<input type="hidden" name="recipeId" value="${requestScope.recipe.recipeId}"> 
		
	<h3 style="margin:10px">레시피 과정정보</h3>
	<!-- 레시피 과정정보 -->
	<div id="recipe_crse" style="padding-left: 10px; padding-right: 10px; padding-top: 5px; padding-bottom: 10px;  margin-bottom: 20px">
	
	
	<button type="button" class="btn btn-default" id="crseBtn">+과정추가</button>
	<button type="button" class="btn btn-default" id="deleteCrseBtn"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>	
		
		<div id="recipe_crse_table">
		
		<c:forEach items="${ requestScope.recipe.recipeCrseList }" var="recipeCrse">
		<table class="recipe_crse_table" id="${ recipeCrse.cookingNo }">
			<tbody>
					<tr>
						<td  rowspan="3" width="60px">
						<input type="hidden" id="cookingNo" name="currentCrseList[${recipeCrse.cookingNo-1}].cookingNo" 
						value=" ${ recipeCrse.cookingNo }">${ recipeCrse.cookingNo }<br>
						</td>
						
						<td width="300px" >
						<textarea cols="60" rows="3" id="cookingDc" name="currentCrseList[${recipeCrse.cookingNo-1}].cookingDc">${recipeCrse.cookingDc}</textarea>
						</td>
					</tr>
					
					<tr>
					<td>
					<c:choose>
						<c:when test="${ recipeCrse.stepImageUrl eq 'null' || empty recipeCrse.stepImageUrl || recipeCrse.stepImageUrl == null}">
							<div class="stepImage">
								<input type="file" id="stepImageUrlSrc" class="btn btn-default" name="currentCrseList[${recipeCrse.cookingNo-1}].stepImageUrlSrc" >
							</div>
							</c:when>
							<c:otherwise>
							<div class="stepImage_none">
								<input type="file" id="stepImageUrlSrc" name="currentCrseList[${recipeCrse.cookingNo-1}].stepImageUrlSrc" >
							</div>
							<div class="stepImage">
								<!-- 내가 저장한 사진경로와 API 사진경로가 다른 문제 해결해야함 -->
								<img src="${ recipeCrse.stepImageUrl }" height="150px" id="${ recipeCrse.stepImageUrl }">
								<input type="hidden" id="stepImageUrl" name="currentCrseList[${recipeCrse.cookingNo-1}].stepImageUrl" value="${ recipeCrse.stepImageUrl }">
								<div class="stepImage_button">
									<button type="button" class="btn btn-danger" id="deleteStepImgBtn"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button>
								</div>
							</div>
							</c:otherwise>
						</c:choose>
							<div class="stepImage_deleted">
								<button type="button" class="btn btn-default" id="backStepImgBtn">원래 사진 복구</button>
							</div>
						</td>
					</tr>
					
					
					<tr>
						<td>
						<c:choose>
						<c:when test="${ recipeCrse.stepTip eq 'null' || empty recipeCrse.stepTip || recipeCrse.stepTip == null}">
						<input type="text" id="stepTip" name="currentCrseList[${recipeCrse.cookingNo-1}].stepTip" placeholder="입력된 팁이 없습니다!" size="60">
						</c:when>
						<c:otherwise>
						<input type="text" id="stepTip"  name="currentCrseList[${recipeCrse.cookingNo-1}].stepTip" value=" ${ recipeCrse.stepTip }" size="60">
						</c:otherwise>
						</c:choose>
						</td>
					</tr>
			</tbody>
		</table>
		</c:forEach>
		
		
	</div>
	</div>
	<input type="submit" class="btn btn-warning" id="updateBtn" value="업데이트">
	<input type="reset" class="btn btn-warning" value="초기화">
	
</form>