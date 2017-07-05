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
					$("#tbody").append($("<tr>").append($("<td>").append(this.irdntId)).append($("<td>").append(this.irdntName)).append($("<td>").append(this.irdntCategory))
					.append($("<td>").append(this.roomTemPeriod)).append($("<td>").append(this.coldTemPeriod)).append($("<td>").append(this.freezeTemPeriod)).append($("<td>").append(this.note))
					.append($("<td>").append($("<a>").prop("href","/turnup_fridger/common/admin/irdntManage/updateIrdnt.do").append($("<button>").prop("type","button").prop("id","updateBtn").append("수정"))))
					.append($("<td>").append($("<a>").prop("href","/turnup_fridger/common/admin/irdntManage/removeIrdnt.do").append($("<button>").prop("type","button").prop("id","deleteBtn").append("삭제")))));
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
				"data":{irdntCategory : $("#irdnt_category").val(), irdntName : $("#irdnt_Name").val()},
				"dataType":"json",
				"success":function(list){
					$.each(list, function(){
					$("#tbody").append($("<tr>").append($("<td>").append(this.irdntId)).append($("<td>").append(this.irdntName)).append($("<td>").append(this.irdntCategory))
					.append($("<td>").append(this.roomTemPeriod)).append($("<td>").append(this.coldTemPeriod)).append($("<td>").append(this.freezeTemPeriod)).append($("<td>").append(this.note))
					.append($("<td>").append($("<a>").prop("href","/turnup_fridger/common/admin/irdntManage/updateIrdnt.do").append($("<button>").prop("type","button").prop("id","updateBtn").append("수정"))))
					.append($("<td>").append($("<a>").prop("href","/turnup_fridger/common/admin/irdntManage/removeIrdnt.do").append($("<button>").prop("type","button").prop("id","deleteBtn").append("삭제")))));
					 });//each
				},
				"error":function(errorMsg){
					alert("오류다!")
				}
			})
		});//searchBtn
		
		$("#updateBtn").on("click",function(){
			$.ajax({
				"url":"/turnup_fridger/common/admin/irdntManage/updateIrdnt.do",
				"type":"POST",
				"data":{},
				"dataType":"json",
				"success":function(list){
					alert("수정완료!")
				},
				"error":function(errorMsg){
					alert("오류다!")
				}
			})
		});//updateBtn
		
		$("#deleteBtn").on("click",function(){
			$.ajax({
				"url":"/turnup_fridger/common/admin/irdntManage/removeIr+dnt.do",
				"type":"POST",
				"data":{irdntId : $("#irdnt_id").val()},
				"dataType":"json",
				"success":function(list){
					alert("삭제완료!")
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
	<select name="irdnt_category" id="irdnt_category">
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