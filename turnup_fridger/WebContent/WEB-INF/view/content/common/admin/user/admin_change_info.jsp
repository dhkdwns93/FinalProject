<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 
 (jsp)admin_change_info
작성자 :  김경혜
최초 작성일 170705
변경이력 
170712 validator 에러메시지 적용
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<style>
.ccfield-prepend{
	margin-bottom:20px;
	width:100%;
}
.ccform-addon{
	color:#bfbfbf; 
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
	background:#a6a6a6;
	height:28px;
	color:#FFFFFF;
	cursor:pointer;
	text-decoration:none;
	font-weight:bold;
}
.ccbtn:hover{
	background:#737373;
}
.ccfield-submit-part{
	text-align:center;
}
/* 기타 일반 text  */
h1 {
	font-family: "Viner Hand ITC" !important;
	src: url("/font/VINERITC.TTF");
	font-weight:bold !important;
	color:#4d4d4d !important;
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
.contact-form{
	display:inline-block;
	width:70%;
	margin-left:5%;
}
</style>
</head>
<body>
	<div class="container">
		<div class='wrapperDiv'>
			<jsp:include page="/WEB-INF/view/layout/side_menu/adminSideMenu.jsp"/>
			<div class='right-box-sidemenu'>
				<div class="contact-form">
				<h1>Edit Profile for Admin</h1>
				<form action="${initParam.rootPath}/common/admin/admin_change.do" method="post">
					<div class="ccfield-prepend">
						<div><label for="id" class="form-text">Admin ID</label></div>
						<span class="ccform-addon"><i class="material-icons">&#xE85E;</i></span>
						<input type="text" id="id" name="adminId" readonly="readonly" value='<sec:authentication property="principal.adminId"/>' class="ccformfield">
						<div class="error"><form:errors path="adminChangeForm.adminId" delimiter="&nbsp;&nbsp"/></div>
					</div>
					<div class="ccfield-prepend">
						<div><label for="password" class="form-text">Password</label></div>
						<span class="ccform-addon"><i class="material-icons">&#xE85E;</i></span>
						<input type="password" id="password" name="oldAdminPw"  class="ccformfield">
						<div class="error"><form:errors path="adminChangeForm.oldAdminPw" delimiter="&nbsp;&nbsp"/></div>	
					</div>
					<div class="ccfield-prepend">
						<div><label for="newPassword" class="form-text">New Password</label></div>
						<span class="ccform-addon"><i class="material-icons">&#xE150;</i></span>
						<input type="password" id="newPassword" name="adminPw"  class="ccformfield">
						<div class="error"><form:errors path="adminChangeForm.adminPw" delimiter="&nbsp;&nbsp"/></div>		
					</div>
					<div class="ccfield-prepend">
						<div><label for="name" class="form-text">Name</label></div>
					 	<span class="ccform-addon"><i class="material-icons">&#xE853;</i></span>	
						<input type="text" id="name" name="adminName" value='<sec:authentication property="principal.adminName"/>' class="ccformfield">
						<div class="error"><form:errors path="adminChangeForm.adminName" delimiter="&nbsp;&nbsp"/></div>	
					</div>
					<div class="ccfield-prepend">
						<div><label for="tel" class="form-text">Tel</label><span id="lengthTel" class="error">&nbsp&nbsp*ex.01012345678</span></div>
						<span class="ccform-addon"><i class="material-icons">&#xE0B0;</i></span>
						<input type="text" id="tel" name="adminTel" value='<sec:authentication property="principal.adminTel"/>' class="ccformfield">
						<div class="error"><form:errors path="adminChangeForm.adminTel" delimiter="&nbsp;&nbsp"/></div>		
					</div>
					<div class="ccfield-prepend">
						<div><label for="inputEmail" class="form-text">Email</label></div>
						<span class="ccform-addon"><i class="material-icons">&#xE0BE;</i></span>
						<input type="text" id="email" name="adminEmail" value='<sec:authentication property="principal.adminEmail"/>' class="ccformfield">
						<div class="error"><form:errors path="adminChangeForm.adminEmail" delimiter="&nbsp;&nbsp"/></div>	
					</div>
					<sec:csrfInput/>
					<div class="ccfield-submit-part">
						<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
							<span class="glyphicon glyphicon-ok" aria-hidden="true">Edit</span>
						</button>
						<button type="button" onclick="location.reload()" class="btn btn-default btn-lg"  style="border:0;outline:0;">
							<span class="glyphicon glyphicon-refresh" aria-hidden="true">Reset</span>
						</button>
					</div>
				</form>
				</div>
			</div><!-- rightside menu -->
		</div>
	</div><!-- container -->
</body>