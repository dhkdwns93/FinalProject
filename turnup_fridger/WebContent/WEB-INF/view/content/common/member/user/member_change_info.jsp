<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)member_change_info
작성자 :  김경혜
최초 작성일 170704
변경이력 
170706 (경혜) 기피재료 검색 추가
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("div#showMyDislikeIrdnt").on("click","button#createMyDislikeIrdnt",function(){
		window.open("${initParam.rootPath}/popup_find_irdnt_form.do","find_irdnt_form","width=500,height=400,resizable=yes");
		var inputTextHtml=$("#showMyDislikeIrdnt").prepend('<div id="myDislikeIrdntText"><input type="text" id="myDislikeIrdnt" name="myDislikeIrdntS" class="form-control">&nbsp&nbsp<button type="button" id="removeMyDislikeIrdnt">해당 기피재료 삭제</button><br></div>');
	});//button#createmyDislikeIrdnt.onclick
	$("div#showMyDislikeIrdnt").on("click","button#removeMyDislikeIrdnt",function(){
			var deleteInputTextHtml=$(this).parent().remove();
		});
});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/view/content/user/layout_menu_security.jsp" />
<hr>


<h2>회원정보수정</h2>
<form action="${initParam.rootPath}/common/member/member_change.do" method="post">
	<div class="form-group">
		<label for="id">회원 ID</label>
		<input type="text" id="id" name="memberId" readonly="readonly" value='<sec:authentication property="principal.memberId"/>' class="form-control">
	</div>
	<div class="form-group">
		<label for="password">기존 PW</label>
		<input type="password" id="password" name="memberPw"  class="form-control">
	</div>
	<div class="form-group">
		<label for="newPassword">변경할 PW</label>
		<input type="password" id="newPassword" name="newMemberPw"  class="form-control">
	</div>
	<div class="form-group">
		<label for="name">이름</label>
		<input type="text" id="name" name="memberName" value='<sec:authentication property="principal.memberName"/>' class="form-control">
	</div>
	<div class="form-group">
		<label for="address">주소</label>
		<input type="text" id="address" name="memberAddress" value='<sec:authentication property="principal.memberAddress"/>' class="form-control">
	</div>
	<div class="form-group">
		<label for="email">이메일</label>
		<input type="text" id="email" name="memberEmail" value='<sec:authentication property="principal.memberEmail"/>' class="form-control">
	</div>
	<div class="form-group">
		<label for="tel">전화번호</label>
		<input type="text" id="tel" name="memberTel" value='<sec:authentication property="principal.memberTel"/>' class="form-control">
	</div>
	<div class="form-group">
		성별
		<input type="text" id="sex" name="memberSex" readonly="readonly" value='<sec:authentication property="principal.memberSex"/>' class="form-control">
	</div>
	<div class="form-group">
		기피재료<br>
		<div id="showMyDislikeIrdnt">
			<button type="button" id="createMyDislikeIrdnt">기피재료추가</button><br>
		</div>
	</div>
	<sec:csrfInput/>
	<button type="submit" class="btn btn-default">수정완료</button>
	<button type="reset" class="btn btn-default">다시작성</button>
</form>
</body>
</html>