<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		"url":"${initParam.rootPath}/common/member/fridger/select.do",
		"type" : "post",
		"data": {'fridgerId' : '${ requestScope.fridgerList[0].fridgerId }', '${_csrf.parameterName}':'${_csrf.token}'},
		"dataType" : "json",
		"success": function(map){
			console.log(map)
			if(map.fridger.fridgerImg != null){
				$("#fridgerImg").append($("<img>").prop("src","/turnup_fridger/images/"+map.fridger.fridgerImg));
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
			if(avgFreshLevel !=null){
				$("#fridgerAvgFreshLevel").text(avgFreshLevel);
			}

			
			
			//위험한 식재료 모달안에 넣기
			$("#myIrdntBadList ul").children().remove();
			$.each(map.myIrdntBadList, function(){
				var day = Math.round((new Date()-this.startDate)/(1000*60*60*24))
				$("#myIrdntBadList ul").append($("<li>").append(this.irdntName).append(" (보관한 지 "+ day +"일이 지났습니다.)"));
			})
			
		},
		"error":function(xhr, msg, code){
			alert("오류가 떴다고 ㅠㅠㅠㅠ" + code);
		}
	})	//end of ajax
	
	
	$("#fridgerNameSelect").on("change", function(){
		$.ajax({
			"url":"${initParam.rootPath}/common/member/fridger/select.do",
			"type" : "post",
			"data": {'fridgerId' : $("#fridgerNameSelect>option:selected").val(), '${_csrf.parameterName}':'${_csrf.token}'},
			"dataType" : "json",
			"success": function(map){
				console.log(map)
				if(map.fridger.fridgerImg != null){
					$("#fridgerImg").append($("<img>").prop("src", map.fridger.fridgerImg));
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
				$("#fridgerAvgFreshLevel").text(avgFreshLevel);
					
				
			},
			"error":function(xhr, msg, code){
				alert("오류가 떴다고 ㅠㅠㅠㅠ" + code);
			}
		})	//end of ajax
	})
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
    width: auto;
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

.fridgerImg img{
width: 250px;
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
  <h1>냉장고 </h1>
  <p>
  	<select id="fridgerNameSelect" name="fridgerId">
  	<c:forEach items="${ requestScope.fridgerList }" var="fridgerGroup">
  		<option value="${fridgerGroup.fridgerId}">
  		${ fridgerGroup.fridger.fridgerName } (주인: ${ fridgerGroup.fridger.memberId })<br>
  		</option>
  	</c:forEach>
  </select>
  </p>
  <p>
  <span id="fridgerImg"><!-- 사진 들어갈 곳 --></span>
	</p>
</article>


<article class="article num2">
  <div class="con1">
  <h1><span id="fridgerName"><!-- 냉장고 이름 --></span></h1>
  <p>주인 : <span id="fridgerOwner"><!-- 냉장고 주인 오는 곳 -->${ requestScope.fridgerList[0].fridger.memberId }</span></p>
  <p>총 <span id="myIrdntCount"><!-- 총 개수 --></span>가지의 식재료를 보관 중입니다!
  <p>현재 냉장고의 신선도 : <span id="fridgerAvgFreshLevel"><!-- 냉장고 주인 오는 곳 --></span>%</p>
  <p>*warnning : 지금<span id="myIrdntBadCount"><!-- 보관레벨'위험'인 식재료 --></span>개의 식재료 상태가 위험합니다!<br>
  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">위험한 식재료 확인하기</button>
  </p>
 <!-- 위험한 식재료 modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">위험 상태 식재료 목록</h4>
      </div>
      <div class="modal-body" id="myIrdntBadList">
      <!-- 위험 재료들 -->
      <ul>
      	<li>durl</li>
		<li>dlfjgrp</li>
		<li>wofyrk</li>
      </ul>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">CLOSE</button>
      </div>
    </div>
  </div>
</div>

  </div>
 
 	  
	
</article>

<article class="article num3">
	dkssuddkssudgktpdyssdfw
</article>



</div>





</div>
</div>
