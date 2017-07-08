<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<div class="navbar-header">
	<a class="navbar-brand topnav" href="/turnup_fridger/">Main</a>
</div>
<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	<ul class="nav navbar-nav navbar-right">

		<li><a><sec:authentication property="authorities"/> 권한으로 로그인</a></li>
		<!-- 권한, 상태별로 분리하기 -->
		<sec:authorize access="!isAuthenticated()">
			<li><a href="#about">login</a></li>
			<li><a href="#services">join</a></li>
		</sec:authorize>
		
		<!-- 회원 메뉴/member로 시작 -->
		<sec:authorize access="hasRole('ROLE_MEMBER')">
			<sec:authentication property="principal" var="member" />
			<li><a>${member.memberName }님 환영합니다</a></li>
			<li><a href="#about">logout</a></li>
			<li><a href="#services">myPage</a></li>
			<li><a id="callMap" href="#"
				onClick="window.open('${initParam.rootPath}/map.jsp','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=750px, height=500px ,top=10, left=10', bottom=10, right=10)">근처마트보기</a>
			</li>
			<li><a id="memo" href="#"
				onClick="window.open('${initParam.rootPath}/common/member/memo/memo_register_form.do','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=450px, height=430px ,top=10, left=10', bottom=10, right=10)">+메모</a>
			</li>
		</sec:authorize>
		
		<%--관리자 메뉴 /admin으로 시작--%>
 		<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
 			<sec:authentication property="principal" var="admin" />
 			<li><a>${admin.adminName}님 환영합니다</a></li>
			<li><a href="#about">logout</a></li>
			<li><a href="#services">myPage</a></li>
			<li><a id="callMap" href="#"
				onClick="window.open('${initParam.rootPath}/map.jsp','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=750px, height=500px ,top=10, left=10', bottom=10, right=10)">근처마트보기</a>
			</li>
		</sec:authorize>

	</ul>
</div>