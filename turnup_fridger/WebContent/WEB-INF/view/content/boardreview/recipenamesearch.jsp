<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
				var txt = "";
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
레시피 검색

<input type="text" id="recipeName">
<button type="button" id="textBtn">검색</button>
<table>
	<tbody id="tbody"></tbody>
</table>
</body>
</html>