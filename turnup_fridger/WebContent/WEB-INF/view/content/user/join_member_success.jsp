<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 
 (jsp)join_member_success
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


<h2>회원가입성공!</h2>
<div class="row">
	<div>회원 ID</div>
	<div>${requestScope.member.memberId}</div>
</div>
<div class="row">
	<div>이름</div>
	<div>${requestScope.member.memberName }</div>
</div>
<div class="row">
	<div>주소</div>
	<div>${requestScope.member.memberAddress }</div>
</div>
<div class="row">
	<div>이메일</div>
	<div>${requestScope.member.memberEmail }</div>
</div>
<div class="row">
	<div>전화번호</div>
	<div>${requestScope.member.memberTel }</div>
</div>
<div class="row">
	<div>성별</div>
	<div>${requestScope.member.memberSex }</div>
</div>
<div class="row">
	<div>기피재료목록</div>
	<div>
		<c:forEach items="${requestScope.myDislikeIrdntNameList }" var="myDislikeIrdntName">
					<li>${myDislikeIrdntName }</li>
		</c:forEach> 
	</div>
</div>

<a href="${initParam.rootPath}/login_form.do"><button type="button">LOGIN</button></a>

</body>
</html>