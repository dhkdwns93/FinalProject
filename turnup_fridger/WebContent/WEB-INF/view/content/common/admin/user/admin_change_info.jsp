<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 
 (jsp)admin_change_info
작성자 :  김경혜
최초 작성일 170705
변경이력 
170712 validator 에러메시지 적용
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


<h2>관리자 정보수정</h2>
<form action="${initParam.rootPath}/common/admin/admin_change.do" method="post">
	<div class="form-group">
		<label for="id">관리자 ID</label>
		<input type="text" id="id" name="adminId" readonly="readonly" value='<sec:authentication property="principal.adminId"/>' class="form-control">
		<span class="error"><form:errors path="adminChangeForm.adminId" delimiter="&nbsp;&nbsp"/></span>
	</div>
	<div class="form-group">
		<label for="password">기존 PW</label>
		<input type="password" id="password" name="oldAdminPw"  class="form-control">
		<span class="error"><form:errors path="adminChangeForm.oldAdminPw" delimiter="&nbsp;&nbsp"/></span>	
	</div>
	<div class="form-group">
		<label for="newPassword">변경할 PW</label>
		<input type="password" id="newPassword" name="adminPw"  class="form-control">
		<span class="error"><form:errors path="adminChangeForm.adminPw" delimiter="&nbsp;&nbsp"/></span>		
	</div>
	<div class="form-group">
		<label for="name">이름</label>
		<input type="text" id="name" name="adminName" value='<sec:authentication property="principal.adminName"/>' class="form-control">
		<span class="error"><form:errors path="adminChangeForm.adminName" delimiter="&nbsp;&nbsp"/></span>	
	</div>
	<div class="form-group">
		<label for="tel">전화번호</label>
		<input type="text" id="tel" name="adminTel" value='<sec:authentication property="principal.adminTel"/>' class="form-control">
		<span class="error"><form:errors path="adminChangeForm.adminTel" delimiter="&nbsp;&nbsp"/></span>		
	</div>
	<div class="form-group">
		<label for="email">이메일</label>
		<input type="text" id="email" name="adminEmail" value='<sec:authentication property="principal.adminEmail"/>' class="form-control">
		<span class="error"><form:errors path="adminChangeForm.adminEmail" delimiter="&nbsp;&nbsp"/></span>	
	</div>
	<sec:csrfInput/>
	<button type="submit" class="btn btn-default">수정완료</button>
	<button type="reset" class="btn btn-default">다시작성</button>
</form>

</body>
</html>