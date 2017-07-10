<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- 
 (jsp)index
작성자 : 
최초 작성일
변경이력 
170703 (경혜)로그인 버튼 추가
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
form{display:inline}
</style>
</head>
<body>
<h1>★☆★냉장고 털ㄴ업★☆★</h1>
<p>
프로젝트 Turn Up the Fridger 인덱스 페이지에용. 여기서 각자 부분 jsp 등등 링크 걸어서 하세용.
</p>
<hr>

<!-- 장규/준 -->
<a href="${initParam.rootPath}/boardnotice/boardNoticeList.do"><button type="button">공지사항</button></a>
<a href="${initParam.rootPath}/common/boardqna/boardQnAList.do"><button type="button">QnA</button></a>
<a href="${initParam.rootPath}/common/boardfree/boardFreeList.do"><button type="button">자유게시판</button></a>
<a href="${initParam.rootPath}/boardreview/boardReviewList.do"><button type="button">후기</button></a>
<hr>
<h3>레시피공유게시판</h3>
<a href="${initParam.rootPath }/boardRecipe/boardRecipeList.do"><button type="button">목록 시이자악</button></a>

<hr>


<h4>레시피관련</h4>
<a href="${initParam.rootPath}/common/admin/recipe/register_form.do"><button type="button">레시피등록</button></a>
<a href="${initParam.rootPath}/common/admin/recipe/recipeList.do"><button type="button">레시피목록</button></a>

<!-- 은영 -->
<h4>냉장고관련</h4>

<a href="${initParam.rootPath}/common/member/fridger/list.do"><button type="button">냉장고리스트(등록/업뎃/가입/초대)</button></a>
<a href="${initParam.rootPath}/common/member/fridger/my_list.do"><button type="button">내냉장고(삭제/등록)</button></a>
<a href="${initParam.rootPath}/common/member/fridger/register_form.do"><button type="button">냉장고등록</button></a>
<a href="${initParam.rootPath}/common/member/fridger/register_form2.do"><button type="button">냉장고등록(with IMG)</button></a>
<a href="${initParam.rootPath}/common/member/fridger/joinProcess/list.do"><button type="button">냉장고 가입처리</button></a>

<br>
<hr>
<!-- 경혜 -->
<a href="${initParam.rootPath}/index_kh.do"><button type="button">경혜기능모음</button></a>

<hr>
<!-- 연수 -->
<h4>재료관리 관련</h4>
<a href="${initParam.rootPath}/common/admin/irdntManage/findAllICategory.do" ><button type="button">재료관리</button></a><br>
<h4>나의 식재료 관련</h4>
<a href="${initParam.rootPath}/common/member/myIrdnt/myIrdntList.do"><button type="button">나의 식재료</button></a><br><hr>
<h4>레시피관리</h4>
<a href="${initParam.rootPath}/common/admin/recipe_for_admin/recipeList.do"><button type="button">레시피 관리</button></a><br><hr>
<h4>레시피 재료검색</h4>
<a href="${initParam.rootPath}/recipe_for_user/search_by_irdnts.do"><button type="button">레시피 재료검색</button></a><br>
<h4>레시피 요리명검색</h4>
<a href="${initParam.rootPath}/recipe_for_user/search_by_recipeName.do"><button type="button">레시피 요리명검색</button></a><br>
<h4>레시피 카테고리검색</h4>
<a href="${initParam.rootPath}/recipe_for_user/search_by_category.do"><button type="button">레시피 카테고리검색</button></a><br>

<hr>
<!-- 현화 -->
<h4>메모 관련</h4>
<a id="memo" href="#" onClick="window.open('${initParam.rootPath}/memo_register_form.jsp','_blank','toolbar=no,location=no,status=no,menubar=no,scrollbar=auto,resizable=no, directories=no,width=450px, height=430px ,top=10, left=10', bottom=10, right=10)"><button type="button">+메모</button></a>
<a href="${initParam.rootPath}/common/member/memo/memoList.do"><button type="button">메모목록</button></a>

<h4>쇼핑몰 관련</h4>
<a href="${initParam.rootPath}/common/shop/shop_register_form.do"><button type="button">쇼핑몰 등록</button></a>
<a href="${initParam.rootPath}/shop/findShopList.do"><button type="button">쇼핑몰 목록</button></a>
</body>
</html>