<%@ page contentType="text/html;charset=UTF-8"%>
<!-- 
 (jsp)nonMemberSideMenu
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
	height:100%;
}
a.list-group-item {
  border:none;
  color: #555;
  text-decoration: none;
  background-color:#ffcccc;
}
a.list-group-item:hover,
a.list-group-item:focus {
  color: #555;
  text-decoration: none;
  background-color: #f5f5f5 !important;
}

</style>
<div class='left-box'>
		<div><h5>Welcome to Turnup-fridger1</h5></div>
		<hr>
		<div class="list-group">
			<a href="${initParam.rootPath}/login_form.do" class="list-group-item">Login</a>
		
		
			<a href="${initParam.rootPath}/join_member_form.do" class="list-group-item">Join us</a>
		
		</div>
</div>


