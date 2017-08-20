<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<script src="${ initParam.rootPath }/scripts/jquery.js"></script>
<script src="${ initParam.rootPath }/scripts/bootstrap.min.js"></script>
<script src="${ initParam.rootPath }/scripts/mdb.js"></script>
<link href="${ initParam.rootPath }/css/bootstrap.css" rel="stylesheet">
<link href="${ initParam.rootPath }/css/landing-page.css" rel="stylesheet">
 <script type="text/javascript">
$(document).ready(function (){
 $("#groupListTable").hide();
 
 
	 $("#fridgerName").on("change", function(){
		 getFridgerInfo($("#fridgerNameSelect>option:selected").val());
	 })
	
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
<p>

  <!-- table -->
  	<select id="fridgerName">
 		<c:forEach items="${fridgerList.fridger}" var="fridger">
 			<option value="${ fridger.fridgerId }"> ${fridger.fridgerNaem}</option> 
 		</c:forEach>
  	
  	</select>
  

    
    </div>
</div>
	</div>
