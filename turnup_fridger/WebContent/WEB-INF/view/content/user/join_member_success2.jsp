<%-- <%@ page contentType="text/html;charset=UTF-8"%>
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
					<span class="font-Broadway">ID</span>
					<span>${requestScope.member.memberId}</span>
				</div>
				<div class="desc">
					<span class="font-Broadway">Name</span>
					<span>${requestScope.member.memberName }</span>
				</div>
				<div class="desc">
					<span class="font-Broadway">Address</span>
					<span>${requestScope.member.memberAddress }</span>
				</div>
				<div class="desc">
					<span class="font-Broadway">Email</span>
					<span>${requestScope.member.memberEmail }</span>
				</div>
				<div class="desc">
					<span class="font-Broadway">Tel</span>
					<span>${requestScope.member.memberTel }</span>
				</div>
				<div class="desc">
					<span class="font-Broadway">Gender</span>
					<span>${requestScope.member.memberSex }</span>
				</div>
				<div class="desc">
					<div class="font-Broadway">기피재료목록</div>
					<div>
						<c:forEach items="${requestScope.myDislikeIrdntNameList }"
							var="myDislikeIrdntName">
							<li>${myDislikeIrdntName }</li>
						</c:forEach>
					</div>
				</div>
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
</html> --%>