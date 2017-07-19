<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

 <script type="text/javascript">
$(document).ready(function(){
	
});
 
 </script>



<div class="container">
<!-- 


 trigger of createFridgerModal
 <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createFridgerModal">냉장고 만들기</button> -->

 <!-- start of createFridgerModal -->
<div class="modal fade" id="inviteFridgerModal" tabindex="-1" role="dialog" aria-labelledby="inviteFridgerModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="resetInviteModal()" ><span aria-hidden="true">&times;</span></button>
        <h3 class="modal-title" id="inviteFridgerModalLabel">냉장고 초대</h3>
      </div>
      <div class="modal-body" >

	      <!-- 에러메시지 -->
      <div class="well errorWell">
      	<span class="error"><!-- 메시지 찍히는 곳 --></span>
      </div>   

	<form id="inviteForm" class="form-horizontal" action="${ initParam.rootPath }/common/member/fridger/invite.do"
		method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
       	<sec:authentication property="principal.memberId" var="memberId"/>	
		<input type="hidden" name="reqMemberId" value="${memberid}">
		<input type="hidden" name="processState" value="20">
       
        <div class="form-group">
          <label class="col-sm-3 control-label" for="inviteFridgerList">Fridger</label>
        <div class="col-sm-8">
          <select class="form-control" id="inviteFridgerList" name="processFridgerId"	>
          </select>
        </div>
        </div>
        <div class="form-group">    
			<label class="col-sm-3 control-label" for="inviteRespMemberId">For</label>
        <div class="col-sm-8">
          <input class="form-control" type="text" id="inviteRespMemberId" name="respMemberId" >
          
        </div>
        </div>
          
        </form>
      </div>
      <div class="modal-footer">
       <button type="button" id="inviteFormBtn" class="btn btn-yellow" style="background-color:#f7c42d; color:#ffffff; width:100px; border:5px; margin: 2px; text-shadow:none; font-weight: bold">REQUEST</button>
        <button type="button" class="btn btn-blue-grey" id="cancel" data-dismiss="modal" onclick="resetInviteModal()" style="background-color:#4c4c34; color:white; border:5px; border-color:#999966; width:100px; margin: 2px; text-shadow:none;  font-weight: bold">CANCEL</button>
      </div>
    </div>
  </div>
</div>
	</div>
	