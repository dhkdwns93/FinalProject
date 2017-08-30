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
		//id랑 재료명만 받아오기
		var recipeId = $(this).children(":first-child").text();
		var recipeName = $(this).children(":nth-child(2)").text();
		
		$("#recipeId", parent.opener.document).val(recipeId);
		$("#recipeName", parent.opener.document).val(recipeName);
		window.close();
	})//click
	
});
</script>
 <link href="bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet">
<style>
    #container {
      width: 70%;
      margin: 0 auto;     /* 가로로 중앙에 배치 */
      padding-top: 10%;   /* 테두리와 내용 사이의 패딩 여백 */
    }
     
    #list {
      text-align: center;
    }
   
    #write {
      text-align: right;
    }
     
    /* Bootstrap 수정 */
    .table > thead {
      background-color: #DDDBDB;
    }
    .table > thead > tr > th {
      text-align: center;
    }
    .table-hover > tbody > tr:hover {
      background-color: #e6ecff;
    }
    .table > tbody > tr > td {
      text-align: center;
    }
    .table > tbody > tr > #title {
      text-align: left;
    }
     
    div > #paging {
      text-align: center;
    }
     
    .hit {
      animation-name: blink;
      animation-duration: 1.5s;
      animation-timing-function: ease;
      animation-iteration-count: infinite;
      /* 위 속성들을 한 줄로 표기하기 */
      /* -webkit-animation: blink 1.5s ease infinite; */
    }
     
    /* 애니메이션 지점 설정하기 */
    /* 익스플로러 10 이상, 최신 모던 브라우저에서 지원 */
    @keyframes blink {
      from {color: white;}
      30% {color: yellow;}
      to {color: red; font-weight: bold;}
      /* 0% {color:white;}
      30% {color: yellow;}
      100% {color:red; font-weight: bold;} */
    }
</style>
</head>
<body>
<h2 style="text-align:center;">레시피 검색</h2>
<hr style="border:0;height:3px;background:#ccc;">

<center>
	<div class="form-inline form-group" >
		<input class="form-control" style="width:20%;" type="text" id="recipeName">
		<button id="textBtn" type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
			<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
		</button>
	</div>
</center>

<table class="table table-striped table-bordered table-hover" style="width:100%;text-align:center;margin-left: auto; margin-right: auto;">
	<thead id="thead"></thead>
	<tbody id="tbody"></tbody>
</table>
</body>
</html>