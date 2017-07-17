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
<!-- 버튼, table css -->

<!-- 기본 자바스크립 -->
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<!-- Latest compiled and minified CSS 아이콘 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script type="text/javascript">
/* $(document).ready(function(){
	$('#btn').on('click', function(){
		location.href="${initParam.rootPath}/common/member/boardRecipe/boardRecipe_write.tiles";
	});
}); */

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
		
</script>
<style>
#absolute {
  
  position: absolute;
  right: 0;
} 
.paging{
	 width:300px; left:0; right:0; margin-left:auto; margin-right:auto; 
}

</style>
</head>
<body class="container">

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
                    <img src="${initParam.rootPath }/img/1.jpg" alt="${top.original }" />
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
               	<a href="${initParam.rootPath }/common/boardRecipe/increaseRecommand.do?recipeId=${top.recipeId}&memberId=${top.memberId}">
               	<p class="li-sub">
               	<i class="glyphicon glyphicon-thumbs-up" style="font-size:20px"> ${top.recommand }
               	</i></p></a>
        </li>
    </c:forEach>
    </ul>
	<%-- <form action="${initParam.rootPath }/common/boardRecipe/increaseRecommand.do">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<input type="hidden" name="recipeId" value="${row.recipeId }">
				<input type="hidden" name="memberId" value="${row.memberId }">
				<input type="hidden" name="recommand" value="${row.recommand }">
				
				<input type="image" id="image-btn" src="${initParam.rootPath }/img/image_btn.png">
				
			</form>
 --%>




    <hr>
	<h3>레시피공유 게시판 전체 목록</h3>
	
	<!-- select 검색기능 -->
	<div id="absolute">
	<form class="form-search" method="post" action="${initParam.rootPath }/boardRecipe/selectSearch.do" class="form-01">
		
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<select name="searchOption" >
			<option value="default">선택</option>
			<option value="title">제목</option>
			<option value="memberId" >작성자</option>
			<option value="txt">내용</option>
		</select>
		<input type="text" name="keyword" />
		<button type="submit"><i class="glyphicon glyphicon-search" style="font-size:15px"></i></button>
		<!-- <input type="reset" value="초기화"/> -->
		
	</form>
	</div>
	
    <!-- 회원 글등록 -->
	<sec:authorize access="hasRole('ROLE_MEMBER')">
	<div id="ex1">
	<form action="${initParam.rootPath }/common/member/boardRecipe/boardRecipe_write.do">
		<input type="hidden" name="${_csrf.parameterName }" 	value="${_csrf.token }">
		<input type="hidden" name="memberId" value="<sec:authentication property="principal.memberId"></sec:authentication>">
		<input type="hidden" name="adminId" value="">
		<div id="absolute"><button type="submit"><i class="glyphicon glyphicon-pencil" style="font-size:15px"></i></button></div>
	</form>	
	</div>
	</sec:authorize>
	
	&emsp;&emsp;&emsp;&emsp;
	
	

   <%--  <ul class="list2 img-list2">
	<c:forEach var="row" items="${requestScope.list}">
        <li>
          <a href="${initParam.rootPath }/boardRecipe/boardRecipeView.do?recipeId=${row.recipeId}" class="inner2">
            	<div class="li-text2">
            		<p class="li-sub2">작성일 : <fmt:formatDate value="${row.date}" pattern="yyyy년 MM월 dd일"/></p>
            	</div>
                <div class="li-img2">
                    <img src="${initParam.rootPath }/img/1.jpg" alt="${row.original }" />
                    <!-- ${top.upImage}-->
                </div>
                <div class="li-text2">
            		<p class="li-head2">${row.recipeId} 제목 : ${row.title} </p>
            	</div>
                <div class="li-text2">
                    <h5 class="li-head2"><i class="glyphicon glyphicon-user" style="font-size:10px"> ${row.memberId }</i></h5>
                    <p class="li-sub2"><i class="glyphicon glyphicon-eye-open" style="font-size:10px">  ${row.hits }</i> </p>
                    <p class="li-sub2"><i class="glyphicon glyphicon-thumbs-up" style="font-size:10px;"> ${row.recommand }</i></p>
                </div>
            </a>
        </li>
    </c:forEach>
    </ul>  --%>
    
     <ul class="list2 img-list2">
	<c:forEach var="top" items="${requestScope.list}">
        <li>
          <a href="${initParam.rootPath }/boardRecipe/boardRecipeView.do?recipeId=${top.recipeId}" class="inner2">
            	<div class="li-text2">
            		<p class="li-sub2">${top.recipeId} </p>
            		<p class="li-sub2">
            		<i class="glyphicon glyphicon-calendar" style="font-size:13px">
            		<fmt:formatDate value="${top.date}" pattern="yyyy년 MM월 dd일"/>
            		</i></p>
            	</div>
                <div class="li-img2">
                    <img src="${initParam.rootPath }/img/1.jpg" alt="${top.original }" />
                    <!-- ${top.upImage}-->
                </div>
                <div class="li-text2">
            		<p class="li-head2"> ${top.title} </p>
            	</div>
                <div class="li-text2">
                    <h5 class="li-head2"><i class="glyphicon glyphicon-user" style="font-size:20px"> ${top.memberId }</i></h5>
                    <p class="li-sub2"><i class="glyphicon glyphicon-eye-open" style="font-size:20px">  ${top.hits }</i> </p>
                </div>
            </a>
                   <%--  <p class="li-sub2"><i class="glyphicon glyphicon-thumbs-up" style="font-size:20px"> ${top.recommand }</i></p> --%>
                   	<a href="${initParam.rootPath }/common/boardRecipe/increaseRecommand.do?recipeId=${top.recipeId}&memberId=${top.memberId}">
	               	<p class="li-sub">
	               	<i class="glyphicon glyphicon-thumbs-up" style="font-size:20px"> ${top.recommand }
	               	</i></p></a>
        </li>
    </c:forEach>
    </ul>
</div>
    























	
	<%-- <a href="${initParam.rootPath }/boardRecipe/boardRecipeList.do">목록</a>

<table border="1" width="600px" >
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
			<th>추천수</th>
			<th>추천?</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="row" items="${requestScope.list}">
		<tr>
			<td>${row.recipeId}</td>
			<td>
				<a href="${initParam.rootPath }/boardRecipe/boardRecipeView.do?recipeId=${row.recipeId}">${row.title}</a>
			</td>
			<td>${row.memberId }</td>
			<td>${row.date}</td>
			<td>${row.hits }</td>
			<td>${row.recommand }</td> 
			<!-- member 사용 버튼 -->
			<sec:authorize access="isAuthenticated()">
			<td>
			
		
			<form action="${initParam.rootPath }/common/boardRecipe/increaseRecommand.do">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<input type="hidden" name="recipeId" value="${row.recipeId }">
				<input type="hidden" name="memberId" value="${row.memberId }">
				<input type="hidden" name="recommand" value="${row.recommand }">
				
				<input type="image" id="image-btn" src="${initParam.rootPath }/img/image_btn.png">
				
			</form>
			
			
			</td>
			</sec:authorize>
		</tr>
	</c:forEach>
	<!-- 회원 글등록 -->
	<sec:authorize access="hasRole('ROLE_MEMBER')">
	<form action="${initParam.rootPath }/common/member/boardRecipe/boardRecipe_write.do">
		<input type="hidden" name="${_csrf.parameterName }" 	value="${_csrf.token }">
		<input type="hidden" name="memberId" value="<sec:authentication property="principal.memberId"></sec:authentication>">
		<input type="hidden" name="adminId" value="">
		<input type="submit" value="글등록">
	</form>	
	</sec:authorize>
	</tbody>
</table>  --%>
<p class="paging">

	<%-- ######################################################
														페이징 처리
			###################################################### --%>
	<!-- 첫페이지로 이동 -->
	<a href="${initParam.rootPath }/boardRecipe/boardRecipeList.do?page=1">첫페이지</a>

	<!--
		이전 페이지 그룹 처리.
		만약에 이전페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리.
	 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.previousPageGroup }" >
			<!-- 이전페이지 그룹이 있따면 isPreviousPageGroup()-->
			<a href="${initParam.rootPath }/itemList?page=${requestScope.pageBean.beginPage - 1}">◀</a>
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
					<a href="${initParam.rootPath }/boardRecipe/boardRecipeList.do?page=${page}">${page }</a>
			   	
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
			<a href="${initParam.rootPath }/boardRecipe/boardRecipeList.do?page=${requestScope.pageBean.endPage + 1}">▶</a>
		</c:when>
		<c:otherwise>
		▶
		</c:otherwise>
	</c:choose>
	
	
	
	
	
	
	
	<!-- 마지막 페이지로 이동 -->

	<a href="${initParam.rootPath }/boardRecipe/boardRecipeList.do?page=${requestScope.pageBean.totalPage}">마지막 페이지</a>




</p>



</body>
</html>