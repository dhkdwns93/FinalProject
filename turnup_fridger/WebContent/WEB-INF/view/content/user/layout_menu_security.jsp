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
 <sec:authentication property="authorities"/> 권한으로 로그인 <br>
 <%--인증 관련 없는 메뉴(로그인 유무에 상관없이 보일 메뉴) --%>
☆★여러분들을 위한 프레젠또~★☆
<a href="${initParam.rootPath}/index.do"><button type="button">index.do ㄱㄱ</button></a>
<hr>
 <%--비회원 메뉴 (로그인 하면 안보여야 하는 메뉴)--%>
 <sec:authorize access="!isAuthenticated()">
 비회원 메뉴
 	<a href="${initParam.rootPath}/login_form.do"><button type="button">로그인</button></a>
	<a href="${initParam.rootPath}/join_member_form.do"><button type="button">회원가입</button></a>
 </sec:authorize>
 <hr>
 <%--인증된(로그인한) 사용자 메뉴--%>
 <sec:authorize access="isAuthenticated()">
 로그인한 사용자 메뉴(관리자, 회원 모두)
 	<a href="javascript:logout()">LOGOUT</a><br>
 </sec:authorize>
 <hr>
 <%--회원 메뉴 /member로 시작 --%>
 <sec:authorize access="hasRole('ROLE_MEMBER')">
 회원 메뉴(회원만)
 	<a href="${initParam.rootPath}/common/member/member_mypage_event.do"><button type="button">MyPage(회원용)</button></a>
 </sec:authorize>
 <hr>
 <%--관리자 메뉴 /admin으로 시작--%>
 <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
 관리자메뉴(마스터관리자, 관리자 모두)
 	<a href="${initParam.rootPath}/common/admin/admin_mypage.do"><button type="button">MyPage(관리자용)</button></a>
 	<a href="${initParam.rootPath}/common/admin/admin_list.do"><button type="button">전체관리자등록정보</button></a>
 	<a href="${initParam.rootPath}/common/admin/member_list.do"><button type="button">전체개인회원정보</button></a>
 </sec:authorize>
 <hr>
 <%--마스터관리자 메뉴 /admin/master으로 시작--%>


 </ul>
 
 
 <%-- 로그아웃 처리--%>
 <script type="text/javascript">
 	function logout(){
 		document.getElementById("logoutForm").submit();
 	}
 </script>
 <form id="logoutForm" action="${initParam.rootPath}/common/logout.do" method="post" style="display:none">
 	<sec:csrfInput/><%--csrf 토큰 생성 --%>
 </form>