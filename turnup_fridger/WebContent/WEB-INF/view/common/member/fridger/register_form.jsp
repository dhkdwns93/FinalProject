<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>냉장고 등록폼</h2>
	<form action="${ initParam.rootPath }/common/member/fridger/register.do"
		method="post">

		<table>
			<tr>
				<th>냉장고 이름</th>
				<td><input type="text" name="fridgerName"
					value="${ param.fridgerName }"> <span class="error"><form:errors
							path="fridger.fridgerName" delimiter="&nbsp;" />
							<c:if test="${ requestScope.errorMsg != null }">
							${ requestScope.errorMsg }
							</c:if>
							</span></td>
			</tr>
			<!-- 회원id는 나중에 세션 값으로  -->
			<tr>
				<th>회원ID</th>
				<td><input type="text" name="memberId"
					value="${ param.memberId }"> <span class="error"><form:errors
							path="fridger.memberId" delimiter="&nbsp;" />
							</span></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="가입">
				</td>
			</tr>
		</table>
		<sec:csrfInput/><%-- csrf 토큰 --%>
	</form>


</body>
</html>