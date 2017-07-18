<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- 
 (jsp)memberSideMenu
작성자 :  김경혜
최초 작성일 170717
변경이력 
-->
<style>

.wrapperDiv{
	display:-webkit-flex;
	display:flex;
}
.left-box-sidemenu{
 	background:#ffcc99;
 	float:left;
 	width:20%;
	min-width:200px;
	max-width:250px;
 	height:100%;
	margin-left:5%;
	margin-bottom:auto;
 	border-radius:10%;
 	padding : 2%;
 	font-size:100%;
}
.right-box-sidemenu{
	-webkit-flex:none;
	flex:none;
	position:relative;
	background:white;
	float:right;
	width:67%;
	height:100%;
	margin-right:5%;
}

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

		<div><h5>My Menu</h5></div>
		<hr>
		<div class="list-group">
		<sec:authorize access="hasRole('ROLE_MEMBER')">
		<sec:authentication property='principal.memberId' var='memberId'/>
			<a href="${initParam.rootPath}/memo/memoList.do?memberId=${memberId}"  class="list-group-item">내 메모보기</a>
	    </sec:authorize>
	        <a href="#"  class="list-group-item" onclick="window.open('/turnup_fridger/memo/map.do','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=750px, height=500px ,top=10, left=10', bottom=10, right=10)">주변 마트보기</a>
	        <a href="${initParam.rootPath}/common/member/member_mypage_event.do"  class="list-group-item">내정보</a>
		</div>
</div>


