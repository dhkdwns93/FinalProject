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


<h2>마이페이지</h2>
<table border="1">
	<tr>
		<th>회원 ID</th>
		<th><sec:authentication property="principal.memberId"></sec:authentication></th>
	</tr>
	<tr>
		<th>회원 PW</th>
		<th><sec:authentication property="principal.memberPw"></sec:authentication></th>
	</tr>
	<tr>
		<th>이름</th>
		<th><sec:authentication property="principal.memberName"></sec:authentication></th>
	</tr>
	<tr>
		<th>주소</th>
		<th><sec:authentication property="principal.memberAddress"></sec:authentication></th>
	</tr>
	<tr>
		<th>이메일</th>
		<th><sec:authentication property="principal.memberEmail"></sec:authentication></th>
	</tr>
	<tr>
		<th>성별</th>
		<th><sec:authentication property="principal.memberSex"></sec:authentication></th>
	</tr>
</table>

<hr>

	

</body>
</html>