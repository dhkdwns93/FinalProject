<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)login_form
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
<body>
<jsp:include page="/WEB-INF/view/content/user/layout_menu_security.jsp" />
<hr>


<h2>로그인form페이지</h2>
<c:if test="${not empty param.errorMessage }">
	<div class="well text-danger">
		${param.errorMessage }
	</div>
</c:if>
<form action="${initParam.rootPath}/login.do" method="post">
	<sec:csrfInput/><%-- csrf token생성 --%>
	<div class="form-group">
	<label for="id">ID</label><br>
	<input type="text" id="id" name="userId" class="form-control">
	</div>
	<div class="form-group">
		<label for="password">PW</label><br>
		<input type="password" id="password" name="userPw" class="form-control">
	</div>
	<button type="submit" class="btn btn-default">LOGIN</button>
	<button type="reset" class="btn btn-default">다시작성</button>
</form>
</body>
</html>