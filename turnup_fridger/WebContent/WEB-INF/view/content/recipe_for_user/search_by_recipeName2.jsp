<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 by 레시피명</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
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
			 	$("#apiPageBean").append($("<a href = 'javascript:getApiList(\""+keyword+"\","+(map.apiList.pageBean.totalPage)+")'>").append("마지막 페이지"));
			 	
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
	
			 $("#userTbody").empty();
			 $.each(map.userList.list, function(){
					$("#userTbody").append($("<tr>").prop("class","userRecipe_col").prop("id",this.recipeId).append($("<td>").append(this.recipeId))
							.append($("<a>").prop("href", "${initParam.rootPath}/recipe/show/detailOfBoard.do?recipeId="+this.recipeId).append(this.title))
							.append($("<td>").append("<img>").prop("src",this.imgUrl))
							.append($("<td>").append(this.memberId)).append($("<td>").append(this.date)).append($("<td>").append(this.hits)).append($("<td>").append(this.recommand)));
			 });//each			 
		
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
	<h2>요리이름으로 레시피 찾기</h2><hr>
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
		<table class="table table-hover table-condensed" style="width:80%; border:5;">
			<thead id="userThead">
				<tr>
					<th>레시피id</th>
					<th>제목</th>
					<th>img</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>추천수</th>
				</tr>
			</thead>
			<tbody id="userTbody"></tbody>
		</table>
	</div>
	<div id="userPageBean" style="text-align:center;" class="tableList"></div>
	</div>
</body>
</html>