<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)admin_mypage
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


<h2>마이페이지(관리자용)</h2>
<table border="1">
	<tr>
		<th>관리자 ID</th>
		<th><sec:authentication property="principal.adminId"></sec:authentication></th>
	</tr>
	<tr>
		<th>관리자 PW</th>
		<th><sec:authentication property="principal.adminPw"></sec:authentication></th>
	</tr>
	<tr>
		<th>이름</th>
		<th><sec:authentication property="principal.adminName"></sec:authentication></th>
	</tr>
	<tr>
		<th>전화번호</th>
		<th><sec:authentication property="principal.adminTel"></sec:authentication></th>
	</tr>
	<tr>
		<th>이메일</th>
		<th><sec:authentication property="principal.adminEmail"></sec:authentication></th>
	</tr>
	<tr>
		<th>관리자권한</th>
		<th><sec:authentication property="principal.adminAuthority"></sec:authentication></th>
	</tr>
</table>

<hr>
<a href="${initParam.rootPath }/common/admin/admin_change_info.do"><button type="button" class="btn btn-default">(관리자)정보수정</button></a>
</body>
</html>