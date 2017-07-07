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
<form action="${initParam.rootPath}/boardnotice/boardNoticeList.do" method="post">
<a href="${initParam.rootPath}/boardnotice/boardnoticelist.do"><input type="submit" value="공지사항"/></a>
<sec:csrfInput/>
</form>
<form action="${initParam.rootPath}/common/boardqna/boardQnAList.do" method="post">
<a href="${initParam.rootPath}/common/boardqna/boardqna_list.do"><input type="submit" value="QnA"/></a>
<sec:csrfInput/>
</form>

<hr>
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
<a href="${initParam.rootPath}/common/member/myIrdnt/myIrdntList.do"><button type="button">나의 식재료</button></a><br>

<hr>
<!-- 현화 -->


</body>
</html>