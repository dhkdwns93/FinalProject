<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

    <a id="about"></a>
    <div class="intro-header">
    <div class="container">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="intro-message">
                        <h1>Turnup-Fridger</h1>
                        <h3>효율적인 식재료 관리를 위한 냉장고 털어먹기</h3>
                        <hr class="intro-divider">
                        <ul class="list-inline intro-social-buttons">
                            <li class="topMenuLi">
                                <a href="#recipe" class="btn btn-default btn-lg"><span class="network-name">Recipe</span></a>
                                <ul class="submenu">
						    		<li><a href="${initParam.rootPath}/recipe_for_user/search_by_irdnts.do" id="submenuLink">재료명 검색</a></li>
						    		<li><a href="${initParam.rootPath}/recipe_for_user/search_by_category.do" id="submenuLink">카테고리별 검색</a></li>
						    		<li><a href="${initParam.rootPath}/recipe_for_user/search_by_recipeName.do" id="submenuLink">레시피로 검색</a></li>
						    	</ul>
                            </li>
                            <sec:authorize access="hasRole('ROLE_MEMBER')">
                            <li class="topMenuLi">
                                <a href="#fridger" class="btn btn-default btn-lg"><span class="network-name">Fridger</span></a>
                            	<ul class="submenu">
						    		<li><a href="${initParam.rootPath}/common/member/fridger/register_form2.do" id="submenuLink">냉장고 만들기</a></li>
						    		<li><a href="${initParam.rootPath}/common/member/fridger/my_list.do" id="submenuLink">냉장고 관리</a></li>
						    		<li><a href="${initParam.rootPath}/common/member/fridger/list.do" id="submenuLink">냉장고 조회</a></li>
									<li><a href="${initParam.rootPath}/common/member/fridger/joinProcess/list.do" id="submenuLink">공유 관리</a></li>
									<li><a href="${initParam.rootPath}/" id="submenuLink">공유 냉장고</a></li>
						    	</ul>
                            </li>
                            </sec:authorize>
                            <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
                            <li class="topMenuLi">
                            	<a href="#"  class="btn btn-default btn-lg"><span class="network-name">Recipe & Irdnt</span></a>
						      	<ul class="submenu">
									<li><a href="${initParam.rootPath}/common/admin/recipe/recipeList.do" id="submenuLink">레시피 조회</a></li>
									<li><a href="${initParam.rootPath}/common/admin/recipe/register_form.do" id="submenuLink">레시피 저장</a></li>
									<li><a href="${initParam.rootPath}/common/admin/irdntManage/findAllICategory.do" id="submenuLink">재료 조회</a></li>
									<li><a href="${initParam.rootPath}/common/admin/recipe/recipeList.do" id="submenuLink">재료 등록</a></li>
									<li><a href="" id="submenuLink">레시피 공유게시판</a></li>
								</ul>
						      </li>
						      <li class="topMenuLi">
						      	<a href="#"  class="btn btn-default btn-lg"><span class="network-name">Board & Member</span></a>
						      	<ul class="submenu">
									<li><a href="${initParam.rootPath}/common/admin/recipe/recipeList.do" id="submenuLink">회원관리</a></li>
									<li><a href="${initParam.rootPath}/common/admin/admin_mypage.do" id="submenuLink">관리자관리</a></li>
									<li><a href="${initParam.rootPath}/boardnotice/boardNoticeList.do" id="submenuLink">게시판 관리</a></li>
								</ul>
							  </li>
                            </sec:authorize>
                            <li class="topMenuLi">
                                <a href="#" class="btn btn-default btn-lg"><span class="network-name">Board</span></a>
                            	<ul class="submenu">
						    		<li><a href="${initParam.rootPath}/boardnotice/boardNoticeList.do" id="submenuLink">공지사항</a></li>
									<li><a href="${initParam.rootPath}/common/boardqna/boardQnAList.do" id="submenuLink">QnA</a></li>
									<li><a href="${initParam.rootPath}/common/boardfree/boardFreeList.do" id="submenuLink">자유게시판</a></li>
									<li><a href="${initParam.rootPath}/boardreview/boardReviewList.do" id="submenuLink">후기</a></li>
									<li><a href="" id="submenuLink">레시피 공유게시판</a></li>
						    	</ul>
                            </li>
                            <sec:authorize access="hasRole('ROLE_MEMBER')">
                            <li class="topMenuLi">
                                <a href="${initParam.rootPath}/shop/findShopList.do" class="btn btn-default btn-lg"><span class="network-name">Shop</span></a>
                            </li>
                            <li class="topMenuLi">
                                <a href="#" class="btn btn-default btn-lg"><span class="network-name">MyPage</span></a>
                            	<ul class="submenu">
                            		<sec:authentication property='principal.memberId' var='memberId'/>
						    		<li><a href="${initParam.rootPath}/memo/memoList.do?memberId=${memberId}" id="submenuLink">내 메모보기</a></li>
						    		<li><a href="#" onClick="window.open('${initParam.rootPath}/memo/map.do','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=750px, height=500px ,top=10, left=10', bottom=10, right=10)" id="submenuLink" id="submenuLink">주변 마트보기</a></li>
						    		<li><a href="${initParam.rootPath}/common/member/member_mypage_event.do" id="submenuLink">회원정보관리</a></li>
						    	</ul>
                            </li>
                            </sec:authorize>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- /.container -->
    </div>
    <!-- /.intro-header -->
</div>
    <!-- Page Content -->

	<a  id="services"></a>
    <div class="content-section-a">

        <div class="container">
            <div class="row">
                <div class="col-lg-5 col-sm-6">
                    <hr class="section-heading-spacer">
                    <div class="clearfix"></div>
                    <h2 class="section-heading">이달의 추천레시피&nbsp;&nbsp;<a target="_blank" href="소갈비찜 상세정보보기화면">소갈비찜</a></h2>
                    <p class="lead">
                    특별한 날, 기념할만한 날을 위한 든든하고 정갈한 음식 소갈비찜을 추천드립니다. 짭짤하고 달달한 맛으로 남녀노소 누구나 맛있게 즐길 수 있는 요리인데요, 요즘같이 무더운 여름철 보양식으로도 손색없습니다!<br>
                    저희 Turnup-Fridger에서 강력추천 드리는 이달의 추천 레시피 소갈비찜을 직접 만들어 드시고 게시판을 통해 후기를 올려주시면 추첨을 통해 다양한 상품을 증정해드립니다. </p>
                </div>
                <div class="col-lg-5 col-lg-offset-2 col-sm-6">
                    <img class="img-responsive" src="img/la.png" alt="소갈비찜 사진">
                </div>
            </div>

        </div>
        <!-- /.container -->

    </div>
    <!-- /.content-section-a -->

    <div class="content-section-b">

        <div class="container">

            <div class="row">
                <div class="col-lg-5 col-lg-offset-1 col-sm-push-6  col-sm-6">
                    <hr class="section-heading-spacer">
                    <div class="clearfix"></div>
                    <h2 class="section-heading">3D Device Mockups<br>by PSDCovers</h2>
                    <p class="lead">Turn your 2D designs into high quality, 3D product shots in seconds using free Photoshop actions by <a target="_blank" href="http://www.psdcovers.com/">PSDCovers</a>! Visit their website to download some of their awesome, free photoshop actions!</p>
                </div>
                <div class="col-lg-5 col-sm-pull-6  col-sm-6">
                    <img class="img-responsive" src="img/rose.jpg" alt="">
                </div>
            </div>

        </div>
        <!-- /.container -->

    </div>
    <!-- /.content-section-b -->

    <div class="content-section-a">

        <div class="container">

            <div class="row">
                <div class="col-lg-5 col-sm-6">
                    <hr class="section-heading-spacer">
                    <div class="clearfix"></div>
                    <h2 class="section-heading">Google Web Fonts and<br>Font Awesome Icons</h2>
                    <p class="lead">This template features the 'Lato' font, part of the <a target="_blank" href="http://www.google.com/fonts">Google Web Font library</a>, as well as <a target="_blank" href="http://fontawesome.io">icons from Font Awesome</a>.</p>
                </div>
                <div class="col-lg-5 col-lg-offset-2 col-sm-6">
                    <img class="img-responsive" src="img/women.jpg" alt="">
                </div>
            </div>

        </div>
        <!-- /.container -->

    </div>
    <!-- /.content-section-a -->