<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)admin_change_info
작성자 :  김경혜
최초 작성일 170705
변경이력 
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


<h2>회원정보수정</h2>
<form action="${initParam.rootPath}/common/admin/admin_change.do" method="post">
	<div class="form-group">
		<label for="id">관리자 ID</label>
		<input type="text" id="id" name="adminId" readonly="readonly" value='<sec:authentication property="principal.adminId"/>' class="form-control">
	</div>
	<div class="form-group">
		<label for="password">기존 PW</label>
		<input type="password" id="password" name="adminPw"  class="form-control">
	</div>
	<div class="form-group">
		<label for="newPassword">변경할 PW</label>
		<input type="password" id="newPassword" name="newAdminPw"  class="form-control">
	</div>
	<div class="form-group">
		<label for="name">이름</label>
		<input type="text" id="name" name="adminName" value='<sec:authentication property="principal.adminName"/>' class="form-control">
	</div>
	<div class="form-group">
		<label for="tel">전화번호</label>
		<input type="text" id="tel" name="adminTel" value='<sec:authentication property="principal.adminTel"/>' class="form-control">
	</div>
	<div class="form-group">
		<label for="email">이메일</label>
		<input type="text" id="email" name="adminEmail" value='<sec:authentication property="principal.adminEmail"/>' class="form-control">
	</div>
	<sec:csrfInput/>
	<button type="submit" class="btn btn-default">수정완료</button>
	<button type="reset" class="btn btn-default">다시작성</button>
</form>

</body>
</html>