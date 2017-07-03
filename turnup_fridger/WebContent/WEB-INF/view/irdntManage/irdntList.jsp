<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("button").on("click",function(){
			alert("시작");	
		$.ajax({
			"url"="/turnup_fridger/irdntManage/allIrdntList.do",
			"type"="POST", 
			"dataType":"json", 
			"success":function(obj){
				alert("응답옴");
				$("#thead").append("<tr><td>재료id</td><td>재료명</td><td>보관기간</td></tr>");
				var txt="";
				$.each(obj,function(){
					txt += ("<tr><td>"+this.irdntId+"</td><td>"+this.irdntName+"</td><td>"+this.irdntPeriod+"</td></tr>");
				});//each
				$("#tbody").html(txt);
			},//success
			"error":function(errorMsg){
				alert("오류다!");
			} 
		})//ajax
		})//btn 
	})

</script>
<style type="text/css">
table, td {
	border: 1px solid black;
}

table {
	width: 700px;
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

<h2>재료 목록</h2><hr>
<button type="button" id="list">재료목록조회</button>
<a href = "/turnup_fridger/irdntManage/irdnt_form.do">재료추가</a>

<div id ="result">
<table>
	<thead id = "thead">
	</thead>
	<tbody id = "tbody"></tbody>
	</table>
</div>


</body>
</html>