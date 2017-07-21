<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 by 레시피명</title>
<link href="${initParam.rootPath }/css/cardList.css" rel="stylesheet" type="text/css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script type="text/javascript">
function getApiList(keyword,page){
	$("#apiResult").show();
	$("#apiTbody").empty();
	$("#apiPageBean").empty();
	if(!page) page = 1;
	
	$.ajax({
		"url":"/turnup_fridger/findApiRecipeByRecipeName.do",
		//"type":"POST",
		"data":{'recipeName' : $("#recipeName").val(),'keyword' : keyword,'page':page,'${_csrf.parameterName}':'${_csrf.token}'},
		"dataType":"json", 
		"success":function(map){
			$("#apiPageBean").empty();
			$("#apiTbody").empty();	
			$.each(map.apiList.list, function(){
				$("#apiTbody").append($("<tr>").prop("class","apiRecipe_col").append($("<td>").append(this.recipeId))
						.append($("<td>").prop("id", "title").append($("<a>").prop("href", "${initParam.rootPath}/recipe/show/detail.do?recipeId="+this.recipeId).append(this.recipeName))).append($("<td>").append(this.sumry))
						.append($("<td>").append(this.categoryName)).append($("<td>").append(this.typeName)).append($("<td>").append(this.cookingTime)).append($("<td>").append(this.calorie)).append($("<td>").append(this.recipeLevel))
						.append($("<td>").append(this.recipeHits)));
			 });//each	 
			 
			 	$("#apiPageBean").append($("<a href='javascript:getApiList(\""+keyword+"\",1)'>").append("첫페이지"));
			
			 	if(map.apiList.pageBean.previousPageGroup!=null){
			 		$("#apiPageBean").append($("<a href='javascript:getApiList(\""+keyword+"\","+(map.apiList.pageBean.beginPage-1)+")'>").append("◀"));
			 		
				}else{
					$("#apiPageBean").append("◀");
				} 	
			 	for(var index = map.apiList.pageBean.beginPage ; index <= map.apiList.pageBean.endPage ; index++){
			 		if(index !=map.apiList.pageBean.page){
			 			$("#apiPageBean").append($("<a href='javascript:getApiList(\""+keyword+"\","+index+")'>").append(index));
					}else{
						$("#apiPageBean").append("["+index+"]"+"&nbsp;&nbsp;");
					}
			 	}
			 	if(map.apiList.pageBean.nextPageGroup!=null){
			 		$("#apiPageBean").append($("<a href ='javascript:getApiList(\""+keyword+"\","+(map.apiList.pageBean.endPage+1)+")'>").append("▶"));
			 	}else{
			 		$("#apiPageBean").append("▶");
			 	}
			 	$("#apiPageBean").append($("<a href = 'javascript:getApiList(\""+keyword+"\","+map.apiList.pageBean.totalPage+")'>").append("마지막 페이지"));
			 	
		},//success
		"error":function(errorMsg){ 
			alert("오류다!");
		} 
	})//ajax
	
};//페이징 함수 

function getUserList(page){
	$("#userResult").show();
	$("#userPageBean").empty();
	if(!page) page = 1;
	
	$.ajax({
		"url":"/turnup_fridger/findUserRecipeByRecipeName.do",
		//"type":"POST",
		"data":{'recipeName' : $("#recipeName").val(),'page':page,'${_csrf.parameterName}':'${_csrf.token}'},
		"dataType":"json", 
		"success":function(map){
			$("#userPageBean").empty();
			
			 $.each(map.userList.list, function(){
				 $("#userUL").append($("<li>").append($("<a>").prop("href","${initParam.rootPath}/boardRecipe/boardRecipeView.do?recipeId="+this.recipeId).prop("class","inner2")
							.append($("<div>").prop("class","li-text2").prop("style","height:50px").append($("<p>").prop("class","li-sub2").append(this.recipeId)))  
						.append($("<div>").prop("class","li-img2").prop("style","height:150px").append($("<img>").prop("src","${initParam.rootPath}/img/"+this.original).prop("style","height:150px").prop("alt",this.original)))
						.append($("<div>").prop("class","li-text2").prop("style","height:70px").append($("<p>").prop("class","li-head2").append(this.title)))
						.append($("<div>").prop("class","li-text2").prop("style","height:50px").append($("<h5>").prop("class","li-head2").append($("<i>").prop("class","glyphicon glyphicon-user")
								.prop("style","font-size:20px").append(this.memberId)))
								.append($("<div>")).prop("class","li-text2").prop("style","height:60px").append($("<p>").prop("class","li-sub2")
								.append($("<i>").prop("class","glyphicon glyphicon-eye-open").prop("style","font-size:20px").append(this.hits)))))
						.append($("<form>").prop("method","post").prop("action","${initParam.rootPath }/common/boardRecipe/increaseRecommand.do")
								.append($("<input>").prop("type","hidden").prop("name","${_csrf.parameterName }").prop("value","${_csrf.token }"))
								.append($("<input>").prop("type","hidden").prop("name","recipeId").prop("value",this.recipeId))
								.append($("<input>").prop("type","hidden").prop("name","memberId").prop("value",this.memberId))
								.append($("<input>").prop("type","hidden").prop("name","recommand").prop("value",this.recommand))
								.append($("<a>").prop("href","#").prop("onClick","this.parentNode.submit()").prop("id","recommand-btn")
										.append($("<i>").prop("class","glyphicon glyphicon-thumbs-up").prop("style","font-size:20px")
										.append(this.recommand)))));
			 });
			 	$("#userPageBean").append($("<a href='javascript:getUserList(1)'>").append("첫페이지"));
				
			 	if(map.userList.pageBean.previousPageGroup!=null){
			 		$("#userPageBean").append($("<a href='javascript:getUserList("+(map.userList.pageBean.beginPage-1)+")'>").append("◀"));
			 		
				}else{
					$("#userPageBean").append("◀");
				} 	
			 	for(var index = map.userList.pageBean.beginPage ; index <= map.userList.pageBean.endPage ; index++){
			 		if(index !=map.userList.pageBean.page){
			 			$("#userPageBean").append($("<a href='javascript:getUserList("+index+")'>").append(index));
					}else{
						$("#userPageBean").append("["+index+"]"+"&nbsp;&nbsp;");
					}
			 	}
			 	if(map.userList.pageBean.nextPageGroup!=null){
			 		$("#userPageBean").append($("<a href ='javascript:getUserList("+(map.userList.pageBean.endPage+1)+")'>").append("▶"));
			 	}else{
			 		$("#userPageBean").append("▶");
			 	}
			 	$("#userPageBean").append($("<a href = 'javascript:getUserList("+(map.userList.pageBean.totalPage)+")'>").append("마지막 페이지"));
		},//success
		"error":function(errorMsg){
			alert("오류다!");
		} 
	})//ajax
	
};//페이징 함수 

$(document).ready(function(){
	
	//테이블정렬기준 숨김.
	$("#sortKeyword").hide();
	$("#apiResult").hide();
	$("#userResult").hide();
	
	$("#searchBtn").on("click",function(){
		$("#sortKeyword").show();
		getApiList(null,1);
		getUserList(1);
	})//searchBtn	

	$(document).on("click",("#hitsDesc"),function(){
		getApiList('recipeHitsDesc',1);		
	});//최다조회순

	$(document).on("click",("#hitsAsc"),function(){
		getApiList('recipeHitsAsc',1);
	});//최저조회순

	$(document).on("click",("#calrorieDesc"),function(){
		getApiList('calorieDesc',1);
	});//고칼로리순

	$(document).on("click",("#calrorieAsc"),function(){
		getApiList('calorieAsc',1);
	});//저칼로리순

	$(document).on("change",("#recipeLevel"),function(){
		getApiList($("#recipeLevel").val(),1);
	});//난이도 
	
})//ready
</script>
</head>
<body>
<div class="container">
<!--레시피명입력받는창-> 검색 -> 레시피info들(페이징) and 레시피공유게시판목록들(페이징)  -->
<!--검색 전 화면이 비어있을테니, top4들 불러오는작업? 여기서는 레시피공유게시판to4  -->
	<div style="text-align:center;">
	<h2 style="text-align:center; font-weight:bold;">요리이름으로 레시피 찾기</h2><hr>
	레시피명 검색 : 
	<input type="text" name ="recipeName" id="recipeName">
	<button type="button" class="btn btn-warning" id="searchBtn">검색</button><br><br><br><br>
	</div>
	
	<div id="sortKeyword" style="text-align:right;">
	<button type="button" class="btn btn-default" id="hitsDesc">최다조회순</button>
	<button type="button" class="btn btn-default" id="hitsAsc">최저조회순</button>
	<button type="button" class="btn btn-default" id="calrorieDesc">고칼로리순</button>
	<button type="button" class="btn btn-default" id="calrorieAsc">저칼로리순</button>
	<select name="recipeLevel" id="recipeLevel">
		<option value="전체">전체</option>
		<option value="초보환영">초보</option>
		<option value="보통">보통</option>
		<option value="어려움">어려움</option>
	</select>
	</div>
	
	<div id="apiResult">
		<h3>기본 레시피 </h3>
		<table class="table table-hover table-condensed" style="width:100%; border:5;">
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
	<div id="apiPageBean" style="text-align:center;"></div>
	<div id="userResult">
		<h3>사용자 레시피</h3>
		<ul class="list2 img-list2" id="userUL" style="border-style:ridge;"></ul>
	</div>
	<div id="userPageBean" style="text-align:center;" class="tableList"></div>
	</div>
</body>
</html>