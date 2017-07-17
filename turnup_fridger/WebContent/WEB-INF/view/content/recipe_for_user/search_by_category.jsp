<%@ page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>                                                      
<meta charset="UTF-8">
<title>레시피 by 카테고리</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
function getList(keyword,page){
	$("#apiTbody").empty();
	$("#pageBean").empty();
	if(!page) page = 1;
	
	$.ajax({
		"url":"/turnup_fridger/findRecipeByCategory.do",
		"data":{'categoryName' : $("#categoryName").val(),'typeName' : $("#typeName").val(),'keyword' : keyword,'page':page,'${_csrf.parameterName}':'${_csrf.token}'},
		"dataType":"json", 
		"success":function(list){
			$("#sortKeyword").show();
			$("#apiThead").show();
			$("#apiTbody").empty();
			$.each(list.list, function(){
				$("#apiTbody").append($("<tr>").prop("class","apiRecipe_col").append($("<td>").append(this.recipeId))
						.append($("<td>").prop("id", "title").append($("<a>").prop("href", "${initParam.rootPath}/recipe/show/detail.do?recipeId="+this.recipeId).append(this.recipeName))).append($("<td>").append(this.sumry))
						.append($("<td>").append(this.categoryName)).append($("<td>").append(this.typeName)).append($("<td>").append(this.cookingTime)).append($("<td>").append(this.calorie)).append($("<td>").append(this.recipeLevel))
						.append($("<td>").append(this.recipeHits)));
				});//each
			 	$("#pageBean").append($("<a href='javascript:getList("+keyword+",1)'>").append("첫페이지"));
			
			 	if(list.pageBean.previousPageGroup!=null){
			 		$("#pageBean").append($("<a href='javascript:getList("+keyword+","+(list.pageBean.beginPage-1)+")'>").append("◀"));
			 		
				}else{
					$("#pageBean").append("◀");
				} 	
			 	for(var index = list.pageBean.beginPage ; index <= list.pageBean.endPage ; index++){
			 		if(index !=list.pageBean.page){
			 			$("#pageBean").append($("<a href='javascript:getList("+keyword+","+index+")'>").append(index));
					}else{
						$("#pageBean").append("["+index+"]"+"&nbsp;&nbsp;");
					}
			 	}
			 	if(list.pageBean.nextPageGroup!=null){
			 		$("#pageBean").append($("<a href ='javascript:getList("+keyword+","+(list.pageBean.endPage+1)+")'>").append("▶"));
			 	}else{
			 		$("#pageBean").append("▶");
			 	}
			 	$("#pageBean").append($("<a href = 'javascript:getList("+keyword+","+(list.pageBean.totalPage)+")'>").append("마지막 페이지"));
		},//success
		"error":function(errorMsg){
			alert("오류다!");
		} 
	})//ajax
	
};//페이징 함수 


$(document).ready(function(){
	
	//테이블정렬기준 숨김.
	$("#sortKeyword").hide();
	$("#apiThead").hide();
	
	$(document).on("click","#searchBtn",function(){
		$("#sortKeyword").show();
		getList(null,1);
	})//searchBtn	
	
	$("#categoryName").on("change",function(){
		$.ajax({
			"url":"/turnup_fridger/getTypeNameCategory.do",
			"type":"POST",
			"data":{'categoryName' : $("#categoryName").val(),'${_csrf.parameterName}':'${_csrf.token}'},
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
	});//categoryName
	
	$(document).on("click",("#hitsDesc"),function(){
		getList('recipeHitsDesc',1);
	});//최다조회순
	
	$(document).on("click",("#hitsAsc"),function(){
		getList('recipeHitsAsc',1);
	});//최저조회순
	
	$(document).on("click",("#calorieDesc"),function(){
		getList('calorieDesc',1);
	});//고칼로리순
	
	$(document).on("click",("#calorieAsc"),function(){
		getList('calorieAsc',1);
	});//저칼로리순
	
	$(document).on("change",("#recipeLevel"),function(){
		getList($("#recipeLevel").val(),1);
	});//난이도 
	
})//ready
</script>
</head>
<body>

<!--유형분류입력받는창-> 음식분류입력받는창 -> 검색 -> 레시피info들(페이징) (레시피공유게시판은 유형분류는 안받겠지?)  -->
<!--검색 전 화면이 비어있을테니, top4들 불러오는작업? 여기서는 레시피쪽 조회수 top4  -->
<div class="container">
	<div style= "text-align:center;">
	<h2>카테고리로 레시피 찾기</h2><hr>
	유형분류 :
	<select name="categoryName" id="categoryName">
		<option value="전체">전체</option>
		<option value="한식">한식</option>
		<option value="서양">서양</option>
		<option value="중국">중국</option>
		<option value="일본">일본</option>
		<option value="이탈리아">이탈리아</option>
		<option value="동남아시아">동남아시아</option>
		<option value="퓨전">퓨전</option>
	</select>&emsp;&emsp;
	음식분류 :  
	<select name="typeName" id="typeName">
		<!--첫번째꺼에 따라서 동적으로 받아서 뿌리자.  -->
	</select> &emsp;
	<button type="button" class="btn btn-warning" id="searchBtn">검색</button><br><br><br><br>
	</div>
	
	<div id="sortKeyword">
	<button type="button" class="btn btn-default" id="hitsDesc">최다조회순</button>
	<button type="button" class="btn btn-default" id="hitsAsc">최저조회순</button>
	<button type="button" class="btn btn-default" id="calorieDesc">고칼로리순</button>
	<button type="button" class="btn btn-default" id="calorieAsc">저칼로리순</button>
	<select name="recipeLevel" id="recipeLevel">
		<option value="전체">전체</option>
		<option value="초보환영">초보</option>
		<option value="보통">보통</option>
		<option value="어려움">어려움</option>
	</select>
	</div><br>	
	
	<div id="apiResult">
		<table  class="table table-hover table-condensed" style="width:100%; border:5;">
			<thead id="apiThead">
				<tr>
					<th>레시피id</th>
					<th>이름</th>
					<th>간략소개</th>
					<th>유형분류</th>
					<th>음식분류</th>
					<th>조리시간</th>
					<th>칼로리</th>
					<th>난이도</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody id="apiTbody"></tbody>
		</table>
	</div>
	<div id="pageBean" style = "text-align:center;"></div>
	</div>
</body>
</html>