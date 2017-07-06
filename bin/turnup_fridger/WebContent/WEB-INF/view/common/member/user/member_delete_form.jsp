<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)member_delete_form
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


<h2>회원탈퇴페이지</h2>
<form action="${initParam.rootPath}/common/member/member_delete.do" method="post">
Id : [ <sec:authentication property="principal.memberName"/> ]님 정말로 탈퇴하시겠습니까?<br>
<input type="hidden" name="memberId" value='<sec:authentication property="principal.memberId"/>' class="form-control">
<label for="password">비밀번호 입력</label> <input type="password" id="password" name="inputPw" class="form-control">
<sec:csrfInput/>
<br>
<a href="${initParam.rootPath}/common/member/member_mypage.do"><button type="button" class="btn btn-default">뒤로 돌아가기</button></a>
<button type="submit" class="btn btn-default">탈퇴하기</button>
</form>
</body>
</html>