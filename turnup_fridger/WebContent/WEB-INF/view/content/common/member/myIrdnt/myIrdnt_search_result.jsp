<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재료 검색</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script type="text/javascript" src="/turnup_fridger/scripts/bootstrap.min.js"></script>
<script type="text/javascript">


//재료들을 검색해서 irdntId값을 골라내서 myIrdnt_form으로 되돌려보내는 팝업창.

$(document).ready(function(){
	$("#thead").hide();
	
	$("#searchBtn").on("click",function(){
		$.ajax({
			"url":"/turnup_fridger/common/member/myIrdnt/findIrdntByName.do",
			"type":"POST",
			"data":{'irdntName':$("#irdntName").val(),'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json", 
			"success":function(list){
				$("#thead").show();
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
		window.close();
	})//click
})//ready	
</script>
<style type="text/css">

#tbody {
	cursor: pointer;
}
</style>
</head>
<body>
<h2 style="text-align:center;font-weight:bold;">재료명 검색</h2><hr>

<div style="text-align:center;"> 
	재료명  &emsp;
	<input type="text" name ="irdntName" id="irdntName">
	<button type="button" id="searchBtn" class="btn btn-default btn-lg" style=" border:0;outline:0;width:40px;height:40px;">
	<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
	</button>
	<br><br>
</div>

	<div id="result">
		<table class="table table-hover table-condensed" style="width:90%; margin-left:auto;margin-right:auto;">
			<thead id="thead">
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
			<tbody id="tbody">
				
			</tbody>
		</table>
	</div>
</body>
</html>