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
		<label for="password">기존 PW</label>
		<input type="password" id="password" name="memberPw"  class="form-control">
	</div>
	<div class="form-group">
		<label for="newPassword">변경할 PW</label>
		<input type="password" id="newPassword" name="newMemberPw"  class="form-control">
	</div>
	<div class="form-group">
		<label for="name">이름</label>
		<input type="text" id="name" name="memberName" value='<sec:authentication property="principal.memberName"/>' class="form-control">
	</div>
	<div class="form-group">
		<label for="address">주소</label>
		<input type="text" id="address" name="memberAddress" value='<sec:authentication property="principal.memberAddress"/>' class="form-control">
	</div>
	<div class="form-group">
		<label for="email">이메일</label>
		<input type="text" id="email" name="memberEmail" value='<sec:authentication property="principal.memberEmail"/>' class="form-control">
	</div>
	<div class="form-group">
		<label for="tel">전화번호</label>
		<input type="text" id="tel" name="memberTel" value='<sec:authentication property="principal.memberTel"/>' class="form-control">
	</div>
	<div class="form-group">
		성별
		<input type="text" id="sex" name="memberSex" readonly="readonly" value='<sec:authentication property="principal.memberSex"/>' class="form-control">
	</div>
	<sec:csrfInput/>
	<button type="submit" class="btn btn-default">수정완료</button>
	<button type="reset" class="btn btn-default">다시작성</button>
</form>
</body>
</html>