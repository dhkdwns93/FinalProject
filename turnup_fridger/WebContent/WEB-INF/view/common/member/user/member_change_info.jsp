<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)member_mypage
작성자 :  김경혜
최초 작성일 170704
변경이력 
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/WEB-INF/view/user/layout_menu_security.jsp" />
<hr>


<h2>회원정보수정</h2>
<form action="${initParam.rootPath}/common/member/member_change.do" method="post">
	<div class="form-group">
		<label for="id">회원 ID</label>
		<input type="text" id="id" name="memberId" class="form-control">
	</div>
</form>
</body>
</html>