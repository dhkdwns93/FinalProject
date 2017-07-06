<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)join_member_form
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
<jsp:include page="/WEB-INF/view/user/layout_menu_security.jsp" />
<hr>


<h2>회원가입페이지</h2>
<%-- controller.common패키지 --%>
<form action="${initParam.rootPath}/join_member.do" method="post">
	<div class="form-group">
		<label for="id">회원 ID</label>
		<input type="text" id="id" name="memberId" class="form-control">
	</div>
	<div class="form-group">
		<label for="password">회원 PW</label>
		<input type="password"  id="password" name="memberPw" class="form-control">
	</div>
	<div class="form-group">
		<label for="name">이름</label>
		<input type="text" id="name" name="memberName" class="form-control">	
	</div>
	<div class="form-group">
		<label for="address">주소</label>
		<input type="text" id="address" name="memberAddress" class="form-control">
	</div>
	<div class="form-group">
		<label for="email">이메일</label>
		<input type="text" id="email" name="memberEmail" class="form-control">
	</div>
	<div class="form-group">
		<label for="tel">전화번호</label>
		<input type="text" id="tel" name="memberTel" class="form-control">
	</div>
	<div class="form-group">
		성별 <label for="sex_man">남</label><input type="radio" id="sex_man" name="memberSex" value="M" class="form-control">
			<label for="sex_woman">여</label><input type="radio" id="sex_woman" name="memberSex" value="W" class="form-control">
	</div>
	<sec:csrfInput/>
	<button type="submit" class="btn btn-default">가입</button>
	<button type="reset" class="btn btn-default">다시작성</button>
</form>

</body>
</html>