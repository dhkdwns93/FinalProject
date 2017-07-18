<%@ page contentType="text/html;charset=UTF-8"%>
<!-- 
 (jsp)nonMemberSideMenu
작성자 :  김경혜
최초 작성일 170703
변경이력 
-->
<style>

.wrapperDiv{
   display:-webkit-flex;
   display:flex;
}
.left-box-sidemenu{
    background:#E6E6E6;
    float:left;
    width:30%;
   min-width:200px;
   max-width:250px;
    height:100%;
   margin-left:5%;
   margin-bottom:auto;
    border-radius:10%;
    padding : 2%;
}
.left-title-sidemenu{
    background:white;
    float:left;
    width:30%;
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
	background-color: #ffcc99;
}

.list-group-item:hover, .list-group-item:focus {
	color: #555;
	text-decoration: none;
	background-color: #fff2e6 !important;
}

</style>

<br><br><br><br>   
<div class='left-title-sidemenu'>
   <div class='left-title-sidemenu'>
      <div><h2>공지사항</h2></div>
      <hr style="border:0;height:3px;background:#ccc;">
   </div>
   <div class='left-box-sidemenu'>   
      <a href="${initParam.rootPath}/boardnotice/boardNoticeList.do" id="submenu2Link" style="text-align:right;">
         <h3 style="color:white;">
            공지사항&nbsp;&nbsp;
            <button type="button" class="btn btn-default btn-lg" style="background:none;color:white;width:30%;border:0;outline:0;">
               <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            </button>
         </h3>
      </a>
   </div>
   
   <div class='left-title-sidemenu'>
      <div>
         <h2>
            <a href="${initParam.rootPath}/login_form.do" id="submenu2Link" style="text-align:right;">
            <h4 style="color:black;">
               Login&nbsp;&nbsp;
               <button type="button" class="btn btn-default btn-lg" style="background:none;color:black;width:30%;border:0;outline:0;">
                  <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
               </button>
            </h4></a>
            
            <a href="${initParam.rootPath}/join_member_form.do" id="submenu2Link"  style="text-align:right;">
            <h4 style="color:black;">
               Join us&nbsp;&nbsp;
               <button type="button" class="btn btn-default btn-lg" style="background:none;color:black;width:30%;border:0;outline:0;">
                  <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
               </button>
            </h4></a>
            
         </h2>
      </div>
   </div>
</div>



