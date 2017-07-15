<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
.lst_erai{
    width:100%;margin:0;padding:0;
    font-size:0;
    letter-spacing:-5px
}
.lst_erai li{
    display:inline-block;
    width:30%;
    min-height:200px;
    margin:0 5px 10px 0;
    background:withe;
    font-size:20px;
    
   /*  letter-spacing:0; */
    line-height:1.5;
    vertical-align:top;
    color:black;
    *display:inline;
    zoom:1;
}
</style>
</head>
<body>
<c:if test="${requestScope.error != null}">
	<script type="text/javascript">alert('권한이 없습니다.')</script>
</c:if>


<h1>후기 게시판</h1><br>
<hr>
<sec:authorize access="hasRole('ROLE_MEMBER')">
후기 작성
<a href="${initParam.rootPath}/boardreview/boardreview_form.do"><button>후기 작성</button></a>
</sec:authorize>
<a href="${initParam.rootPath}/index.do"><button>홈으로</button></a>
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
<form action="${initParam.rootPath}/boardreview/boardReviewStarList.do" method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
<button>별점순</button>
</form>
<ul class="lst_erai">
<c:forEach var="row" items="${list}">
    <li>
    	<p style="width:200px;">
   			<c:if test="${row.imageName != null}">
   				<img width="250px" alt="${row.imageName}" src="${initParam.rootPath}/img/${row.imageName}"><br>
   			</c:if>
   			<c:if test="${row.imageName == null}">
   				<img width="290px" src="${initParam.rootPath}/img/noimages.png">
   			</c:if>
     	</p>
      	<p>제목 : ${row.boardReviewTitle}</p>
      	<p class="album-title">레시피 : ${row.recipeName}</p>
      	<p>
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
      	</p>
      	<p>작성자 : ${row.memberId}</p>
        <p><fmt:formatDate value="${row.boardReviewDate}" pattern="yyyy-MM-dd"/></p>
      	<p>
   			${row.boardReviewTxt}
      	</p>
      	<p>
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
      	</p>
    </li>
 </c:forEach>
</ul>
</body>
</html>