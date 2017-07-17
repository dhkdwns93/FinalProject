<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)login_form
작성자 :  김경혜
최초 작성일 170703
변경이력 
170708 ID/PW 찾기 버튼 추가
170714 modal로 css처리
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
			window.open("${initParam.rootPath}/popup_find_IdPw_form.do","find_IdPw_form","width=500,height=400,resizable=yes");
		});//end of findIdPwBtn
		
	});
</script>
<style>
.ccfield-prepend{
	margin-bottom:20px;
	width:100%;
}
.ccform-addon{
	color:#f8ae45; 
	float:left;
	padding:8px;
	width:8%;
	height:34px;
	background:#FFFFFF;
	border: 1px solid #f1f1f1;
	text-align:center;
	
}
.ccformfield {
	color:#000000; 
	background:#FFFFFF;
	border: 1px solid #f1f1f1;
	padding:15.5px;
	width:60%;
	height:34px;
	font-family: 'Lato',Arial,sans-serif;
	font-size:14px;
	margin:0;
}
.ccformfield {
	font-family: 'Lato',Arial,sans-serif;
}
.ccbtn{
	font-size:13px;
	border:none;
	background:#f8ae45;
	height:28px;
	color:#FFFFFF;
	cursor:pointer;
	text-decoration:none;
	font-weight:bold;
}
.ccbtn:hover{
	background:#d8850e;
}
.ccfield-submit-part{
	text-align:center;
}
/* 기타 일반 text  */
h1 {
	font-family: "Viner Hand ITC";
	src: url("/font/VINERITC.TTF");
	font-weight:bold;
	color:#4d4d4d;
}
.form-text{
	font-size:14px;
	color:#808080;
}
/* 에러메시지 */
.error{
  font-size:80% !important;
  color:#808080 !important;
}
/* contact-form 넓이*/
.login-form{
	display:inline-block;
	width:50%;
}
</style>
</head>
<body>

<hr>


<jsp:include page="/WEB-INF/view/layout/side_menu/nonMemberSideMenu.jsp"/>
<div class='right-box-sidemenu'>

<div class="login-form">
<h1>Login</h1>
<c:if test="${not empty param.errorMessage }">
	<div class="well text-danger">${param.errorMessage }</div>
</c:if>
<form action="${initParam.rootPath}/login.do" method="post">
	<sec:csrfInput />
	<%-- csrf token생성 --%>
	<div class="form-group">
		<label for="id"><span class="form-text">ID</span></label><br> <input type="text" id="id"
			name="userId" class="form-control">
	</div>
	<div class="form-group">
		<label for="password"><span class="form-text">Password</span></label><br> <input type="password"
			id="password" name="userPw" class="form-control">
	</div>
	<div class="ccfield-submit-part">
		<button type="submit" class="btn btn-default">LOGIN</button>
		<button type="button" id="findIdPwBtn" class="btn btn-default">forget
			ID/Password</button>
	</div>
</form>
</div><!-- login-form -->


</div>
</body>
</html>