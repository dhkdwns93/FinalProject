<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 
 (jsp)join_member_success
작성자 :  김경혜
최초 작성일 170703
변경이력 
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>

.member-join-success-table {
	margin-left: auto;
	margin-right: auto;
	width : 90%;
	/* border:1px solid lightgrey; */
}
.table-attribute-name{
	width:33%;
    color: #444444;
    font-weight:bold;
    font-size:18px;
    padding-top : 10px;
    padding-bottom:10px;
}
.table-attribute-text{
	font-size:15px;
	text-align:left;
	padding-top:3px;
	padding-left:5px;
}
</style>

<body>
	<jsp:include page="/WEB-INF/view/content/user/layout_menu_security.jsp" />
	<hr>
	<jsp:include
		page="/WEB-INF/view/layout/side_menu/nonMemberSideMenu.jsp" />
	<div class='right-box-sidemenu'>
		<div class="join-member">
		<div class="card hovercard">
			<img src="https://cdn.pixabay.com/photo/2017/03/23/19/57/asparagus-2169305__340.jpg" alt>
			<div class="avatar">
				<img src="http://pds20.egloos.com/pds/201008/03/58/d0027758_4c58239c49510.jpg" alt>
			</div>
			<div class="info">
				<div class="title font-Viner_Hand_ITC">Welcome to Turnup-Fridger!</div>
				<div class="desc">
				<table class="member-join-success-table">
					<tr>
						<td class="font-Broadway table-attribute-name">ID</td>
						<td class="table-attribute-text">${requestScope.member.memberId}</td>
					</tr>
					<tr>
						<td class="font-Broadway table-attribute-name">Name</td>
						<td class="table-attribute-text">${requestScope.member.memberName }</td>
					</tr>
					<tr>
						<td class="font-Broadway table-attribute-name">Address</td>
						<td class="table-attribute-text">${requestScope.member.memberAddress }</td>
					</tr>
					<tr>
						<td class="font-Broadway table-attribute-name">Email</td>
						<td class="table-attribute-text">${requestScope.member.memberEmail }</td>
					</tr>
					<tr>
						<td class="font-Broadway table-attribute-name">Tel</td>
						<td class="table-attribute-text">${requestScope.member.memberTel }</td>
					</tr>
					<tr>
						<td class="font-Broadway table-attribute-name">Gender</td>
						<td class="table-attribute-text">${requestScope.member.memberSex }</td>
					</tr>
					<tr>
						<td class="font-Broadway table-attribute-name" style="font-size:15px">기피재료목록</td>
						<td class="table-attribute-text">
							<c:forEach items="${requestScope.myDislikeIrdntNameList }"
								var="myDislikeIrdntName">
								<li>${myDislikeIrdntName }</li>
							</c:forEach>
						</td>
					</tr>
				</table><!-- end of table  -->			
				</div><!-- desc -->
			</div>
			<!-- info -->
			<div class="bottom">
				<a href="${initParam.rootPath}/login_form.do"><button
						type="button" class="btn btn-block">LOGIN</button></a>
			</div>
			<!-- bottom -->
		</div>
		<!-- card hovercard -->
		</div><!-- rounded -->
	</div>
	<!-- rightbox -->

</body>
</html>