<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>재료 검색</h2>
<form action="" method="post">
<input type="text" name="irdnt">
<button type="button">검색</button>
<hr>
<sec:csrfInput/>
<button type="submit" class="btn btn-default">재료추가</button>
<a href="javascript:window.close()"><button type="button">닫기</button></a>
</form>
</body>
</html>