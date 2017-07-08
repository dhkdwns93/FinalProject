<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

//재료들을 검색해서 irdntId값을 골라내서 myIrdnt_form으로 되돌려보내는 팝업창.

$(document).ready(function(){
	
	$("#searchBtn").on("click",function(){
		$.ajax({
			"url":"/turnup_fridger/common/member/myIrdnt/findIrdntByName.do",
			"type":"POST",
			"data":{'irdntName':$("#irdntName").val(),'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json", 
			"success":function(list){
				$("#tbody").empty();
				$.each(list, function(){
					$("#tbody").append($("<tr>").prop("id","irdnt_col").append($("<td>").append(this.irdntId)).append($("<td>").append(this.irdntName)).append($("<td>").append(this.irdntCategory))
					.append($("<td>").append(this.roomTemPeriod)).append($("<td>").append(this.coldTemPeriod)).append($("<td>").append(this.freezeTemPeriod)).append($("<td>").append(this.note)));
				 	});//each
			},//success
			"error":function(xhr, msg, code){
				alert("오류발생-" + code);
			} 
		});
	})//searchBtn
	
	$(document).on("click","#irdnt_col",function(){
		//id랑 재료명만 받아오는고~
		var irdntId = $(this).children(":first-child").text();
		var irdntName = $(this).children(":nth-child(2)").text();
		
		$("#irdntId", parent.opener.document).val(irdntId);
		$("#irdntName", parent.opener.document).val(irdntName);
	})//click
})//ready	
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
<h2>재료명 검색</h2><hr>

	재료명 : 
	<input type="text" name ="irdntName" id="irdntName">
	<button type="button" id="searchBtn">검색</button><br><br>

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
				</tr>	
			</thead>
			<tbody id="tbody"></tbody>
		</table>
	</div>
	<button type="button" onclick="window.close();">닫기</button>
</body>
</html>