<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

	<h2>냉장고 등록폼</h2>
	<form action="${ initParam.rootPath }/common/member/fridger/register.do" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<table>
			<tr>
				<th>냉장고 이름</th>
				<td><input type="text" name="fridgerName"
					value="${ param.fridgerName }">
					<span class="error"><form:errors
							path="fridger.fridgerName" delimiter="&nbsp;"/>
							<c:if test="${ requestScope.errorMsg_fridgerName != null }">
							${ requestScope.errorMsg_fridgerName }
							</c:if>
							</span></td>
			</tr>
			<!-- 회원id는 principal 값으로  -->
			<tr>
				<th>회원ID</th>
				<td><sec:authentication property="principal.memberId" var="memberId"/>
				<input type="text" name="memberId"
					value="${ memberId }" readonly>
				<span class="error"><form:errors
							path="fridger.memberId" delimiter="&nbsp;" />
							<c:if test="${ requestScope.errorMsg_memberId != null }">
							${ requestScope.errorMsg_memberId }
							</c:if>
							</span>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="가입">
				</td>
			</tr>
		</table>
		
	</form>