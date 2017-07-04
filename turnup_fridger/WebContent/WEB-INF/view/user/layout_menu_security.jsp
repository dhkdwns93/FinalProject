<%@ page contentType="text/html;charset=UTF-8"%>
<!-- 
 (jsp)menu_security
작성자 :  김경혜
최초 작성일 170703
변경이력 
 -->
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%--
   sec:authorize access="Spring Security EL"  : EL 표현식의 인증/권한 상태의 사용자에게만 보여질 
   									내용을 태그의 content로 넣는다.
 --%>
 <ul class="nav nav-stacked">
 <%--비회원 메뉴 (로그인 하면 안보여야 하는 메뉴)--%>
 <sec:authorize access="!isAuthenticated()">
 	<a href="${initParam.rootPath}/user/login_form.do"><button type="button">로그인</button></a><br>
	<a href="${initParam.rootPath}/user/join_member_form.do"><button type="button">회원가입</button></a>
 </sec:authorize>
 
 <%--인증된(로그인한) 사용자 메뉴--%>
 <sec:authorize access="isAuthenticated()">
 	<a href="javascript:logout()">LOGOUT</a><br>
 </sec:authorize>
 
 <%--회원 메뉴 /member로 시작 --%>
 
 <%--관리자 메뉴 /admin으로 시작--%>
 
 <%--마스터관리자 메뉴 /admin/master으로 시작--%>
 
 <%--인증 관련 없는 메뉴(로그인 유무에 상관없이 보일 메뉴) --%>
 </ul>
 
 
 <%-- 로그아웃 처리--%>
 <script type="text/javascript">
 	function logout(){
 		document.getElementById("logoutForm").submit();
 	}
 </script>
 <form id="logoutForm" action="${initParam.rootPath}/user/logout.do" method="post" style="display:none">
 	<sec:csrfInput/><%--csrf 토큰 생성 --%>
 </form>