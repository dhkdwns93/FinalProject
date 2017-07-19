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
<title>Turnup-fridger Email-Check</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"  rel="stylesheet">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
<style>
.ccfield-prepend {
	margin-bottom: 20px;
	width: 100%;
}

.ccform-addon {
	color: #bfbfbf;
	float: left;
	padding: 8px;
	width: 8%;
	height: 34px;
	background: #FFFFFF;
	border: 1px solid #f1f1f1;
	text-align: center;
}

.ccformfield {
	color: #000000;
	background: #FFFFFF;
	border: 1px solid #f1f1f1;
	padding: 15.5px;
	width: 60%;
	height: 34px;
	font-family: 'Lato', Arial, sans-serif;
	font-size: 14px;
	margin: 0;
}

.ccformfield {
	font-family: 'Lato', Arial, sans-serif;
}

.ccbtn {
	font-size: 13px;
	border: none;
	background: #a6a6a6;
	height: 28px;
	color: #FFFFFF;
	cursor: pointer;
	text-decoration: none;
	font-weight: bold;
}

.ccbtn:hover {
	background: #737373;
}

.ccfield-submit-part {
	text-align: center;
}
/* 기타 일반 text  */
h1 {
	font-family: "Viner Hand ITC";
	src: url("/font/VINERITC.TTF");
	font-weight: bold;
	color: #4d4d4d;
}

.form-text {
	font-size: 14px;
	color: #808080;
}
/* 에러메시지 */
.error-popup {
	font-size: 100% !important;
	color: #808080 !important;
}
/* popup-body 넓이*/
.popup-body {
	width: 100%;
	display: inline-block;
	margin-top: 10%;
	margin-left: auto;
	margin-right: auto;
}
.popup-btn{
 	text-align:center;
}
</style>
</head>
<body>

	<div class="container">

		<div class="popup-body">
			<h1 class="modal-title font-Viner_Hand_ITC">Email Duplication Check</h1>
			<hr>
			<div class="form-text">*이메일은 ID/PW찾을 때 사용되니 실제 사용 이메일을 작성해주시기 바랍니다.</div>
			<div class="ccfield-prepend">
			<input type="email" id="inputEmail" name="inputEmail email" value="${param.inputEmail}" class="ccformfield" placeholder="Email">
			<button type="button" id="duplicateEmailBtn" class="ccbtn"><span class="glyphicon glyphicon-ok" aria-hidden="true"> Check</span></button>
			<div id="duplicateResult" class="error-popup"></div>
			</div>
			
			<div id="useEmail" class="popup-btn" style="display:none">
			<hr>
				<input type="hidden" id="email" name="email">
				<button type="submit" id="useEmailBtn"class="btn btn-default btn-lg"  style="border:0;outline:0;">
					<span class="glyphicon glyphicon-ok" aria-hidden="true">Use</span>
				</button>
			</div>
			<div class="popup-btn">
				<button type="button" onclick="self.close()" class="btn btn-default btn-lg"  style="border:0;outline:0;">
					<span class="glyphicon glyphicon-remove" aria-hidden="true">Close</span>
				</button>
			</div>
			
		</div>
		<!-- popup-body -->
	</div>
	<!-- container -->
</body>
</html>