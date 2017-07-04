<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$.ajax({
			"url":"/turnup_fridger/common/admin/irdntManage/allIrdntList.do",
			"dataType":"json", 
			"success":function(list){
				alert("응답옴");  
				$("#thead").append("<tr><td>재료id</td><td>재료명</td><td>재료분류명</td><td>상온보관기간</td><td>냉장보관기간</td><td>냉동보관기간</td><td>비고</td></tr>");
				var txt="";
				$.each(list,function(){
					txt += ("<tr><td>"+this.irdntId+"</td><td>"+this.irdntName+"</td><td>"+this.irdntCategory+
							"</td><td>"+this.roomTemPeriod+"</td><td>"+this.coldTemPeriod+"</td><td>"+this.freezeTemPeriod+"</td><td>"+this.note+"</td></tr>");
				});//each
				$("#tbody").html(txt);
			},//success
			"error":function(errorMsg){
				alert("오류다!");
			} 
		})//ajax
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

<a href = "/turnup_fridger/common/admin/irdntManage/irdnt_form.do">재료추가</a>

<div id ="result">
<table>
	<thead id = "thead">
	</thead>
	<tbody id = "tbody"></tbody>
	</table>
</div>


</body>
</html>