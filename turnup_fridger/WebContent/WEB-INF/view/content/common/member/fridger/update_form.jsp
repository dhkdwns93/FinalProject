<%-- <%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script src="${ initParam.rootPath }/scripts/jquery.js"></script>
<script src="${ initParam.rootPath }/scripts/bootstrap.min.js"></script>
<link href="${ initParam.rootPath }/css/bootstrap.css" rel="stylesheet">
<link href="${ initParam.rootPath }/css/landing-page.css" rel="stylesheet">
<script type="text/javascript">

$(document).ready(function(){
	$("div.stepImage_none").hide();
	$("div.stepImage_deleted").hide();
	$(document).on("click", "#deleteStepImgBtn", function(){
		console.log($(".stepImage").find("img"))
		if(confirm("기존사진을 삭제하시겠습니까?") != true){
			return false;
		}else{
			$(this).parent().parent().hide();
			$(this).parent().parent().parent().children("div.stepImage_deleted").show();
			$(this).parent().parent().find("#fridgerImg").removeAttr("value");
			$(this).parent().parent().parent().find(".stepImage_none").show();
			alert("기존사진이 삭제되었습니다. 새로운 사진을 등록해주세요.");
		}
	})
	
	
	$(document).on("click", "#backStepImgBtn", function(){
		//console.log($(this).parent().parent().children(".stepImage").find("#stepImageUrl"));
		//console.log($(this).parent().parent().children(".stepImage").find("img").prop("id"));
			$(this).parent().parent().find("div.stepImage_none").hide();
			$(this).parent().filter("div.stepImage_deleted").hide();
			$(this).parent().parent().children(".stepImage").show();
			$(this).parent().parent().children(".stepImage").find("#fridgerImg").val($(this).parent().parent().children(".stepImage").find("img").prop("id"));
			$(this).parent().parent().children("#fridgerImgSrc").removeAttr("value").hide();
			
	})
	
})
function changeOwner(){
	var newOwner = $("#groupMemberId>option:selected").val();
	$("#CurrentOwnerId").val(newOwner);
}


function closeWin(){
	document.fridgerUpdateForm.action="${ initParam.rootPath }/common/member/fridger/update.do";
	window.opener.location.reload();

}
</script>


<style>
.stepImage{
position:relative;
width: 100%;
}


.stepImage_button{
position: absolute;
top:5px;
left:5px;
}

img{
max-width: 200px;
height: 200px;
}


</style>

<div class="modal fade bs-example-modal-sm" id="changeModal"  tabindex="-1" role="dialog" aria-labelledby="mySmallModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
    <div class="modal-header  modal-sm">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">냉장고 공유 회원</h4>
      </div>
      <div class="modal-body">
        <p>
        <select name="memberId" id="groupMemberId">
       		<c:forEach items="${requestScope.fridger.fridgerGroupList}" var="fridgerGroup">
       			<option value="${ fridgerGroup.groupMemberId }">${ fridgerGroup.groupMemberId }</option>
       		</c:forEach> 
        </select>
        </p>
      </div>
      
      <div class="modal-footer modal-sm">
        <button type="button" class="btn btn-default bt-sm" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary bt-sm" data-dismiss="modal" onclick="changeOwner()">변경</button>
      </div>
    </div>
  </div>
</div>

	<h2>냉장고 업뎃폼</h2>	

	<form name="fridgerUpdateForm" class="form-horizontal" method="post" onsubmit="closeWin()" enctype="multipart/form-data">
		<input type="hidden" name="fridgerId" value="${requestScope.fridger.fridgerId}">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

		 <div class="form-group">
		 	<label for="fridgerName" class="col-xs-2 control-label">Fridger</label>
		 
			<div class="col-xs-4">
				<input type="text" class="form-control" name="fridgerName" id="fridgerName" value="${ requestScope.fridger.fridgerName }" >
					<span class="error"><form:errors
							path="fridger.fridgerName" delimiter="&nbsp;" />
							<c:if test="${ requestScope.errorMsg_fridgerName != null }">
							${ requestScope.errorMsg_fridgerName }
							</c:if>
							</span>
			</div>
		</div>
		
		<div class="form-inline form-group">
		<!-- 회원id는 principal 값으로  -->
			<label for="memberId" class="col-xs-2 control-label">Owner</label>
			<sec:authentication property="principal.memberId" var="memberId"/>
   			<div class="col-xs-4">
      			<input type="text" class="form-control" name="memberId" id="CurrentOwnerId" value="${ memberId }" readonly>
      			<button type="button" id="changeBtn" class="btn btn-primary btn-sm" 
      					data-toggle="modal" data-target="#changeModal">변경</button>
      			<button type="button" class="btn btn-primary btn-sm" id="fridgerIdChangeBtn">초기화</button>
      			<span class="error"><form:errors
							path="fridger.memberId" delimiter="&nbsp;" />
							<c:if test="${ requestScope.errorMsg_memberId != null }">
							${ requestScope.errorMsg_memberId }
							</c:if>
							</span>
   			</div>
 		</div>

		<div class="form-group">
   	 		<label for="fridgerImgSrc" class="col-xs-2 control-label">Image</label>
    		<div class="col-xs-6">
      			<c:choose>
						<c:when test="${  requestScope.fridger.fridgerImg eq 'null' || empty requestScope.fridger.fridgerImg || requestScope.fridger.fridgerImg == null}">
							<div class="stepImage">
								<input type="file" id="fridgerImgSrc" name="fridgerImgSrc" >
							</div>
							</c:when>
							<c:otherwise>
							<div class="stepImage_none">
								<input type="file" id="fridgerImgSrc" name="fridgerImgSrc" >
							</div>
							<div class="stepImage">
								<!-- 내가 저장한 사진경로와 API 사진경로가 다른 문제 해결해야함 -->
								<img src="${initParam.rootPath}/images/${ requestScope.fridger.fridgerImg }" height="150px" id="${ requestScope.fridger.fridgerImg }">
								<input type="hidden" class="form-control" id="fridgerImg" name="fridgerImg" value="${ requestScope.fridger.fridgerImg }">
								<div class="stepImage_button">
									<button type="button" id="deleteStepImgBtn" class="btn btn-default bt-sm">삭제</button>
								</div> 
							</div>
							</c:otherwise>
						</c:choose>
							<div class="stepImage_deleted">
								<button type="button" id="backStepImgBtn" class="btn btn-default bt-sm">원래 사진 복구</button>
							</div>
    		</div>
  		</div>
  		<div class="form-group">
    		<div class="col-xs-offset-2 col-xs-6">
      			<input type="submit" id="submitBtn" class="btn btn-primary bt-sm" value="업데이트">
				<input type="reset" class="btn btn-default bt-sm" value="초기화">
   	 		</div>
  		</div>

					
			
	</form>


 --%>