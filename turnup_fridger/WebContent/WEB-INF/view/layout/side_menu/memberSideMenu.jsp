<%@ page contentType="text/html;charset=UTF-8"%>
<!-- 
 (jsp)memberSideMenu
작성자 :  김경혜
최초 작성일 170703
변경이력 
-->
<style>
.left-box{
 	background:#ffcccc;
 	float:left;
 	width:20%;
 	height:100%;
 	border-radius:10%;
 	padding : 2%;
 	font-size:100%;
}
.right-box{
	background:white;
	float:right;
	width:75%;
	height:70%;

</style>
<div class='left-box'>
		<div><h5>Welcome to Turnup-fridger</h5></div>
		<hr>
		<div>
			<a href="${initParam.rootPath}/login_form.do" >Login</a>
		</div>
		<div>
			<a href="${initParam.rootPath}/join_member_form.do">Join us</a>
		</div>
</div>


