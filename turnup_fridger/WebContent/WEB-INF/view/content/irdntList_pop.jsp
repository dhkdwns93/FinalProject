<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript"
	src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){

	$("#searchBtn").on("click",function(){
		$.ajax({
			"url":"/turnup_fridger/common/admin/irdntManage/findIrdntByName.do",
			"type":"POST",
			"data":{'irdntName' : $("#irdntName").val(),'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json",
			"success":function(list){
				if(list.length == 0){
					$("#tbody").empty();
					$("#tbody").append($("<tr>").prop("id","irdnt_col").append($("<td>").append("검색 결과가 없습니다")));
			}else{
				$("#tbody").empty();
				$.each(list, function(){
					$("#tbody").append($("<tr>").prop("id","irdnt_col").append($("<td>").prop("class","irdntRow").prop("id","irdntId").prop("value", this.irdntId).append(this.irdntName)));
				 
				});//each
			}
			},
			"error":function(errorMsg){
				alert("오류가 발생하였습니다. "+errorMsg);
			}
		})
	});//searchBtn
	
	$(document).on("click",".irdntRow" , function(){
			console.log($(this).text());
			$("#irdnt_info #irdntName").val($(this).text());
			$("#irdnt_info #irdntId").val($(this).val());
			
	}); // end of click on irdntRow

});

function sendIrdnt(){
	var irdntId = $("#irdnt_info #irdntId").val();
	var irdntName = $("#irdnt_info #irdntName").val();
	var irdntTypeCode = $("#irdnt_info #irdntTypeCode>option:selected").val();
	var irdntTypeName = $("#irdnt_info #irdntTypeCode>option:selected").text();
	var irdntAmount = $("#irdnt_info #irdntAmount").val() + $("#unit>option:selected").text();
	opener.setIrdnt(irdntId, irdntName, irdntTypeCode, irdntTypeName, irdntAmount );
	window.close();
}

</script>
<style type="text/css">
table, td, th {
	border: 1px solid black;
}

table {
	width: 200px;
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

	<h2>재료명 검색</h2>
	<input type="text" name ="irdntName" id="irdntName">
	<button type="button" id="searchBtn">검색</button><br>

	<div id="result">
		<table>
			<tbody id="tbody">
				<tr>
				<!-- 스크롤 처리하기, 재료명 누르면 값을 가지고 부모 페이지 이동 -->
					<td>*검색한 내용 출력부</td>
				</tr>
			</tbody>
		</table>
	</div>
<hr>
<div>
<table id="irdnt_info">
<thead>
	<tr>
		<th>재료명</th>
		<th>재료구분</th>
		<th colspan="2">중량</th>
	</tr>
</thead>
<tbody>
	<tr>
		<td><input type="text" id="irdntName" size="10" readonly>
			<input type="hidden" id="irdntId"></td>
		<td><select id="irdntTypeCode" name="irdntTypeCode">
			<option value="3060001">주재료</option>
			<option value="3060002">부재료</option>
			<option value="3060003">양념</option>
		</select>
		</td>
		<td><input type="number" id="irdntAmount" size="10"></td>
		<td><select id="unit" name="unit">
			<option>개</option>
			<option>g</option>
			<option>kg</option>
			<option>컵</option>
			<option>T</option>
			<option>마리</option>
		</select>
		</td>		
	</tr>
</tbody>
</table>	
<button type="button" id="submitBtn" onclick="sendIrdnt()">추가완료</button>
<button type="button" id="submitBtn" onclick="window.close()">취소</button>
	</div>

</body>
</html>