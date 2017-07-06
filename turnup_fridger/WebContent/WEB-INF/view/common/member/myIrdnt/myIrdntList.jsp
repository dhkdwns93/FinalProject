<%@ page contentType="text/html;charset=UTF-8"%>
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
			"url":"/turnup_fridger/common/member/myIrdnt/allMyIrdntList.do",
			"dataType":"json", 
			"success":function(list){
				$.each(list,function(){
					
					
				});//each
			},//success
			"error":function(errorMsg){
				alert("오류다!");
			} 
		})//ajax
		
		//재료클릭 -> 재료 상세정보 팝업.-> 일단 보여주고, 수정하기 누르면 수정모드.
		
		//선택삭제
		
		//
	
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


<h2>나의 식재료 목록</h2><hr>
<a href = "/turnup_fridger/common/member/myIrdnt/myIrdnt_form.do">재료추가</a>

<div id ="result">
<table>
	<thead id = "thead">
		<tr>
			<th></th>
			<th></th>
			<th></th>
		</tr>
	</thead>
	<tbody id = "tbody"></tbody>
	</table>
</div>

</body>
</html>