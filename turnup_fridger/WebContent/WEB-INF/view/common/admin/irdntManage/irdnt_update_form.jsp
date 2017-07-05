<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery-3.2.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
		//window.document.irdntId = opener.document.$(this).parent().parent().children(":first-child").text()
				
		$("#updateBtn").on("click",function(){
			$.ajax({
			"url" : "/turnup_fridger/common/admin/irdntManage/updateIrdnt.do",
			"type" : "POST",
			"data" : {
				'irdntId' : $("#irdntId").val(),
				'irdntName' : $("#irdntName").val(),
				'irdntCategory' : $("#irdntCategory").val(),
				'roomTemPeriod' : $("#roomTemPeriod").val(),
				'coldTemPeriod' : $("#coldTemPeriod").val(),
				'freezeTemPeriod' : $("#freezeTemPeriod").val(),
				'note' : $("#note").val(),
				'${_csrf.parameterName}' : '${_csrf.token}'},
			"dataType" : "json",
			"success" : function(list) {
				alert("수정완료!")
			},
			"error" : function(errorMsg) {
				alert("오류다!")
			}
		})//ajax 
	})//updateBtn
	})//ready

	function updateIrdnt() {
		//console.log(zipcode+" "+address);
		//window : 현재 창
		//opener : 팝업을 띄운 창 (window)를 가리키는 객체.

		//opener.document.join_form.zipcode.value = zipcode;
		//opener.document.join_form.address.value = address;
		
		
		if (window.confirm("창을 닫겠습니까?")) {
			window.close();
		}
	}
</script>
</head>
<body>

<h2>재료 수정</h2>

<form action="/turnup_fridger/irdntManage/updateIrdnt.do" method="post">
<table>
	<tr>
		<th>재료id</th>
		<td><input id = "irdntId" type="text" name="irdntId" value="${irdnt.irdntId}" readOnly><span class="error"><form:errors path="irdnt.irdntId" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>재료명</th>
		<td><input id = "irdntName" type="text" name="irdntName" value="${irdnt.irdntName}"><span class="error"><form:errors path="irdnt.irdntName" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>카테고리</th>
		<td><input id = "irdntCategory"type="text" name="irdntPeriod" value="${irdnt.irdntCategory}"><span class="error"><form:errors path="irdnt.irdntCategory" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>실온보관기간</th>
		<td><input id = "roomTemPeriod" type="text" name="irdntPeriod" value="${irdnt.roomTemPeriod}"><span class="error"><form:errors path="irdnt.roomTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>냉장보관기간</th>
		<td><input id = "coldTemPeriod" type="text" name="irdntPeriod" value="${irdnt.coldTemPeriod}"><span class="error"><form:errors path="irdnt.coldTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>냉동보관기간</th>
		<td><input id = "freezeTemPeriod" type="text" name="irdntPeriod" value="${irdnt.freezeTemPeriod}"><span class="error"><form:errors path="irdnt.freezeTemPeriod" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<th>비고</th>
		<td><input id = "note" type="text" name="irdntPeriod" value="${irdnt.note}"><span class="error"><form:errors path="irdnt.note" delimiter="&nbsp;&nbsp;"/></span></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" id ="updateBtn" value="수정하기" >
		</td>
	</tr>
	<tr>
		<td>
			<button onclick="window.close();">닫기</button>
		</td>
	</tr>
</table>
<sec:csrfInput/>
</form>
</body>
</html>