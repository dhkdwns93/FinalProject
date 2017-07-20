<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
</head>
<body>
<div class="container">
<jsp:include page="/WEB-INF/view/layout/side_menu/boardSideMenu.jsp"/>
<div id="table" style="width:50%; margin-left: auto; margin-right: auto;">
<br><br>
<h2>${boardReview.memberId}님의 레시피 후기</h2>
<div id="table" style="width:800px;">
<form action="${initParam.rootPath}/boardreview/boardReviewList.do" method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	<button type="submit" class="btn btn-default btn-lg"  style="border:0;outline:0;">
		<span class="glyphicon glyphicon-list" aria-hidden="true"></span>
	</button>
</form>
<table class="table table-bordered" style="width:100%; border:1; text-align:center">
	<tr>
		<td>레시피</td>
		<td>${boardReview.recipeName}</td>
	</tr>
	<tr>
		<td>제목</td>
		<td>${boardReview.boardReviewTitle}</td>
	</tr>
	<tr>
		<td>작성자</td>
		<td>${boardReview.memberId}</td>
	</tr>	
	<tr>
		<td>별점</td>
		<td>
			<c:if test="${boardReview.boardReviewStar == 0}">
    			<img width="100px" src="${initParam.rootPath}/starimage/rating0.png">
    		</c:if>
    		<c:if test="${boardReview.boardReviewStar == 1}">
    			<img width="100px" src="${initParam.rootPath}/starimage/rating01.png">    		
    		</c:if>
    		<c:if test="${boardReview.boardReviewStar == 2}">
    			<img width="100px" src="${initParam.rootPath}/starimage/rating02.png">    		
    		</c:if>
    		<c:if test="${boardReview.boardReviewStar == 3}">
    			<img width="100px" src="${initParam.rootPath}/starimage/rating03.png">    		
    		</c:if>
    		<c:if test="${boardReview.boardReviewStar == 4}">
    			<img width="100px" src="${initParam.rootPath}/starimage/rating04.png">    		
    		</c:if>
    		<c:if test="${boardReview.boardReviewStar == 5}">
    			<img width="100px"  src="${initParam.rootPath}/starimage/rating05.png">    		
    		</c:if>
    		<c:if test="${boardReview.boardReviewStar == 6}">
    			<img width="100px" src="${initParam.rootPath}/starimage/rating06.png">    		
    		</c:if>
    		<c:if test="${boardReview.boardReviewStar == 7}">
     			<img width="100px"  src="${initParam.rootPath}/starimage/rating07.png">   		
    		</c:if>
    		<c:if test="${boardReview.boardReviewStar == 8}">
     			<img width="100px"  src="${initParam.rootPath}/starimage/rating08.png">   		
    		</c:if>
    		<c:if test="${boardReview.boardReviewStar == 9}">
     			<img width="100px"  src="${initParam.rootPath}/starimage/rating09.png">   		
    		</c:if>
    		<c:if test="${boardReview.boardReviewStar == 10}">
      			<img width="100px" src="${initParam.rootPath}/starimage/rating10.png">  		
    		</c:if>
		</td>
	</tr>	
	<tr>
		<td>내용</td>
		<td style="width:70%">
			<c:if test="${boardReview.imageName == null}">
 				${fn:replace(boardReview.boardReviewTxt, cn, br)}
 			</c:if>
   			<c:if test="${boardReview.imageName != null}">
   				<img width="60%" alt="${boardReview.imageName}" src="${initParam.rootPath}/img/${boardReview.imageSaveName}"><br>
   				${fn:replace(boardReview.boardReviewTxt, cn, br)}
   			</c:if>
		</td>
	</tr>
</table>
</div>
</div>
</div>
</body>
</html>