<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<h1>Turnup-Fridger</h1>
<h3>효율적인 식재료 관리를 위한 냉장고 털어먹기</h3>
<hr class="intro-divider">
<ul class="list-inline intro-social-buttons">
	<li class="topMenuLi"><a href="#recipe"
		class="btn btn-default btn-lg"><i class="fa fa-twitter fa-fw"></i>
			<span class="network-name">레시피 검색</span></a>
		<ul class="submenu">
			<li><a href="${initParam.rootPath}/recipe_for_user/search_by_irdnts.do" id="submenuLink">재료명 검색</a></li>
			<li><a href="${initParam.rootPath}/recipe_for_user/search_by_category.do" id="submenuLink">카테고리별 검색</a></li>
			<li><a href="${initParam.rootPath}/recipe_for_user/search_by_recipeName.do" id="submenuLink">레시피로 검색</a></li>
		</ul></li>
	<!-- 회원만 -->
	<sec:authorize access="hasRole('ROLE_MEMBER')">
	<li class="topMenuLi"><a href="#fridger"
		class="btn btn-default btn-lg"><i class="fa fa-linkedin fa-fw"></i>
			<span class="network-name">냉장고 관리</span></a>
		<ul class="submenu">
			<li><a href="${initParam.rootPath}/common/member/fridger/register_form2.do" id="submenuLink">냉장고 만들기</a></li>
			<li><a href="${initParam.rootPath}/common/member/fridger/my_list.do" id="submenuLink">내 냉장고 관리</a></li>
			<li><a href="${initParam.rootPath}/common/member/fridger/list.do" id="submenuLink">냉장고 조회</a></li>
			<li><a href="${initParam.rootPath}/common/member/fridger/joinProcess/list.do" id="submenuLink">공유 관리</a></li>
			<li><a href="" id="submenuLink">공유 냉장고</a></li>
		</ul></li>
	</sec:authorize>
	
		<!-- 관리자만 -->
		<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
		<li class="topMenuLi"><a href="#recipe_ridnt_mng"
		class="btn btn-default btn-lg"><i class="fa fa-linkedin fa-fw"></i>
			<span class="network-name">레시피 & 재료</span></a>
		<ul class="submenu">
			<li><a href="${initParam.rootPath}/common/admin/recipe/recipeList.do" id="submenuLink">레시피 조회</a></li>
			<li><a href="${initParam.rootPath}/common/admin/recipe/register_form.do" id="submenuLink">레시피 저장</a></li>
			<li><a href="${initParam.rootPath}/common/admin/irdntManage/findAllICategory.do" id="submenuLink">재료 조회</a></li>
			<li><a href="${initParam.rootPath}/common/admin/recipe/recipeList.do" id="submenuLink">재료 등록</a></li>
			<li><a href="" id="submenuLink">레시피 공유게시판</a></li>
		</ul></li>
		</sec:authorize>
		
		<!-- 관리자만 -->
		<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
		<li class="topMenuLi"><a href="#member_board_mng"
		class="btn btn-default btn-lg"><i class="fa fa-linkedin fa-fw"></i>
			<span class="network-name">게시판 & 회원</span></a>
		<ul class="submenu">
			<li><a href="${initParam.rootPath}/common/admin/recipe/recipeList.do" id="submenuLink">회원관리</a></li>
			<li><a href="${initParam.rootPath}/common/admin/recipe/recipeList.do" id="submenuLink">관리자관리</a></li>
			<li><a href="${initParam.rootPath}/boardnotice/boardNoticeList.do" id="submenuLink">게시판 관리</a></li>
		</ul></li>
		</sec:authorize>
	<li class="topMenuLi"><a href="#" class="btn btn-default btn-lg"><i
			class="fa fa-linkedin fa-fw"></i> <span class="network-name">게시판</span></a>
		<ul class="submenu">
			<li><a href="${initParam.rootPath}/boardnotice/boardNoticeList.do" id="submenuLink">공지사항</a></li>
			<li><a href="${initParam.rootPath}/common/boardqna/boardQnAList.do" id="submenuLink">QnA</a></li>
			<li><a href="${initParam.rootPath}/common/boardfree/boardFreeList.do" id="submenuLink">자유게시판</a></li>
			<li><a href="${initParam.rootPath}/boardreview/boardReviewList.do" id="submenuLink">후기</a></li>
			<li><a href="" id="submenuLink">레시피 공유게시판</a></li>
		</ul></li>
		
	<!-- 회원만 -->
	<sec:authorize access="hasRole('ROLE_MEMBER')">
	<li class="topMenuLi"><a href="${initParam.rootPath}/shop/findShopList.do" class="btn btn-default btn-lg"><i
			class="fa fa-linkedin fa-fw"></i> <span class="network-name">쇼핑하기</span></a>
	</li>
	</sec:authorize>
	
	<!-- 회원만 -->
	<sec:authorize access="hasRole('ROLE_MEMBER')">
	<li class="topMenuLi"><a href="#" class="btn btn-default btn-lg"><span
			class="network-name">마이페이지</span></a>
		<ul class="submenu">
			<%-- <sec:authentication property='principal.memberId' var='memberId'/> --%>
			<li><a href="${initParam.rootPath}/memo/memoList.do?memberId=${memberId}" id="submenuLink">내 메모보기</a></li>
			<li><a href="#"
				onClick="window.open('${initParam.rootPath}/memo/map.do','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=750px, height=500px ,top=10, left=10', bottom=10, right=10)" id="submenuLink">주변 마트보기</a></li>
			<li><a href="${initParam.rootPath}/common/member/member_mypage_event.do" id="submenuLink">회원정보수정</a></li>
		</ul></li>
		</sec:authorize>
</ul>