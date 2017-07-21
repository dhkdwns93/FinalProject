<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script src="${ initParam.rootPath }/scripts/jquery.js"></script>
<script src="${ initParam.rootPath }/scripts/bootstrap.min.js"></script>
<script src="${ initParam.rootPath }/scripts/mdb.js"></script>
<link href="${ initParam.rootPath }/css/bootstrap.css" rel="stylesheet">
<%-- <link href="${ initParam.rootPath }/css/mdb.css" rel="stylesheet"> --%>
<link href="${ initParam.rootPath }/css/landing-page.css" rel="stylesheet">
 <script type="text/javascript">
$(document).ready(function (){

			
	
	
});



</script>

<style>

#listTable{
display: none;
}

.errorWell{
display: none;
}

button{
margin-left: 2px;
margin-right: 2px;
}

</style>


<div class="container">
<jsp:include page="/WEB-INF/view/layout/side_menu/fridgerSideMenu.jsp"/>
<div class='right-box-sidemenu'>

<div class='inner-page' style="margin-top: 60px">

<div id="listHeader" style="position: relative" align="center">

<!-- 지금,<span style="font-size: 35px">Turnup Fridger</span>에서는  <br> -->
 <img src="/turnup_fridger/images/logo-letter2.png">에서 <br> 
지금까지 <span id="allFridgerCount" style="font-size: 35px"><!-- 냉장고 수 --></span>개의 냉장고를<br>
<span id="allFridgerGroupCount" style="font-size: 35px"><!-- 냉장고 수 --></span>명의 회원이 공유하고 있습니다.<br>
<br>
<hr>
<br>
가족 구성원끼리 냉장고를 공유하여 관리하세요. <br>
더욱 효율적으로 냉장고를 관리할 수 있을 것입니다.


<div id="inviteModal" style="position: absolute; border:1px solid lightgray; border-radius:5px; padding:20px; width:300px; height:220px; top:320px; left:35px; text-align: center;">
	<h3 style="font-weight: bold;">냉장고로 초대하기</h3>
	당신의 냉장고를 공유할 <br>
	회원을 초대합니다. <br>
	<br>
	<button type="button" class="btn btn-warning" id="inviteModalBtn" style="background-color:#f7c42d; color:#ffffff; width:70px; border:5px; margin: 2px; text-shadow:none; font-weight: bold">INVITE</button>
</div>
<div id="joinModal" style="position: absolute; border:1px solid lightgray; border-radius:5px; padding:20px; width:300px; height:220px; top:320px; right:35px; text-align: center;">
	<h3 style="font-weight: bold;">냉장고에 가입하기</h3>
	공유를 원하는 다른 회원의 <br>
	냉장고에 가입합니다.<br>
	<br>
	<button type="button" class="btn btn-default" id="joinModalBtn" style="background-color:#ccccb3; color:white; border:5px; border-color:#999966; width:70px; margin: 2px; text-shadow:none;  font-weight: bold">JOIN</button>
</div>
</div>


<p>

  <!-- table -->
   	<div id="listTable" style="width:850px;">
 		<table class="table table-hover table-condensed" style="width:100%; border:1; text-align:center">
			<thead>
				<tr>
					<th style="width:5%;">NO</th>
					<th style="width:18%;">냉장고명</th>
					<th style="width:12%;">처리상태</th>
					<th style="width:12%;">요청일</th>
					<th style="width:12%;">응답일</th>
					<th style="width:10%;">요청회원</th>
					<th style="width:10%;">응답회원</th>
					<th style="width:21%;">처리</th>
				</tr>
			</thead>
			<tbody>
				<!-- 내용 받아올 부분 -->
			</tbody>
		</table>
		</div>
  
  <!-- table -->
   	<div id="groupListTable" style="width:850px;">
 		<table class="table table-hover table-condensed" style="width:100%; border:1; text-align:center">
			<thead>
				<tr>
					<th style="width:5%;">NO</th>
					<th style="width:18%;">냉장고명</th>
					<th style="width:12%;">주인</th>
					<th style="width:12%;">요청일</th>
					<th style="width:12%;">응답일</th>
					<th style="width:10%;">요청회원</th>
					<th style="width:10%;">응답회원</th>
					<th style="width:21%;">처리</th>
				</tr>
			</thead>
			<tbody>
				<!-- 내용 받아올 부분 -->
			</tbody>
		</table>
		</div>
  

    
    </div>
</div>
	</div>
