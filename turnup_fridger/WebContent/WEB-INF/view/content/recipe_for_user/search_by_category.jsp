<%@ page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 by 카테고리</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
	$("#searchBtn").on("click",function(){
		$.ajax({
			"url":"/turnup_fridger/findRecipeByRecipeName.do",
			"type":"POST",
			"data":{'recipeName' : $("#recipeName").val(),'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json",
			"success":function(obj){
				
				$("#apiThead").append($("<tr>").prop("id","apiRecipe_col").append($("<th>").append("레시피id")).append($("<th>").append("이름")).append($("<th>").append("간략소개")).append($("<th>").append("유형분류"))
						.append($("<th>").append("음식분류")).append($("<th>").append("조리시간")).append($("<th>").append("칼로리")).append($("<th>").append("난이도")).append($("<th>").append("대표이미지"))
						.append($("<th>").append("조회수")));
				
				$("#userThead").append($("<tr>").prop("id","userRecipe_col").append($("<th>").append("레시피id")).append($("<th>").append("제목")).append($("<th>").append("작성자")).append($("<th>").append("작성일"))
						.append($("<th>").append("조회수")).append($("<th>").append("추천수")));
					
				$.each(map.apiList, function(){
					$("#apiTbody").append($("<tr>").prop("id","apiRecipe_col").append($("<td>").append("레시피id")).append($("<td>").append("이름")).append($("<td>").append("간략소개")).append($("<td>").append("유형분류"))
							.append($("<td>").append("음식분류")).append($("<td>").append("조리시간")).append($("<td>").append("칼로리")).append($("<td>").append("난이도")).append($("<td>").append("대표이미지"))
							.append($("<td>").append("조회수")));
				 });//each	 
				$.each(map.userList, function(){
					$("#userTbody").append($("<tr>").prop("id","userRecipe_col").append($("<td>").append("레시피id")).append($("<td>").append("제목")).append($("<td>").append("작성자")).append($("<td>").append("작성일"))
							.append($("<td>").append("조회수")).append($("<td>").append("추천수")));
				 });//each			
			},//success
			"error":function(xhr, msg, code){
				alert("오류발생-" +msg+ ":" +code);
			}
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
	
	$("#categoryName").on("change",function(){
		$.ajax({
			"url":"/category_jquery_mvc/category/getSecond",
			"type":"post",
			"data":"id="+ $(this).val(),
			"dataType":"json",
			//"beforeSend":function(){},
			"success":function(arr){
				//alert("응답옴");
				var txt = "";
				$.each(arr,function(){
					txt += ("<option value ="+this.categoryId +">"+this.categoryName +"</option>");
				})
				$("#second_category").append(txt);
			}//arr
		})
		
		
	});//categoryName
	
})//ready
</script>
</head>
<body>
<h2>카테고리로 레시피 찾기</h2>

<!--유형분류입력받는창-> 음식분류입력받는창 -> 검색 -> 레시피info들(페이징) (레시피공유게시판은 유형분류는 안받겠지?)  -->
<!--검색 전 화면이 비어있을테니, top4들 불러오는작업? 여기서는 레시피쪽 조회수 top4  -->

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
	</select>
	음식분류 :  
	<select name="typeName" id="typeName">
		<option value="전체">전체</option>
		<!--첫번째꺼에 따라서 동적으로 받아서 뿌리자.  -->
	</select> 
	
	<!--api레시피 top4 가져올까?  -->
	
	<!--테이블 나타나면 정렬종류 선택 : 최다조회순,칼로리순,난이도순...  -->
	<div id="apiResult">
		<table>
			<thead id="apiThead"></thead>
			<tbody id="apiTbody"></tbody>
		</table>
	</div>
	
</body>
</html>