<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script src="${ initParam.rootPath }/scripts/jquery.js"></script>
<script src="${ initParam.rootPath }/scripts/bootstrap.min.js"></script>
<script src="${ initParam.rootPath }/scripts/mdb.js"></script>
<link href="${ initParam.rootPath }/css/bootstrap.css" rel="stylesheet">
<link href="${ initParam.rootPath }/css/mdb.css" rel="stylesheet">
<link href="${ initParam.rootPath }/css/landing-page.css" rel="stylesheet">
<script type="text/javascript">
$(document).ready(function(){
	$("#myIrdntBadAlert").hide();
	$("#freshLevelFrame").hide();
	getFridgerInfo(${ requestScope.fridgerList[0].fridgerId })
	
	
	$("#fridgerNameSelect").on("change", function(){
		alert($("#fridgerNameSelect>option:selected").val());
		getFridgerInfo($("#fridgerNameSelect>option:selected").val());
	
	})




	
function getFridgerInfo(fridgerId){
	$.ajax({
		"url":"${initParam.rootPath}/common/member/fridger/select.do",
		"type" : "post",
		"data": {'fridgerId' : fridgerId, '${_csrf.parameterName}':'${_csrf.token}'},
		"dataType" : "json",
		"success": function(map){
			getTypeChart();
			getPlaceChart();
			console.log(map)
			if(map.fridger.fridgerImg != null){
				$("#fridgerImg").html($("<img>").prop("src", map.fridger.fridgerImg));
			}
			
		
			$("#fridgerName").text(map.fridger.fridgerName);
			$("#fridgerOwner").text(map.fridger.memberId);
			$("#myIrdntCount").text(map.myIrdntCount);
			$("#myIrdntBadCount").text(map.myIrdntBadCount);
		
			var all = map.myIrdntCount;
			var good = map.myIrdntGoodCount;
			var normal = map.myIrdntNormalCount;
			var bad = map.myIrdntBadCount;
			var avgFreshLevel = ((bad*0)+(normal*50)+(good*100))/all;
			var avgLevel = map.myIrdntCount
			if(!isNaN(avgFreshLevel)){
				$("#fridgerAvgFreshLevel").text(Math.round(avgFreshLevel)+"%");
				$("#freshLevelFrame").show();
				showFreshLevelBar(Math.round(avgFreshLevel));
			}else{
				$("#freshLevelFrame").hide().prop("aria-valuenow","0");
				$("#fridgerAvgFreshLevel").text("신선도 측정 불가. 식재료가 존재하는지 확인하세요!")
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
				$("#myIrdntBadList ul").append($("<li>").append(this.irdntName).append(" (보관한 지 "+ day +"일이 지났습니다.)"));
			})
			
		},
		"error":function(xhr, msg, code){
			alert("오류가 떴다고 ㅠㅠㅠㅠ" + code);
		}
	})	//end of ajax
}	
	

function showFreshLevelBar(avgFreshLevel){
	if(avgFreshLevel>=70 ){
		$("#freshLevelBar").prop("class", "progress-bar progress-bar-success")
	}else if(avgFreshLevel>=40){
		$("#freshLevelBar").prop("class", "progress-bar progress-bar-warning")
	}else{
		$("#freshLevelBar").prop("class", "progress-bar progress-bar-danger")
	}
    var width = 1;
    var id = setInterval(frame, 15);
    function frame() {
        if (width >= avgFreshLevel) {
            clearInterval(id);
        } else {
            width++; 
            $("#freshLevelBar").prop("aria-valuenow", width);
            $("#freshLevelBar").css("width", width+"%");
            
            
        }
    }
}
	 
	 
function getTypeChart(){
 var typeData = [
	    {
	        value: 200,
	        color:"#F7464A",
	        highlight: "#FF5A5E",
	        label: "육류"
	    },
	    {
	        value: 50,
	        color: "#46BFBD",
	        highlight: "#5AD3D1",
	        label: "채소류"
	    },
	    {
	        value: 100,
	        color: "#FDB45C",
	        highlight: "#FFC870",
	        label: "가공식품류"
	    },
	    {
	        value: 70,
	        color: "#6aaf8c",
	        highlight: "#6aca8c",
	        label: "유제품"
	    }
	]

 var option = {
		    responsive: true,
		    };
//Get the context of the canvas element we want to select
var typeCtx = document.getElementById("typeChart").getContext("2d");

typeCtx.clearRect(0, 0, 800, 800);
typeCtx.beginPath();

 var myDoughnutChart = new Chart(typeCtx).Doughnut(typeData,option); 

 Chart.defaults.global = {
		animation: true,
		animationSteps: 60,
		animationEasing: "easeOutQuart",
/* 		showTooltips: true,
		tooltipEvents: ["mousemove", "touchstart", "touchmove"], */
	    onAnimationProgress: function(){},
	    onAnimationComplete: function(){}
	 }

}

function getPlaceChart(){
	 var placeData = [
		    {
		        value: 300,
		        color:"#F7464A",
		        highlight: "#FF5A5E",
		        label: "실온"
		    },
		    {
		        value: 50,
		        color: "#46BFBD",
		        highlight: "#5AD3D1",
		        label: "냉장"
		    },
		    {
		        value: 100,
		        color: "#FDB45C",
		        highlight: "#FFC870",
		        label: "냉동"
		    }
		]
	 
	 
	 var option = {
			    responsive: true,
			    };
	//Get the context of the canvas element we want to select
	var placeCtx = document.getElementById("placeChart").getContext("2d");
	placeCtx.clearRect(0, 0, 800, 800);
	placeCtx.beginPath();

	 var myDoughnutChart = new Chart(placeCtx).Doughnut(placeData,option); 
	 
	 Chart.defaults.global = {
			animation: true,
			animationSteps: 60,
			animationEasing: "easeOutQuart",
	/* 		showTooltips: true,
			tooltipEvents: ["mousemove", "touchstart", "touchmove"], */
		    onAnimationProgress: function(){},
		    onAnimationComplete: function(){}
		 }

	}


})
</script>

<style> 
header{
    padding: 1em;
	text-align:left;
    clear: left;
}

.flex-container {
    display: -webkit-flex;
    display: flex;  
    -webkit-flex-flow: row wrap;
    flex-flow: row wrap;
    text-align: center;
    margine:50px;
	padding-bottom: 100px;
}

.flex-container > * {
    padding: 15px;
    -webkit-flex: 1 100%;
    flex: 1 100%;
}

.section{
	text-align: left;
}


.articles {
    position: relative;
    margine:50px;
	padding-bottom: 50px;
}

.article {
    text-align: left;	
    position: absolute;

}



.article.num1 {
    width: 35%;
    left: 0;
}

.article.num2 {
    width: 400px;
    left: 30%;
    right: 0;
}


.article.num3 {
    width: auto;
    left: 70%;
    right: 0;
}

.con1{
position: relative;
}

.inner.con1{
	left:0;
	witdh:250px;
	text-align: center;	
    position: absolute;
}

.inner.con2{
	right:0;
	left:280px;
	witdh:250px;
	text-align: center;	
    position: absolute;
}


#fridgerImg img{
height: 250px;
border-radius: 0;
}


#freshLevelFrame {
  width: 100%;
}

#freshLevelBar {
  width: 1%;
  height: 30px;
}


@media all and (min-width: 768px) {
	
    .nav {
    text-align:left;
    -webkit-flex: 1 auto;
    flex:1 auto;
    -webkit-order:1;
    order:1;}
   
    
    .article {-webkit-flex:3 0px;
    flex:3 0px;-webkit-order:2;
    order:2;}
    
    .article.num1 {-webkit-flex:3 0px;
    flex:3 0px;-webkit-order:2;
    order:2;}
    
    
    .article.num2 {-webkit-flex:3 0px;
    flex:3 0px;-webkit-order:2;
    order:2;}
}
</style>
<!-- 위험한 식재료 modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="position; top:0; right:0;">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">위험 상태 식재료 목록</h4>
      </div>
      <div class="modal-body" id="myIrdntBadList">
      <!-- 위험 재료들 -->
      <ul>

      </ul>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">CLOSE</button>
      </div>
    </div>
  </div>
</div>


<div class="container">
<div class="flex-container">

<header>
 <h1>내냉장고</h1>
  <p>효율적인 냉장고 관리를 위한 페이지입니다.<br>
	냉장고 속 재료들의 재고 및 상태관리를 돕고 오래된 재료는 빨리 소비할 수 있게하여 냉장고 상태를 깔끔하게 유지 할 수 있게 합니다.</p>
  <p><strong>당신의 냉장고, 더이상 지저분하게 방치하지 마세요!</strong></p>
</header>


<div class="articles">

<article class="article num1">
  <!-- <h1>냉장고 </h1> -->
  <p>
  	<select id="fridgerNameSelect" name="fridgerId" style="width:200px;">
   	<c:forEach items="${ requestScope.fridgerList }" var="fridgerGroup">
  		<option value="${fridgerGroup.fridgerId}">
  		${ fridgerGroup.fridger.fridgerName } (주인: ${ fridgerGroup.fridger.memberId })
  		</option>
  	</c:forEach>
  </select>
  </p>
  <p>
  <span id="fridgerImg"><!-- 사진 들어갈 곳 --></span>
	</p>
	<input type="button" class="btn btn-default" data-toggle="modal" data-target="#createFridgerModal" value="+">

</article>


<article class="article num2">
  <div class="con1">
  <h1><span id="fridgerName"><!-- 냉장고 이름 --></span></h1>
  <br>
  <p>주인 : <span id="fridgerOwner"><!-- 냉장고 주인 오는 곳 -->${ requestScope.fridgerList[0].fridger.memberId }</span></p>
  <p>총 <span id="myIrdntCount"><!-- 총 개수 --></span>가지의 식재료를 보관 중입니다!
  
  <p>현재 냉장고의 신선도 : <span id="fridgerAvgFreshLevel"><!-- 냉장고 신선도 --></span>  </p>
 <!-- progress bar -->
    <div id="freshLevelFrame" class="progress">
  		<div id="freshLevelBar" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0"  aria-valuemin="0" aria-valuemax="100">
    	</div>
  	</div>
 
  	<div>
	<div style="width: 300px; height: 150px; position:absolute; left:-50px;">
		<canvas id="typeChart">분류별</canvas>
	</div>
	<div style="width: 150px; height: 150px; position:absolute; right:0">
		<canvas id="placeChart">보관장소별</canvas>
	</div>
	</div>


  </div>
 
</article>


<article class="article num3">
<!-- 위험경고창 -->
	<div id="myIrdntBadAlert" class="alert alert-danger alert-dismissible fade in" role="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
      <h4 id="oh-snap!-you-got-an-error!">*warning!!<a class="anchorjs-link" href="#oh-snap!-you-got-an-error!"><span class="anchorjs-icon"></span></a></h4>
      <p>지금<span id="myIrdntBadCount"><!-- 보관레벨'위험'인 식재료 --></span>개의 식재료 상태가 위험합니다. 빠른 시간 내에 처리 하십시오.</p>
      <p>
        <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#myModal">위험한 식재료 확인하기</button>
        <button type="button" class="btn btn-default" data-dismiss="alert" >닫기</button>
      </p>
    </div>

</article>



</div>
<div>
<jsp:include page="/WEB-INF/view/content/common/member/fridger/register_form2.jsp"/>
</div>




</div>
</div>
