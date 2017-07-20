<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- 
 (jsp)popup_find_IdPw_form
작성자 :  김경혜
최초 작성일 170710
변경이력 
 -->
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(document).on("click","#findIdPwBtn",function(){
		$.ajax({
			url:"${initParam.rootPath}/popup_find_IdPw.do",
			type:"post",
			data:{ 'inputName' : $("input#inputName").val(),'inputEmail' : $("input#inputEmail").val(), '${_csrf.parameterName}':'${_csrf.token}' },			
			dataType:"text",
			success:function(responseText){
				if(responseText==("nonExistMember")){
					$("#sendEmail").hide();
					$("#findResult").show();
					$("div#findResult").text("*입력하신 정보와 일치하는 계정이 존재하지 않습니다.");
				}else{
					$("#sendEmail").show();
					$("#findResult").show();
					$("div#findResult").text("Email로 ID/Password를 전송받으시겠습니까?");
				}
			}
		});//end of ajax
	});//end of findIdPwBtn
	$("button#sendEmailBtn").on("click",function(){
		alert("*해당 이메일로 ID/Password 전송이 완료되었습니다");
		$('#findIdPwModal').modal('hide');
	});
});

function resetModal(){
	document.getElementById("findIdPwForm").reset();
}

function openModal(){
	$('#findIdPwModal').modal('show');
}
</script>
<style>
.font-Viner_Hand_ITC {
	font-family: "Viner Hand ITC";
	src: url("/font/VINERITC.TTF");
	color: #6D6C75;
}
</style>

<div class="container">


<div class="modal fade" id="findIdPwModal" tabindex="-1" role="dialog" aria-labelledby="createFridgerModalLabel" aria-hidden="true">
<div class="modal-dialog">
<div class="modal-content">

<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="resetModal()" ><span aria-hidden="true">&times;</span></button>
	<h3 class="modal-title font-Viner_Hand_ITC" id="myModalLabel">Find My Account</h3>
</div>
<form action="${initParam.rootPath }/send_find_IdPw_email.do" method="post" id="findIdPwForm" class="form-horizontal" >
<sec:csrfInput/>
<div class="modal-body">
<div class="form-group">
	<label for="inputName" class="col-sm-2">Name </label>
	<div class="col-sm-8">
	<input type="text" id="inputName" name="inputName" class="form-control">
	</div>
</div>
<div class="form-group">
	<label for="inputName" class="col-sm-2">Email </label>
	<div class="col-sm-8">
 	<input type="text" id="inputEmail" name="inputEmail" class="form-control">
 	</div>
</div>
<div class="form-group" style="text-align:center">
<button type="button" id="findIdPwBtn" class="btn btn-default">아이디/비밀번호 찾기</button>
</div>
<div class="form-group">
	<div id="findResult" class="col-sm-10 control-label" style="display:none"></div>
</div>


</div><!-- modal-body -->
<div class="modal-footer">
	<span id="sendEmail" style="display:none">
		<button type="submit" id="sendEmailBtn" class="btn btn-primary">전송</button>
	</span>
	<input type="button" id="cancel" class="btn btn-default" data-dismiss="modal" onclick="resetModal()" value="Close">
</div><!-- modal-footer -->
</form>
</div><!-- .modal-content -->
</div><!-- .modal-dialog -->
</div><!-- .modal fade -->


</div><!-- .container  -->