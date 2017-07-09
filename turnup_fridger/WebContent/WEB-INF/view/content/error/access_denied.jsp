<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)access_denied
작성자 :  김경혜
최초 작성일 170706
변경이력 

-->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2 class="text-danger">
<sec:authentication property="authorities"/>권한으로 접근할 수 없습니다.
</h2>
<hr>
<a href="${initParam.rootPath}/index.do">홈페이지로 돌아가기</a>
</body>
</html>