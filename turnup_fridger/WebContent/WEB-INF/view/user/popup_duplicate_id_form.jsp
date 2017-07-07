<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)popup_duplicate_id_form
작성자 :  김경혜
최초 작성일 170706
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
	$("button#duplicateIdBtn").on("click",function(){
		$.ajax({
			url:"${initParam.rootPath}/popup_duplicate_id.do",
			type:"post",
			data:{ 'inputId' : $("input#inputId").val(), '${_csrf.parameterName}':'${_csrf.token}' },			
			dataType:"text",
			success:function(responseText){
				if(responseText==("duplicateIdError")){
					$("div#useId").hide();
					$("div#duplicateResult").text("다른 사용자가 사용중인 ID입니다.");
				}else if(responseText==("idLengthError")){
					$("div#duplicateResult").text("*아이디는 공백없이 글자수 2~15자 내로 작성해주십시오");
				}else{
					$("div#useId").show();
					$("div#duplicateResult").text("ID : [  "+responseText+"  ]는 사용이 가능합니다.");
					$("input#id").val(responseText);
				}
			}
		});//end of ajax
	});//end of duplicateIdBtn
	
	$("button#useIdBtn").on("click",function(){
		var id=$("input#id").val();
		opener.document.join_member_form.memberId.value=id;
		//opener.document.join_member_form._csrf.parameterName.value=_csrf.token;
		window.close();
	});
});
</script>
</head>
<body>
<h2>회원아이디 중복검사</h2>
<input type="text" id="inputId" name="inputId" value="${param.inputId}">
<button type="button" id="duplicateIdBtn">중복검사</button>
<div id="duplicateResult"></div>
<div id="useId" style="display:none">
<hr>
	<input type="hidden" id="id" name="id">
	<button type="submit" id="useIdBtn">아이디 사용하기</button><button type="button" onclick="self.close()">닫기</button>
</div>
</body>
</html>