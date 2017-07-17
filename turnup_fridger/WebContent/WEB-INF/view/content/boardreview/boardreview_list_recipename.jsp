<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/turnup_fridger/scripts/jquery.js"></script>
<script type="text/javascript">
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
 span, td, th{
	padding: 5px; 
 }
 span.error{
	font-size:small;
	color: red;
 }
</style>
</head>
<body>
<c:if test="${requestScope.error != null}">
	<script type="text/javascript">alert('권한이 없습니다.')</script>
</c:if>

<c:if test="${empty list}">
<div id="table" style="width:800px; margin-left: auto; margin-right: auto;">
<h1>후기 게시판</h1><br>
<table class="table table-hover table-condensed" style="width:100%; border:1; text-align:center;">
<a href="${initParam.rootPath}/index.do"><button>홈으로</button></a>
<div style="float:right">
	<form action="${initParam.rootPath}/boardreview/boardReviewBySelect.do" method="post">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<select name="select" id="select">
			<option>전체보기</option>
			<option value="레시피">레시피</option>
			<option value="아이디">아이디</option>
		</select>
		<input type="text" name="keyword" placeholder="키워드를 입력해주세요">
		<button>검색</button>
	</form>
	</div>
	<br><a style="text-align:center"><h2>검색한 레시피가 없습니다.</h2></a>
</table>
<sec:authorize access="hasRole('ROLE_MEMBER')">
<a href="${initParam.rootPath}/boardreview/boardreview_form.do"><button>후기 작성</button></a>
</sec:authorize>
</div>
</c:if>
<c:if test="${!empty list}">
<div id="table" style="width:800px; margin-left: auto; margin-right: auto;">
<h1>후기 게시판</h1><br>
<a href="${initParam.rootPath}/index.do"><button>홈으로</button></a>
<div style="float:right">
	<form action="${initParam.rootPath}/boardreview/boardReviewBySelect.do" method="post">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
		<select name="select" id="select">
			<option>전체보기</option>
			<option value="레시피">레시피</option>
			<option value="아이디">아이디</option>
		</select>
		<input type="text" name="keyword" placeholder="키워드를 입력해주세요">
		<button>검색</button>
	</form>
</div>
<div style="background-color:#dcdcdc;">
<table class="table table-hover table-condensed" style="width:100%;text-align:center;">
<c:forEach var="row" items="${list}">
<table>
	<tr>
		<td>
			<c:if test="${row.boardReviewStar == 0}">
    			<img width="100px"  src="${initParam.rootPath}/img/icon/사진9.png">
    		</c:if>
    		<c:if test="${row.boardReviewStar == 1}">
    			<img width="100px"  src="${initParam.rootPath}/img/icon/사진1.png">  		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 2}">
    			<img width="100px"  src="${initParam.rootPath}/img/icon/사진3.png">    		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 3}">
    			<img width="100px"  src="${initParam.rootPath}/img/icon/사진2.png">  		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 4}">
    			<img width="100px"  src="${initParam.rootPath}/img/icon/사진4.png">    		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 5}">
    			<img width="100px"  src="${initParam.rootPath}/img/icon/사진6.png">       		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 6}">
    			<img width="100px"  src="${initParam.rootPath}/img/icon/사진7.png">       		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 7}">
     			<img width="100px"  src="${initParam.rootPath}/img/icon/사진3.png">     		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 8}">
     			<img width="100px"  src="${initParam.rootPath}/img/icon/사진1.png">     		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 9}">
     			<img width="100px"  src="${initParam.rootPath}/img/icon/사진3.png">     		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 10}">
      			<img width="100px"  src="${initParam.rootPath}/img/icon/사진4.png">    		
    		</c:if>
		</td>	
		<td style="background-color:white">
				<h4>${row.memberId}</h4>님의 후기  |  <fmt:formatDate value="${row.boardReviewDate}" pattern="yyyy-MM-dd"/> 
		</td>
		<td  style="background-color:white">
	<!-- 회원 권한 폼 -->
			<sec:authorize access="hasRole('ROLE_MEMBER')">
   			<form action="${initParam.rootPath}/boardreview/boardReviewUploadView.do" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<input type="hidden" name="boardReviewId" value="${row.boardReviewId}">
				<input type="hidden" name="memberId" value="<sec:authentication property="principal.memberId"></sec:authentication>">
				<input type="hidden" name="writer" value="${row.memberId}">
				<button>수정하기</button>
			</form>
				<form action="${initParam.rootPath}/boardreview/boardReviewRemove.do" method="post">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
					<input type="hidden" name="boardReviewId" value="${row.boardReviewId}">
					<input type="hidden" name="writer" value="${row.memberId}">	
					<input type="hidden" name="memberId" value="<sec:authentication property="principal.memberId"></sec:authentication>">
					<input type="hidden" name="adminId" value="">
					<input type="submit" value="삭제하기" onclick="return delete_event();">
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
				<input type="submit" value="삭제하기" onclick="return delete_event();">
			</form>
			</sec:authorize>
		</td>
	</tr>
	<tr>
		<td>
		</td>
		<td style="background-color:white">
				${row.boardReviewTitle}
		</td>
		<td style="background-color:white">
		</td>
	</tr>
	<tr>
		<td>
		</td>
		<td style="background-color:white">
				${row.recipeName}	|	
			<c:if test="${row.boardReviewStar == 0}">
    			<img width="100px" src="${initParam.rootPath}/starimage/rating0.png">
    		</c:if>
    		<c:if test="${row.boardReviewStar == 1}">
    			<img width="100px" src="${initParam.rootPath}/starimage/rating01.png">    		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 2}">
    			<img width="100px" src="${initParam.rootPath}/starimage/rating02.png">    		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 3}">
    			<img width="100px" src="${initParam.rootPath}/starimage/rating03.png">    		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 4}">
    			<img width="100px" src="${initParam.rootPath}/starimage/rating04.png">    		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 5}">
    			<img width="100px"  src="${initParam.rootPath}/starimage/rating05.png">    		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 6}">
    			<img width="100px" src="${initParam.rootPath}/starimage/rating06.png">    		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 7}">
     			<img width="100px"  src="${initParam.rootPath}/starimage/rating07.png">   		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 8}">
     			<img width="100px"  src="${initParam.rootPath}/starimage/rating08.png">   		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 9}">
     			<img width="100px"  src="${initParam.rootPath}/starimage/rating09.png">   		
    		</c:if>
    		<c:if test="${row.boardReviewStar == 10}">
      			<img width="100px" src="${initParam.rootPath}/starimage/rating10.png">  		
    		</c:if>
		</td>
		<td  style="background-color:white">
		</td>
	</tr>	
	<tr>
		<td>
		</td>
		<td style="background-color:white;width:100px" >
				<a style="color:white">&asdfasdfsdfadfasdfasdfasdfasdfasdfasdfasdfasdfsdfasdfadsffsdfsdfffsdf</a>
				${row.boardReviewTxt}<br>
			<c:if test="${row.imageName != null}">
   				<img width="500px" alt="${row.imageName}" src="${initParam.rootPath}/img/${row.imageName}"><br>
   			</c:if>
		</td>
		<td  style="background-color:white">
		</td>
	</tr>		
</table>
<br>
</c:forEach>
</table>
</div>
<sec:authorize access="hasRole('ROLE_MEMBER')">
<a href="${initParam.rootPath}/boardreview/boardreview_form.do"><button>후기 작성</button></a>
</sec:authorize>
<p style="text-align:center;">
	<%-- ######################################################
														페이징 처리
			###################################################### --%>
	<!-- 첫페이지로 이동 -->
	<a href="${initParam.rootPath}/boardreview/boardReviewByRecipeName.do?page=1&recipeName=${requestScope.recipeName}">첫페이지</a>

	<!--
		이전 페이지 그룹 처리.
		만약에 이전페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리.
	 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.previousPageGroup}">
			<%-- 이전페이지 그룹이 있디면 : previousPageGroup()--%>
			<a href="${initParam.rootPath }/boardreview/boardReviewByRecipeName.do?page=${requestScope.pageBean.beginPage - 1}&recipeName=${requestScope.recipeName}">☜</a>
		</c:when>
		<c:otherwise>
				☜	
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
					<a href="${initParam.rootPath}/boardreview/boardReviewByRecipeName.do?page=${page}&recipeName=${requestScope.recipeName}">&nbsp;${page}&nbsp;</a>
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
			<a href="${initParam.rootPath }/boardreview/boardReviewByRecipeName.do?page=${requestScope.pageBean.endPage + 1}&recipeName=${requestScope.recipeName}">☞</a>
		</c:when>
		<c:otherwise>
				☞		
		</c:otherwise>
	</c:choose>			
	

	<!-- 마지막 페이지로 이동 -->
	<a href="${initParam.rootPath}/boardreview/boardReviewByRecipeName.do?page=${requestScope.pageBean.totalPage}&recipeName=${requestScope.recipeName}">마지막페이지</a>
</p>
</div>
</c:if>
<br>
</body>
</html>