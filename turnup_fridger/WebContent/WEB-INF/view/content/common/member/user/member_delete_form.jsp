<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)member_delete_form
작성자 :  김경혜
최초 작성일 170704
변경이력 
170711 회원 개인 탈퇴처리 한번더 화긴
 -->

<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(document).on("click","#leaveMemberBtn",function(){
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
	});//end of leaveMemberBtn
});

function resetModal(){
	document.getElementById("deleteMemberForm").reset();
}

function openModal(){
	$('#deleteMemberModal').modal('show');
}
</script>
<style>
.font-Viner_Hand_ITC {
	font-family: "Viner Hand ITC";
	src: url("/font/VINERITC.TTF");
	color: #6D6C75;
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

.form-text{
	font-size:14px;
	color:#808080;
}
/* 에러메시지 */
.error{
  font-size:80% !important;
  color:#808080 !important;
}
</style>

<div class='wrapperDiv'>
	
	
	<div class='right-box-sidemenu'>
		<div class="container">
		
		
		<div class="modal fade" id="deleteMemberModal" tabindex="-1" role="dialog" aria-labelledby="createFridgerModalLabel" aria-hidden="true">
		<div class="modal-dialog">
		<div class="modal-content">
		
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="resetModal()" ><span aria-hidden="true">&times;</span></button>
			<h3 class="modal-title font-Viner_Hand_ITC" id="myModalLabel">Delete My Account</h3>
		</div><!-- modal-header -->
		
		<form action="${initParam.rootPath}/common/member/member_delete.do" method="post" id="deleteMemberForm" class="form-horizontal">
		<div class="modal-body">
		<div class="form-group">
			<div class="col-sm-6 form-text">[ <sec:authentication property="principal.memberName"/> ]님 정말로 탈퇴하시겠습니까?</div>
			<input type="hidden" name="memberId" value='<sec:authentication property="principal.memberId"/>' class="form-control">
		</div><!-- form-group -->
		
		<div class="form-group">
			<input type="hidden" id="originalMemberPw" value='<sec:authentication property="principal.memberPw"/>' class="form-control">
			<label for="inputPw" class="col-sm-2 form-text">Password</label> 
			<input type="password" id="inputMemberPw" name="inputMemberPw" class="ccformfield col-sm-8">
		</div><!-- form-group -->
		<sec:csrfInput/>
		<div class="form-group">
			<div id="checkPwResult" class="col-sm-6 control-label error"></div>
		</div>
		
		</div><!-- modal-body -->
		<div class="modal-footer">
		<input type="button" id="cancel" class="btn btn-default" data-dismiss="modal" onclick="resetModal()" value="Cancel">
		<a href="${initParam.rootPath}/common/member/member_delete.do"><input type="submit" id="leaveMemberBtn" class="btn btn-primary" value="Delete My Account"></a>
		</div><!-- modal-footer -->
		</form>
		</div><!-- .modal-content -->
		</div><!-- .modal-dialog -->
		</div><!-- .modal fade -->
		
		
		</div><!-- .container  -->
		
		
	</div><!-- right-box -->
</div><!-- wrapperDiv -->	
