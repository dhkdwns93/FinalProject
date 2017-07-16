<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)member_delete_form
작성자 :  김경혜
최초 작성일 170704
변경이력 
170711 회원 개인 탈퇴처리 한번더 화긴
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("button#leaveMemberBtn").on("click",function(){
		var submitTrue=false;
		$.ajax({
			url:"${initParam.rootPath}/common/member/checkPw.do",
			type:"post",
			data:{'originalMemberPw':$("input#originalMemberPw").val(),'inputMemberPw':$("input#inputMemberPw").val(),'${_csrf.parameterName}':'${_csrf.token}'},
			async:false,
			success:function(responseText){
				if(responseText==("checkPwError")){
					$("div#checkPwResult").text("비밀번호가 일치하지 않습니다.");
					submitTrue="false";
				}else{
					$("div#checkPwResult").text("비밀번호가 일치합니다.");
					submitTrue="true";
				}
			}
		});//end of ajax-비밀번호 매칭
		
		//입력한 비밀번호가 일치하지 않으면 탈퇴불가. 일치하면 한번더 탈퇴확인.
		if(submitTrue=="false"){
			return false;
		}else{
			return window.confirm("정말 탈퇴 하시겠습니까?");
		}
	});
});//end of leaveMemberBtn

</script>
</head>
<body>
	<div class="container">
	<jsp:include page="/WEB-INF/view/content/user/layout_menu_security.jsp" />
<hr>

		<h2>회원탈퇴페이지</h2>
		<form action="${initParam.rootPath}/common/member/member_delete.do"
			method="post">
			[
			<sec:authentication property="principal.memberName" />
			] 님 정말로 탈퇴하시겠습니까?<br> <input type="hidden" name="memberId"
				value='<sec:authentication property="principal.memberId"/>'
				class="form-control"> <input type="hidden"
				id="originalMemberPw"
				value='<sec:authentication property="principal.memberPw"/>'
				class="form-control"> <label for="inputPw">회원비밀번호 입력</label>
			<input type="password" id="inputMemberPw" name="inputMemberPw"
				class="form-control">
			<sec:csrfInput />
			<div id="checkPwResult"></div>
			<hr>
			<a href="${initParam.rootPath}/common/member/member_mypage.do"><button
					type="button" class="btn btn-default">뒤로 돌아가기</button></a>
			<button type="submit" id="leaveMemberBtn" class="btn btn-default">탈퇴하기</button>
		</form>
	</div> 
</body>
</html>