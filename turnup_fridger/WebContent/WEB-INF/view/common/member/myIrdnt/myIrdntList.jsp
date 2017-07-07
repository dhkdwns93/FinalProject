<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		//기본적으로 가져오는 모든 재료 목록들. 
		$.ajax({
			"url":"/turnup_fridger/common/member/myIrdnt/allMyIrdntList.do?fridgerId=1",
			//"data":{'fridgerId': 1},
			"dataType":"json", 
			"success":function(list){
					 $.each(list, function(){
							if(this.storgePlace=="실온"){
								$("#roomTbody").append($("<tr>").append($("<td>").append(this.myIrdntKey)).append($("<td>").prop("id","irdntName_col").append(this.irdntName)).append($("<td>").append(this.freshLevel))
										.append($("<td>").append($("<input>").prop("type","checkbox").prop("name","deleteChk").prop("id","deleteChk").prop("value",this.myIrdntKey))))
								} 
							else if(this.storgePlace=="냉장"){ 
								$("#coldTbody").append($("<tr>").append($("<td>").append(this.myIrdntKey)).append($("<td>").prop("id","irdntName_col").append(this.irdntName)).append($("<td>").append(this.freshLevel))
										.append($("<td>").append($("<input>").prop("type","checkbox").prop("name","deleteChk").prop("id","deleteChk").prop("value",this.myIrdntKey))))
								}
							else if(this.storgePlace=="냉동"){
								$("#freezeTbody").append($("<tr>").append($("<td>").append(this.myIrdntKey)).append($("<td>").prop("id","irdntName_col").append(this.irdntName)).append($("<td>").append(this.freshLevel))
										.append($("<td>").append($("<input>").prop("type","checkbox").prop("name","deleteChk").prop("id","deleteChk").prop("value",this.myIrdntKey))))
								}
							})//each	
			},//success
			"error":function(xhr, msg, code){
				alert("오류발생-" +msg+ ":" +code);
			} 
		});//ajax
		
		//재료클릭 -> 재료 상세정보 팝업 (쿼리로 정보들 붙여서 보내기)
		$(document).on("click","#irdntName_col",function(){
			var myIrdntKey = $(this).parent().children(":first-child").text();
			window.open("/turnup_fridger/common/member/myIrdnt/findIrdntByKey.do?myIrdntKey="+myIrdntKey,"detail","width=500, height=400");
		
		});//
				
		//선택삭제 -> 체크박스 만들어서 체크된것만 삭제처리하게 
		$(document).on("click","#deleteOnSelect",function(){
			//var irdntKey = $(this).parent().parent().children(":first-child").text();
			var irdntKeyList = [];
			$("input[name='deleteChk']:checked").each(function(){
				irdntKeyList.push($(this).parent().parent().children(":first-child").text());
			});
			
			$.ajax({
				"url":"/turnup_fridger/common/member/myIrdnt/removeMyIrdnt.do",
				"type":"POST",
				"data":{'irdntKey':irdntKeyList,'fridgerId':1,'${_csrf.parameterName}':'${_csrf.token}'},
				"dataType":"text",
				"traditional": true,
				"success":function(TEXT){
					alert(TEXT);
					window.location.reload();
				},
				"error":function(xhr, msg, code){
					alert("오류발생-" +msg+ ":" +code);
				}
			})			
		});
				
		//검색버튼
		$("#searchBtn").on("click",function(){
			$.ajax({
				"url":"/turnup_fridger/common/member/myIrdnt/findMyIrdntByFreshLevelAndIrdntName.do?fridgerId=1",
				"type":"post",
				"data":{'freshLevel':$("#freshLevel").val(), 'irdntName':$("#irdntName").val(),'${_csrf.parameterName}':'${_csrf.token}'},
				"dataType":"json", 
				"success":function(list){
					$("#roomTbody").empty();
					$("#coldTbody").empty();
					$("#freezeTbody").empty();
		 			 	$.each(list, function(){
		 			 		if(this.storgePlace=="실온"){
								$("#roomTbody").append($("<tr>").append($("<td>").append(this.myIrdntKey)).append($("<td>").prop("id","irdntName_col").append(this.irdntName)).append($("<td>").append(this.freshLevel))
										.append($("<td>").append($("<input>").prop("type","checkbox").prop("name","deleteChk").prop("id","deleteChk").prop("value",this.myIrdntKey))))
								} 
							else if(this.storgePlace=="냉장"){ 
								$("#coldTbody").append($("<tr>").append($("<td>").append(this.myIrdntKey)).append($("<td>").prop("id","irdntName_col").append(this.irdntName)).append($("<td>").append(this.freshLevel))
										.append($("<td>").append($("<input>").prop("type","checkbox").prop("name","deleteChk").prop("id","deleteChk").prop("value",this.myIrdntKey))))
								}
							else if(this.storgePlace=="냉동"){
								$("#freezeTbody").append($("<tr>").append($("<td>").append(this.myIrdntKey)).append($("<td>").prop("id","irdntName_col").append(this.irdntName)).append($("<td>").append(this.freshLevel))
										.append($("<td>").append($("<input>").prop("type","checkbox").prop("name","deleteChk").prop("id","deleteChk").prop("value",this.myIrdntKey))))
								}
							})//each	
				},//success
				"error":function(xhr, msg, code){
					alert("오류발생-" +msg+ ":" +code);
				} 
			});
		});
	})

</script>
<style type="text/css">
table, td {
	border: 1px solid black;
}

table {
	width: 1000px;
	border-collapse: collapse;
}

td {
	padding: 5px;
}

#tbody {
	cursor: pointer;
}
</style>
</head>
<body>


<h2>나의 식재료 목록</h2><hr>
<a href = "/turnup_fridger/common/member/myIrdnt/myIrdnt_form.do"><button type="button">재료추가</button></a>
<button type="button" id="deleteOnSelect">선택삭제</button><br><br>

신선도 :
	<select name="freshLevel" id="freshLevel">
		<option value="전체">전체</option>
		<option value="안전">안전</option>
		<option value="보통">보통</option>
		<option value="위험">위험</option>
	</select> 
재료명검색 : 
	<input type="text" name ="irdntName" id="irdntName">
	<button type="button" id="searchBtn">검색</button><br><br>


<div id ="result">
실온보관재료 : 
<table id = "room">
	<thead>
		<tr>
			<th>재료key</th>
			<th>재료명</th>
			<th>신선도</th>
			<th>삭제여부</th>
		</tr>
	</thead>
	<tbody id = "roomTbody"></tbody>
</table><br>
냉장보관재료 : 
<table id = "cold">
	<thead>
		<tr>
			<th>재료key</th>
			<th>재료명</th>
			<th>신선도</th>
			<th>삭제여부</th>
		</tr>
	</thead>
	<tbody id = "coldTbody"></tbody>
</table><br>
냉동보관재료 : 
<table id = "freeze">
	<thead>
		<tr>
			<th>재료key</th>
			<th>재료명</th>
			<th>신선도</th>
			<th>삭제여부</th>
		</tr>
	</thead>
	<tbody id = "freezeTbody"></tbody>
</table><br>
</div>

</body>
</html>