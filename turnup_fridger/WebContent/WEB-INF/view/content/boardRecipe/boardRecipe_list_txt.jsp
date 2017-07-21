<%@page import="kr.co.turnup_fridger.vo.MemberRecipeRecommand"%>
<%@page import="kr.co.turnup_fridger.vo.BoardShareRecipe"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link href="${initParam.rootPath }/css/cardList.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<!-- 페이지 번호 버튼 -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

<!-- 기본 자바스크립 -->
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<!-- Latest compiled and minified CSS 아이콘 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script type="text/javascript">

/*  $(document).ready(function(){
	$('#recommand-btn').on('click', function(){
		
			alert('추천하시겠습니까?');
			document.submit();
		}

});  
 */

/* 추천 중복 에러 알림창으로 떠서 알려주는거 하기!!
 * 
 $(document).ready(function(){
	$("#btnWrite").on("click", function(){
		 if(!$("#id").val()){
			alert("값 넣으세요");
			return;
		} 
		$.ajax({
			"url":"/turnup_fridger/boardRecipe/boardRecipeInsert.do",
			"type":"post",
			"data":{'irdntName':$("#irdntName").val(),'${_csrf.parameterName}':'${_csrf.token}'},
			"dataType":"json",
			
			"error":function(xhr, msg, code){
				alert("오류발생-"+code);
			}
			
		}); 
		*/
	/* 	function recommand_event(){
			var recipeId = $('input[name=recipeId]').val();
			var memberId = $('input[name=memberId]').val();
			
			if(confirm("확실하게 삭제 하시겠습니까?")==true){
				
				location.href="/turnup_fridger/common/boardRecipe/increaseRecommand.do";
				
			}else{
				return false;
			}
		}; */
		
		function add_event(){
			
			return location.href="/turnup_fridger/boardRecipe/boardRecipe_write";
		}
		function search_event(){
			if(document.search.keyword.value == ""){
				alert("검색어를 입력하세요");
				return;
			}
			document.search.submit();
		}
</script>
<style>
#absolute {
  
	text-align:center;

  /* position: absolute; */
  right: 0;
} 
div.paging{
	 width:320px; left:0; right:0; margin-left:auto; margin-right:auto; 
}
.ccformfield {
	color:#000000; 
	background:#FFFFFF;
	border: 1px solid #f1f1f1;
	padding:15.5px;
	width:60%;
	height:34px;
	font-family: 'Lato',Arial,sans-serif;
	font-size:14px;
	margin:0;
}

/* #container { 
    width: 780px; 
    background: #FFFFFF; 
    margin: 0 auto; 
    border: 1px solid #000000; 
    text-align: left; 
} */
div.part{
text-align:center;
}
@media all and (min-width: 40em) {
  .list2 {
    padding: 0.1em;
    max-width: 90em;
    margin: 0 auto;
    overflow: hidden;
  }
}
</style>
</head>
<c:if test="${requestScope.boardShareRecipe ==null }">
	<script type="text/javascript">
		location.href="${initParam.rootPath}/boardRecipe/boardRecipeList.do";
		/*${initParam.rootPath}/common/member/boardRecipe/boardRecipe_write.do  */
	</script>
</c:if>	
	
<body>

<div  class="container">
<h3>BEST 레시피 4</h3>

<div id="pattern" class="pattern">
    <ul class="list img-list">
		<c:forEach var="top" items="${requestScope.top}">
         <li>
          <a href="${initParam.rootPath }/boardRecipe/boardRecipeView.do?recipeId=${top.recipeId}" class="inner">
            	<div class="li-text">
            		<p class="li-sub">${top.recipeId} </p>
            		<p class="li-sub">
            		<i class="glyphicon glyphicon-calendar" style="font-size:13px">
            		<fmt:formatDate value="${top.date}" pattern="yyyy년 MM월 dd일"/>
            		</i></p>
            	</div>
                <div class="li-img">
                    <img src="${initParam.rootPath }/img/${top.original}" alt="${top.original }" style="width:130%; height:250px;" />
                    <!-- ${top.upImage}-->
                </div>
                <div class="li-text">
            		<p class="li-head"> ${top.title} </p>
            	</div>
                <div class="li-text">
                    <h5 class="li-head"><i class="glyphicon glyphicon-user" style="font-size:20px"> ${top.memberId }</i></h5>
                </div>
                <div class="li-text">
                    <p class="li-sub"><i class="glyphicon glyphicon-eye-open" style="font-size:20px">  ${top.hits }</i> </p>
                </div>    
            </a>
               	 	<form method="post" action="${initParam.rootPath }/common/boardRecipe/increaseRecommand.do">
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
						<input type="hidden" name="recipeId" value="${top.recipeId }">
						<input type="hidden" name="memberId" value="${top.memberId }">
					
					<a href="#" onClick="this.parentNode.submit()" id="recommand-btn"><i class="glyphicon glyphicon-thumbs-up" style="font-size:20px">&emsp;${top.recommand }</i></a>
					</form><!-- return recommand_event(); -->
					
        </li>
    </c:forEach>
    </ul>





    <hr>
	<h3>레시피공유 게시판 전체 목록</h3>
	<br><br>
	<div class="form-inline form-group" >
		<div class="part">
	<!-- select 검색기능 -->
	<form name="search" method="post" action="${initParam.rootPath }/boardRecipe/selectSearch.do">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		
		<select name="searchOption" class="form-control" id="searchOption" >
			<option>선택</option>
			<option value="제목" >제목</option>
			<option value="아이디">작성자</option>
			<option value="내용" >내용</option>
		</select>
		
		<input type="text" name="keyword" class="ccformfield" placeholder="키워드를 입력해주세요"/>
		<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;" >
		<span class="glyphicon glyphicon-search" aria-hidden="true">검색</span>
		</button>
	</form>
	</div>
	<br>
    <!-- 회원 글등록 -->
	<sec:authorize access="hasRole('ROLE_MEMBER')">
	<div id="ex1">
	<form action="${initParam.rootPath }/common/member/boardRecipe/boardRecipe_write.do">
		<input type="hidden" name="${_csrf.parameterName }" 	value="${_csrf.token }">
		<input type="hidden" name="memberId" value="<sec:authentication property="principal.memberId"></sec:authentication>">
		<input type="hidden" name="adminId" value="">
		<div id="absolute">
		<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;" onclick="return add_event();">
		<span class="glyphicon glyphicon-pencil" aria-hidden="true">글쓰기</span>
		</button></div>
	</form>	
	</div>
	</sec:authorize>
	</div>
	&emsp;&emsp;&emsp;&emsp;
	
    <!-- lst_pet -->
  	<ul class="list2 img-list2"style="width:110%; height:1000px;" ><!--  style="width:110%; height:2000px ; " -->
	<c:forEach var="top" items="${requestScope.list}" >
      
        <li>
        <div class="li-text2" >
          
          <a href="${initParam.rootPath }/boardRecipe/boardRecipeView.do?recipeId=${top.recipeId}" class="inner2">
            	
            	<div class="li-text2" style="height:50px">
            		<p class="li-sub2" >${top.recipeId} </p>
            	</div>
            	<div class="li-text2" style="height:50px">	
            		<p class="li-sub2" style="height:80px;">
            		<i class="glyphicon glyphicon-calendar" style="font-size:13px; height:50px;">
            		<fmt:formatDate value="${top.date}" pattern="yyyy년 MM월 dd일" />
            		</i>
            	</p>
            	</div>
                <div class="li-img2" style="height:150px">
                    <img src="${initParam.rootPath }/img/${top.original}" alt="${top.original }" style="width:80%; height:150px;"/>
                    <!-- ${top.upImage}-->
                </div>
                <div class="li-text2" style="height:50px">
            		<p class="li-head2"> ${top.title} </p>
            	</div>
                <div class="li-text2" style="height:50px">
                    <h5 class="li-head2"><i class="glyphicon glyphicon-user" style="font-size:20px"> ${top.memberId }</i></h5>
                </div>
                <div class="li-text2" style="height:50px">
                    <p class="li-sub2"><i class="glyphicon glyphicon-eye-open" style="font-size:20px">  ${top.hits }</i> </p>
               	</div>
               
            </a>
             
            
            	<form name="add" method="post" action="${initParam.rootPath }/common/boardRecipe/increaseRecommand.do">
					<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<input type="hidden" name="recipeId" value="${top.recipeId }">
					<input type="hidden" name="memberId" value="${top.memberId }">
					
				<a href="#" onClick="this.parentNode.submit()" id="recommand-btn"><i class="glyphicon glyphicon-thumbs-up" style="font-size:20px">&emsp;${top.recommand }</i></a>
				</form>
			
        </div>
        </li>
    </c:forEach>
    </ul>
</div>
    <br><br>
    
   <%-- <li class="disabled">
      <a href="${initParam.rootPath}/boardnotice/boardNoticeList.do?page=1">
         <span class="glyphicon glyphicon-chevron-left"/>
      </a>
   </li> --%>
<div class="paging">
<p>	
	<%-- ######################################################
														페이징 처리
			###################################################### --%>
	<!-- 첫페이지로 이동 -->
	<a href="${initParam.rootPath }/oardRecipe/boardSearchByTxt.do?page=1">첫페이지</a>

	<!--
		이전 페이지 그룹 처리.
		만약에 이전페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리.
	 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.previousPageGroup }" >
			<!-- 이전페이지 그룹이 있따면 isPreviousPageGroup()-->
			<a href="${initParam.rootPath }/boardShareRecipe/boardSearchByTxt.do?page=${requestScope.pageBean.beginPage - 1}&txt=${requestScope.txt}">◀</a>
		</c:when>
		<c:otherwise>
			◀	
		</c:otherwise>
	</c:choose>
	
	
	
	
	
	<!-- 
		현재 page가 속한 page 그룹내의 페이지들 링크.
		현재 pageGroup의 시작page ~ 끝 page
	 -->
	 <!-- 만약에 page가 현재페이지면 링크처리를 하지 않고 p가 현재페이지가 아니라면 링크처리. -->
	
	<c:forEach begin="${requestScope.pageBean.beginPage }" 
			   end="${requestScope.pageBean.endPage }" var="page">
			   <c:choose>
			   	<c:when test="${requestScope.pageBean.page != page}">
			   	<!-- 현재페이지가 아니라면 -->
					<a href="${initParam.rootPath }/boardShareRecipe/boardSearchByTxt.do?page=${page}&txt=${requestScope.txt}">&nbsp;${page}&nbsp;</a>
			   	
			   	</c:when>
			   	<c:otherwise>
			   		&nbsp;[${page}]&nbsp;
			   	</c:otherwise>
			   </c:choose>
	</c:forEach>
	
	
	<!-- 
		다음페이지 그룹으로 이동
		만약에 다음페이지 그룹이 있으면 링크 처리 없으면 화살표만 나오도록 처리
	 -->
	
	<c:choose>
		<c:when test="${requestScope.pageBean.nextPageGroup}">
			<a href="${initParam.rootPath }/boardShareRecipe/boardSearchByTxt.do?page=${requestScope.pageBean.endPage + 1}&txt=${requestScope.txt}">▶</a>
		</c:when>
		<c:otherwise>
		▶
		</c:otherwise>
	</c:choose>
	
	
	
	
	
	
	
	<!-- 마지막 페이지로 이동 -->

	<a href="${initParam.rootPath }/boardShareRecipe/boardSearchByTxt.do?page=${requestScope.pageBean.totalPage}&txt=${requestScope.txt}">마지막 페이지</a>

</p>

</div>

</div>


</body>
</html>