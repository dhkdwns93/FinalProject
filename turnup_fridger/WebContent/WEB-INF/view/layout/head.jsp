<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
 
 <script type="text/javascript">
 	function logout(){
 		document.getElementById("logoutForm").submit();
 	}
 </script>
 <%-- 로그아웃 처리--%>
 <form id="logoutForm" action="${initParam.rootPath}/common/logout.do" method="post" style="display:none">
 	<sec:csrfInput/><%--csrf 토큰 생성 --%>
 </form>

<div class="navbar-header">
	<a class="navbar-brand topnav" href="/turnup_fridger/">Main</a>
</div>
<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	<ul class="nav navbar-nav navbar-right">

		<%-- <li><a><sec:authentication property="authorities"/> 권한으로 로그인</a></li> --%>
		<!-- 권한, 상태별로 분리하기 -->
		<sec:authorize access="!isAuthenticated()">
			<li><a href="${initParam.rootPath}/login_form.do">login</a></li>
			<li><a href="${initParam.rootPath}/join_member_form.do">join</a></li>
		</sec:authorize>
		
		<!-- 회원 메뉴/member로 시작 -->
		<sec:authorize access="hasRole('ROLE_MEMBER')">
			<sec:authentication property="principal" var="member" />
			<li><a>${member.memberName }님 환영합니다</a></li>
			<li><a href="javascript:logout()">logout</a></li>
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
			<li><a href="${initParam.rootPath}/common/logout.do">logout</a></li>
			<li><a href="#services">myPage</a></li>
			<li><a id="callMap" href="#"
				onClick="window.open('${initParam.rootPath}/map.jsp','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=750px, height=500px ,top=10, left=10', bottom=10, right=10)">근처마트보기</a>
			</li>
		</sec:authorize>

	</ul>
</div>


