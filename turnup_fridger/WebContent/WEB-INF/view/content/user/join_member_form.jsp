<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 
 (jsp)join_member_form
작성자 :  김경혜
최초 작성일 170703
변경이력 
170709 (경혜) 기피재료 검색 추가
170711 (경혜) 주소검색 API 추가
 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
var checkNumCreateMyDislikeIrdnt=0;//기피재료 4개까지 입력받음
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
	
	$("button#findAddressBtn").on("click",function(){
		window.open("${initParam.rootPath}/popup_find_address_form.do","find_address_form","width=500,height=500,resizable=yes");
	});//end of findAddressBtn
	
	$("div#showMyDislikeIrdnt").on("click","button#createMyDislikeIrdnt",function(){
		if(checkNumCreateMyDislikeIrdnt<4){
			window.open("${initParam.rootPath}/popup_find_irdnt_form.do","find_irdnt_form","width=500,height=400,resizable=yes");
			var inputTextHtml=$("#showMyDislikeIrdnt").prepend('<div id="myDislikeIrdntText"><input type="hidden" id="myDislikeIrdntId" name="myDislikeIrdntId" value="${param.irdntId}" class="ccformfield"><input type="text" id="myDislikeIrdntName" name="myDislikeIrdntName" value="${param.irdntName}" readonly="readonly" class="ccformfield">&nbsp&nbsp<button type="button" id="removeMyDislikeIrdnt" class="btn btn-default btn-lg"  style="border:0;outline:0;"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button><br></div>');
			var irdntId="${param.irdntId}";
			if(irdntId!=("")){
				var inputTextHtml=$("#showMyDislikeIrdnt").prepend('<div id="myDislikeIrdntText"><input type="hidden" id="myDislikeIrdntId" name="myDislikeIrdntId" value="${param.irdntId}" class="ccformfield "><input type="text" id="myDislikeIrdntName" name="myDislikeIrdntName" value="${param.irdntName}" readonly="readonly" class="ccformfield">&nbsp&nbsp<button type="button" id="removeMyDislikeIrdnt" class="btn btn-default btn-lg"  style="border:0;outline:0;"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button><br></div>');
			}
			checkNumCreateMyDislikeIrdnt=checkNumCreateMyDislikeIrdnt+1;
		}else{
			$("span#tooMuchIrdnt").text("*기피재료는 4개까지만 설정할 수 있습니다.");
		} 
	});//end of createMyDislikeIrdnt(Btn)
	
	$("div#showMyDislikeIrdnt").on("click","button#removeMyDislikeIrdnt",function(){
			var deleteInputTextHtml=$(this).parent().remove();
	});//end of showMyDislikeIRdnt
});
</script>
<style>
.ccformfield2 {
	color:#000000; 
	background:#FFFFFF;
	border: 1px solid #f1f1f1;
	padding:15.5px;
	width:70%;
	height:80px;
	font-family: 'Lato',Arial,sans-serif;
	font-size:14px;
	margin:0;
}
.ccformfield2 {
	font-family: 'Lato',Arial,sans-serif;
}
.ccfield-prepend{
	margin-bottom:20px;
	width:100%;
}
.ccform-addon{
	color:#bfbfbf; 
	float:left;
	padding:8px;
	width:8%;
	height:34px;
	background:#FFFFFF;
	border: 1px solid #f1f1f1;
	text-align:center;
	
}
.ccformfield {
	color:#000000; 
	background:#FFFFFF;
	border: 1px solid #f1f1f1;
	padding:15.5px;
	width:60%;
	height:34px;
	font-family: 'Lato',Arial,sans-serif;
	font-size:14px;
	margin:0;
}
.ccformfield {
	font-family: 'Lato',Arial,sans-serif;
}
.ccbtn{
	font-size:13px;
	border:none;
	background:#a6a6a6;
	height:28px;
	color:#FFFFFF;
	cursor:pointer;
	text-decoration:none;
	font-weight:bold;
}
.ccbtn:hover{
	background:#737373;
}
.ccfield-submit-part{
	text-align:center;
}
/* 기타 일반 text  */
h1 {
	font-family: "Viner Hand ITC";
	src: url("/font/VINERITC.TTF");
	font-weight:bold;
	color:#4d4d4d;
}
.form-text{
	font-size:14px;
	color:#808080;
}
/* 에러메시지 */
.error{
  font-size:80% !important;
  color:#808080 !important;
}
/* contact-form 넓이*/
.form-page{
	display:inline-block;
	width:70%;
	margin-left:5%;
}
</style>
</head>
<body>
<div class="container">
<div class='wrapperDiv'>
<jsp:include page="/WEB-INF/view/layout/side_menu/nonMemberSideMenu.jsp"/>
<div class='right-box-sidemenu'>

<div class="form-page">
<h1>Contact Form</h1>
<%-- controller.common패키지 --%>
<form action="${initParam.rootPath}/join_member.do" method="post" name="usePopup">
	<span class="form-text">※모든 사항은 필수기입사항입니다.</span>
	<hr>
	<div id="idCheck" class="ccfield-prepend">
		<span id="duplicateBefore">
		<span class="ccform-addon"><i class="material-icons">&#xE150;</i></span>
		<input type="text" id="id" name="inputId" class="ccformfield" placeholder="ID    *중복검사는 필수사항입니다.">
		</span>
		<span id="duplicateAfter" style="display:none">
		<span class="ccform-addon"><i class="material-icons">&#xE150;</i></span>
		<input type="text" id="memberId" name="memberId" value="${param.memberId}" readonly="readonly" class="ccformfield">
		</span>
		<span><button type="button" id="duplicateIdBtn" class="ccbtn">ID 중복검사</button></span>
		<div class="error"><form:errors path="member.memberId" delimiter="&nbsp;&nbsp"/></div>
	</div>
	<div class="ccfield-prepend">
		<span class="ccform-addon"><i class="material-icons">&#xE150;</i></span>
		<input type="password"  id="password" name="memberPw" class="ccformfield" placeholder="Password">
		<div class="error"><form:errors path="member.memberPw" delimiter="&nbsp;&nbsp"/></div>
	</div>
	<div class="ccfield-prepend">
		<span class="ccform-addon"><i class="material-icons">&#xE853;</i></span>
		<input type="text" id="name" name="memberName" class="ccformfield" placeholder="Name">
		<div class="error"><form:errors path="member.memberName" delimiter="&nbsp;&nbsp"/></div>	
	</div>
	<div class="ccfield-prepend">
		<span class="ccform-addon"><i class="material-icons">&#xE153;</i></span>
		<input type="text" id="address" name="memberAddress" readonly="readonly" class="ccformfield" placeholder="Address">
		<button type="button" id="findAddressBtn" class="ccbtn">주소검색</button>
		<div class="error"><form:errors path="member.memberAddress" delimiter="&nbsp;&nbsp"/></div>
	</div>
	<div id="emailCheck" class="ccfield-prepend">
		<span class="ccform-addon"><i class="material-icons">&#xE0BE;</i></span>
		<span id="duplicateEmailBefore">
		<input type="text" id="inputEmail" name="inputEmail" class="ccformfield" placeholder="Email    *이메일 중복검사는 필수사항입니다.">
		</span>
		<span id="duplicateEmailAfter" style="display:none">
		<input type="text" id="memberEmail" name="memberEmail" value="${param.email}" readonly="readonly" class="ccformfield">
		</span>
		<button type="button" id="duplicateEmailBtn" class="ccbtn">Email 중복검사</button>
		<div class="error"><form:errors path="member.memberEmail" delimiter="&nbsp;&nbsp"/></div>
	</div>
	<div class="ccfield-prepend">
		<span class="ccform-addon"><i class="material-icons">&#xE0B0;</i></span>
		<input type="text" id="tel" name="memberTel" class="ccformfield" placeholder="Tel  *ex.01012345678">
		<div class="error"><form:errors path="member.memberTel"/></div>
	</div>
	<div class="ccfield-prepend">
		<span class="form-text">성별&nbsp;&nbsp;&nbsp;</span>
		<label for="sex_man"><span class="form-text">Man</span></label>&nbsp;<input type="radio" id="sex_man" name="memberSex" value="M" >
		&nbsp;&nbsp;<label for="sex_woman"><span class="form-text">Woman</span></label>&nbsp;<input type="radio" id="sex_woman" name="memberSex" value="W">
		<div class="error"><form:errors path="member.memberSex" delimiter="&nbsp;&nbsp"/></div>
	</div>
	<div class="ccfield-prepend">
		<div class="form-text">기피재료</div>
		<div id="showMyDislikeIrdnt">
			<input type="hidden" id="myDislikeIrdntId" name="myDislikeIrdntId" value="-1" class="ccformfield">
			<button type="button" id="createMyDislikeIrdnt" class="ccbtn">기피재료추가</button><br>
			<div class="error" id="tooMuchIrdnt"></div>
		</div>
	</div>
	<sec:csrfInput/>
	<div class="ccfield-submit-part">
			<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
				<span class="glyphicon glyphicon-ok" aria-hidden="true">Join</span>
			</button>
			
			<button type="button" onclick="location.reload()" class="btn btn-default btn-lg"  style="border:0;outline:0;">
				<span class="glyphicon glyphicon-refresh" aria-hidden="true">Reset</span>
			</button>
	</div>
</form>
</div>

</div><!-- contact-form -->


</div><!-- wrapperDiv -->
</div><!-- container -->
</body>
</html>