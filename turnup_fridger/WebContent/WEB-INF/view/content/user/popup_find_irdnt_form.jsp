<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)popup_find_irdnt_form
작성자 :  김경혜
최초 작성일 170707
변경이력 
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#searchBtn").on("click",function(){
		$.ajax({
			"url":"${initParam.rootPath}/findIrdntByName.do",
			"type":"POST",
			"data":{'irdntName':$("#irdntName").val(),'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json", 
			"success":function(list){
				$("#tbody").empty();
				$.each(list, function(idx){
					$("#tbody").append($("<tr>").prop("id","irdnt_col")
					.append($("<td>").append("<input type='hidden' id='irdntId' name='irdntId' value="+this.irdntId+">"+(idx+1)))
					.append($("<td>").append("<input type='hidden' id='irdntName2' name='irdntName2' value="+this.irdntName+">"+(this.irdntName)))
					.append($("<td>").append(this.irdntCategory))
					.append($("<td>").append("<button type='button' id='selectIrdntBtn' value='d'>재료추가</button>")));
				 });//end of each
			}//success
		});//end of ajax
	});//end of searhBtn
	
	$("tbody#tbody").on("click","button#selectIrdntBtn",function(){
		var irdntId=$(this).parent().parent().children(":first-child").children().val();
		var irdntName=$(this).parent().parent().children(":nth-child(2)").children().val();
		
		//form name= usePopup로 보내는거야
		//myDislikeIrdntId
		if(!opener.document.usePopup.myDislikeIrdntId.length){
			opener.document.usePopup.myDislikeIrdntId.value=irdntId;
		}else{
			opener.document.usePopup.myDislikeIrdntId[0].value=irdntId;
		}
		//myDislikeIrdntName
		if(!opener.document.usePopup.myDislikeIrdntName.length){
			opener.document.usePopup.myDislikeIrdntName.value=irdntName;
		}else{
			opener.document.usePopup.myDislikeIrdntName[0].value=irdntName;
		}
		
		window.close();
	});//end of selectIrdntBtn
});
</script>
</head>
<body>
<h2>재료명 검색</h2><hr>

	재료명 : 
	<input type="text" name ="irdntName" id="irdntName">
	<button type="button" id="searchBtn">검색</button><br><br>

	<div id="result">
		<table border="1" width="500px">
			<thead>
				<tr>
				<th>번호</th>
				<th>재료명</th>
				<th>카테고리</th>
				<th>추가</th>
				</tr>	
			</thead>
			<tbody id="tbody"></tbody>
		</table>
	</div>
	<button type="button" onclick="window.close();">닫기</button>

</body>
</html>