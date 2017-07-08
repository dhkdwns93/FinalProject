<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 
 (jsp)join_member_form
작성자 :  김경혜
최초 작성일 170703
변경이력 
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("button#duplicateIdBtn").on("click",function(){
		var inputId=$("input#id").val();
		window.open("${initParam.rootPath}/popup_duplicate_id_form.do?inputId="+inputId,"duplicate_id_form","width=500,height=300,resizable=yes");
		$("span#duplicateBefore").hide();
		$("span#duplicateError").hide();
		$("span#duplicateAfter").show();
		$("input#id").val("");
	});//end of duplicateIdBtn
	
	$("button#duplicateEmailBtn").on("click",function(){
		var inputEmail=$("input#inputEmail").val();
		window.open("${initParam.rootPath}/popup_duplicate_email_form.do?inputEmail="+inputEmail,"duplicate_email_form","width=800,height=300,resizable=yes");
		$("span#duplicateEmailBefore").hide();
		$("span#duplicateEmailError").hide();
		$("span#duplicateEmailAfter").show();
		$("input#inputEmail").val("");
	});//end of duplicateEmailBtn
	
	$("div#showMyDislikeIrdnt").on("click","button#createMyDislikeIrdnt",function(){
		window.open("${initParam.rootPath}/popup_find_irdnt_form.do","find_irdnt_form","width=500,height=400,resizable=yes");
		var inputTextHtml=$("#showMyDislikeIrdnt")
				.prepend('<div id="myDislikeIrdntText"><input type="hidden" id="myDislikeIrdntId" name="myDislikeIrdntId" value="${param.irdntId}" class="form-control"><input type="text" id="myDislikeIrdntName" name="myDislikeIrdntName" value="${param.irdntName}" readonly="readonly" class="form-control">&nbsp&nbsp<button type="button" id="removeMyDislikeIrdnt">해당 기피재료 삭제</button><br></div>');
	});//end of createMyDislikeIrdnt(Btn)
	
	$("div#showMyDislikeIrdnt").on("click","button#removeMyDislikeIrdnt",function(){
			var deleteInputTextHtml=$(this).parent().remove();
	});//end of showMyDislikeIRdnt

});

</script>
</head>
<body>
<jsp:include page="/WEB-INF/view/user/layout_menu_security.jsp" />
<hr>


<h2>회원가입페이지</h2>
<%-- controller.common패키지 --%>
<form action="${initParam.rootPath}/join_member.do" method="post" name="useIrdntPopup">
	※모든 사항은 필수기입사항입니다.<br><br>
	<div id="idCheck" class="form-group">
		<label for="id">회원 ID</label>
		<span id="duplicateBefore">
		<input type="text" id="id" name="inputId" class="form-control">
		</span>
		<span id="duplicateAfter" style="display:none">
		<input type="text" id="memberId" name="memberId" value="${param.memberId}" readonly="readonly" class="form-control">
		</span>
		<button type="button" id="duplicateIdBtn" class="btn btn-default">ID 중복검사</button>
		<span class="error"><form:errors path="member.memberId" delimiter="&nbsp;&nbsp"/></span>
		<br><span id="duplicateError" class="error">&nbsp&nbsp*중복검사는 필수사항입니다.</span>
	</div>
	<div class="form-group">
		<label for="password">회원 PW</label>
		<input type="password"  id="password" name="memberPw" class="form-control">
		<span class="error"><form:errors path="member.memberPw" delimiter="&nbsp;&nbsp"/></span>
	</div>
	<div class="form-group">
		<label for="name">이름</label>
		<input type="text" id="name" name="memberName" class="form-control">
		<span class="error"><form:errors path="member.memberName" delimiter="&nbsp;&nbsp"/></span>	
	</div>
	<div class="form-group">
		<label for="address">주소</label>
		<input type="text" id="address" name="memberAddress" class="form-control">
		<span class="error"><form:errors path="member.memberAddress" delimiter="&nbsp;&nbsp"/></span>
	</div>
	<div id="emailCheck" class="form-group">
		<label for="inputEmail">이메일</label>
		<span id="duplicateEmailBefore">
		<input type="text" id="inputEmail" name="inputEmail" class="form-control" >
		</span>
		<span id="duplicateEmailAfter" style="display:none">
		<input type="text" id="memberEmail" name="memberEmail" value="${param.email}" readonly="readonly" class="form-control">
		</span>
		<button type="button" id="duplicateEmailBtn" class="btn btn-default">Email 중복검사</button>
		<span class="error"><form:errors path="member.memberEmail" delimiter="&nbsp;&nbsp"/></span>
		<br><span id="duplicateEmailError" class="error">&nbsp&nbsp*이메일 중복검사는 필수사항입니다.</span>
	</div>
	<div class="form-group">
		<label for="tel">전화번호</label>
		<input type="text" id="tel" name="memberTel" class="form-control">
		<span class="error"><form:errors path="member.memberTel"/></span>
	</div>
	<div class="form-group">
		성별 <label for="sex_man">남</label><input type="radio" id="sex_man" name="memberSex" value="M" class="form-control">
			<label for="sex_woman">여</label><input type="radio" id="sex_woman" name="memberSex" value="W" class="form-control">
		<span class="error"><form:errors path="member.memberSex" delimiter="&nbsp;&nbsp"/></span>
	</div>
	<div class="form-group">
		기피재료<br>
		<div id="showMyDislikeIrdnt">
			<button type="button" id="createMyDislikeIrdnt">기피재료추가</button><br>
		</div>
	</div>
	<sec:csrfInput/>
	<button type="submit" id="submit" class="btn btn-default">가입</button>
	<button type="button" onclick="location.reload()" class="btn btn-default">다시작성</button>
</form>

</body>
</html>