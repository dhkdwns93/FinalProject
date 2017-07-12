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
/* //후기 삭제
function delete_event(){
	if (confirm("정말 삭제하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/boardreview/boardreview_list.do";
	}else{   
		//취소
	    return false;
	}
};


//후기 등록
function insert_event(){
	if (confirm("등록 하시겠습니까??") == true){    
		//확인
		location.href="/turnup_fridger/boardreview/boardreview_list.do";
	}else{   
		//취소
	    return false;
	}
};
 */
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
<h1>후기 게시판</h1><br>
<hr>
<sec:authorize access="hasRole('ROLE_MEMBER')">
후기 작성
<a href="${initParam.rootPath}/boardreview/boardreview_form.do"><button>후기 작성</button></a>
<a href="${initParam.rootPath}/index.do"><button>홈으로</button></a>
</sec:authorize>
 <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
 	<a href="${initParam.rootPath}/index.do"><button>홈으로</button></a>
 </sec:authorize>
<hr>
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

<c:forEach var="row" items="${list}">
<table border="1" width="600px" style="text-align:center"> 
<thead>
    <tr>
        <td>
        	레시피 : ${row.recipeName} |
        	제목 : ${row.boardReviewTitle} |
        	작성자 : ${row.memberId} |
        	작성일 : <fmt:formatDate value="${row.boardReviewDate}" pattern="yyyy-MM-dd"/>
        </td>
    </tr>
</thead>
 <tbody>   
    <tr>
    	<td>별점 : 
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
    </tr>
    <tr>
   		<td>
   			<c:if test="${row.imageName == null}">
 				${row.boardReviewTxt}
 			</c:if>
   			<c:if test="${row.imageName != null}">
   				<img width="320px" alt="${row.imageName}" src="${initParam.rootPath}/up_image/${row.imageSaveName}"><br>
   				${row.boardReviewTxt}
   			</c:if>
   		</td>
    </tr>	
	<!-- 회원 권한 폼 -->
	<sec:authorize access="hasRole('ROLE_MEMBER')">
		<tr>
   			<td>
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
			</td>
     	</tr> 
	</sec:authorize>

	
	<!-- 관리자 권한 폼 -->
	<sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_MASTERADMIN','ROLE_HEADMASTERADMIN')">
	<tr>
   		<td>	
			<form action="${initParam.rootPath}/boardreview/boardReviewRemove.do" method="post">
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
				<input type="hidden" name="boardReviewId" value="${row.boardReviewId}">
				<input type="hidden" name="writer" value="${row.memberId}">
				<input type="hidden" name="adminId" value="<sec:authentication property="principal.adminId"></sec:authentication>">
				<input type="hidden" name="memberId" value="">
				<input type="submit" value="삭제하기" onclick="return delete_event();">
			</form>
		</td>
    </tr>
	</sec:authorize>
   	   
</tbody>
</table>
</c:forEach>
<p>
	<%-- ######################################################
														페이징 처리
			###################################################### --%>
	<!-- 첫페이지로 이동 -->
	<a href="${initParam.rootPath}/boardreview/boardReviewStarList.do?page=1">첫페이지</a>

	<!--
		이전 페이지 그룹 처리.
		만약에 이전페이지 그룹이 있으면 링크처리하고 없으면 화살표만 나오도록 처리.
	 -->
	<c:choose>
		<c:when test="${requestScope.pageBean.previousPageGroup}">
			<%-- 이전페이지 그룹이 있디면 : previousPageGroup()--%>
			<a href="${initParam.rootPath }/boardreview/boardReviewStarList.do?page=${requestScope.pageBean.beginPage - 1}">☜</a>
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
					<a href="${initParam.rootPath}/boardreview/boardReviewStarList.do?page=${page}">&nbsp;${page}&nbsp;</a>
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
			<a href="${initParam.rootPath }/boardreview/boardReviewStarList.do?page=${requestScope.pageBean.endPage + 1}">☞</a>
		</c:when>
		<c:otherwise>
				☞		
		</c:otherwise>
	</c:choose>			
	
	<!-- 마지막 페이지로 이동 -->
	<a href="${initParam.rootPath}/boardreview/boardReviewStarList.do?page=${requestScope.pageBean.totalPage}">마지막페이지</a>

</p>
</body>
</html>