<%@ page contentType="text/html;charset=UTF-8"%>

☆ Welcome! ☆
<h1>Turnup-Fridger</h1>
<h3>효율적인 식재료 관리를 위한 냉장고 털어먹기</h3>
<hr class="intro-divider">
<ul class="list-inline intro-social-buttons">
	<li class="topMenuLi"><a href="#recipe"
		class="btn btn-default btn-lg"><i class="fa fa-twitter fa-fw"></i>
			<span class="network-name">레시피 검색</span></a>
		<ul class="submenu">
			<li><a href="#" id="submenuLink">재료명 검색</a></li>
			<li><a href="#" id="submenuLink">카테고리별 검색</a></li>
			<li><a href="#" id="submenuLink">레시피로 검색</a></li>
		</ul></li>
	<li class="topMenuLi"><a href="#fridger"
		class="btn btn-default btn-lg"><i class="fa fa-linkedin fa-fw"></i>
			<span class="network-name">냉장고 관리</span></a>
		<ul class="submenu">
			<li><a href="${initParam.rootPath}/common/member/fridger/register_form2.do" id="submenuLink">냉장고 만들기</a></li>
			<li><a href="${initParam.rootPath}/common/member/fridger/my_list.do" id="submenuLink">냉장고 관리</a></li>
			<li><a href="" id="submenuLink">공유 냉장고</a></li>
		</ul></li>
	<li class="topMenuLi"><a href="#" class="btn btn-default btn-lg"><i
			class="fa fa-linkedin fa-fw"></i> <span class="network-name">게시판</span></a>
		<ul class="submenu">
			<li><a href="${initParam.rootPath}/boardnotice/boardNoticeList.do" id="submenuLink">공지사항</a></li>
			<li><a href="${initParam.rootPath}/common/boardqna/boardQnAList.do" id="submenuLink">QnA</a></li>
			<li><a href="${initParam.rootPath}/common/boardfree/boardFreeList.do" id="submenuLink">자유게시판</a></li>
			<li><a href="${initParam.rootPath}/boardreview/boardReviewList.do" id="submenuLink">후기</a></li>
			<li><a href="" id="submenuLink">레시피 공유게시판</a></li>
		</ul></li>
	<li class="topMenuLi"><a href="#" class="btn btn-default btn-lg"><i
			class="fa fa-linkedin fa-fw"></i> <span class="network-name">쇼핑하기</span></a>
	</li>
	<li class="topMenuLi"><a href="#" class="btn btn-default btn-lg"><span
			class="network-name">마이페이지</span></a>
		<ul class="submenu">
			<li><a href="" id="submenuLink">내 메모보기</a></li>
			<li><a href="" id="submenuLink">주변 마트보기</a></li>
			<li><a href="" id="submenuLink">회원정보수정</a></li>
		</ul></li>
</ul>