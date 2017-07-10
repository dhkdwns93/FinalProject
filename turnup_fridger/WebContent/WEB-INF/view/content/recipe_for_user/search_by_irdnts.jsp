<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 by 재료</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	//테이블정렬기준 숨김.
	$("#sortKeyword").hide();
	
	$.ajax(function(){
		//재료관리에서 식재료들 리스트로 받아오기.
		//재료관리 - 재료명, 체크박스	
		"url":"/turnup_fridger/common/admin/irdntManage/allIrdntList.do",
		"type":"POST",
		"dataType":"json",
		"success":function(list){
			$("#irdntManageThead").empty();	
			$("#irdntManageThead").append($("<tr>").prop("id","irdntManage_col").append($("<th>").append("레시피id")
			$("#irdntManageTbody").empty();	
			$.each(list, function(){
				$("#irdntManageTbody").append($("<tr>").prop("id","apiRecipe_col").append($("<td>").append(this.recipeId)).append($("<td>").append(this.recipeName)).append($("<td>").append(this.sumry)).append($("<td>").append(this.categoryName))
					.append($("<td>").append(this.typeName)).append($("<td>").append(this.cookingTime)).append($("<td>").append(this.calorie)).append($("<td>").append(this.recipeLevel)).append($("<td>").append(this.imgUrl))
					.append($("<td>").append(this.recipeHits)));
				 });//each	 		 
			},//success
			"error":function(xhr, msg, code){
				alert("오류발생-" +msg+ ":" +code);
			}//error
	});
	$.ajax(function(){
		//나의식재료랑에서 식재료들 리스트로 받아오기.
		//나의식재료 - 재료명,신선도?, 체크박스
		"url":"/turnup_fridger/common/member/myIrdnt/allMyIrdntList.do",
		"type":"POST",
		"dataType":"json", 
		"success":function(list){
			$("#myIrdntThead").empty();	
			$("#myIrdntThead").append($("<tr>").prop("id","apiRecipe_col").append($("<th>").append("레시피id")).append($("<th>").append("이름"))pend($("<th>").append("유형분류"))
				.append($("<th>").append("음식분류")).append($("<th>").append("조리시간")).append($("<th>").append("칼로리")).append($("<th>").append("난이도")).append($("<th>").append("대표이미지"))
				.append($("<th>").append("조회수")));
			$("#myIrdntTbody").empty();	
			$.each(list, function(){
				$("#myIrdntTbody").append($("<tr>").prop("id","apiRecipe_col").append($("<td>").append(this.recipeId)).append($("<td>").append(this.recipeName)).append($("<td>").append(this.sumry)).append($("<td>").append(this.categoryName))
					.append($("<td>").append(this.typeName)).append($("<td>").append(this.cookingTime)).append($("<td>").append(this.calorie)).append($("<td>").append(this.recipeLevel)).append($("<td>").append(this.imgUrl))
					.append($("<td>").append(this.recipeHits)));
				 });//each	 		 
			},//success
			"error":function(xhr, msg, code){
				alert("오류발생-" +msg+ ":" +code);
			}//error	
	});//ajax2
	
	
	$(document).on("click",("#dislikeBtn"),function(){
		//체크박스로 선택된 재료들 기피재료테이블로 옮기기
		var irdntId = $(this).parent().children(":first-child").text();
		window.open("/turnup_fridger/common/member/myIrdnt/findIrdntByKey.do?myIrdntKey="+myIrdntKey,"detail","width=500, height=400");
	
	});//기피재료버튼
	
	$(document).on("click",("#likeBtn"),function(){
		//체크박스로 선택된 재료들 선택재료테이블로 옮기기
	});//선택재료버튼
	
	$(document).on("click",("선택재료,기피재료 컬럼"),function(){
		//테이블에서 삭제처리 
	});//컬럼클릭
	
	$(document).on("click",("#searchBtn"),function(){
		//숨김되었던것 나타나게 
		
		//선택재료, 기피재료 리스트에 넣어서 핸들러로 보내기 
		
		//var dislikes = 
		//var likes = 
		$.ajax({
			"url":"/turnup_fridger/findRecipeByIrdntId.do",
			"type":"POST",
			"data":{'irdntIds' : $("#recipeName").val(),'hateIrdntIds' : $("#recipeName").val(),'keyword' : $("#recipeName").val(),'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json",
			"success":function(obj){
				
				$("#apiThead").append($("<tr>").prop("id","apiRecipe_col").append($("<th>").append("레시피id")).append($("<th>").append("이름")).append($("<th>").append("간략소개")).append($("<th>").append("유형분류"))
						.append($("<th>").append("음식분류")).append($("<th>").append("조리시간")).append($("<th>").append("칼로리")).append($("<th>").append("난이도")).append($("<th>").append("대표이미지"))
						.append($("<th>").append("조회수")));
				
				$("#userThead").append($("<tr>").prop("id","userRecipe_col").append($("<th>").append("레시피id")).append($("<th>").append("제목")).append($("<th>").append("작성자")).append($("<th>").append("작성일"))
						.append($("<th>").append("조회수")).append($("<th>").append("추천수")));
				
				$("#apiTbody").empty();	
				$.each(map.apiList, function(){
					$("#apiTbody").append($("<tr>").prop("id","apiRecipe_col").append($("<td>").append("레시피id")).append($("<td>").append("이름")).append($("<td>").append("간략소개")).append($("<td>").append("유형분류"))
							.append($("<td>").append("음식분류")).append($("<td>").append("조리시간")).append($("<td>").append("칼로리")).append($("<td>").append("난이도")).append($("<td>").append("대표이미지"))
							.append($("<td>").append("조회수")));
				 });//each	 
				 
				 $("#userTbody").empty();
				 $.each(map.userList, function(){
					$("#userTbody").append($("<tr>").prop("id","userRecipe_col").append($("<td>").append("레시피id")).append($("<td>").append("제목")).append($("<td>").append("작성자")).append($("<td>").append("작성일"))
							.append($("<td>").append("조회수")).append($("<td>").append("추천수")));
				 });//each			
			},//success
			"error":function(xhr, msg, code){
				alert("오류발생-" +msg+ ":" +code);
			}
		})
	});//검색
	
	/* $(document).on("click",("#hitsDesc"),function(){
		
	});//최다조회순
	
	$(document).on("click",("#hitsAsc"),function(){
	
	});//최저조회순
	
	$(document).on("click",("#calrorieDesc"),function(){
	
	});//고칼로리순
	
	$(document).on("click",("#calrorieAsc"),function(){
	
	});//저칼로리순
	
	$(document).on("change",("#recipeLevel"),function(){

	});//난이도 */
	
})//ready
</script>
</head>
<body>
<h2>재료로 레시피 찾기</h2>

<!--나의식재료 / 재료관리  ->  나의 기피재료/나의 선택재료 -> 검색버튼 -> 레시피info들(페이징) and 레시피공유게시판목록들(페이징)-->
	
	나의 식재료 : 
	<div id="myIrdnt">
		<table>
			<thead id="myIrdntThead"></thead>
			<tbody id="myIrdntTbody"></tbody>
		</table>
	</div>
	기타 재료 : 
	<div id="irdntManage">
		<table>
			<thead id="irdntManageThead"></thead>
			<tbody id="irdntManageTbody"></tbody>
		</table>
	</div>
	<!--체크박스 골라서 버튼누르면 이동 다중선택가능하지만, 4개이하 -->
	<button type="button" id="likeBtn">선택재료</button><br>
	<button type="button" id="dislikeBtn">기피재료</button><br>

	<!--컬럼누르면 테이블에서 삭제  -->
	기피재료 : 
	<div id="dislikeResult">
		<table>
			<thead id="dislikeThead"></thead>
			<tbody id="dislikeTbody"></tbody>
		</table>
	</div>
	선택재료 : 
	<div id="likeResult">
		<table>
			<thead id="likeThead"></thead>
			<tbody id="likeTbody"></tbody>
		</table>
	</div>
	
	<!--위의 재료들을 리스트에 담아서 재료로 검색하는 핸들러로 보낸다. -->
	<button type="button" id="searchBtn">레시피검색</button><br>

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