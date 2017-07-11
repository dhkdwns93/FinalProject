<%@ page contentType="text/html;charset=UTF-8"%>
<!-- 
 (jsp)join_admin_success
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


<h2>관리자 등록 성공!</h2>
<div class="row">
	<div>관리자 ID</div>
	<div>${requestScope.admin.adminId}</div>
</div>
<div class="row">
	<div>관리자 이름</div>
	<div>${requestScope.admin.adminName }</div>
</div>
<div class="row">
	<div>전화번호</div>
	<div>${requestScope.admin.adminTel }</div>
</div>
<div class="row">
	<div>이메일</div>
	<div>${requestScope.admin.adminEmail }</div>
</div>
<div class="row">
	<div>관리자 권한</div>
	<div>${requestScope.admin.adminAuthority }</div>
</div>

</body>
</html>