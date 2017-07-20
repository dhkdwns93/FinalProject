<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	//줄 바꿈
	pageContext.setAttribute("br", "<br/>");
	pageContext.setAttribute("cn", "\n");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" 
href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
//후기 삭제
function delete_event(){
	if (confirm("정말 삭제하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/boardreview/boardreview_list.do";
	}else{   
		//취소
	    return false;
	}
};
</script>
<style type="text/css">
 form{display:inline}
</style>
<style type="text/css">
span, td, th{
	padding: 5px; 
}
span.error{
	font-size:small;
	color: red;
}
.blink {
    -webkit-animation: blink 2.5s linear infinite;
} 
@-webkit-keyframes blink {
    0% { color: red; }
    33% { color: yellow; }
    66% { color: blue; }
    100% { color: green; }
}
</style>
</head>
<body>
<c:if test="${requestScope.error != null}">
	<script type="text/javascript">alert('권한이 없습니다.')</script>
</c:if>

<div class="container">
<jsp:include page="/WEB-INF/view/layout/side_menu/boardSideMenu.jsp"/>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />  

<c:if test="${empty list}">
<div id="table" style="width:auto; margin-left: auto; margin-right: auto;">
<br><br>
<h1>후기</h1>
<hr>
<table class="table table-hover table-condensed" style="width:100%; border:1; text-align:center;">
<div class="form-inline form-group" >
	<a href="${initParam.rootPath}/index.do">
		<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
			<span class="glyphicon glyphicon-home" aria-hidden="true"></span>
		</button>
	</a>
	<sec:authorize access="hasRole('ROLE_MEMBER')">
		<a href="${initParam.rootPath}/boardreview/boardreview_form.do">
			<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
				<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
			</button>
		</a>
	</sec:authorize>

	<div class="ccfield-prepend" style="float:right">
		<div style="float:right">
		<form action="${initParam.rootPath}/boardreview/boardReviewStarList.do" method="post">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;">
				<span class="glyphicon glyphicon-star" aria-hidden="true"></span>
			</button>
		</form>
		</div>
		<form class="form-inline" action="${initParam.rootPath}/boardreview/boardReviewBySelect.do" method="post">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<select class="form-control" name="select" id="select">
				<option>전체보기</option>
				<option value="레시피">레시피</option>
				<option value="아이디">아이디</option>
			</select>
				<input class="container form-control input-group" type="text" name="keyword" placeholder="키워드를 입력해주세요">
				<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;">
					<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
				</button>
		</form>
	</div>
</div>
	<br><h2 style="text-align:center">등록된 게시물이 없습니다.</h2>
</table>
</div>
</c:if>


<c:if test="${!empty list}">
<div id="table" style="width:auto; margin-left: auto; margin-right: auto;">
<br><br>
<h1>후기</h1>
<hr>
<div class="form-inline form-group" >
	<a href="${initParam.rootPath}/index.do">
		<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
			<span class="glyphicon glyphicon-home" aria-hidden="true"></span>
		</button>
	</a>
	<sec:authorize access="hasRole('ROLE_MEMBER')">
		<a href="${initParam.rootPath}/boardreview/boardreview_form.do">
			<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
				<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
			</button>
		</a>
	</sec:authorize>

	<div class="ccfield-prepend" style="float:right">
		<div style="float:right">
		<form action="${initParam.rootPath}/boardreview/boardReviewStarList.do" method="post">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;">
				<span class="glyphicon glyphicon-star" aria-hidden="true"></span>
			</button>
		</form>
		</div>
		<form class="form-inline" action="${initParam.rootPath}/boardreview/boardReviewBySelect.do" method="post">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<select class="form-control" name="select" id="select">
				<option>전체보기</option>
				<option value="레시피">레시피</option>
				<option value="아이디">아이디</option>
			</select>
				<input class="container form-control input-group" type="text" name="keyword" placeholder="키워드를 입력해주세요">
				<button type="submit" class="btn btn-default btn-lg" style="border:0;outline:0;">
					<span class="glyphicon glyphicon-search" aria-hidden="true"></span>
				</button>
		</form>
	</div>
</div>
<table class="table table-hover table-condensed" style="width:auto; border:1; text-align:center;">
<c:forEach var="row" items="${list}">
<table>
	<tr>
		<td style="width:10%;">
			<div style="float:right">
	    		<img width="80%"  src="${initParam.rootPath}/img/icon/요리사3.png">
	    	</div>
		</td>	
		<td style="width:70%;">
				<h4>${row.memberId}</h4>님의 후기 &nbsp; |  <fmt:formatDate value="${row.boardReviewDate}" pattern="yyyy-MM-dd"/>  
				<fmt:formatDate value="${row.boardReviewDate}" pattern="yyyy-MM-dd" var="date"/>  
				<c:if test="${today == date }">
					&nbsp;&nbsp;&nbsp;<a class="blink">new</a>
				</c:if>
		</td>
		<td  style="width:20%;">
	<!-- 회원 권한 폼 -->
			<sec:authorize access="hasRole('ROLE_MEMBER')">
   			<form action="${initParam.rootPath}/boardreview/boardReviewUploadView.do" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<input type="hidden" name="boardReviewId" value="${row.boardReviewId}">
				<input type="hidden" name="memberId" value="<sec:authentication property="principal.memberId"></sec:authentication>">
				<input type="hidden" name="writer" value="${row.memberId}">
				<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
					<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
				</button>
			</form>
				<form action="${initParam.rootPath}/boardreview/boardReviewRemove.do" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<input type="hidden" name="boardReviewId" value="${row.boardReviewId}">
					<input type="hidden" name="writer" value="${row.memberId}">	
					<input type="hidden" name="memberId" value="<sec:authentication property="principal.memberId"></sec:authentication>">
					<input type="hidden" name="adminId" value="">
					<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return delete_event();">
						<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
					</button>
				</form>
			</sec:authorize>
	<!-- 관리자 권한 폼 -->
			<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">	
			<form action="${initParam.rootPath}/boardreview/boardReviewRemove.do" method="post">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<input type="hidden" name="boardReviewId" value="${row.boardReviewId}">
				<input type="hidden" name="writer" value="${row.memberId}">
				<input type="hidden" name="adminId" value="<sec:authentication property="principal.adminId"></sec:authentication>">
				<input type="hidden" name="memberId" value="">
				<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;" onclick="return delete_event();">
					<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
				</button>
			</form>
			</sec:authorize>
		</td>
	</tr>
	<tr>
		<td>
		</td>
		<td style="width:70%;">
				${row.boardReviewTitle}
				<br><br>
		</td>
		<td>
		</td>
	</tr>
	<tr>
		<td>
		</td>
		<td style="width:70%;">
				<a href="${initParam.rootPath}/recipe/show/detail.do?recipeId=${row.recipeId}">${row.recipeName}</a>	|	
			<c:if test="${row.boardReviewStar == 0}">
    			<img width="20%" src="${initParam.rootPath}/starimage/rating0.png">
    		</c:if>
    		<c:if test="${row.boardReviewStar == 1}">
    			<img width="20%" src="${initParam.rootPath}/starimage/rating01.png">    		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 2}">
    			<img width="20%" src="${initParam.rootPath}/starimage/rating02.png">    		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 3}">
    			<img width="20%" src="${initParam.rootPath}/starimage/rating03.png">    		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 4}">
    			<img width="20%" src="${initParam.rootPath}/starimage/rating04.png">    		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 5}">
    			<img width="20%"  src="${initParam.rootPath}/starimage/rating05.png">    		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 6}">
    			<img width="20%" src="${initParam.rootPath}/starimage/rating06.png">    		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 7}">
     			<img width="20%"  src="${initParam.rootPath}/starimage/rating07.png">   		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 8}">
     			<img width="20%"  src="${initParam.rootPath}/starimage/rating08.png">   		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 9}">
     			<img width="20%"  src="${initParam.rootPath}/starimage/rating09.png">   		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 10}">
      			<img width="20%" src="${initParam.rootPath}/starimage/rating10.png">  		
    		</c:if>
		</td>
		<td>
		</td>
	</tr>	
	<tr>
		<td>
		</td>
		<td style="width:70%;" >
				<a style="color:white">&asdfasdfsdfadfasdfasdfasdfasdfasdfasdfasdfasdfsdfassfsdfsdfddfffff</a><br>
				${fn:replace(row.boardReviewTxt, cn, br)}<br>
			<c:if test="${row.imageName != null}">
   				<img width="90%" alt="${row.imageName}" src="${initParam.rootPath}/img/board/${row.imageName}"><br>
   			</c:if>
		</td>
		<td>
		</td>
	</tr>		
</table>
<br>
<br>
</c:forEach>
</table>
<p style="text-align:center;">
	<%-- ######################################################
														페이징 처리
			###################################################### --%>
	<!-- 첫페이지로 이동 -->
	<a href="${initParam.rootPath}/boardreview/boardReviewList.do?page=1">첫페이지</a>

	<!--
		이전 페이지 그룹 처리.
		만약에 이전페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리.
	 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.previousPageGroup}">
			<%-- 이전페이지 그룹이 있디면 : previousPageGroup()--%>
			<a href="${initParam.rootPath }/boardreview/boardReviewList.do?page=${requestScope.pageBean.beginPage - 1}">◀</a>
		</c:when>
		<c:otherwise>
				◀
		</c:otherwise>
	</c:choose>
	
	<!-- 
		현재 page가 속한 page 그룹내의 페이지들 링크.
		현재 pageGroup의 시작page ~ 끝 page
	 -->
	 <!-- 만약에 page가 현재페이지면 링크처리를 하지 않고 page가 현재페이지가 아니라면 링크처리. -->
		<c:forEach begin="${requestScope.pageBean.beginPage}" end="${requestScope.pageBean.endPage}" var="page">
			<c:choose>
				<c:when test="${requestScope.pageBean.page != page}"> <%-- 현재패이지가 아니라면 --%>
					<a href="${initParam.rootPath}/boardreview/boardReviewList.do?page=${page}">&nbsp;${page}&nbsp;</a>
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
			<%-- 다음페이지 그룹이 있디면 : nextPageGroup()--%>
			<a href="${initParam.rootPath }/boardreview/boardReviewList.do?page=${requestScope.pageBean.endPage + 1}">▶</a>
		</c:when>
		<c:otherwise>
				▶		
		</c:otherwise>
	</c:choose>			
	<!-- 마지막 페이지로 이동 -->
	<a href="${initParam.rootPath}/boardreview/boardReviewList.do?page=${requestScope.pageBean.totalPage}">마지막페이지</a>
</p>
</div>
</c:if>
</div>
</body>
</html>