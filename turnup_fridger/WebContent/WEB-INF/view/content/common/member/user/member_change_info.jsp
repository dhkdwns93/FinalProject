<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!-- 
 (jsp)member_change_info
작성자 :  김경혜
최초 작성일 170704
변경이력 
170706 (경혜) 기피재료 검색 추가
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
	$("button#duplicateEmailBtn").on("click",function(){
		var memberId=$("input#id").val();
		var inputEmail=$("input#inputEmail").val();
		window.open("${initParam.rootPath}/popup_duplicate_email_form.do?inputEmail="+inputEmail,"duplicate_email_form","width=600,height=380,resizable=yes");
		$("input#inputEmail").val("");
		$("input#memberEmail").val("${param.email}");
	});//end of duplicateEmailBtn
	
	$("button#findAddressBtn").on("click",function(){
		window.open("${initParam.rootPath}/popup_find_address_form.do","find_address_form","width=500,height=500,resizable=yes");
	});//end of findAddressBtn
	
	$("div#showMyDislikeIrdnt").on("click","button#createMyDislikeIrdnt",function(){
		if(checkNumCreateMyDislikeIrdnt<4){
			window.open("${initParam.rootPath}/popup_find_irdnt_form.do","find_irdnt_form","width=500,height=600,resizable=yes");
			var inputTextHtml=$("#showMyDislikeIrdnt").prepend('<div id="myDislikeIrdntText"><input type="hidden" id="myDislikeIrdntId" name="myDislikeIrdntId" value="${param.irdntId}" class="ccformfield "><input type="text" id="myDislikeIrdntName" name="myDislikeIrdntName" value="${param.irdntName}" readonly="readonly" class="ccformfield">&nbsp&nbsp<button type="button" id="removeMyDislikeIrdnt" class="btn btn-default btn-lg"  style="border:0;outline:0;"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button><br></div>');
			var irdntId="${param.irdntId}";
			if(irdntId!=("")){
				var inputTextHtml=$("#showMyDislikeIrdnt").prepend('<div id="myDislikeIrdntText"><input type="hidden" id="myDislikeIrdntId" name="myDislikeIrdntId" value="${param.irdntId}" class="ccformfield "><input type="text" id="myDislikeIrdntName" name="myDislikeIrdntName" value="${param.irdntName}" readonly="readonly" class="ccformfield">&nbsp&nbsp<button type="button" id="removeMyDislikeIrdnt" class="btn btn-default btn-lg"  style="border:0;outline:0;"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span></button><br></div>');
			}
			checkNumCreateMyDislikeIrdnt=checkNumCreateMyDislikeIrdnt+1;
		}else{
			$("span#tooMuchIrdnt").text("*기피재료는 4개까지만 설정할 수 있습니다.");
		} 
	});//button#createmyDislikeIrdnt.onclick
	$("div#showMyDislikeIrdnt").on("click","button#removeMyDislikeIrdnt",function(){
			var deleteInputTextHtml=$(this).parent().remove();
	});
});
</script>
<style>
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
	font-family: "Viner Hand ITC" !important;
	src: url("/font/VINERITC.TTF");
	font-weight:bold !important;
	color:#4d4d4d !important;
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
.contact-form{
	display:inline-block;
	width:70%;
	margin-left:5%;
}
</style>
</head>
<body>
	<div class="container">
		<div class='wrapperDiv'>
			<jsp:include page="/WEB-INF/view/layout/side_menu/memberSideMenu.jsp"/>
			<div class='right-box-sidemenu'>
				<div class="contact-form">
					<h1>Edit Profile</h1>
					<form action="${initParam.rootPath}/common/member/member_change.do" method="post" name="usePopup">
						<div class="ccfield-prepend">
							<div><label for="id" class="form-text">ID</label></div>
							<span class="ccform-addon"><i class="material-icons">&#xE85E;</i></span>
							<input type="text" id="id" name="memberId" readonly="readonly" value='<sec:authentication property="principal.memberId"/>' class="ccformfield" >
							<div class="error"><form:errors path="memberChangeForm.memberId" delimiter="&nbsp;&nbsp"/></div>
						</div>
						<div class="ccfield-prepend">
							<div><label for="password" class="form-text">Password</label></div>
							<span class="ccform-addon"><i class="material-icons">&#xE85E;</i></span>
							<input type="password" id="oldPassword" name="oldMemberPw"  class="ccformfield">
							<div class="error"><form:errors path="memberChangeForm.oldMemberPw" delimiter="&nbsp;&nbsp"/></div>
						</div>
						<div class="ccfield-prepend">
							<div><label for="newPassword" class="form-text">New Password</label></div>
							<span class="ccform-addon"><i class="material-icons">&#xE150;</i></span>
							<input type="password" id="password" name="memberPw"  class="ccformfield">
							<div class="error"><form:errors path="memberChangeForm.memberPw" delimiter="&nbsp;&nbsp"/></div>
						</div>
						<div class="ccfield-prepend">
							<div><label for="name" class="form-text">Name</label></div>
						 	<span class="ccform-addon"><i class="material-icons">&#xE853;</i></span>	
							<input type="text" id="name" name="memberName" value='<sec:authentication property="principal.memberName"/>' class="ccformfield">
							<div class="error"><form:errors path="memberChangeForm.memberName" delimiter="&nbsp;&nbsp"/></div>
						</div>
						<div class="ccfield-prepend">
							<div><label for="address" class="form-text">Address</label></div>
							<span class="ccform-addon"><i class="material-icons">&#xE153;</i></span>
							<input type="text" id="address" name="memberAddress" value='<sec:authentication property="principal.memberAddress"/>' readonly="readonly" class="ccformfield">
							<button type="button" id="findAddressBtn" class="ccbtn">주소검색</button>
							<div class="error"><form:errors path="memberChangeForm.memberAddress" delimiter="&nbsp;&nbsp"/></div>
						</div>
						<div class="ccfield-prepend">
							<div><label for="inputEmail" class="form-text">Email</label></div>
							<span class="ccform-addon"><i class="material-icons">&#xE0BE;</i></span>
							<span id="duplicateEmailBefore" style="display:none">
							<input type="text" id="inputEmail" name="inputEmail" value='<sec:authentication property="principal.memberEmail"/>' readonly="readonly" class="ccformfield" >
							</span>
							<span id="duplicateEmailAfter">
							<input type="text" id="memberEmail" name="memberEmail" value='<sec:authentication property="principal.memberEmail"/>' readonly="readonly" class="ccformfield">
							</span>
							<button type="button" id="duplicateEmailBtn" class="ccbtn">Email 중복검사</button>
							<div class="error"><form:errors path="memberChangeForm.memberEmail" delimiter="&nbsp;&nbsp"/></div>
							<div id="duplicateEmailError" class="error">&nbsp&nbsp*이메일변경을 원하시면 중복검사를 해주세요.</div>	
							</div>
						<div class="ccfield-prepend">
							<div><label for="tel" class="form-text">Tel</label><span id="lengthTel" class="error">&nbsp&nbsp*ex.01012345678</span></div>
							<span class="ccform-addon"><i class="material-icons">&#xE0B0;</i></span>
							<input type="text" id="tel" name="memberTel" value='<sec:authentication property="principal.memberTel"/>' class="ccformfield">
							<div class="error"><form:errors path="memberChangeForm.memberTel" delimiter="&nbsp;&nbsp"/></div>
						</div>
						<div class="ccfield-prepend" hidden>
							<span class="form-text">성별&nbsp;&nbsp;&nbsp;</span>
							<input type="text" id="sex" name="memberSex" readonly="readonly" value='<sec:authentication property="principal.memberSex"/>' class="ccformfield">
							<div class="error"><form:errors path="memberChangeForm.memberSex" delimiter="&nbsp;&nbsp"/></div>
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
								<span class="glyphicon glyphicon-ok" aria-hidden="true">Edit</span>
							</button>
							<button type="button" onclick="location.reload()" class="btn btn-default btn-lg"  style="border:0;outline:0;">
								<span class="glyphicon glyphicon-refresh" aria-hidden="true">Reset</span>
							</button>
						</div>
					</form>
				</div><!-- contact-form -->
			</div><!-- right-side-menu -->
		</div><!-- wrapperDiv -->
	</div><!-- container -->
</body>
</html>