<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<!-- <script src="http://code.jquery.com/jquery-latest.min.js"></script> -->

<style>
.wrapperDiv{
   display:-webkit-flex;
   display:flex;
}
.left-box-sidemenu{
    background:white;
    float:left;
    width:20%;
   min-width:200px;
   max-width:250px;
    height:100%;
   margin-left:5%;
   margin-bottom:auto;
    border-radius:10%;
    padding : 2%;
    font-size:100%;
}
.right-box-sidemenu{
   -webkit-flex:none;
   flex:none;
   position:relative;
   background:white;
   float:right;
   width:67%;
   height:100%;
   margin-right:5%;
}
.list-group-item {
   border: none;
   color: #555;
   text-decoration: none;
   background-color: white;
}
.list-group-item:hover, .list-group-item:focus {
   color: #555;
   text-decoration: none;
   background-color: #EAE7E7 !important;
}
</style>
<div class='left-box-sidemenu' >
      <div>
         <h2 style="text-align:center;">냉장고 공유</h2>
      </div>
      <hr style="border:0;height:3px;background:#ccc;">
      <div class="list-group">
      <sec:authentication property='principal.memberId' var='memberId'/>
      
      	<a href="javascript:window.location.reload();" class="list-group-item" style="text-align:right;">
       공유하기   
            <button type="button" class="btn btn-default btn-lg" style="background:none;color:black;width:30%;border:0;outline:0;">
               <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            </button>
         </a>
         
  <!--        <a href="/turnup_fridger/common/member/fridger/group/manage.do" class="list-group-item" style="text-align:right;">
       공유관리   
            <button type="button" class="btn btn-default btn-lg" style="background:none;color:black;width:30%;border:0;outline:0;">
               <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            </button>
         </a>
          -->
         <a href="javascript:getRequestList()"  class="list-group-item" style="text-align:right;">
        요청한 공유
            <button type="button" class="btn btn-default btn-lg" style="background:none;color:black;width:30%;border:0;outline:0;">
               <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            </button>
         </a>         

         <a href="javascript:getResponseList()" class="list-group-item" style="text-align:right;" >
        요청받은 공유   
            <button type="button" class="btn btn-default btn-lg" style="background:none;color:black;width:30%;border:0;outline:0;">
               <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            </button>
         </a>         
         
      </div>
</div>