<%@ page contentType="text/html;charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<html>
<title>레시피 상세화면</title>

<style>
.star-rating { width:130px; }
.star-rating,.star-rating span{ 
display:inline-block; 
height:24px; 
overflow:hidden; 
background:url(/turnup_fridger/starimage/star.png)no-repeat; 
}
.star-rating span{ background-position:left bottom; line-height:0; vertical-align:top; }
</style>

<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
function getReview(page){
	if(!page) page = 1;
	$.ajax({   
		"url":"/turnup_fridger/recipe/show/detail/review.do",
		"type":"POST",
		"data":{'recipeId':${requestScope.recipe.recipeId},'page':page,'${_csrf.parameterName}':'${_csrf.token}'}, 
		"dataType":"json", 
		"success":function(reviewMap){
			
			$("#reviewTbody").empty();
			$.each(reviewMap.list, function(){
				$("#reviewTbody").empty();
				$("#reviewTbody").append($("<tr>").prop("class","review_col").append($("<td>").append(this.boardReviewId)).append($("<td>").append(this.boardReviewTitle))
						.append($("<td>").append(this.boardReviewTxt)).append($("<td>").append(this.imageName)).append($("<td>").append(this.memberId))
						.append($("<td>").append(this.boardReviewDate)).append($("<td>")
								.append($("<span>").prop("class","star-rating").append($("<span>").prop("style","width:"+(this.boardReviewStar)*10+"%")))));
				});//each									
				
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

	$("#deleteIrdnt").hide();
	$("#reviewThead").hide();
	
	$("#updateBtn").on("click", function(){
		window.open(
				"${ initParam.rootPath }/common/admin/recipe/update_chk.do?recipeId=${requestScope.recipe.recipeId}",
				"_blank",
				"fullscreen=yes, height=700, width=500, resizable=no, scrollbars=no, location=no, toolbar=no, directories=no, menubar=no"
				);
	});

	$("#deleteBtn").on("click", function(){
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
	});
	
	$.ajax({
		"url":"/turnup_fridger/getMyIrdntList.do", 
		"type":"POST",
		"data":{'fridgerId':1,'${_csrf.parameterName}':'${_csrf.token}'},
		"dataType":"json", 
		"success":function(list){
			$("#myIrdntThead").empty();	
			$("#myIrdntThead").append($("<tr>").append($("<th>").append("재료명")).append($("<th>").append("신선도")).append($("<th>").append("수량메모"))
					.append($("<th>").append("삭제")));
			$("#myIrdntTbody").empty();	
			$.each(list, function(){
				$("#myIrdntTbody").append($("<tr>").prop("class","irdnt_col").append($("<td>").append(this.irdntName)).append($("<td>").append(this.freshLevel))
						.append($("<td>").append(this.irdntCount))
						.append($("<td>").append($("<button>").prop("type","button").prop("id","deleteBtn").prop("value",this.myIrdntKey).append("삭제"))));
			});
			},//success
			"error":function(xhr, msg, code){ 
					alert("오류발생-" +msg+ ":" +code);	
			}//error	
	});//재료편집

	$(document).on("click" ,"#deleteRecipeBtn", function(){

		console.log( ${ requestScope.recipe.recipeId})
		
		$.ajax({
			"url":"/turnup_fridger/common/admin/recipe/remove.do",
			"type":"POST",		
			"data":{'recipeId' : ${ requestScope.recipe.recipeId },'${_csrf.parameterName}':'${_csrf.token}'},
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

	})
	
	/* $.ajax(function(){
		
	});//재료삭제 받아오기
	
	$(document).on("click","#deleteBtn",function(){
		alert($(this).val());
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
	});//삭제버튼클릭
	
<<<<<<< HEAD
	$("#favoriteBtn").on("click",function(){
		
	});//즐겨찾기 
	 */
=======
	$("#reviewBtn").on("click",function(){
		$("#reviewThead").show();
		getReview(1);
	});//후기보기
	
	$.ajax({
		"url":"/turnup_fridger/findFavoriteRecipeByIds.do", 
		"data":'recipeId='+${requestScope.recipe.recipeId}, 
		"dataType":"text", 
		"success":function(text){
			//alert(text);
			if(text=="0"){
				//빈하트출력.
				$("#favoriteSection").append($("<img>").prop("width","70").prop("class","heart")
						.prop("src","/turnup_fridger/starimage/emptyHeart.png"));
			}else{
				//빨간하트 출력.
				$("#favoriteSection").append($("<img>").prop("width","70").prop("class","heart")
						.prop("src","/turnup_fridger/starimage/fullHeart.png"));
			}
		},
		"error":function(xhr, msg, code){ 
			alert("오류발생-" +msg+ ":" +code);	
		}		
	});//즐겨찾기 사진 처음에 불러오기. 
	
	$(document).on("click",".heart",function(){
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

	
	
>>>>>>> branch 'master' of https://github.com/dhkdwns93/FinalProject.git
	
<<<<<<< HEAD
	
	$("#changePortionFor1_Btn").on("click",function(){
		var qnt = getNumber($("#standardQnt").text())
		$("#standardQnt").text('1인분');
		$("span.amountChangable").each(function(){
			//console.log($(this).text());
			var amt = $(this).text();
			if(!isNaN(amt)){	//정수일때
			 	//console.log(amt/qnt*1)
			 	$(this).text(amt/qnt*1);
			}
			if(amt.includes("/")){	//분수인경우
				console.log(amt);
				var frct = amt.split('/');
				console.log(frct[1]*qnt);
				frct[1] = frct[1]*qnt;
				console.log(frct[0]*1);
				frct[0] = frct[0]*1;
				console.log(getFrct(frct))
				$(this).text(getFrct(frct));
			}if(!amt || amt ==''){
				$(this).remove();
			}
		})
		$(".changePortionBtn").removeAttr("disabled");
		$("#changePortionFor1_Btn").prop("disabled","disabled");
	});//단위변환:1인분

	
	$("#changePortionFor2_Btn").on("click",function(){
		var qnt = getNumber($("#standardQnt").text())
		$("#standardQnt").text('2인분');
		$("span.amountChangable").each(function(){
			//console.log($(this).text());
			var amt = $(this).text();
			if(!isNaN(amt)){	//정수일때
			 	//console.log(amt/qnt*2)
			 	$(this).text(amt/qnt*2);
			}
			if(amt.includes("/")){	//분수인경우
				console.log(amt);
				var frct = amt.split('/');
				console.log(frct[1]*qnt);
				frct[1] = frct[1]*qnt;
				console.log(frct[0]*2);
				frct[0] = frct[0]*2;
				console.log(getFrct(frct))
				$(this).text(getFrct(frct));
			}if(!amt || amt ==''){
				$(this).remove();
			}
		})
		$(".changePortionBtn").removeAttr("disabled");
		$("#changePortionFor2_Btn").prop("disabled","disabled");
	});//단위변환:2인분
	
	
	$("#changePortionFor3_Btn").on("click",function(){
		//원상복귀 과정 필요
		var qnt = getNumber($("#standardQnt").text())
		$("#standardQnt").text('3인분');
		$("span.amountChangable").each(function(){
			//console.log($(this).text());
			var amt = $(this).text();
			if(!isNaN(amt)){	//정수일때
			 	//console.log(amt/qnt*3)
			 	$(this).text(amt/qnt*3);
			}
			if(amt.includes("/")){	//분수인경우
				console.log(amt);
				var frct = amt.split('/');
				console.log(frct[1]*qnt);
				frct[1] = frct[1]*qnt;
				console.log(frct[0]*3);
				frct[0] = frct[0]*3;
				console.log(getFrct(frct))
				$(this).text(getFrct(frct));
			}if(!amt || amt ==''){
				$(this).remove();
			}
		})
		$(".changePortionBtn").removeAttr("disabled");
		$("#changePortionFor3_Btn").prop("disabled","disabled");
		
	});//단위변환:3인분
=======
	$("#changePortion").on("click",function(){
	});//단위변환
>>>>>>> branch 'master' of https://github.com/dhkdwns93/FinalProject.git
	
<<<<<<< HEAD
	$("#changePortionFor4_Btn").on("click",function(){
		var qnt = getNumber($("#standardQnt").text())
		$("#standardQnt").text('4인분');
		$("span.amountChangable").each(function(){
			//console.log($(this).text());
			var amt = $(this).text();
			if(!isNaN(amt)){	//정수일때
			 	//console.log(amt/qnt*4)
			 	$(this).text(amt/qnt*4);
			}
			if(amt.includes("/")){	//분수인경우
				console.log(amt);
				var frct = amt.split('/');
				console.log(frct[1]*qnt);
				frct[1] = frct[1]*qnt;
				console.log(frct[0]*4);
				frct[0] = frct[0]*4;
				console.log(getFrct(frct))
				$(this).text(getFrct(frct));
			}if(!amt || amt ==''){
				$(this).remove();
			}
		})
		$(".changePortionBtn").removeAttr("disabled");
		$("#changePortionFor4_Btn").prop("disabled","disabled");
	});//단위변환:4인분
	
	
})

//숫자 추출
function getNumber(str){
		var target = str;
		var regex = /[^0-9]/g;
		target = target.replace(regex, '');
	  return target;
}
=======
})//ready
>>>>>>> branch 'master' of https://github.com/dhkdwns93/FinalProject.git

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


//이동
function moveTo(url,recipeId){
		window.open(
				url+"?recipeId="+recipeId,
				"_blank",
				"fullscreen=yes, height=700, width=500, resizable=no, scrollbars=no, location=no, toolbar=no, directories=no, menubar=no"
				);
		
}

</script>
<script type="text/javascript">

</script>
<style>
div#whole{
margin:10px;
width:auto;
}
div#recipe_info{
padding:15px;
background-color:lightgray;
position:relative;
margin:10px;
width: auto;
height: auto;
}

div#recipe_irdnt{
position: absolute;
top:0;
width: 350px;
right: 0;
}

div#recipe_crse{
padding:15px;
background-color:lightgray;
margin:10px;
width: auto;
top: 650px;
}
</style>

<!--즐겨찾기버튼  -->
<!-- <button type="button" id="favoriteBtn"></button><br><br> -->
<div id="favoriteSection"></div><br><br>

<!--단위변환  -->
<button type="button" id="changePortionFor1_Btn" class="changePortionBtn">1인분</button>
<button type="button" id="changePortionFor2_Btn" class="changePortionBtn">2인분</button>
<button type="button" id="changePortionFor3_Btn" class="changePortionBtn">3인분</button>
<button type="button" id="changePortionFor4_Btn" class="changePortionBtn">4인분</button><hr>

<div class="container">
<h2>레시피 상세화면</h2>

<div id="whole">
	<div id="recipe_info">
		<h3>레시피 기본정보</h3>
		<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
		<button type="button" onclick="moveTo('/turnup_fridger/common/admin/recipe/info/update_chk.do', '${requestScope.recipe.recipeId}')">수정</button>
		</sec:authorize>
		<table>
			<tbody>
				<tr>
					<th>레시피명</th>
					<td>${ requestScope.recipe.recipeName }</td>
				</tr>
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
					<td>${ requestScope.recipe.irdntCode }</td>
				</tr>
				<tr>
					<th>기준가격</th>
					<td>${ requestScope.recipe.price }</td>
				</tr>
				<tr>
					<th>사진</th>
					<td><img src="${ requestScope.recipe.imgUrl }" width="400px"></td>
				</tr>
				<tr>
					<th>조회수</th>
					<td>${ requestScope.recipe.recipeHits }</td>
				</tr>
			</tbody>
		</table>
	
	<div id="recipe_irdnt">
	
		<h3>레시피 재료정보</h3>
		<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
		<button type="button" onclick="moveTo('/turnup_fridger/common/admin/recipe/irdnt/update_chk.do', '${requestScope.recipe.recipeId}')">수정</button>
		</sec:authorize>
		<div>
		주재료 :
		<c:forEach items="${ requestScope.recipe.recipeIrdntList }" var="recipeIrdnt" >
		<c:if test="${recipeIrdnt.irdntTypeCode == 3060001}">
		${ recipeIrdnt.irdntName }, 
		</c:if>
		</c:forEach>
		</div>
		<div>
		부재료 : 
		<c:forEach items="${ requestScope.recipe.recipeIrdntList }" var="recipeIrdnt" >
		<c:if test="${recipeIrdnt.irdntTypeCode == 3060002}">
		${ recipeIrdnt.irdntName }, 
		</c:if>
		</c:forEach>
		</div>
		<div>
		양념 : 
		<c:forEach items="${ requestScope.recipe.recipeIrdntList }" var="recipeIrdnt" >
		<c:if test="${recipeIrdnt.irdntTypeCode == 3060003}">
		${ recipeIrdnt.irdntName }, 
		</c:if>
		</c:forEach>
		</div>
	</div>
	</div>

	<!--타이머?  -->

	<div id="recipe_crse">
	<h3>레시피 과정정보</h3>
	<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
	<button type="button" onclick="moveTo('/turnup_fridger/common/admin/recipe/crse/update_chk.do', '${requestScope.recipe.recipeId}')">수정</button>
	</sec:authorize>
	<table>
	<c:forEach items="${ requestScope.recipe.recipeCrseList }" var="recipeCrse">
	<tr>
		<td>
			${recipeCrse.cookingNo} - ${recipeCrse.cookingDc}<br>
			<c:if test="${recipeCrse.stepTip !='null'}">
				(팁: ${recipeCrse.stepTip} )<br>
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
<div style="margin-right: 50px;  width: auto;  right:0; position: absolute;">

<!--나의 식재료들 가져와서 수정,삭제할수있게 하는 테이블  -->
	<div id="deleteIrdnt" style="overflow-x:hidden; overflow-y:scroll; height:200px;width:300px;">사용한 재료삭제</div>
		<table>
			<thead id="myIrdntThead">
				<tr>
					<th>재료명</th>
					<th>신선도</th>
					<th>수량메모</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody id="myIrdntTbody"></tbody>
		</table>
	</div><hr>


<!--후기게시판연결  -->
	<button type="button" id="reviewBtn">후기 보기</button>
	<div id="review">
		<table>
			<thead id="reviewThead">
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>글</th>
					<th>사진</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>별점</th>
				</tr>
			</thead>
			<tbody id="reviewTbody">
			</tbody>
		</table>
	</div>
	<div id="reviewPageBean"></div>



<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
<button type="button" id="deleteRecipeBtn">삭제</button> 
</sec:authorize>
<button type="button" onclick="window.history.back()">뒤로가기</button>
