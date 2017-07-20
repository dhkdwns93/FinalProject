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
<%-- <link href="${ initParam.rootPath }/css/mdb.css" rel="stylesheet"> --%>
<link href="${ initParam.rootPath }/css/landing-page.css" rel="stylesheet">
<sec:authentication property="principal.memberId" var="memberId"/>
<script type="text/javascript">
$(document).ready(function(){
	
	
	$("#myIrdntBadAlert").hide();
	$("#freshLevelFrame").hide();
	getFridgerInfo('${ requestScope.fridgerList[0].fridgerId }')
	
	$("#fridgerNameSelect").on("change", function(){
		getFridgerInfo($("#fridgerNameSelect>option:selected").val());
	

	
	})

	
	
	
	/* 냉장고 컨트롤 기능 */
	// 냉장고 열어보기
	$(document).on("click", "#moveInBtn", function(){
		var fridgerId = $("span#fridgerId").text();
		var fridgerName = $("span#fridgerName").text();
		
		window.location.href="${initParam.rootPath}/common/member/myIrdnt/myIrdntList.do?fridgerId="+fridgerId+"&fridgerName="+fridgerName;
	});
	
	
	
	
	// 냉장고 추가 폼
	$(document).on("click","#createBtn", function(){
		var fridgerId = $("span#fridgerId").text();
		var fridgerOwner = $("span#fridgerOwner").text();
		
		$("#createFridgerModal").modal("show");
	});	// end of click on requstBtn
	
	// 냉장고 추가 처리
	$(document).on("click", "#registerFormBtn",function(){
		
		 $("#fridgerImg").val($(".item.active").find("img").attr("src"))
		//alert($("#fridgerImg").val())
		 var formData = $("#registerForm").serializeArray();
		console.log(formData)
		$.ajax({
			"url": "${initParam.rootPath }/common/member/fridger/register.do",
			"type": "post",
			"data": formData,
			"dataType":"text",
			"success": function(text){
				if(text == "0"){
					//alert("완료!")
					$("#createFridgerModal").modal("hide");
					$(".errorWell").find(".error").empty();
					$(".errorWell").hide();
					resetRegisterModal();
					window.location.reload();
				}else{
					$(".errorWell").find(".error").text(text);
					$(".errorWell").show();
				}
			}
		})
 	})
	
	
	
	// 냉장고 수정폼
	$(document).on("click","#updateBtn", function(){
		var fridgerId = $("span#fridgerId").text();
		var fridgerOwner = $("span#fridgerOwner").text();
		
		
		$.ajax({
			"url": "${initParam.rootPath }/common/member/fridger/show/detail.do",
			"type": "post",
			"data": {'fridgerId':fridgerId, '${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json",
			"beforeSend": function(){
				if("${memberId}" != fridgerOwner){
					alert("수정 권한이  없습니다!");
					return false;
				}
			},
			"success": function(list){
				//alert($("span#fridgerName").text());
				
				$.each(list,function(){
					$("#updateOwnerIdList").append($("<option>").prop("value", this.groupMemberId).append(this.groupMemberId))
				});
				
				$("#updateFridgerName").prop("placeholder", $("span#fridgerName").text())
				$("#updateFridgerId").prop("value",fridgerId)
				$("#updateFridgerCarousel img").filter("[src='"+$("span#fridgerImg>img").attr("src")+"']").parent().addClass("active")
				$("#updateFridgerModal").modal("show");
				
			}
		})
		
			
		
		
		
		
		
	});	// end of click on requstBtn
	
	//냉장고 수정 처리
	$(document).on("click", "#updateFormBtn",function(){
		/*  alert($("#updateFridgerName").val());
		alert($("#updateFridgerCarousel .item.active").find("img").attr("src")); */
		var fridgerImg = $("#updateFridgerCarousel .item.active").find("img").attr("src");
		$("#updateFridgerImg").val(fridgerImg);
		//alert($("#updateFridgerImg").val())
		if(!$("#updateFridgerName").val()){
			$("#updateFridgerName").val($("#updateFridgerName").prop("placeholder"));
		}	
			
		
		var formData = $("#updateForm").serializeArray();
		console.log(formData)
		$.ajax({
			"url": "${initParam.rootPath }/common/member/fridger/update.do",
			"type": "post",
			"data": formData,
			"dataType":"text",
			"beforeSend": function(){
				getFridgerInfo($("#updateFridgerId").val())
				console.log($("#updateFridgerImg").val());
				console.log(fridgerImg);				
				
			},
			"success": function(text){
				if(text == "0"){
					/* alert("완료!")*/
					getFridgerInfo($("#updateFridgerId").val())
					$("#updateFridgerModal").modal('hide');
					resetUpdateModal();
				}else{		
					$(".errorWell").find(".error").text(text);
					$(".errorWell").show();
				}
			}
			
		})
	
	})
	
	
	// 냉장고 삭제
	$(document).on("click","#removeBtn", function(){
		var fridgerId = $("span#fridgerId").text();
		var fridgerOwner = $("span#fridgerOwner").text();
		$.ajax({
			"url":"/turnup_fridger/common/member/fridger/remove.do",
			"type":"post",
			"data":{'fridgerId' : fridgerId, '${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"text",
			"beforeSend":function(){
				
				if("${memberId}" != fridgerOwner){
					alert("삭제 권한이  없습니다!");
					return false;
				}
				
				if(confirm("삭제하시겠습니까?") != true){
					return false;
				}
			},
			"success": function(txt){
		       alert(txt);
		       window.location.reload();
		     },
	        "error":function(xhr, msg, code){
				alert("오류발생-" + code);
			}
			
		});	//end of ajax
	});	// end of click on requstBtn
	
	
	// 냉장고 탈퇴
	$(document).on("click","#outBtn", function(){

		$.ajax({
			"url":"/turnup_fridger/common/member/fridger/fridgerGroup/out.do",
			"type":"post",
			"data":{'fridgerId' : $("span#fridgerId").text(), 'groupMemberId': ${memberId},'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"text",
			"beforeSend":function(){
				if(confirm("정말로 그룹에서 나가시겠습니까?") != true){
					return false;
				}
			},
			"success": function(txt){
				if(txt==0){
					alert("완료되었습니다.")
			       window.location.reload();
				}else{
					alert("실패: "+txt);
				}
		       
		     },
	        "error":function(xhr, msg, code){
				alert("오류발생-" + code);
			}
			
		});	//end of ajax
	});	// end of click on requstBtn
	
	
	$('#createFridgerModal').on('hide.bs.modal', function (e) {
		resetRegisterModal();
	})
	
	
	$('#updateFridgerModal').on('hide.bs.modal', function (e) {
		resetUpdateModal();
	})
	
})


function getFridgerInfo(fridgerId){
		$.ajax({
			"url":"${initParam.rootPath}/common/member/fridger/select.do",
			"type" : "post",
			"data": {'fridgerId' : fridgerId, '${_csrf.parameterName}':'${_csrf.token}'},
			"dataType" : "json",
			"success": function(map){ 
				if(map.fridger.memberId == "${memberId}"){
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
					$("#myIrdntBadList ul").append($("<li>").append(this.irdntName).append(" (보관한 지 "+ day +"일이 지났습니다.)"));
				})
				
			},
			"error":function(xhr, msg, code){
				alert("오류가 떴다고 ㅠㅠㅠㅠ" + code);
			}
		})	//end of ajax
	}	
		
	
	function showFreshLevelBar(avgFreshLevel){
        $("#freshLevelBar").css("width","0%");
		if(avgFreshLevel>=70 ){
			$("#freshLevelBar").prop("class", "progress-bar progress-bar-success")
		}else if(avgFreshLevel>=40){
			$("#freshLevelBar").prop("class", "progress-bar progress-bar-warning")
		}else{
			$("#freshLevelBar").prop("class", "progress-bar progress-bar-danger")
		}
	    var width = 1;
	    var id = setInterval(frame, 5);
	    function frame() {
	        if (width >= avgFreshLevel) {
	            clearInterval(id);
	        } else {
	            width++; 
	            $("#freshLevelBar").css("width", width+"%");
	            $("#fridgerAvgFreshLevel").text(width+"%");       
	        }
	    }
	} 
		 
	function getTypeChart(list){
	 
	
	  var typeData = [];
	 var colors = ["#e64200","#ff9933", "#f5d03d", "#b7e236", "#dce8c9", "#d1d194", "#94946b","#585841"];
	 var highlights = ["#e6672d","#ffb366", "#f7dc6e","#c7e963", "#f3f7ed", "#e0e0b8", "#a9a989","#757557"];
	  var idx = 0;
		$.each(list, function(){
			var obj = {
					value: this.count,
					color: colors[idx],
					highlight:  highlights[idx++],
					label: this.categoryName
			}
			 typeData.push(obj)
		 });
	 
	 
	 var option = {
			    responsive: false
			    };
	//Get the context of the canvas element we want to select
	var typeCnv = document.getElementById("typeChart");
	var typeCtx= typeCnv.getContext("2d");
		typeCtx.clearRect(0, 0, 1500, 1000);
		typeCtx.beginPath();
		//typeCtx.fillStyle = "white";
		//typeCtx.fillRect(0, 0, typeCnv.width, typeCnv.height);

		var myDoughnutChart = new Chart(typeCtx).Doughnut(typeData,option); 
		$("#typeChart").attr("width","150").attr("height","150");
	};
		
	function getPlaceChart(roomTemp,coldTemp,freezeTemp){
		console.log(roomTemp+","+coldTemp+","+freezeTemp)
		
		
		 var placeData = [
			    {
			        value: roomTemp,
			        color:"#ff9933",
			        highlight: "#ffb366",
			        label: "실온"
			    },
			    {
			        value: coldTemp,
			        color: "#f5d03d",
			        highlight: "#f7dc6e",
			        label: "냉장"
			    },
			    {
			        value: freezeTemp,
			        color: "#d1d194",
			        highlight: "#e0e0b8",
			        label: "냉동"
			    }
			]
		 
		 var option = {
			responsive: false
				    };
		
		//Get the context of the canvas element we want to select
		var placeCnv= document.getElementById("placeChart");
		var placeCtx= placeCnv.getContext("2d");
			placeCtx.clearRect(0, 0, 1500, 1000);
			placeCtx.beginPath();
			/* placeCtx.fillStyle = "white";
			placeCtx.fillRect(0, 0, placeCnv.width, placeCnv.height); */
		 	
		 var myDoughnutChart = new Chart(placeCtx).Doughnut(placeData,option); 
		 $("#placeChart").attr("width","150").attr("height","150");
	};

	
	
	
	


function resetRegisterModal(){
	document.getElementById("registerForm").reset();
	$(".errorWell").find(".error").empty();
	$(".errorWell").hide();
}
	
function resetUpdateModal(){
	document.getElementById("updateForm").reset();
	$(".errorWell").find(".error").empty();
	$(".errorWell").hide();
}

</script>
<style> 
 
.container h1,h2,h3,h4{
font-weight: bold;
}

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
    height:auto;
    
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
width:100%;
}

.con2{
position: relative;
width:100%;
height: 100%;
}


.inner1{
float: left;
display: block;
position: absolute;
overflow: hidden;
width:70%;
height:300px;

left:-50px;
top:50;
text-align: center;
}

.inner2{
float: left;
display: block;
position: absolute;
overflow: hidden;
width:70%;
height:300px;
right:-50px;
top:50;
text-align: center;
}

.title{
font-size: 24px;
font-weight: bold;
}


.errorWell{
display: none;
}

#fridgerImg img{
width : 230px;
border-radius: 0;
}


#freshLevelFrame {
  width: 70%;
}

#freshLevelBar {
  width: 1%;
  height: 30px;
}


#fridgerAvgFreshLevel{
position: absolute; 
top:0; 
right:0;
font-size: 40px;
}

#removeBtn, #updateBtn, #outBtn{
display: none;
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

<div>
<!-- 등록폼 -->
<jsp:include page="/WEB-INF/view/content/common/member/fridger/register_form2.jsp"/>
<jsp:include page="/WEB-INF/view/content/common/member/fridger/update_form2.jsp"/>

</div>


<div class="container">
<div class="flex-container">

<header>
 <h1>내냉장고</h1>
  <p>효율적인 냉장고 관리를 위한 페이지입니다.<br>
	냉장고 속 재료들의 재고 및 상태관리를 돕고 오래된 재료는 빨리 소비할 수 있게하여 냉장고 상태를 깔끔하게 유지 할 수 있게 합니다.</p>
  <p><strong>당신의 냉장고, 더이상 지저분하게 방치하지 마세요!</strong></p>
</header>

<hr style="margin-bottom: -15px;">
<div class="articles">

<article class="article num1">
  <!-- <h1>냉장고 </h1> -->
  <p>
  	<select id="fridgerNameSelect" class="form-control" name="fridgerId" style="width:230px;">
   	<c:forEach items="${ requestScope.fridgerList }" var="fridgerGroup">
  		<option value="${fridgerGroup.fridgerId}">
  		${ fridgerGroup.fridger.fridgerName }
  		<c:if test="${ fridgerGroup.groupMemberId eq fridgerGroup.fridger.memberId }">
  			${ fridgerGroup.fridger.fridgerName } [★Owner]
  		</c:if>
  		</option>
  	</c:forEach>
  </select>
  </p>
  
  <p>
  <span id="fridgerImg"><!-- 사진 들어갈 곳 --></span>
	</p>
		
	<!-- 냉장고 열어보기 -->
	<button type="button" id="moveInBtn" class="btn btn-warning" style="background-color:#f7c42d; color:#ffffff; width:230px; border:5px; margin: 2px; text-shadow:none; font-weight: bold">냉장고 열어보기</button>
	<br>
	
	<!-- 주인냉장고 일 때: 삭제/ 수정 -->
	<!-- 냉장고 삭제하기 -->
	<button type="button" id="removeBtn" class="btn btn-warning" style="background-color:#4c4c34; color:#ffffff; border:5px; border-color:#1e1e15; width:110px; margin: 2px; text-shadow:none; font-weight: bold">삭제</button>
	<!-- 냉장고 수정하기 -->
	<button type="button" id="updateBtn" class="btn btn-warning" data-target="#updateFridgerModal" style="background-color:#ccccb3; color:white; border:5px; border-color:#999966; width:110px; margin: 2px; text-shadow:none;  font-weight: bold">수정</button>
	
	<!-- 주인냉장고 아닐 때: 삭제/ 수정 -->
	<!-- 냉장고 그룹 나가기 -->
	<button type="button" id="outBtn" class="btn btn-warning" style="background-color:#4c4c34; color:#ffffff; border:5px; border-color:#1e1e15; width:230px; margin: 2px; text-shadow:none; font-weight: bold;">냉장고 그룹 나가기</button>
	
	
	<br>
	<!-- 냉장고 추가 -->
	<button type="button" id="createBtn" class="btn btn-default" style="background-color: #f2f2f2; border:5px; border-color: gray;  width:230px; margin: 2px;" data-target="#createFridgerModal" >
	<img src="/turnup_fridger/images/glyphicons/png/glyphicons-433-plus.png" style="opacity: 0.7;"></button>
</article>


<article class="article num2">
  <div class="con1">
  <h1><span id="fridgerName"><!-- 냉장고 이름 --></span></h1>
  <div>Owned by <span id="fridgerOwner"><!-- 냉장고 주인 오는 곳 --></span><span id="fridgerId" hidden="true"><!-- 냉장고 아이디--></span></div>
  
  <hr>
  <div style="position: relative;">현재 냉장고의 신선도 
	  <div id="fridgerAvgFreshLevelFault" style="color:#cfcfc9"><!-- 냉장고 신선도 측정불가시 --></div>
 <!-- progress bar -->
    <div id="freshLevelFrame" class="progress">
  		<div id="freshLevelBar" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0"  aria-valuemin="0" aria-valuemax="100">
    	</div>
  	</div>
  	
  	<span id="fridgerAvgFreshLevel"><!-- 냉장고 신선도 --></span>
 	
 	
 </div>
 
 <br>
 <div>총 <span id="myIrdntCount"><!-- 총 개수 --></span>가지의 식재료를 보관 중입니다!</div>
 
 </div>
<br>	
 <div class="con2">
  	<div class="inner1">
  	<span class="title" >카테고리별</span>
  		<p>
  		<canvas id="typeChart" width=150 height=150 ></canvas>
  		</p>
  	</div>
  	<div class="inner2">
  	<span class="title">보관장소별</span>
  		<p>
		<canvas id="placeChart" width = 150 height=150 ></canvas>
		</p>
	</div>
 </div>
</article>





<article class="article num3">
	<!-- 위험한 식재료 경고창 &modal -->
	<jsp:include page="/WEB-INF/view/content/common/member/fridger/myFridger_alert.jsp"/>
	
</article>


</div>

</div>
</div>
