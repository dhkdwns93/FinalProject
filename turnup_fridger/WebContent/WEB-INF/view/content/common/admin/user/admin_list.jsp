<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)admin_list
작성자 :  김경혜
최초 작성일 170705
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


<h2>전체관리자등록정보 -paging처리 할것</h2>
<table border="1" width="1000px">
<thead id="thead">
	<tr>
		<th>번호</th>
		<th>관리자 ID</th>
		<th>이름</th>
		<th>전화번호</th>
		<th>이메일</th>
		<th>관리자권한</th>
		<th>Master관리자 기능</th>
	</tr>	
</thead>
<tbody>
<c:forEach var="admin" items="${requestScope.adminList}">
	<tr>
		<td>페이징 목록 번호</td>
		<td>${admin.adminId }</td>
		<td>${admin.adminName }</td>
		<td>${admin.adminTel }</td>
		<td>${admin.adminEmail }</td>
		<td>${admin.adminAuthority }</td>
		<td>
			<!-- 일반 Admin에게 보이는 것 -->
			<sec:authorize access="hasRole('ROLE_ADMIN')">
				권한없음
			</sec:authorize>
			
			<!-- MasterAdmin/HeadMasterAdmin에게 보이는 것  -->
			<sec:authorize access="hasAnyRole('ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
				<!-- 관리자권한수정 -->
				<form action="${initParam.rootPath }/common/admin/master/admin_change_authority.do" method="post">
					<input type="hidden" name="adminId" value="${admin.adminId }">
					<select name="adminAuthority" value="${admin.adminAuthority}">
						<option value="${admin.adminAuthority}">--권한선택--</option>
						<option value="ROLE_ADMIN">일반 Admin</option>
						<option value="ROLE_MASTERADMIN">MasterAdmin</option>
					</select>
					<sec:csrfInput/>
					<button type="submit">권한수정</button>
				</form>
				
				<!-- 관리자탈퇴처리 -->
				<form action="${initParam.rootPath}/common/admin/master/admin_delete.do" method="post">
					<input type="hidden" name="adminId" value="${admin.adminId}">
					<sec:csrfInput/>
					<button type="submit">탈퇴</button>
				</form>
			</sec:authorize>
		</td>
	</tr>
</c:forEach>
</tbody>
</table>

<hr>
 <sec:authorize access="hasAnyRole('ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
 마스터관리자메뉴(마스터관리자만)
 	<!-- 관리자 등록 -->
 	<a href="${initParam.rootPath}/common/admin/master/join_admin_form.do"><button type="button">관리자 등록</button></a>
 </sec:authorize>
</body>
</html>