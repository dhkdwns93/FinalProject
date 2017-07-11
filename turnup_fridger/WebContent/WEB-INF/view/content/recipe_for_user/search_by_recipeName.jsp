<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 by 레시피명</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	//테이블정렬기준 숨김.
	$("#sortKeyword").hide();
	
	$("#searchBtn").on("click",function(){
		//숨긴것 나타나게
		$("#sortKeyword").show();
		alert($("#recipeName").val());
		
		$.ajax({
			"url":"/turnup_fridger/findRecipeByRecipeName.do",
			"type":"POST",
			"data":{'recipeName' : $("#recipeName").val(),'keyword' : '보통','${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json",
			"success":function(map){
				$("#apiThead").empty();	
				$("#apiThead").empty();	
				$("#apiThead").append($("<tr>").prop("id","apiRecipe_col").append($("<th>").append("레시피id")).append($("<th>").append("이름")).append($("<th>").append("간략소개")).append($("<th>").append("유형분류"))
						.append($("<th>").append("음식분류")).append($("<th>").append("조리시간")).append($("<th>").append("칼로리")).append($("<th>").append("난이도")).append($("<th>").append("대표이미지"))
						.append($("<th>").append("조회수")));
				
				$("#userThead").append($("<tr>").prop("id","userRecipe_col").append($("<th>").append("레시피id")).append($("<th>").append("제목")).append($("<th>").append("작성자")).append($("<th>").append("작성일"))
						.append($("<th>").append("조회수")).append($("<th>").append("추천수")));
				
				$("#apiTbody").empty();	
				$.each(map.apiList, function(){
					$("#apiTbody").append($("<tr>").prop("id","apiRecipe_col").append($("<td>").append(this.recipeId)).append($("<td>").append(this.recipeName)).append($("<td>").append(this.sumry)).append($("<td>").append(this.categoryName))
							.append($("<td>").append(this.typeName)).append($("<td>").append(this.cookingTime)).append($("<td>").append(this.calorie)).append($("<td>").append(this.recipeLevel)).append($("<td>").append(this.imgUrl))
							.append($("<td>").append(this.recipeHits)));
				 });//each	 
				 
				 $("#userTbody").empty();
				 $.each(map.userList, function(){
					$("#userTbody").append($("<tr>").prop("id","userRecipe_col").append($("<td>").append(this.boardShareRecipeId)).append($("<td>").append(this.boardShareRecipeTitle)).append($("<td>").append(this.memberId))
							.append($("<td>").append(this.boardShareRecipeDate)).append($("<td>").append(this.boardShaerRecipeHits)).append($("<td>").append(this.boardShareRecipeRecommand)));
				 });//each			 
			},//success
			"error":function(xhr, msg, code){
				alert("오류발생-" +msg+ ":" +code);
			}//error
		})
	})//searchBtn	
	/* 
	$.ajax(function(){
		//top4가져오기
		"url":"/turnup_fridger/common/admin/irdntManage/allIrdntList.do",
		"dataType":"json", 
		"success":function(list){
			$.each(list, function(){
				$("#tbody").append($("<tr>").prop("id","irdnt_col").append($("<td>").append(this.irdntId)).append($("<td>").append(this.irdntName)).append($("<td>").append(this.irdntCategory))
				.append($("<td>").append(this.roomTemPeriod)).append($("<td>").append(this.coldTemPeriod)).append($("<td>").append(this.freezeTemPeriod)).append($("<td>").append(this.note))
				.append($("<td>").append($("<button>").prop("type","button").prop("id","updateBtn").append("수정")))
				.append($("<td>").append($("<button>").prop("type","button").prop("id","deleteBtn").append("삭제"))));
			 	});//each
		},//success
		"error":function(errorMsg){
			alert("오류다!");
		} 	
	})//ajax */
	
})//ready
</script>
</head>
<body>
<h2>요리이름으로 레시피 찾기</h2>

<!--레시피명입력받는창-> 검색 -> 레시피info들(페이징) and 레시피공유게시판목록들(페이징)  -->
<!--검색 전 화면이 비어있을테니, top4들 불러오는작업? 여기서는 레시피공유게시판to4  -->

	<!--레시피공유게시판 top4 가져올까?  -->

	레시피명검색
	<input type="text" name ="recipeName" id="recipeName">
	<button type="button" id="searchBtn">검색</button><br>
	
	<div id="sortKeyword">
	<button type="button" id="hitsDesc">최다조회순</button>
	<button type="button" id="hitsAsc">최저조회순</button>
	<button type="button" id="calrorieDesc">고칼로리순</button>
	<button type="button" id="calrorieAsc">저칼로리순</button>
	<select name="recipeLevel" id="recipeLevel">
		<option value="전체">전체</option>
		<option value="초보환영">초보</option>
		<option value="보통">보통</option>
		<option value="어려움">어려움</option>
	</select>
	</div>
	
	<div id="apiResult">
		<table>
			<thead id="apiThead"></thead>
			<tbody id="apiTbody"></tbody>
		</table>
	</div>
	<div id="userResult">
		<table>
			<thead id="userThead"></thead>
			<tbody id="userTbody"></tbody>
		</table>
	</div>
	
</body>
</html>