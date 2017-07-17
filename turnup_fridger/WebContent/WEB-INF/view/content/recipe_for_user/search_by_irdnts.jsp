<%@ page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 by 재료</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
function getList(keyword,page){
	$("#apiThead").show();
	$("#userResult").show();
	$("#apiPageBean").show();
	$("#userPageBean").show();
	$("#sortKeyword").show();
	
	if(!page) page = 1;
	
	var dislikes = [];
	var likes = [];
	
	$("#dislikeTbody tr").each(function(){
		dislikes.push($(this).children(":first-child").text());
	}); 
	$("#likeTbody tr").each(function(){
		likes.push($(this).children(":first-child").text());
	}); 

	$.ajax({		
		"url":"/turnup_fridger/findRecipeByIrdntId.do",
		"type":"POST",
		"data":'irdntIds='+likes+'&hateIrdntIds='+dislikes+'&keyword='+keyword+'&page='+page+'&${_csrf.parameterName}=${_csrf.token}',
		//"data":{'irdntIds':likes, 'hateIrdntIds':dislikes,'keyword':'보통','page':1,'${_csrf.parameterName}':'${_csrf.token}'},
		"dataType":"json",
		"success":function(map){
			$("#apiPageBean").empty();
			$("#userPageBean").empty();
			$("#apiTbody").empty();	
			$.each(map.apiMap.apiList, function(){
				$("#apiTbody").append($("<tr>").prop("class","apiRecipe_col").prop("id",this.recipeId).append($("<td>").append("")).append($("<td>").append(this.recipeId))
						.append($("<td>").prop("id", "title").append($("<a>").prop("href", "${initParam.rootPath}/recipe/show/detail.do?recipeId="+this.recipeId).append(this.recipeName))).append($("<td>").append(this.sumry))
						.append($("<td>").append(this.categoryName)).append($("<td>").append(this.typeName)).append($("<td>").append(this.cookingTime)).append($("<td>").append(this.calorie)).append($("<td>").append(this.recipeLevel))
						.append($("<td>").append(this.recipeHits)));
			 });//each	 
			$.each(map.apiMap.countList, function(){
				$("#"+this.recipe_id).children(":first-child").text(this.count);
			 });//each	 
			 
			 $("#userTbody").empty();
			 $.each(map.userMap.userList, function(){
					$("#userTbody").append($("<tr>").prop("class","userRecipe_col").prop("id",this.recipeId).append($("<td>").append("")).append($("<td>").append(this.recipeId))
							.append($("<td>").prop("id", "title").append($("<a>").prop("href", "${initParam.rootPath}/recipe/show/detailOfBoard.do?recipeId="+this.recipeId).append(this.title)))
							.append($("<td>").append(this.memberId)).append($("<td>").append(this.date)).append($("<td>").append(this.hits)).append($("<td>").append(this.recommand)));
			 });//each
			 $.each(map.userMap.countList, function(){
					$("#"+this.recipeId).children(":first-child").text(this.count);
				});//each
		
		//페이징		

			 	$("#apiPageBean").append($("<a href='javascript:getList("+keyword+",1)'>").append("첫페이지"));
			
			 	if(map.apiMap.pageBean.previousPageGroup!=null){
			 		$("#apiPageBean").append($("<a href='javascript:getList("+keyword+","+(map.apiMap.pageBean.beginPage-1)+")'>").append("◀"));
			 		
				}else{
					$("#apiPageBean").append("◀");
				} 	
			 	for(var index = map.apiMap.pageBean.beginPage ; index <= map.apiMap.pageBean.endPage ; index++){
			 		if(index !=map.apiMap.pageBean.page){
			 			$("#apiPageBean").append($("<a href='javascript:getList("+keyword+","+index+")'>").append(index));
					}else{
						$("#apiPageBean").append("["+index+"]"+"&nbsp;&nbsp;");
					}
			 	}
			 	if(map.apiMap.pageBean.nextPageGroup!=null){
			 		$("#apiPageBean").append($("<a href ='javascript:getList("+keyword+","+(map.apiMap.pageBean.endPage+1)+")'>").append("▶"));
			 	}else{
			 		$("#apiPageBean").append("▶");
			 	}
			 	$("#apiPageBean").append($("<a href = 'javascript:getList("+keyword+","+(map.apiMap.pageBean.totalPage)+")'>").append("마지막 페이지"));
			 	
			 	//============================
			 	
			 	$("#userPageBean").append($("<a href='javascript:getList("+keyword+",1)'>").append("첫페이지"));
				
			 	if(map.userMap.pageBean.previousPageGroup!=null){
			 		$("#userPageBean").append($("<a href='javascript:getList("+keyword+","+(map.userMap.pageBean.beginPage-1)+")'>").append("◀"));
			 		
				}else{
					$("#userPageBean").append("◀");
				} 	
			 	for(var index = map.userMap.pageBean.beginPage ; index <= map.userMap.pageBean.endPage ; index++){
			 		if(index !=map.userMap.pageBean.page){
			 			$("#userPageBean").append($("<a href='javascript:getList("+keyword+","+index+")'>").append(index));
					}else{
						$("#userPageBean").append("["+index+"]"+"&nbsp;&nbsp;");
					}
			 	}
			 	if(map.userMap.pageBean.nextPageGroup!=null){
			 		$("#userPageBean").append($("<a href ='javascript:getList("+keyword+","+(map.userMap.pageBean.endPage+1)+")'>").append("▶"));
			 	}else{
			 		$("#userPageBean").append("▶");
			 	}
			 	$("#userPageBean").append($("<a href = 'javascript:getList("+keyword+","+(map.userMap.pageBean.totalPage)+")'>").append("마지막 페이지"));
		
		},//success
		"error":function(errorMsg){
			alert("오류다!");
		} 
	})//ajax
	
};//페이징 함수 


$(document).ready(function(){
	
	$("#sortKeyword").hide();
	$("#dislikeResult").hide();
	$("#likeResult").hide();
	$("#apiThead").hide();	
	$("#userResult").hide();	
	$("#apiPageBean").hide();
	$("#userPageBean").hide();
	$("#myFridersThead").hide();
	$("#myIrdnt").hide();
	
	$.ajax({
		//재료관리에서 식재료들 리스트로 받아오기.
		//재료관리 - 재료명, 선택, 기피	
		"url":"/turnup_fridger/getIrdntList.do",
		//"type":"POST",
		"dataType":"json",
		"success":function(list){
			$("#irdntManageThead").empty();	
			$("#irdntManageThead").append($("<tr>").append($("<th>").append("재료명")).append($("<th>").append("선택")).append($("<th>").append("기피")));
			$("#irdntManageTbody").empty();	
			$.each(list, function(){
				$("#irdntManageTbody").append($("<tr>").prop("class","irdnt_col").append($("<td>").append(this.irdntName))
						.append($("<td>").append($("<button>").prop("type","button").prop("class","likeBtn").prop("value",this.irdntId).append("선택")))
						.append($("<td>").append($("<button>").prop("type","button").prop("class","dislikeBtn").prop("value",this.irdntId).append("기피"))));
				 });//each	 		 
			},//success
			"error":function(xhr, msg, code){
				alert("오류발생-" +msg+ ":" +code);
			}//error
	});//ajax1
	
	//*******************************************************************************************************************************************************

	$("#getMyFridger").on("click",function(){
		
		$.ajax({	
			//나의 냉장고들 불러오기 
			//냉장고id, 냉장고 이름, 선택버튼
				"url":"/turnup_fridger/getFridgers.do", 
				//"type":"POST",
				"data":{'${_csrf.parameterName}':'${_csrf.token}'},
				"dataType":"json", 
				"success":function(list){
					$("#myFridersThead").show();
					$.each(list, function(){
						$("#myFridersTbody").append($("<tr>").append($("<td>").append(this.fridgerId)).append($("<td>").append(this.fridgerName))
								.append($("<td>").append($("<button>").prop("type","button").prop("class","selectFridger").prop("value",this.fridgerId).append("선택"))));
						})
					},//success
					"error":function(xhr, msg, code){ 
						if(msg=='error'&&code=='Internal Server Error'){
							alert("비회원은 불러올 수 없습니다.");
						}else{
							alert("오류발생-" +msg+ ":" +code);	
						}
						
					}//error	
			});//ajax2
	});
	
	
	$(document).on("click",".selectFridger",function(){
		$("#myIrdnt").show();		
		var fridgerId = $(this).val();
		$.ajax({
			//나의식재료 - 재료명,신선도, 선택, 기피
			"url":"/turnup_fridger/getMyIrdntList.do", 
			"type":"POST",
			"data":{'fridgerId':fridgerId,'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json", 
			"success":function(list){
				$("#myIrdntThead").empty();	
				$("#myIrdntThead").append($("<tr>").append($("<th>").append("재료명")).append($("<th>").append("신선도")).append($("<th>").append("선택"))
						.append($("<th>").append("기피")));
				$("#myIrdntTbody").empty();	
				$.each(list, function(){
					$("#myIrdntTbody").append($("<tr>").prop("class","irdnt_col").append($("<td>").append(this.irdntName)).append($("<td>").append(this.freshLevel))
							.append($("<td>").append($("<button>").prop("type","button").prop("class","likeBtn").prop("value",this.irdntId).append("선택")))
							.append($("<td>").append($("<button>").prop("type","button").prop("class","dislikeBtn").prop("value",this.irdntId).append("기피"))));	 
					})
				},//success
				"error":function(xhr, msg, code){ 
						alert("오류발생-" +msg+ ":" +code);	
					
				}//error	
		});//ajax3
	});//냉장고선택-> 식재료 보여주기 
	
	$("#getMydislike").on("click",function(){
	
		$.ajax({
			//나의 기피재료 받아오기.
			"url":"/turnup_fridger/getMyDislikeIrdnt.do", 
			"type":"POST",
			"data":{'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json", 
			"success":function(map){
				$("#dislikeResult").show();
				$.each(map.dislikeIrdnt, function(){
					
					$("#dislikeTbody").append($("<tr>").prop("class","select_col").prop("id",this.irdntId).append($("<td>").append(this.irdntId)).append($("<td>").append('')));	 
					})
				$.each(map.irdntList, function(){
					$("#"+this.irdntId).children(":nth-child(2)").text(this.irdntName);	 
					})	
				},//success
				"error":function(xhr, msg, code){ 
					if(msg=='error'&&code=='Internal Server Error'){
						alert("비회원은 불러올 수 없습니다.");
					}else{
						alert("오류발생-" +msg+ ":" +code);	
					}
						
				}//error	
		});//ajax4
	});
	
	//*******************************************************************************************************************************************************
	$(document).on("click",(".dislikeBtn"),function(){
		var irdntId = $(this).val();
		var irdntName= $(this).parent().parent().children(":first-child");
		$("#dislikeResult").show();
		$("#dislikeTbody").append($("<tr>").prop("class","select_col").append($("<td>").append(irdntId)).append($("<td>").append(irdntName)));
		$(this).parent().parent().remove();
	});//기피재료버튼
	
	$(document).on("click",(".likeBtn"),function(){
		var irdntId = $(this).val();
		var irdntName= $(this).parent().parent().children(":first-child");
		$("#likeResult").show();
		$("#likeTbody").append($("<tr>").prop("class","select_col").append($("<td>").append(irdntId)).append($("<td>").append(irdntName)));
		$(this).parent().parent().remove();
	});//선택재료버튼
	
	$(document).on("click",(".select_col"),function(){
		//테이블에서 삭제처리 
		$(this).remove();
	});//컬럼클릭
	
	$(document).on("click",("#searchBtn"),function(){
		//선택재료, 기피재료 리스트에 넣어서 핸들러로 보내기 
		getList(null,1);
	});//검색
	
	$(document).on("click","#hitsDesc",function(){
		getList('recipeHitsDesc',1);
	});//최다조회순
	
	$(document).on("click","#hitsAsc",function(){
		getList('recipeHitsAsc',1);
	});//최저조회순
	
	$(document).on("click","#calrorieDesc",function(){
		getList('calorieDesc',1);
	});//고칼로리순
	
	$(document).on("click","#calrorieAsc",function(){
		getList('calorieAsc',1);
	});//저칼로리순
	
	$(document).on("change","#recipeLevel",function(){
		getList($("#recipeLevel").val(),1);
	});//난이도 

})//ready
</script>
</head>
<body>
<%-- <input type="hidden" id="memberId" value="<sec:authentication property='principal.memberId'/>">  --%>
<%-- <sec:authentication property="principal.memberId" var="memberId"/> --%>

<div style="text-align:center;"><h2>재료로 레시피 찾기</h2><br><hr></div>

	<div id="irdntManage" style="width:23%; border:5; float:left; border:5; overflow-x:hidden; overflow-y:scroll; height:600px;width:400px; margin:20px;">
	기타 재료 :   
		<table  class="table table-hover table-condensed" style="padding: 10px";>
			<thead id="irdntManageThead"></thead>
			<tbody id="irdntManageTbody"></tbody>
		</table>
	</div>
	
	
	<div id="myIrdntSection" style="width:23%; float: left; padding:10px;" >
	<div id="myFridgers" style="border:5; overflow-x:hidden; overflow-y:scroll; height:300px;width:350px;margin:20px;">
	나의 냉장고 목록 :
		<button type="button" id="getMyFridger" >냉장고불러오기</button>   
		<table class="table table-hover table-condensed" style=" border:5;">
			<thead id="myFridersThead">
				<tr>
				<th>냉장고id</th>
				<th>냉장고애칭</th>
				<th>선택</th>
			</tr>	
			</thead>
			<tbody id="myFridersTbody">
			</tbody>
		</table>
	</div><hr>
	<div id="myIrdnt" style="border:5; overflow-x:hidden; overflow-y:scroll; height:300px;width:350px;margin:20px;">
	냉장고 속 식재료 
		<table class="table table-hover table-condensed">
			<thead id="myIrdntThead"></thead>
			<tbody id="myIrdntTbody"></tbody>
		</table>
	</div>
	</div>

	
	<!--컬럼누르면 테이블에서 삭제  -->
	<div id="dislikeSection" style="width:23%; border:5;float: left;border:5; overflow-x:hidden; overflow-y:scroll; height:350px; margin:20px;">
	기피재료 : 
	<button type="button" id="getMydislike" >나의 기피재료 불러오기</button>
	<table id="dislikeResult" class="table table-hover table-condensed" >
		<thead id="dislikeThead">
			<tr>
				<th>재료id</th>
				<th>재료명</th>
			</tr>
		</thead>
		<tbody id="dislikeTbody"></tbody>
	</table>
	</div>
	
	<div id="likeSeciton" style="width:23%; border:5;float: left;border:5; overflow-x:hidden; overflow-y:scroll; height:350px; margin:20px;">
	선택재료 : 
	<table id="likeResult" class="table table-hover table-condensed">
		<thead id="likeThead">
			<tr>
				<th>재료id</th>
				<th>재료명</th>
			</tr>
		</thead>
		<tbody id="likeTbody"></tbody>
	</table>
	</div><br>
	<br>
	
	<!--위의 재료들을 리스트에 담아서 재료로 검색하는 핸들러로 보낸다. -->
	<div style="width:50%; border:5;float: right;">
	<button type="button" id="searchBtn" style="float:right; margin-top:100px;margin-right:480px;width:200px;height:100px;">레시피검색</button><br>
	</div>

	<div id="recipeSection" style="width:100%; border:5;float: left;">
	<div id="sortKeyword">
	<div style="text-align:center;"><hr><br><h3>기본 레시피 검색결과</h3><br><hr></div>
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
	</div><br>
	<div id="apiResult">
		<table class="table table-hover table-condensed" style="border:5;">
			<thead id="apiThead">
				<tr>
					<th>만족하는 재료수</th>
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
	</div><br>
	<div id="apiPageBean" style="text-align:center;"></div>
	<br>
	
	<div id="userResult" >
	<div style="text-align:center;"><hr><h3><br>사용자레시피 검색결과</h3><br><hr></div>
		<table class="table table-hover table-condensed" style="border:5;">
			<thead id="userThead">
				<tr>
					<th>만족하는 재료수</th>
					<th>레시피id</th>
					<th>제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
					<th>추천수</th>
				</tr>
			</thead>
			<tbody id="userTbody"></tbody>
		</table>
	</div><br>
	<div id="userPageBean" style="text-align:center;"></div>
	</div>
</body>
</html>
