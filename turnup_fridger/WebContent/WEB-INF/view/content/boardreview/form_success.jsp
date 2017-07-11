<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>후기 등록 완료</h2>
<table border="1" width="600px" style="text-align:center"> 
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
		<td>
			<c:if test="${boardReview.imageName == null}">
 				${boardReview.boardReviewTxt}
 			</c:if>
   			<c:if test="${boardReview.imageName != null}">
   				<img width="320px" alt="${boardReview.imageName}" src="${initParam.rootPath}/up_image/${boardReview.imageSaveName}"><br>
   				${boardReview.boardReviewTxt}
   			</c:if>
		</td>
	</tr>
</table>
<a href="${initParam.rootPath}/boardreview/boardReviewList.do"><button type="button">목록으로</button></a>
</body>
</html>