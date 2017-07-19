<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" 
href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#textBtn").on("click",function(){
		$.ajax
		({		
			"url":"/turnup_fridger/boardreview/reviewRecipeName.do", 
			"type":"POST",
			"data":{"recipeName":$("#recipeName").val(), '${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json",
			"beforeSend":function()
			{
				if(!$("#recipeName").val())
				{
					alert("레시피 이름을 입력하세요");
					return false;
				}
			},
			"success":function(list)
			{
				
				if(!list.length)
				{
					alert("해당 레시피가 업습니다.");
					return false;
				}
				var txt = "";
				$("#thead").empty().append("<tr><td>레시피 번호</td><td>레시피 이름</td></tr>");
				$("#tbody").empty();
				$.each(list, function()
				{
					$("#tbody").append($("<tr>").prop("id","col").append($("<td>").append(this.recipeId)).append($("<td>").append(this.recipeName)));

				});
			}
		});
	});
	$(document).on("click","#col",function(){
		//id랑 재료명만 받아오는고~
		var recipeId = $(this).children(":first-child").text();
		var recipeName = $(this).children(":nth-child(2)").text();
		
		$("#recipeId", parent.opener.document).val(recipeId);
		$("#recipeName", parent.opener.document).val(recipeName);
		window.close();
	})//click
	
});
</script>

<style type="text/css">
table, td{
	border: 1px solid black;
}
table{
	width:700px;
	border-collapse: collapse;
}
td{
	padding: 5px;
}
#tbody{
	cursor: pointer;
}
</style>
</head>
<body>
<h1>레시피 검색</h1>
<hr>
<input type="text" id="recipeName">
<button id="textBtn" type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
	<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
</button>
<table class="table table-hover table-condensed" style="width:100%;text-align:center;margin-left: auto; margin-right: auto;">
	<thead id="thead"></thead>
	<tbody id="tbody"></tbody>
</table>
</body>
</html>