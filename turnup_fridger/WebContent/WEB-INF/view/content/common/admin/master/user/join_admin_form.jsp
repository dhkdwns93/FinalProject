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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/WEB-INF/view/content/user/layout_menu_security.jsp" />
<hr>


<h2>관리자 등록페이지</h2>
<%-- controller.admin패키지 --%>
<form action="${initParam.rootPath}/common/admin/master/join_admin.do" method="post">
	<div class="form-group">
		<label for="id">관리자 ID</label>
		<input type="text" id="id" name="adminId" class="form-control">
		<span class="error"><form:errors path="admin.adminId" delimiter="&nbsp;&nbsp"/></span>
	</div>
	<div class="form-group">
		<label for="password">관리자 PW</label>
		<input type="password"  id="password" name="adminPw" class="form-control">
		<span class="error"><form:errors path="admin.adminPw" delimiter="&nbsp;&nbsp"/></span>	
	</div>
	<div class="form-group">
		<label for="name">이름</label>
		<input type="text" id="name" name="adminName" class="form-control">	
		<span class="error"><form:errors path="admin.adminName" delimiter="&nbsp;&nbsp"/></span>	
	</div>
	<div class="form-group">
		<label for="tel">전화번호</label>
		<input type="text" id="tel" name="adminTel" class="form-control">
		<span class="error"><form:errors path="admin.adminTel" delimiter="&nbsp;&nbsp"/></span>	
	</div>
	<div class="form-group">
		<label for="email">이메일</label>
		<input type="text" id="email" name="adminEmail" class="form-control">
		<span class="error"><form:errors path="admin.adminEmail" delimiter="&nbsp;&nbsp"/></span>
	</div>
	<sec:csrfInput/>
	<button type="submit" class="btn btn-default">관리자등록</button>
	<button type="reset" class="btn btn-default">다시작성</button>
</form>
</body>
</html>