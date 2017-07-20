<%@ page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html>
<title>레시피 상세화면</title>
<% 
	Cookie hits = new Cookie("hits",request.getParameter("hits"));
	hits.setMaxAge(60*60*24);
	response.addCookie(hits);
%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript" src="/turnup_fridger/scripts/bootstrap.min.js"></script>
<script src="${ initParam.rootPath }/scripts/mdb.js"></script>

<script type="text/javascript">
function getReview(page){
	if(!page) page = 1;
	$("#reviewPageBean").empty();
	$.ajax({   
		"url":"/turnup_fridger/recipe/show/detail/review.do",
		"type":"POST",
		"data":{'recipeId':${requestScope.recipe.recipeId},'page':page,'${_csrf.parameterName}':'${_csrf.token}'},  
		"dataType":"json", 
		"success":function(reviewMap){
			$("#reviewTbody").empty();
			$.each(reviewMap.list, function(){
				$("#reviewTbody").append($("<tr>").prop("class","review_col").append($("<td>").append(this.boardReviewId)).append($("<td>").append(this.boardReviewTitle))
						.append($("<td>").append(this.boardReviewTxt)).append($("<td>").append(this.memberId))
						.append($("<td>").append(this.boardReviewDate)).append($("<td>")
								.append($("<span>").prop("class","star-rating").append($("<span>").prop("style","width:"+(this.boardReviewStar)*10+"%")))));
			});//each				
			
			//================페이징	
			
			 	$("#reviewPageBean").append($("<a href='javascript:getReview(1)'>").append("첫페이지"));
			
			 	if(reviewMap.pageBean.previousPageGroup!=null){
			 		$("#reviewPageBean").append($("<a href='javascript:getReview("+(reviewMap.pageBean.beginPage-1)+")'>").append("◀"));
			 		
				}else{
					$("#reviewPageBean").append("◀");
				} 	
			 	for(var index = reviewMap.pageBean.beginPage ; index < reviewMap.pageBean.endPage ; index++){
			 		if(index !=reviewMap.pageBean.page){
			 			$("#reviewPageBean").append($("<a href='javascript:getReview("+index+")'>").append(index));
					}else{
						$("#reviewPageBean").append("["+index+"]"+"&nbsp;&nbsp;");
					}
			 	}
			 	if(reviewMap.pageBean.nextPageGroup!=null){
			 		$("#reviewPageBean").append($("<a href ='javascript:getReview("+(reviewMap.pageBean.endPage+1)+")'>").append("▶"));
			 	}else{
			 		$("#reviewPageBean").append("▶");
			 	}
			 	$("#reviewPageBean").append($("<a href = 'javascript:getReview("+(reviewMap.pageBean.totalPage)+")'>").append("마지막 페이지"));
			 
		},//success
		"error":function(xhr, msg, code){
			alert("오류발생-" +msg+ ":" +code);
		} 
	})//ajax
	
};//페이징 함수 
$(document).ready(function(){
	getReview(1);
	
	$("#updateBtn").on("click", function(){
		window.open(
				"${ initParam.rootPath }/common/admin/recipe/update_chk.do?recipeId=${requestScope.recipe.recipeId}",
				"_blank",
				"fullscreen=yes, height=700, width=500, resizable=no, scrollbars=no, location=no, toolbar=no, directories=no, menubar=no"
				);
	});
/* 	$("#deleteBtn").on("click", function(){
		$.ajax({
			"url":"/turnup_fridger/common/admin/recipe/update.do",
			"type":"POST",
			"data":{'recipe' : $("#categoryName").val(),'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json", 
			"success":function(list){
				$("#typeName").empty();
				$.each(list, function(){
					$("#typeName").append($("<option>").prop("value",this).append(this))
				});//each
			},
			"error":function(xhr, msg, code){
				alert("오류발생-" +msg+ ":" +code);
			}
		})
	}); */
	
	$(document).on("click",".review_col",function(){
		var reviewId=$(this).children(":first-child").text();
		//alert(reviewId);
		$.ajax({
			"url":"/turnup_fridger/findReviewByboardReviewId.do",
			//"type":"POST",		
			"data":{'boardReviewId' :reviewId},
			"dataType":"text",
			"beforeSend":function(){
				if(confirm("레시피 후기 게시판으로 이동하시겠습니까?") != true){
					return false;
				}
			},
			"success":function(text){
				window.location.href="${initParam.rootPath}/boardreview/boardReviewList.do"
			},
			"error":function(xhr, msg, code){
				alert("오류발생-" +msg+ ":" +code);
			}
		});
		
	});//후기게시판페이지로 이동.
	
	$(document).on("click" ,"#deleteRecipeBtn", function(){
		console.log(${ requestScope.recipe.recipeId});
		$.ajax({
			"url":"/turnup_fridger/common/admin/recipe/remove.do",
			"type":"POST",		
			"data":{'recipeId' : ${requestScope.recipe.recipeId},'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"text",
			"beforeSend":function(){
				if(confirm("레시피를 삭제하시겠습니까?") != true){
					return false;
				}
			},
			"success":function(text){
				if(text == 1){
					alert("삭제가 완료되었습니다.");
				}
				window.location.href="${initParam.rootPath}/common/admin/recipe/recipeList.do"
			},
			"error":function(xhr, msg, code){
				alert("오류발생-" +msg+ ":" +code);
			}
		});
	});//레시피삭제
	
	//********************************************************************************************************************
	$("#matchMyIrdnt").on("click",function(){
		$.ajax({
			"url":"/turnup_fridger/findMatchIrdnt.do",  
			"type":"POST",
			"data":{'recipeId':${requestScope.recipe.recipeId},'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json", 
			"success":function(list){
				$("#myIrdntTbody").empty();	
				$.each(list, function(){
					$("#myIrdntTbody").append($("<tr>").append($("<td>").append(this.fridgerId)).append($("<td>").append(this.irdntName))
						.append($("<td>").append(this.freshLevel)).append($("<td>").append(this.irdntCount))
						.append($("<td>").append($("<button>").prop("type","button").prop("class","deleteIrdnt").prop("value",this.myIrdntKey).append("삭제"))));
				})
			},//success
			"error":function(xhr, msg, code){ 
				alert("오류발생-" +msg+ ":" +code);	
			}//error	
		});//일치하는 식재료 보여주기 
	});
	 
	$(document).on("click",".deleteIrdnt",function(){
		//alert($(this).val());
		$.ajax({
			"url":"/turnup_fridger/removeMyIrdnt.do", 
			//"type":"POST",
			"data":{'myIrdntKey':$(this).val()},
			"dataType":"text", 
			"success":function(text){
				alert(text);
				document.location.reload();
				},
				"error":function(xhr, msg, code){ 
						alert("오류발생-" +msg+ ":" +code);	
				}	
		});
	});//재료삭제버튼클릭
	
	//********************************************************************************************************************
	$.ajax({
		"url":"/turnup_fridger/findFavoriteRecipeByIds.do", 
		"data":'recipeId='+${requestScope.recipe.recipeId}, 
		"dataType":"text", 
		"success":function(text){
			//alert(text);
			if(text=="0"){
				//빈하트출력.
				$("#favoriteSection").append($("<img>").prop("width","30").prop("id","heart").prop("class","img-rounded")
						.prop("src","/turnup_fridger/starimage/emptyHeart.png"));
			}else{
				//빨간하트 출력.
				$("#favoriteSection").append($("<img>").prop("width","30").prop("id","heart").prop("class","img-rounded")
						.prop("src","/turnup_fridger/starimage/fullHeart.png"));
			}
		},
		"error":function(xhr, msg, code){ 
			//alert("오류발생-" +msg+ ":" +code);	
		}		
	});//즐겨찾기 사진 처음에 불러오기. 
	
	$(document).on("click","#heart",function(){ 
		$.ajax({
			"url":"/turnup_fridger/findFavoriteRecipeByIds.do", 
			"data":'recipeId='+${requestScope.recipe.recipeId},    
			"dataType":"text", 
			"success":function(text){
				//alert(text);
				if(text=="0"){
					//추가할꺼냐 확인받고 add
					if (confirm("즐겨찾기에 추가하시겠습니까?") == true){    
						location.href="/turnup_fridger/addFavoriteRecipe.do?recipeId="+${requestScope.recipe.recipeId};
						//document.location.reload();//이걸하면 안먹히네 기능이 
					}else{   
					    return false;
					}
				}else{
					//삭제할꺼냐 확인받고 remove
					if (confirm("즐겨찾기에서 제외하시겠습니까?") == true){    
						location.href="/turnup_fridger/removeFavorite.do?recipeId="+${requestScope.recipe.recipeId};
						//document.location.reload();
					}else{   
					    return false;
					}
				
				}
			},//success
			"error":function(xhr, msg, code){ 
						alert("오류발생-" +msg+ ":" +code);	
				}//error	
		});
	});//하트 클릭하면 
	
	
	
	
	$("#changePortionFor1_Btn").on("click",function(){
		$("#standardQnt").fadeOut();
		var qnt = getNumber($("#standardQnt").text())
		
		$("#standardQnt").fadeIn().text('1인분');
		$("span.amountChangable").each(function(){
			$(this).fadeOut();
			var amt = $(this).text();
			if(!amt || amt ==''){
				$(this).remove();
			}else{
			
				if(!isNaN(amt)){	//정수일때
					amt = ((amt/qnt)*1);
					if(!is_integer(amt)){
						amt = amt.toFixed(2);
					}
				}
				else if(amt.includes("/")){	//분수인경우
					var frct = amt.split('/');
					frct[1] = frct[1]*qnt;
					frct[0] = frct[0]*1;
					amt = getFrct(frct);
				}
				$(this).fadeIn().text(amt);
			}
		})
		$(".changePortionBtn").removeAttr("disabled");
		$("#changePortionFor1_Btn").prop("disabled","disabled");
	});//단위변환:1인분
	
	$("#changePortionFor2_Btn").on("click",function(){
		$("#standardQnt").fadeOut();
		
		var qnt = getNumber($("#standardQnt").text())
		$("#standardQnt").fadeIn().text('2인분');
		$("#standardQnt").text('2인분');
		$("span.amountChangable").each(function(){ 
			$(this).fadeOut();
			var amt = $(this).text();
			if(!amt || amt ==''){
				$(this).remove();
			}else{
			
				if(!isNaN(amt)){	//정수일때
				 	//console.log(amt/qnt*4)
					amt = ((amt/qnt)*2);

					if(!is_integer(amt)){
						amt = amt.toFixed(2);
					}					
				}
				else if(amt.includes("/")){	//분수인경우
					var frct = amt.split('/');
					frct[1] = frct[1]*qnt;
					frct[0] = frct[0]*2;
					amt = getFrct(frct);
				}
				
				$(this).fadeIn().text(amt);
			}
		})
		$(".changePortionBtn").removeAttr("disabled");
		$("#changePortionFor2_Btn").prop("disabled","disabled");
	});//단위변환:2인분
	
	
	$("#changePortionFor3_Btn").on("click",function(){
		//원상복귀 과정 필요
		$("#standardQnt").fadeOut();
		var qnt = getNumber($("#standardQnt").text())
		$("#standardQnt").fadeIn().text('3인분');
		$("span.amountChangable").each(function(){
			//console.log($(this).text());
			$(this).fadeOut();
			var amt = $(this).text();
			if(!amt || amt ==''){
				$(this).remove();
			}else{
			
				if(!isNaN(amt)){	//정수일때
				 	//console.log(amt/qnt*4)
					amt = ((amt/qnt)*3);
				
					if(!is_integer(amt)){
						amt = amt.toFixed(2);
					}
				}
				else if(amt.includes("/")){	//분수인경우
					var frct = amt.split('/');
					frct[1] = frct[1]*qnt;
					frct[0] = frct[0]*3;
					amt = getFrct(frct);
				}
				
				
				
				
				$(this).fadeIn().text(amt);
			}
		})
		$(".changePortionBtn").removeAttr("disabled");
		$("#changePortionFor3_Btn").prop("disabled","disabled");
		
	});//단위변환:3인분
	$("#changePortionFor4_Btn").on("click",function(){
		$("#standardQnt").fadeOut();
		var qnt = getNumber($("#standardQnt").text())
		$("#standardQnt").fadeIn().text('4인분');
		$("span.amountChangable").each(function(){
			$(this).fadeOut();
			var amt = $(this).text();
			if(!amt || amt ==''){
				$(this).remove();
			}else{
			
				if(!isNaN(amt)){	//정수일때
				 	//console.log(amt/qnt*4)
					amt = ((amt/qnt)*4);
				
					if(!is_integer(amt)){
						amt = amt.toFixed(2);
					}
				}
				else if(amt.includes("/")){	//분수인경우
					var frct = amt.split('/');
					frct[1] = frct[1]*qnt;
					frct[0] = frct[0]*4;
					amt = getFrct(frct);
				}
				
				$(this).fadeIn().text(amt);
			}
		})
		$(".changePortionBtn").removeAttr("disabled");
		$("#changePortionFor4_Btn").prop("disabled","disabled");
	});//단위변환:4인분
	
	$("#timerBtn").on("click",function(){
		window.open("/turnup_fridger/timer.do","timer","width=500, height=200");
	});
	
	
})

//숫자 추출
function getNumber(str){
		var target = str;
		var regex = /[^0-9]/g;
		target = target.replace(regex, '');
	  return target;
}

//분수추출
function getFrct(frct){
	var bunja = frct[0];
	var bunmo = frct[1];
	if(bunmo == 0){
		bunmo == 0;
		bunja == 0;
	}
	
	var gcdResult = getGcd(bunja,bunmo);
	bunmo = bunmo/gcdResult;
	bunja = bunja/gcdResult;
	
	return bunja+"/"+bunmo;
	
}
function getGcd(a,b){ //최대공약수 계산
	while(b != 0){
		var temp = a%b;
		a = b;
		b = temp;
	}
	return Math.abs(a);
}

function is_integer(n){
    var reg = /^\d+$/;
    return reg.test(n);
}


//이동
function moveTo(url,recipeId){
		window.open(
				url+"?recipeId="+recipeId,
				"_blank",
				"fullscreen=yes, height=700, width=500, resizable=no, scrollbars=no, location=no, toolbar=no, directories=no, menubar=no"
				);
}
</script>
<style>
.star-rating { width:130px; }
.star-rating,.star-rating 
span{ 
display:inline-block; 
height:24px; 
overflow:hidden; 
background:url(/turnup_fridger/starimage/star.png)no-repeat; 
}
.star-rating span{ background-position:left bottom; line-height:0; vertical-align:top; }
table tr td{
	padding:15px;
}
.floating {
  position: fixed; 
  right: 50%; 
  top: 300px; 
  margin-right: -720px;
  text-align:center;
  width: 120px;
}
</style>
<div class="container" style="position:relative;">

<!--즐겨찾기버튼  -->


<h1 style="font-weight:bold;">${requestScope.recipe.recipeName}</h1>
<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN','ROLE_MEMBER')">
	<div id="favoriteSection" style="cursor:pointer;position:absolute; right:30px;top:40px"></div>
</sec:authorize>
<hr>
<div id="whole">
	<div id="recipe_info">
		<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
		<button type="button" onclick="moveTo('/turnup_fridger/common/admin/recipe/info/update_chk.do', '${requestScope.recipe.recipeId}')">수정</button>
		</sec:authorize>

		<div style="width:50%;float:left;">
		<!-- <div style="position:absolute;top:10px;left:10px;"> -->
 		<img src="${ requestScope.recipe.imgUrl }" alt="photo" style="width:500px;height:400px;">
		</div>

		<div style="width:50%;float:right;margin-top:10px;">
		<table class="table table-hover table-condensed">
			<thead>
			<tr>
				<th colspan="2">
				<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN','ROLE_MEMBER')">
<div id="favoriteSection" style="cursor:pointer;float:right"></div> 
</sec:authorize>
				</th>
			</tr>
			</thead>
			<tbody>
				<tr>
					<th>유형분류</th>
					<td>${ requestScope.recipe.categoryName }</td>
				</tr>
				<tr>
					<th>음식분류</th>
					<td>${ requestScope.recipe.typeName }</td>
				</tr>
				<tr>
					<th>조리시간</th>
					<td>${ requestScope.recipe.cookingTime }</td>
				</tr>
				<tr>
					<th>칼로리</th>
					<td>${ requestScope.recipe.calorie }</td>
				</tr>
				<tr>
					<th>기준인분</th>
					<td id="standardQnt">${ requestScope.recipe.qnt }</td>
				</tr>
				<tr>
					<th>난이도</th>
					<td>${ requestScope.recipe.recipeLevel }</td>
				</tr>
				<tr>
					<th>재료별분류</th>
					<td>
					<c:choose>
						<c:when test="${ requestScope.recipe.irdntCode != 'null' && !empty requestScope.recipe.irdntCode}">
						${ requestScope.recipe.irdntCode }
						</c:when>
						<c:otherwise>
						없음
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<th>기준가격</th>
					<td>${ requestScope.recipe.price }</td>
				</tr>

				<tr>
					<th>조회수</th>
					<td>${ requestScope.recipe.recipeHits }</td>
				</tr>
			</tbody>
		</table>
		</div>
	<!--단위변환  -->
</div>

<div style="text-align:center;">
<a data-toggle="tooltip" title="1인분으로 맞추어 정보를 변환합니다. ">
<button type="button" id="changePortionFor1_Btn" class="changePortionBtn btn btn-default" >1인분</button></a>&emsp;
<a data-toggle="tooltip" title="2인분으로 맞추어 정보를 변환합니다. ">
<button type="button" id="changePortionFor2_Btn" class="changePortionBtn btn btn-default">2인분</button></a>&emsp;
<a data-toggle="tooltip" title="3인분으로 맞추어 정보를 변환합니다. ">
<button type="button" id="changePortionFor3_Btn" class="changePortionBtn btn btn-default">3인분</button></a>&emsp;
<a data-toggle="tooltip" title="4인분으로 맞추어 정보를 변환합니다. ">
<button type="button" id="changePortionFor4_Btn" class="changePortionBtn btn btn-default">4인분</button></a>&emsp;
</div>

	<div id="recipe_irdnt" style="width:100%;">
		<br><hr>	
		<h3 style="font-weight:bold;">재료정보</h3>
		<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
		<button type="button" onclick="moveTo('/turnup_fridger/common/admin/recipe/irdnt/update_chk.do', '${requestScope.recipe.recipeId}')">수정</button>
		</sec:authorize>
		
		<div style="padding:10px;">
		주재료 :  
			<c:forEach items="${ requestScope.recipe.recipeIrdntList }" var="recipeIrdnt" >
				<c:if test="${recipeIrdnt.irdntTypeCode == 3060001}">
					${ recipeIrdnt.irdntName }&nbsp;${ recipeIrdnt.irdntAmount }&nbsp;&nbsp;
				</c:if>
			</c:forEach>
		</div>
		<div style="padding:10px;">
		부재료 :  
			<c:forEach items="${ requestScope.recipe.recipeIrdntList }" var="recipeIrdnt" >
				<c:if test="${recipeIrdnt.irdntTypeCode == 3060002}">
					${ recipeIrdnt.irdntName }&nbsp;${ recipeIrdnt.irdntAmount }&nbsp;&nbsp;
				</c:if>
			</c:forEach>
		</div>
		<div style="padding:10px;" >
		양념 : 
			<c:forEach items="${ requestScope.recipe.recipeIrdntList }" var="recipeIrdnt" >
				<c:if test="${recipeIrdnt.irdntTypeCode == 3060003}">
					${ recipeIrdnt.irdntName }&nbsp;${ recipeIrdnt.irdntAmount }&nbsp;&nbsp;
				</c:if>
			</c:forEach>
		</div>
	</div>
<!--나의 식재료들 가져와서 수정,삭제할수있게 하는 테이블  -->
	<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN','ROLE_MEMBER')">
	<br>
	<a data-toggle="tooltip" title="${requestScope.recipe.recipeName}를 만들면서 다 쓴 재료를 삭제할 수 있습니다.">
	<button type="button" id="matchMyIrdnt" data-toggle="collapse" data-target="#myIrdnt" class="btn btn-default">냉장고 속 재료 삭제 ↓</button></a>
	<div id="myIrdnt" class="collapse">
		<table class="table table-hover table-condensed" style="width:50%; border:5;">
			<thead id="myIrdntThead">
				<tr>
					<th>냉장고id</th>
					<th>재료명</th>
					<th>신선도</th>
					<th>수량메모</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody id="myIrdntTbody"></tbody>
		</table>
	</div>
	</sec:authorize>

	<div id="recipe_crse" style="width:100%;">
	<br><hr>
	<h3 style="font-weight:bold;">상세과정</h3>
	<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
	<button type="button" onclick="moveTo('/turnup_fridger/common/admin/recipe/crse/update_chk.do', '${requestScope.recipe.recipeId}')">수정</button>
	</sec:authorize>
	<table>
	<c:forEach items="${ requestScope.recipe.recipeCrseList }" var="recipeCrse">
	<tr>
		<td>
			${recipeCrse.cookingNo} - ${recipeCrse.cookingDc}<br>
			<c:if test="${recipeCrse.stepTip !='null'}">
				*팁: ${recipeCrse.stepTip} <br>
			</c:if>
			<c:if test="${recipeCrse.stepImageUrl != 'null'}">
				<img src="${ recipeCrse.stepImageUrl }"><br>
			</c:if>
			</td>
		</tr>
	</c:forEach>
	</table>
	</div>
</div>



<!--후기게시판연결  -->
	<!-- <button type="button" id="reviewBtn" >후기 보기</button> -->
	<div id="review"  style= " width:90%;">
	<br><hr>
		<h3 style="font-weight:bold;">레시피 후기</h3> 
		<table class="table table-hover table-condensed">
			<thead id="reviewThead">
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>글</th>
					<th>작성자</th> 
					<th>작성일</th>
					<th>별점</th>
				</tr>
			</thead>
			<tbody id="reviewTbody">
			</tbody>
		</table>
	<div id="reviewPageBean" style="text-align:center;"></div>
	</div>

<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
<button type="button" id="deleteRecipeBtn">삭제</button> 
</sec:authorize>

<div class="floating" style="padding:10px;">
 	<a href="#"><button type="button" id="topBtn" class="btn btn-default">TOP</button></a>
    <button type="button" id="timerBtn" class="btn btn-warning" style="width:70px;height:40px;">타이머</button>
	<button type="button" onclick="window.history.back()" class="btn btn-default">BACK</button>
</div>

</div>
</body>
</html>