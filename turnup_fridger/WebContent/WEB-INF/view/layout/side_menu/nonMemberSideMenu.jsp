<%@ page contentType="text/html;charset=UTF-8"%>
<!-- 
 (jsp)nonMemberSideMenu
작성자 :  김경혜
최초 작성일 170703
변경이력 
-->
<style>
.wrapperDiv{
	display:-wibkit-flex;
	display:flex;
}

.left-box-sidemenu {
	background: #ffcc99;
	float: left;
	margin-left: 50px;
	width: 230px;
	/* height: 100%; */
	border-radius: 10%;
	padding: 1%;
	font-size: 100%;
}
.right-box-sidemenu {
	background: white;

}
/* .right-box-sidemenu {
	background: white;
	float:left;
	margin-left: 320px;
	margin-right: 35%;
	width: 65%;
	height: 100%;
} */

.list-group-item {
	border: none;
	color: #555;
	text-decoration: none;
	background-color: #ffcc99;
}

.list-group-item:hover, .list-group-item:focus {
	color: #555;
	text-decoration: none;
	background-color: #fff2e6 !important;
}
</style>


<div class='left-box-sidemenu'>
		<div><h5>1233Welcome to Turnup-fridger</h5></div>
		<hr>
		<div class="list-group">
			<a href="${initParam.rootPath}/login_form.do" class="list-group-item">Login</a>
			<a href="${initParam.rootPath}/join_member_form.do" class="list-group-item">Join us</a>
		
		</div>
</div>


