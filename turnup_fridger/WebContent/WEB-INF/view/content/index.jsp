<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>


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
                        <sec:authorize access="!hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
                            <li class="topMenuLi">
                                <a href="#recipe" class="btn btn-default btn-lg"><span class="network-name">Recipe</span></a>
                                <ul class="submenu">
						    		<li><a href="${initParam.rootPath}/recipe_for_user/search_by_irdnts.do" id="submenuLink">재료명 검색</a></li>
						    		<li><a href="${initParam.rootPath}/recipe_for_user/search_by_category.do" id="submenuLink">카테고리별 검색</a></li>
						    		<li><a href="${initParam.rootPath}/recipe_for_user/search_by_recipeName.do" id="submenuLink">레시피로 검색</a></li>
						    	</ul>
                            </li>
                            </sec:authorize>
                            <sec:authorize access="hasRole('ROLE_MEMBER')">
                            <li class="topMenuLi">
                                <a href="#fridger" class="btn btn-default btn-lg"><span class="network-name">Fridger</span></a>
                            	<ul class="submenu">
						    		<li><a href="${initParam.rootPath}/common/member/fridger/main.do" id="submenuLink">나의 냉장고</a></li>
									<li><a href="${initParam.rootPath}/common/member/fridger/joinProcess/list.do" id="submenuLink">냉장고 공유</a></li>
						    	</ul>
                            </li>
                            </sec:authorize>
                            <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
                            <li class="topMenuLi">
                            	<a href="#"  class="btn btn-default btn-lg"><span class="network-name">Recipe & Irdnt</span></a>
						      	<ul class="submenu">
									<li><a href="${initParam.rootPath}/common/admin/recipe/recipeList.do" id="submenuLink">레시피 조회</a></li>
									<li><a href="${initParam.rootPath}/common/admin/recipe/register_form.do" id="submenuLink">레시피 저장</a></li>
									<li><a href="${initParam.rootPath}/common/admin/irdntManage/findAllICategory.do" id="submenuLink">재료 조회 및 등록</a></li>
									<li><a href="${initParam.rootPath}/boardRecipe/boardRecipeList.do" id="submenuLink">레시피 공유게시판</a></li>
								</ul>
						      </li>
						      <li class="topMenuLi">
						      	<a href="#"  class="btn btn-default btn-lg"><span class="network-name">Board & Member</span></a>
						      	<ul class="submenu">
						      		<li><a href="${initParam.rootPath}/common/admin/admin_mypage.do" id="submenu2Link">관리자 계정 정보</a></li>
									<li><a href="${initParam.rootPath}/common/admin/member_list.do" id="submenuLink">회원관리</a></li>
									<li><a href="${initParam.rootPath}/common/admin/admin_mypage.do" id="submenuLink">관리자관리</a></li>
									<li><a href="${initParam.rootPath}/boardnotice/boardNoticeList.do" id="submenuLink">게시판 관리</a></li>
								</ul>
							  </li>
							  <li class="topMenuLi">
							  	<a href="${initParam.rootPath}/common/shop/shopList_for_admin.do" class="btn btn-default btn-lg"><span class="network-name">Shop</span></a>
							  </li>
                            </sec:authorize>
                            <sec:authorize access="!hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
                            <li class="topMenuLi">
                                <a href="#" class="btn btn-default btn-lg"><span class="network-name">Board</span></a>
                            	<ul class="submenu">
						    		<li><a href="${initParam.rootPath}/boardnotice/boardNoticeList.do" id="submenuLink">공지사항</a></li>
									<li><a href="${initParam.rootPath}/common/boardqna/boardQnAList.do" id="submenuLink">QnA</a></li>
									<li><a href="${initParam.rootPath}/common/boardfree/boardFreeList.do" id="submenuLink">자유게시판</a></li>
									<li><a href="${initParam.rootPath}/boardreview/boardReviewList.do" id="submenuLink">후기</a></li>
									<li><a href="${initParam.rootPath}/boardRecipe/boardRecipeList.do" id="submenuLink">레시피 공유</a></li>
								</ul>
                            </li>
                            </sec:authorize>
                            <sec:authorize access="hasRole('ROLE_MEMBER')">
                            <li class="topMenuLi">
                                <a href="${initParam.rootPath}/shop/findShopList.do" class="btn btn-default btn-lg"><span class="network-name">Shop</span></a>
                            </li>
                            </sec:authorize>
                        </ul>
                    </div> <!-- intro message -->
                </div> <!-- col-lg-12 -->
            </div> <!-- row -->
        </div> <!-- container -->
    </div> <!-- container -->
	</div> <!-- intro-header -->



    <div class="content-section-a">
        <div class="container">
            <div class="row">
                <div class="col-lg-5 col-sm-6">
                    <hr class="section-heading-spacer">
                    <div class="clearfix"></div>
                    <h2 class="section-heading">이달의 추천레시피&nbsp;&nbsp;<a target="_blank" href="${initParam.rootPath}/recipe/show/detail.do?recipeId=50">소갈비찜</a></h2>
                    <p class="lead">
                    특별한 날, 기념할만한 날을 위한 든든하고 정갈한 음식 소갈비찜을 추천드립니다. 짭짤하고 달달한 맛으로 남녀노소 누구나 맛있게 즐길 수 있는 요리인데요, 요즘같이 무더운 여름철 보양식으로도 손색없습니다!<br>
                    저희 <span class="tf"><b>Turnup-Fridger</b></span>에서 강력추천 드리는 이달의 추천 레시피 소갈비찜을 직접 만들어 드시고 게시판을 통해 후기를 올려주시면 추첨을 통해 다양한 상품을 드립니다. </p>
                </div>
                <div class="col-lg-5 col-lg-offset-2 col-sm-6">
                    <img class="img-responsive mainImg" src="img/la.png"  style="border-radius: 50em;">
                </div>
            </div> <!-- row -->
        </div>  <!-- container -->
    </div> <!-- content-section-a -->



    <div class="content-section-b">
        <div class="container">
            <div class="row">
                <div class="col-lg-5 col-lg-offset-1 col-sm-push-6  col-sm-6">
                    <hr class="section-heading-spacer">
                    <div class="clearfix"></div>
                    <h2 class="section-heading">음식물 보관 팁</h2>
                    <p class="lead"><b>식중독 위험구간인<br> 5ºC ~ 60ºC 사이의 음식들을 주의하세요!</b><br><br>뜨거운 음식을 보관할 때에는 60ºC이상!<br> 실온음식을 보관할 때에는 5ºC이하의 서늘한 곳!<br> 차가운 음식은 -15ºC이하의 냉장 또는 냉동구간에!<br>
                    					 <b>뜨거운 기온과 습한 날씨로 인해 평소보다 더 주의깊은<br>식재료 관리가 필요합니다</b></p>
                </div>
                <div class="col-lg-5 col-sm-pull-6  col-sm-6">
                    <img class="img-responsive mainImg" src="img/rose.jpg"  style="border-radius: 50em;">
                </div>
            </div> <!-- row -->
        </div>  <!--  container -->
    </div> <!-- content-section-b -->



    <div class="content-section-a">
        <div class="container">
            <div class="row">
                <div class="col-lg-5 col-sm-6">
                    <hr class="section-heading-spacer">
                    <div class="clearfix"></div>
                    <h2 class="section-heading">당신의 냉장고는 쾌적한가요?</h2>
                    <p class="lead">내부의 여유공간이 5% 이하가 되면 우리의 냉장고는 점점 지쳐갑니다. 기술이 발달해 성능 좋은 냉장고들이 넘치는 요즘에도 마찬가지입니다.<br>
                    하지만 지금 당신의 냉장고는 어떤가요?<br>언젠간 먹어야지라는 마음으로 넣어둔 음식이 이미 가득채우고 있지는 않은가요? 
                    지쳐가는 당신의 냉장고와 허기진 당신의 배를 위해 '냉장고 털어먹기'가 필요한 지금, 바로<sec:authorize access="isAuthenticated()">
                    <span class="tf"><b>Turnup-Fridger</b></span>
                    </sec:authorize>
                    <sec:authorize access="!isAuthenticated()">
                    <a href="${initParam.rootPath}/join_member_form.do"><span class="tf"><b>Turnup-Fridger</b></span></a>
                    </sec:authorize> 와 함께 하세요.</p>
                </div>
                <div class="col-lg-5 col-lg-offset-2 col-sm-6">
                    <img class="img-responsive mainImg" src="img/women.jpg" style="border-radius: 50em;">
                </div>
            </div> <!-- row -->
        </div> <!-- container -->
    </div> <!--  content-section-a -->
    