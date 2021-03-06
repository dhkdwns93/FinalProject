<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script src="${ initParam.rootPath }/scripts/jquery.js"></script>
<script src="${ initParam.rootPath }/scripts/bootstrap.min.js"></script>
<link href="${ initParam.rootPath }/css/bootstrap.css" rel="stylesheet">
<link href="${ initParam.rootPath }/css/landing-page.css" rel="stylesheet">
<script type="text/javascript">

$(document).on("click", "#ownerChangeBtn", function(){
	$("#updateOwnerId").removeAttr("name").hide();
	$("#ownerChangeBtn").hide();
	$("#updateOwnerIdList").prop("name", "memberId").fadeIn();
	$("#ownerChangeCancelBtn").fadeIn();
	
	
})

$(document).on("click", "#ownerChangeCancelBtn", function(){
	$("#updateOwnerIdList").removeAttr("name").hide();
	$("#ownerChangeCancelBtn").hide();
	$("#updateOwnerId").prop("name", "memberId").fadeIn();
	$("#ownerChangeBtn").fadeIn();
})

</script>

<style>
img{
border-radius: 5px;
}

#updateOwnerIdList{
display: none;
}

#ownerChangeCancelBtn{
display: none;
}

.article-slide .carousel-indicators {
    bottom: 0;
    left: 0;
    margin-left: 5px;
    width: 100%;
    text-align: center;
}

/* Indicators list style */
.article-slide .carousel-indicators li {
    border: medium none;
    border-radius: 0;
    float: none;
    height: 24px;
    margin-bottom: 5px;
    margin-left: 0;
    margin-right: 5px !important;
    margin-top: 0;
    width: auto;
}


/* Indicators images style */
.article-slide .carousel-indicators img {
	width:auto; 
	height:25px;
    float: left;
    left: 0;
    width: auto;
}


/* Indicators active image style */
.article-slide .carousel-indicators .active img {
   border: 2px solid gray;
   border-radius: 0;
}

.well{
display: none;
}
</style>

<div class="container">
<!-- 
 trigger of updateFridgerModal
 <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createFridgerModal">냉장고 만들기</button> -->

 <!-- start of updateFridgerModal -->
<div class="modal fade" id="updateFridgerModal" tabindex="-1" role="dialog" aria-labelledby="createFridgerModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="resetUpdateModal()" ><span aria-hidden="true">&times;</span></button>
        <h3 class="modal-title" id="myModalLabel">냉장고 수정</h3>
      </div>
      <div class="modal-body" >
      
      <!-- 에러메시지 -->
      <div class="well errorWell">
      	<span class="error"><!-- 에러메시지 올곳  --></span>
      </div>   
      
      
         
 
	<form id="updateForm" class="form-horizontal" action="${initParam.rootPath }/common/member/fridger/update.do" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <input type="hidden" name="fridgerId" id="updateFridgerId" >
         <div class="form-group">
          <label class="col-sm-2 control-label" for="updateFridgerName">Name</label>
        <div class="col-sm-6">
          <input class="form-control" id="updateFridgerName" name="fridgerName" type="text" >
        </div>
        </div>
        <div class="form-group">    
	        <sec:authentication property="principal.memberId" var="memberId"/>
			<label class="col-sm-2 control-label" for="updateOwnerId">Owner</label>
	        <div class="col-sm-4">
	          	<input class="form-control" type="text" id="updateOwnerId" name="memberId" value="${ memberId }" readonly="readonly" style="border: none;">   
	          	<select class="form-control" id="updateOwnerIdList"><!-- 그룹멤버들 오는곳 --></select>
	        </div>
	         <div class="col-sm-2" style="margin-left: -20px; margin-bottom: 2px">
	       		<button type="button" id="ownerChangeBtn" class="btn btn-default" style="background-color: #f2f2f2; border:5px; border-color: gray; width:100px; margin: 2px; text-shadow:none; font-weight: bold">
	       		CHANGE</button>
	       		<button type="button" id="ownerChangeCancelBtn" class="btn btn-default" style="background-color: #f2f2f2; border:5px; border-color: gray; width:100px; margin: 2px; text-shadow:none; font-weight: bold">
	       		CANCEL</button>
	         </div>
        </div>
        
          <div class="form-group">
              <label class="col-sm-2 control-label" for="updateFridgerImg">Image</label>
             <div class="col-sm-9">
              <input class="form-control" type="hidden" id="updateFridgerImg" name="fridgerImg">
              <p class="help-block">냉장고 사진을 선택해주세요</p>
               <!-- start of fridgerCarousel -->
  
  <div id="updateFridgerCarousel" class="carousel slide article-slide" data-ride="carousel" data-interval="false" style="position: relative;" align="center">
    <!-- Indicators -->
    <ol class="carousel-indicators">
		<li data-target="#updateFridgerCarousel" data-slide-to="0" class="active"><img src="${initParam.rootPath}/images/fridger/f1.png" alt="fridger1"></li>
		<li data-target="#updateFridgerCarousel" data-slide-to="1"><img src="${initParam.rootPath}/images/fridger/f2.png" alt="fridger1"></li>
		<li data-target="#updateFridgerCarousel" data-slide-to="2"><img src="${initParam.rootPath}/images/fridger/f3.png" alt="fridger1" ></li>
		<li data-target="#updateFridgerCarousel" data-slide-to="3"><img src="${initParam.rootPath}/images/fridger/f4.png" alt="fridger1" ></li>
		<li data-target="#updateFridgerCarousel" data-slide-to="4"><img src="${initParam.rootPath}/images/fridger/f5.png" alt="fridger1"></li>
		<li data-target="#updateFridgerCarousel" data-slide-to="5"><img src="${initParam.rootPath}/images/fridger/f6.png" alt="fridger1"></li>
		<li data-target="#updateFridgerCarousel" data-slide-to="6"><img src="${initParam.rootPath}/images/fridger/f7.png" alt="fridger1"></li>
		<li data-target="#updateFridgerCarousel" data-slide-to="7"><img src="${initParam.rootPath}/images/fridger/f8.png" alt="fridger1"></li>
		<li data-target="#updateFridgerCarousel" data-slide-to="8"><img src="${initParam.rootPath}/images/fridger/f9.png" alt="fridger1"></li>
		<li data-target="#updateFridgerCarousel" data-slide-to="9"><img src="${initParam.rootPath}/images/fridger/f10.png" alt="fridger1"></li>
		<li data-target="#updateFridgerCarousel" data-slide-to="10"><img src="${initParam.rootPath}/images/fridger/f11.png" alt="fridger1"></li>
		<li data-target="#updateFridgerCarousel" data-slide-to="11"><img src="${initParam.rootPath}/images/fridger/f12.png" alt="fridger1"></li>
		<li data-target="#updateFridgerCarousel" data-slide-to="12" ><img src="${initParam.rootPath}/images/fridger/f13.png" alt="fridger1"></li>		
    </ol>
        
        <!-- Wrapper for slides -->
    <div class="carousel-inner"  style="width:400px;height:250px;position: relative;" align="center">
    
      <div class="item">
        <img src="${initParam.rootPath}/images/fridger/f1.png" alt="fridger1" style="width:auto; height:250px;"> 
      </div>
      <div class="item">
         <img src="${initParam.rootPath}/images/fridger/f2.png" alt="fridger2" style="width:auto;height:250px;">
      </div>
      <div class="item">
         <img src="${initParam.rootPath}/images/fridger/f3.png" alt="fridger3" style="width:auto;height:250px;">
      </div>
      
      <div class="item">
         <img src="${initParam.rootPath}/images/fridger/f4.png" alt="fridger4" style="matwidth:auto; height:250px;">
      </div>
      
      <div class="item">
         <img src="${initParam.rootPath}/images/fridger/f5.png" alt="fridger5" style="width:auto;height:250px;">
      </div>
      
      <div class="item">
         <img src="${initParam.rootPath}/images/fridger/f6.png" alt="fridger6" style="width:auto;height:250px;">
      </div>
      
      <div class="item">
         <img src="${initParam.rootPath}/images/fridger/f7.png" alt="fridger7" style="width:auto;height:250px;">
      </div>
      
      <div class="item">
         <img src="${initParam.rootPath}/images/fridger/f8.png" alt="fridger8" style="width:auto;height:250px;">
      </div>
      
      <div class="item">
         <img src="${initParam.rootPath}/images/fridger/f9.png" alt="fridger9" style="width:auto;height:250px;">
      </div>
      
      <div class="item">
         <img src="${initParam.rootPath}/images/fridger/f10.png" alt="fridger10" style="width:auto;height:250px;">
      </div>
      
      <div class="item">
         <img src="${initParam.rootPath}/images/fridger/f11.png" alt="fridger11" style="width:auto;height:250px;">
      </div>
      
      <div class="item">
         <img src="${initParam.rootPath}/images/fridger/f12.png" alt="fridger12" style="width:auto;height:250px;">
      </div>
      
      <div class="item">
         <img src="${initParam.rootPath}/images/fridger/f13.png" alt="fridger13" style="width:auto;height:250px;">
      </div>
    </div>
    <!-- Left and right controls -->
    <a class="left carousel-control" href="#updateFridgerCarousel" data-slide="prev">
      <span style="position:absolute; top: 45%; left:10px;"><img src="${initParam.rootPath}/images/glyphicons/png/glyphicons-225-chevron-left.png"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#updateFridgerCarousel" data-slide="next" >
      <span style="position:absolute; top: 45%; bottom:40%; right:10px;"><img src="${initParam.rootPath}/images/glyphicons/png/glyphicons-224-chevron-right.png"></span>
            <span class="sr-only">Next</span>
    </a>
  </div>
  
   <!-- end of fridgerCarousel -->				
             </div>
          </div>
      
        </form>
      </div>
      <div class="modal-footer">
       <button type="button" id="updateFormBtn" class="btn btn-yellow" style="background-color:#f7c42d; color:#ffffff; width:100px; border:5px; margin: 2px; text-shadow:none; font-weight: bold">UPDATE</button>
       
        <button type="button" class="btn btn-blue-grey" id="cancel" data-dismiss="modal" onclick="resetUpdateModal()" style="background-color:#4c4c34; color:white; border:5px; border-color:#999966; width:100px; margin: 2px; text-shadow:none;  font-weight: bold">cancel</button>
     </div>
    </div>
  </div>
</div>

<!-- end of updateFridgerModal -->


	</div>