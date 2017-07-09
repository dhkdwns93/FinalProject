<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)popup_duplicate_email_form
작성자 :  김경혜
최초 작성일 170707
변경이력 
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("button#duplicateEmailBtn").on("click",function(){
		$.ajax({
			url:"${initParam.rootPath}/popup_duplicate_email.do",
			type:"post",
			data:{ 'inputEmail' : $("input#inputEmail").val(), '${_csrf.parameterName}':'${_csrf.token}' },			
			dataType:"text",
			success:function(responseText){
				if(responseText==("duplicateEmailError")){
					$("div#useEmail").hide();
					$("div#duplicateResult").text("이미 인증된 Email입니다.");
				}else{
					$("div#useEmail").show();
					$("div#duplicateResult").text("Email : [  "+responseText+"  ]는 사용이 가능합니다.");
					$("input#email").val(responseText);
				}
			}
		});//end of ajax
	});//end of duplicateEmailBtn
	
	$("button#useEmailBtn").on("click",function(){
		var email=$("input#email").val();
		opener.document.usePopup.memberEmail.value=email;
		window.close();
	});
});
</script>
</head>
<body>
<h2>회원 이메일 중복검사</h2>
*이메일은 ID/PW찾을 때 사용되니 실제 사용 이메일을 작성해주시기 바랍니다.<br>
<input type="text" id="inputEmail" name="inputEmail" value="${param.inputEmail}">
<button type="button" id="duplicateEmailBtn">중복검사</button>
<div id="duplicateResult"></div>
<div id="useEmail" style="display:none">
<hr>
	<input type="hidden" id="email" name="email">
	<button type="submit" id="useEmailBtn">이메일 사용하기</button><button type="button" onclick="self.close()">닫기</button>
</div>
</body>
</html>