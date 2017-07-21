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
 $("#groupListTable").hide();
 
 
	 $("#fridgerName").on("change", function(){
		 getFridgerInfo($("#fridgerNameSelect>option:selected").val());
	 })
			
	
	
});

/* function getFridgerInfo(fridgerId){
	$.ajax({
		"url":"${initParam.rootPath}/common/member/fridger/select.do",
		"type" : "post",
		"data": {'fridgerId' : fridgerId, '${_csrf.parameterName}':'${_csrf.token}'},
		"dataType" : "json",
		"success": function(map){
			if(map.fridger.memberId == '${memberId}'){ 
				$("#removeBtn").show();
				$("#updateBtn").show();
				$("#outBtn").hide();
			}else{
				$("#removeBtn").hide();
				$("#updateBtn").hide();
				$("#outBtn").show();
			}
			
			getTypeChart(map.irdntCategoryList)
			getPlaceChart(map.myIrdntRoomTempCount, map.myIrdntColdTempCount, map.myIrdntFreezeTempCount)
			
			
			if(map.fridger.fridgerImg != null){
				$("span#fridgerImg").html($("<img>").prop("src", map.fridger.fridgerImg));
			}
						
			$("span#fridgerName").text(map.fridger.fridgerName);
			$("span#fridgerOwner").text(map.fridger.memberId);
			$("span#fridgerId").text(map.fridger.fridgerId);
			$("span#myIrdntCount").text(map.myIrdntCount);
			$("span#myIrdntBadCount").text(map.myIrdntBadCount);
		
			var all = map.myIrdntCount;
			var good = map.myIrdntGoodCount;
			var normal = map.myIrdntNormalCount;
			var bad = map.myIrdntBadCount;
			var avgFreshLevel = ((bad*0)+(normal*50)+(good*100))/all;
			var avgLevel = map.myIrdntCount
			if(!isNaN(avgFreshLevel)){
				$("#fridgerAvgFreshLevelFault").empty();
		     	$("#freshLevelBar").css("width","0%");
				$("#freshLevelFrame").show();
				showFreshLevelBar(Math.round(avgFreshLevel));
				$(".con2").show();
				
			}else{
				$("#freshLevelFrame").hide();
				$("#fridgerAvgFreshLevel").text("")
			    $("#freshLevelBar").css("width","0%");
				$("#fridgerAvgFreshLevelFault").text("*신선도 측정 불가. 식재료가 존재하지 않습니다!");
				$(".con2").hide();
			}
						
						
			if(bad > 0){
				$("#myIrdntBadAlert").fadeIn();
			}else{
				$("#myIrdntBadAlert").hide();
			}
			
			
			//위험한 식재료 모달안에 넣기
			$("#myIrdntBadList ul").empty();
			$.each(map.myIrdntBadList, function(){
				var day = Math.round((new Date()-this.startDate)/(1000*60*60*24))
				var endStr ="";
				if(this.endDate != null && this.endDate!=""){
					var end = Math.round((this.endDate-new Date())/(1000*60*60*24));
					endStr = " 유통기한 "+end+"일 남음.";
				}
				$("#myIrdntBadList ul").append($("<li>").append(this.irdntName).append(" (보관한 지 "+ day +"일 지남."+endStr+")"));
			})
		},
		"error":function(xhr, msg, code){
			alert("오류가 떴다고 ㅠㅠㅠㅠ" + code);
		}
	})	//end of ajax
} */

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
