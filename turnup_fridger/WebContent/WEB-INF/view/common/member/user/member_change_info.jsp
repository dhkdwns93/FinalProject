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
		<input type="text" id="id" name="memberId" readonly="readonly" value='<sec:authentication property="principal.memberId"/>' class="form-control">
	</div>
	<div class="form-group">
		<label for="oldPassword">기존 PW</label>
		<input type="password" id="oldPassword" name="oldMemberPw"  class="form-control">
	</div>
	<div class="form-group">
		<label for="password">변경할 PW</label>
		<input type="password" id="password" name="memberPw"  class="form-control">
	</div>
	<div class="form-group">
		<label for="id">이름</label>
		<input type="text" id="id" name="memberId" value='<sec:authentication property="principal.memberId"/>' class="form-control">
	</div>
	<div class="form-group">
		<label for="id">주소</label>
		<input type="text" id="id" name="memberId" value='<sec:authentication property="principal.memberId"/>' class="form-control">
	</div>
	<div class="form-group">
		<label for="id">이메일</label>
		<input type="text" id="id" name="memberId" value='<sec:authentication property="principal.memberId"/>' class="form-control">
	</div>
	<div class="form-group">
		<label for="id">성별</label>
		<input type="text" id="id" name="memberId" value='<sec:authentication property="principal.memberId"/>' class="form-control">
	</div>
</form>
</body>
</html>