<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 
 (jsp)join_admin_form
작성자 :  김경혜
최초 작성일 170705
변경이력 
170712 validator 에러메시지 추가
 -->

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
.form-page{
	display:inline-block;
	width:70%;
	margin-left:5%;
}
</style>


<div class="container">
<div class='wrapperDiv'>
	<jsp:include page="/WEB-INF/view/layout/side_menu/adminSideMenu.jsp"/>
	<div class='right-box-sidemenu'>

	<div class="form-page">
			
		
		
		<h1>Register Admin</h1>
		<%-- controller.admin패키지 --%>
		<form action="${initParam.rootPath}/common/admin/master/join_admin.do" method="post">
			<div class="ccfield-prepend">
				<span class="ccform-addon"><i class="material-icons">&#xE150;</i></span>
				<input type="text" id="id" name="adminId" class="ccformfield" placeholder="ID">
				<div class="error"><form:errors path="admin.adminId" delimiter="&nbsp;&nbsp"/></div>
			</div>
			<div class="ccfield-prepend">
				<span class="ccform-addon"><i class="material-icons">&#xE150;</i></span>
				<input type="password"  id="password" name="adminPw" class="ccformfield" placeholder="Password">
				<div class="error"><form:errors path="admin.adminPw" delimiter="&nbsp;&nbsp"/></div>	
			</div>
			<div class="ccfield-prepend">
				<span class="ccform-addon"><i class="material-icons">&#xE853;</i></span>
				<input type="text" id="name" name="adminName" class="ccformfield" placeholder="Name">	
				<div class="error"><form:errors path="admin.adminName" delimiter="&nbsp;&nbsp"/></div>	
			</div>
			<div class="ccfield-prepend">
				<span class="ccform-addon"><i class="material-icons">&#xE0B0;</i></span>
				<input type="text" id="tel" name="adminTel" class="ccformfield" placeholder="Tel">
				<div class="error"><form:errors path="admin.adminTel" delimiter="&nbsp;&nbsp"/></div>	
			</div>
			<div class="ccfield-prepend">
				<span class="ccform-addon"><i class="material-icons">&#xE0BE;</i></span>
				<input type="text" id="email" name="adminEmail" class="ccformfield" placeholder="Email">
				<div class="error"><form:errors path="admin.adminEmail" delimiter="&nbsp;&nbsp"/></div>
			</div>
			<sec:csrfInput/>
			<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
				<span class="glyphicon glyphicon-ok" aria-hidden="true">Register</span>
			</button>
			
			<button type="button" onclick="location.reload()" class="btn btn-default btn-lg"  style="border:0;outline:0;">
				<span class="glyphicon glyphicon-refresh" aria-hidden="true">Reset</span>
			</button>

		</form>
		
		 </div><!-- form-page -->
 	</div><!-- rightside menu -->
</div>
</div><!-- container -->
