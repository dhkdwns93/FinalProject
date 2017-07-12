<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)popup_find_IdPw_form
작성자 :  김경혜
최초 작성일 170710
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
	$("button#findIdPwBtn").on("click",function(){
		$.ajax({
			url:"${initParam.rootPath}/popup_find_IdPw.do",
			type:"post",
			data:{ 'inputName' : $("input#inputName").val(),'inputEmail' : $("input#inputEmail").val(), '${_csrf.parameterName}':'${_csrf.token}' },			
			dataType:"text",
			success:function(responseText){
				if(responseText==("nonExistMember")){
					$("div#sendEmail").hide();
					$("div#findResult").text("*입력하신 정보와 일치하는 계정이 존재하지 않습니다.");
				}else{
					$("div#sendEmail").show();
					$("div#findResult").text("Email로 ID/Password를 전송받으시겠습니까?");
				}
			}
		});//end of ajax
	});//end of findIdPwBtn
	$("button#sendEmailBtn").on("click",function(){
		alert("*해당 이메일로 ID/Password 전송이 완료되었습니다");
	});
	
});
</script>
</head>
<body>
<h2>아이디/패스워드 찾기</h2>
<form action="${initParam.rootPath }/send_find_IdPw_email.do" method="post">
<sec:csrfInput/>
<div class="row">
Name <input type="text" id="inputName" name="inputName">
</div>
<div class="row">
Email <input type="text" id="inputEmail" name="inputEmail">
</div>
<button type="button" id="findIdPwBtn">아이디/비밀번호 찾기</button>
<div id="findResult"></div>
<div id="sendEmail" style="display:none">
	<button type="submit" id="sendEmailBtn">전송</button>
</div>
<hr>
<div class="row">
	<button type="button" onclick="self.close()">닫기</button>
</div>
</form>
</body>
</html>