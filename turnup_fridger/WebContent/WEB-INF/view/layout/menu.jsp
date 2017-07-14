<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<div class="nav navbar-nav">
  <ul class="navbar-center">
      <li class="topMenuLi"><a href="#" class="navbar-brand">Recipe</a>
      	<ul class="submenu">
			<li><a href="${initParam.rootPath}/recipe_for_user/search_by_irdnts.do" id="submenuLink">재료명 검색</a></li>
			<li><a href="${initParam.rootPath}/recipe_for_user/search_by_category.do" id="submenuLink">카테고리별 검색</a></li>
			<li><a href="${initParam.rootPath}/recipe_for_user/search_by_recipeName.do" id="submenuLink">레시피로 검색</a></li>
		</ul>
      </li>
      <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
      <sec:authorize access="hasRole('ROLE_MEMBER')">
      <li class="topMenuLi"><a href="#" class="navbar-brand">Fridger</a>
      	<ul class="submenu">
			<li><a href="${initParam.rootPath}/common/member/fridger/register_form2.do" id="submenuLink">냉장고 만들기</a></li>
			<li><a href="${initParam.rootPath}/common/member/fridger/my_list.do" id="submenuLink">내 냉장고 관리</a></li>
			<li><a href="${initParam.rootPath}/common/member/fridger/list.do" id="submenuLink">냉장고 조회</a></li>
			<li><a href="${initParam.rootPath}/common/member/fridger/joinProcess/list.do" id="submenuLink">공유 관리</a></li>
			<li><a href="${initParam.rootPath}/" id="submenuLink">공유 냉장고</a></li>
		</ul>
      </li>
      </sec:authorize>
      <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
      <li class="topMenuLi"><a href="#" class="navbar-brand">Recipe & Irdnt</a>
      	<ul class="submenu">
			<li><a href="${initParam.rootPath}/common/admin/recipe/recipeList.do" id="submenuLink">레시피 조회</a></li>
			<li><a href="${initParam.rootPath}/common/admin/recipe/register_form.do" id="submenuLink">레시피 저장</a></li>
			<li><a href="${initParam.rootPath}/common/admin/irdntManage/findAllICategory.do" id="submenuLink">재료 조회</a></li>
			<li><a href="${initParam.rootPath}/common/admin/recipe/recipeList.do" id="submenuLink">재료 등록</a></li>
			<li><a href="" id="submenuLink">레시피 공유게시판</a></li>
		</ul>
      </li>
      <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
      <li class="topMenuLi"><a href="#" class="navbar-brand">Board & Member</a>
      	<ul class="submenu">
			<li><a href="${initParam.rootPath}/common/admin/recipe/recipeList.do" id="submenuLink">회원관리</a></li>
			<li><a href="${initParam.rootPath}/common/admin/admin_mypage.do" id="submenuLink">관리자관리</a></li>
			<li><a href="${initParam.rootPath}/boardnotice/boardNoticeList.do" id="submenuLink">게시판 관리</a></li>
		</ul>
	  </li>
      </sec:authorize>
     <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
      <li class="topMenuLi"><a href="#" class="navbar-brand">Board</a>
      	<ul class="submenu">
			<li><a href="${initParam.rootPath}/boardnotice/boardNoticeList.do" id="submenuLink">공지사항</a></li>
			<li><a href="${initParam.rootPath}/common/boardqna/boardQnAList.do" id="submenuLink">QnA</a></li>
			<li><a href="${initParam.rootPath}/common/boardfree/boardFreeList.do" id="submenuLink">자유게시판</a></li>
			<li><a href="${initParam.rootPath}/boardreview/boardReviewList.do" id="submenuLink">후기</a></li>
			<li><a href="" id="submenuLink">레시피 공유게시판</a></li>
		</ul>
      </li>
      <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
      <sec:authorize access="hasRole('ROLE_MEMBER')">
	  <li class="topMenuLi"><a href="${initParam.rootPath}/shop/findShopList.do" class="navbar-brand">Shop</a></li>
	  <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
  	  <li class="topMenuLi"><a href="#" class="navbar-brand">MyPage</a>
  	  	<ul class="submenu">
			<sec:authentication property='principal.memberId' var='memberId'/>
			<li><a href="${initParam.rootPath}/memo/memoList.do?memberId=${memberId}" id="submenuLink">내 메모보기</a></li>
			<li><a href="#" onClick="window.open('${initParam.rootPath}/memo/map.do','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=750px, height=500px ,top=10, left=10', bottom=10, right=10)" id="submenuLink">주변 마트보기</a></li>
			<li><a href="${initParam.rootPath}/common/member/member_mypage_event.do" id="submenuLink">회원정보</a></li>
		</ul>
  	  </li>
  	  </sec:authorize>
  </ul>
</div>



