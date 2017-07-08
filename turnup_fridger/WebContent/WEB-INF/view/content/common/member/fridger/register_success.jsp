<%@ page contentType="text/html;charset=UTF-8"%>

<h2>등록 성공했다</h2>
냉장고 ID : ${ requestScope.fridger.fridgerId }<br>
사진 : 
<img src="${ initParam.rootPath }/images/${ requestScope.fridger.fridgerImg}">
<br>
냉장고 이름 : ${ requestScope.fridger.fridgerName }<br>
냉장고 주인 : ${ requestScope.fridger.memberId }<br>

<br>
<a href="${ initParam.rootPath }/common/member/fridger/register_form.do">등록폼으로 가기</a><br>
<a href="${ initParam.rootPath }/common/member/fridger/list.do">냉장고 목록보기</a><br>
<a href="${ initParam.rootPath }">index로 돌아가기</a><br>

