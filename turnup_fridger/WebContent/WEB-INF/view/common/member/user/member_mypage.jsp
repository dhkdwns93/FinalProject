<%@ page contentType="text/html;charset=UTF-8"%>
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
	<table>
		<tr>
			<th>회원 ID</th>
			<th><sec:authentication property="principal.memberId"></sec:authentication></th>
		</tr>


	</table>

</body>
</html>