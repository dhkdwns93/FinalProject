<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">

//재료들을 검색해서 irdntId값을 골라내서 myIrdnt_form으로 되돌려보내는 팝업창.

$(document).ready(function(){
	
	$(document).on("click", "button#searchBtn",function(){
		$.ajax({
			"url":"/turnup_fridger/common/member/boardRecipe/findIrdntByNameShare.do",
			"type":"POST",
			"data":{'irdntName':$("#irdntName").val(),'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json", 
			"success":function(list){
				$("#tbody").empty(); 
				$.each(list, function(idx){
					$("#tbody").append($("<tr>").
							prop("id","irdnt_col").
							append($("<td>").append("<input type='hidden' id='irdntId' value="+this.irdntId+">"+(idx+1))).
							append($("<td>").append("<input type='hidden' id='irdntName2' name='irdntName2' value="+this.irdntName+">"+(this.irdntName))).
							append($("<td>").append(this.irdntCategory)).
							append($("<td>").append("<button type='button' id='selectIrdntBtn' class='btn btn-default'>재료추가</button>")));
							
					
				 	});//each
			}//success 
		});//end of ajax
	});//searchBtn
	
	$(document).on("click","button#selectIrdntBtn",function(){
		//id랑 재료명만 받아오는고~
		var irdntId = $(this).parent().parent().children(":first-child").children().val();
		var irdntName = $(this).parent().parent().children(":nth-child(2)").children().val();
		
		if(!opener.document.boardPopup.irdntId.length){
			opener.document.boardPopup.irdntId.value=irdntId;
		}else{
			opener.document.boardPopup.irdntId[opener.document.boardPopup.irdntId.length-1].value=irdntId;
		}
		//myDislikeIrdntName
		if(!opener.document.boardPopup.irdntName.length){
			opener.document.boardPopup.irdntName.value=irdntName;
		}else{
			opener.document.boardPopup.irdntName[opener.document.boardPopup.irdntName.length-1].value=irdntName;
		}
		window.close();
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
	<button type="button" id="searchBtn" class="btn btn-default">검색</button><br><br>

	<div id="result">
		<table>
			<thead>
				<tr>
				<th>재료id</th>
				<th>재료명</th>
				<th>카테고리</th>
				<th>추가</th>
				</tr>	
			</thead>
			<tbody id="tbody"></tbody>
		</table>
	</div>
	<button type="button" class="btn btn-default" onclick="window.close();">닫기</button>
</body>
</html>