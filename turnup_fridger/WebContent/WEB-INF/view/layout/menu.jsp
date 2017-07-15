<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
 
 <%-- 로그아웃 처리--%>
 <script type="text/javascript">
    function logout(){
       document.getElementById("logoutForm").submit();
    }
 </script>
 <form id="logoutForm" action="${initParam.rootPath}/common/logout.do" method="post" style="display:none">
    <sec:csrfInput/><%--csrf 토큰 생성 --%>
 </form>

<div class="navbar-header">
   <a class="navbar-brand" href="${initParam.rootPath}" ><i class="material-icons">home</i></a>
</div>
<!-- =================== -->
<ul class="list-inline navbar-nav navbar-left">
   <li class="topMenuLi2"><a href="#" class="navbar-brand">Recipe</a>
         <ul class="submenu2">
         <li><a href="${initParam.rootPath}/recipe_for_user/search_by_irdnts.do" id="submenu2Link">재료명 검색</a></li>
         <li><a href="${initParam.rootPath}/recipe_for_user/search_by_category.do" id="submenu2Link">카테고리별 검색</a></li>
         <li><a href="${initParam.rootPath}/recipe_for_user/search_by_recipeName.do" id="submenu2Link">레시피로 검색</a></li>
      </ul>
      </li>
      <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
      <sec:authorize access="hasRole('ROLE_MEMBER')">
      <li class="topMenuLi2"><a href="#" class="navbar-brand">Fridger</a>
         <ul class="submenu2">
         <li><a href="${initParam.rootPath}/common/member/fridger/register_form2.do" id="submenu2Link">냉장고 만들기</a></li>
         <li><a href="${initParam.rootPath}/common/member/fridger/my_list.do" id="submenu2Link">내 냉장고 관리</a></li>
         <li><a href="${initParam.rootPath}/common/member/fridger/list.do" id="submenu2Link">냉장고 조회</a></li>
         <li><a href="${initParam.rootPath}/common/member/fridger/joinProcess/list.do" id="submenu2Link">공유 관리</a></li>
         <li><a href="${initParam.rootPath}/" id="submenu2Link">공유 냉장고</a></li>
      </ul>
      </li>
      <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
      </sec:authorize>
      <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
      <li class="topMenuLi2"><a href="#" class="navbar-brand">Recipe & Irdnt</a>
         <ul class="submenu2">
         <li><a href="${initParam.rootPath}/common/admin/recipe/recipeList.do" id="submenu2Link">레시피 조회</a></li>
         <li><a href="${initParam.rootPath}/common/admin/recipe/register_form.do" id="submenu2Link">레시피 저장</a></li>
         <li><a href="${initParam.rootPath}/common/admin/irdntManage/findAllICategory.do" id="submenu2Link">재료 조회</a></li>
         <li><a href="${initParam.rootPath}/common/admin/recipe/recipeList.do" id="submenu2Link">재료 등록</a></li>
         <li><a href="" id="submenu2Link">레시피 공유게시판</a></li>
      </ul>
      </li>
      <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
      <li class="topMenuLi2"><a href="#" class="navbar-brand">Board & Member</a>
         <ul class="submenu2">
         <li><a href="${initParam.rootPath}/common/admin/member_list.do" id="submenu2Link">회원관리</a></li>
         <li><a href="${initParam.rootPath}/common/admin/admin_mypage.do" id="submenu2Link">관리자관리</a></li>
         <li><a href="${initParam.rootPath}/boardnotice/boardNoticeList.do" id="submenu2Link">게시판 관리</a></li>
      </ul>
     </li>
      </sec:authorize>
      <li class="topMenuLi2"><a href="#" class="navbar-brand">Board</a>
         <ul class="submenu2">
         <li><a href="${initParam.rootPath}/boardnotice/boardNoticeList.do" id="submenu2Link">공지사항</a></li>
         <li><a href="${initParam.rootPath}/common/boardqna/boardQnAList.do" id="submenu2Link">QnA</a></li>
         <li><a href="${initParam.rootPath}/common/boardfree/boardFreeList.do" id="submenu2Link">자유게시판</a></li>
         <li><a href="${initParam.rootPath}/boardreview/boardReviewList.do" id="submenu2Link">후기</a></li>
         <li><a href="" id="submenu2Link">레시피 공유게시판</a></li>
      </ul>
      </li>
      <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
      <sec:authorize access="hasRole('ROLE_MEMBER')">
       <li class="topMenuLi2"><a href="#" class="navbar-brand">MyMenu</a>
          <ul class="submenu2">
         <sec:authentication property='principal.memberId' var='memberId'/>
         <li><a href="${initParam.rootPath}/memo/memoList.do?memberId=${memberId}" id="submenu2Link">내 메모보기</a></li>
         <li><a href="#" onClick="window.open('${initParam.rootPath}/memo/map.do','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=750px, height=500px ,top=10, left=10', bottom=10, right=10)" id="submenu2Link">주변 마트보기</a></li>
         <li><a href="${initParam.rootPath}/common/member/member_mypage_event.do" id="submenu2Link">회원정보보기</a></li>
      </ul>
       </li>
       <li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
     <li class="topMenuLi2"><a href="${initParam.rootPath}/shop/findShopList.do" class="navbar-brand">Shop</a></li>
       </sec:authorize>
</ul>
<!-- ================== -->
<div class="collapse navbar-collapse">
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
         <li><a href="${initParam.rootPath}/common/member/member_mypage_event.do">MyPage</a></li>
         <li><a href="javascript:logout()">logout</a></li>
         <li><a id="memo" href="#"
            onClick="window.open('${initParam.rootPath}/memo/memoPopup.do','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=450px, height=430px ,top=10, left=10', bottom=10, right=10)">+메모</a>
         </li>
      </sec:authorize>
      
      <%--관리자 메뉴 /admin으로 시작--%>
       <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
          <sec:authentication property="principal" var="admin" />
          <li><a>${admin.adminName}님 환영합니다</a></li>
          <li><a href="${initParam.rootPath}/common/admin/admin_mypage.do" id="submenuLink">MyPage</a></li>
         <li><a href="javascript:logout()">logout</a></li>
         
      </sec:authorize>

   </ul>
</div>

