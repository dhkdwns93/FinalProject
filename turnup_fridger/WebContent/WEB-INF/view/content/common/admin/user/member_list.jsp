<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)member_list
작성자 :  김경혜
최초 작성일 170705
변경이력 
170711 한번더회원탈퇴처리 확인
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("button#deleteMemberBtn").on("click",function(){
		return window.confirm("정말 이 회원을 탈퇴처리 하시겠습니까?");
	});
});

</script>
</head>
<body>
<jsp:include page="/WEB-INF/view/content/user/layout_menu_security.jsp" />
<hr>


<h2>전체개인회원정보 -paging처리 할것</h2>
<table border="1" width="1000px">
<thead id="thead">
	<tr>
		<th>번호</th>
		<th>회원 ID</th>
		<th>이름</th>
		<th>주소</th>
		<th>이메일</th>
		<th>전화번호</th>
		<th>성별</th>
		<th>관리자 기능</th>
	</tr>	
</thead>
<tbody>
<c:forEach var="member" items="${requestScope.memberList}"  varStatus="loop">
	<tr>
		<td>${(loop.index)+1}</td>
		<td>${member.memberId }</td>
		<td>${member.memberName }</td>
		<td>${member.memberAddress }</td>
		<td>${member.memberEmail }</td>
		<td>${member.memberTel}</td>
		<td>${member.memberSex}</td>
		<td>
			<!-- 개인회원강제탈퇴처리 -->
			<form action="${initParam.rootPath}/common/admin/member_delete.do" method="post">
				<input type="hidden" name="memberId" value="${member.memberId}">
				<sec:csrfInput/>
				<button type="submit" id="deleteMemberBtn">탈퇴</button>
			</form>
		</td>
	</tr>
</c:forEach>
</tbody>
</table>

</body>
</html>