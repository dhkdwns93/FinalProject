<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="/turnup_fridger/scripts/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$.ajax({
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
		})//ajax
	
		$("#searchBtn").on("click",function(){
			$.ajax({
				"url":"/turnup_fridger/common/admin/irdntManage/findIrdntByKeyword.do",
				"type":"POST",
				"data":{'irdntCategory' : $("#irdntCategory").val(), 'irdntName' : $("#irdntName").val(),'${_csrf.parameterName}':'${_csrf.token}'},
				"dataType":"json",
				"success":function(list){
					$.each(list, function(){
					$("#tbody").append($("<tr>").prop("id","irdnt_col").append($("<td>").append(this.irdntId)).append($("<td>").append(this.irdntName)).append($("<td>").append(this.irdntCategory))
					.append($("<td>").append(this.roomTemPeriod)).append($("<td>").append(this.coldTemPeriod)).append($("<td>").append(this.freezeTemPeriod)).append($("<td>").append(this.note))
					.append($("<td>").append($("<button>").prop("type","button").prop("id","updateBtn").append("수정")))
					.append($("<td>").append($("<button>").prop("type","button").prop("id","deleteBtn").append("삭제"))));
					 });//each
				},
				"error":function(errorMsg){
					alert("오류다!")
				}
			})
		});//searchBtn
		
		
		$(document).on("click","#updateBtn",function(){
			var irdntId = $(this).parent().parent().children(":first-child").text();
			$.ajax({
				"url" : "/turnup_fridger/common/admin/irdntManage/updateIrdnt.do",
				"type" : "POST",
				"data" : {
					'irdntId' : $("#irdntId").val(),
					'irdntName' : $("#irdntName").val(),
					'irdntCategory' : $("#irdntCategory").val(),
					'roomTemPeriod' : $("#roomTemPeriod").val(),
					'coldTemPeriod' : $("#coldTemPeriod").val(),
					'freezeTemPeriod' : $("#freezeTemPeriod").val(),
					'note' : $("#note").val(),
					'${_csrf.parameterName}' : '${_csrf.token}'},
				"dataType" : "json",
				"success" : function(list) {
					alert("수정완료!")
				},
				"error" : function(errorMsg) {
					alert("오류다!")
				}
			})//ajax 
			
			
			
			
			
			/*var irdnt $(this).parent().
			window.open("/turnup_fridger/common/admin/irdntManage/irdnt_update_form","재료수정","width=500, height=500");
			window.document.irdntId.value = $(this).parent().parent().children(":fist-child"),text;
			window.document.irdntName.value = $(this).parent().parent().children(":fist-child"),text;
			window.document.irdntCategory.value = $(this).parent().parent().children(":fist-child"),text;
			window.document.roomTemPeriod.value = $(this).parent().parent().children(":fist-child"),text;
			window.document.coldTemPeriod.value = $(this).parent().parent().children(":fist-child"),text;
			window.document.freezeTemPeriod.value = $(this).parent().parent().children(":fist-child"),text;
			window.document.note.value = $(this).parent().parent().children(":fist-child"),text; 	 */
		
		});//updateBtn
		
		$(document).on("click","#deleteBtn",function(){
			var irdntId = $(this).parent().parent().children(":first-child").text();	
			$.ajax({
				"url":"/turnup_fridger/common/admin/irdntManage/removeIrdnt.do",
				"type":"POST",
				"data":{'irdntId':irdntId,'${_csrf.parameterName}':'${_csrf.token}'},
				"dataType":"text",
				"success":function(TEXT){
					alert(TEXT)
					//삭제가 되긴하는데, 다음화면이 자동으로 새로고침되면 좋겠는데....
				},
				"error":function(errorMsg){
					alert("오류다!")
				}
			})
		});//deleteBtn
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

	<h2>재료 목록</h2>
	<hr>

	<a href="/turnup_fridger/common/admin/irdntManage/irdnt_form.do">재료추가</a><br><br>

	카테고리 : 
	<select name="irdntCategory" id="irdntCategory">
		<option value="전체">전체</option>
		<c:forEach items="${requestScope.irdntCategory}" var="irdntCategory">
			<option value="${irdntCategory}">${irdntCategory}</option>
		</c:forEach>
	</select> 
	
	재료명검색
	<input type="text" name ="irdntName" id="irdntName">
	<button type="button" id="searchBtn">검색</button><br>
<%-- 
	재료id
	<input type="text" name ="irdntId" id="irdntId">
	<button type="button" id="updateBtn">수정</button>
	
	재료id 
	<input type="text" name ="irdntId" id="irdntId">
	<button type="button" id="deleteBtn">삭제</button><br><br>
--%>	
	<div id="result">
		<table>
			<thead>
				<tr>
				<th>재료id</th>
				<th>재료명</th>
				<th>카테고리</th>
				<th>실온보관기간</th>
				<th>냉장보관기간</th>
				<th>냉동보관기간</th>
				<th>비고</th>
				<th>수정</th>
				<th>삭제</th>
				</tr>	
			</thead>
			<tbody id="tbody"></tbody>
		</table>
	</div>


</body>
</html>