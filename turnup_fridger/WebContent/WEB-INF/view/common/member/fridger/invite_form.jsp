<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
 <script type="text/javascript">
$(document).ready(function(){
	 
	$.ajax({
		"url":"/turnup_fridger/common/member/fridger/show/mine.do",
		"type":"post",
		"data":{'${_csrf.parameterName}':'${_csrf.token}'},
		"dataType": "json",
	    "success": function(list){
	        	$("#fridgerList").empty();
		        $.each(list, function(){
		        	$("#fridgerList").append($("<option>").prop("value",this.fridgerId).text(this.fridgerId+"-"+this.fridgerName));
		        });	// end of each
	     },
	    "error":function(xhr, msg, code){
				alert("오류발생-" + code);
		}
	}); //end of ajax
	
});
 
 </script>

<body>
	<h2>냉장고 초대폼</h2>
	<form action="${ initParam.rootPath }/common/member/fridger/invite.do"
		method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<table>
			<tr>
				<th colspan="2">현재 로그인한 회원은"<sec:authentication property="principal.memberId"/>"님 입니다</th>
			</tr>
			<tr>
				<th>내 냉장고 목록</th>
				<td><select name="processFridgerId" id="fridgerList"></select>
			</tr>
			<tr>
				<th>초대할 회원ID</th>
			 	<td><input type="text" name="respMemberId"></td>
			<tr>
				<td colspan="2"><input type="submit"value="초대하기">
				</td>
			</tr>
		</table>
		<input type="hidden" name="processState" value="20">
	</form>

</body>
</html>